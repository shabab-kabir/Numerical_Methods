function bezierTriangle(controlPoints, nPoints)
    % controlPoints: A matrix of control points for the Bezier triangle.
    % nPoints: Number of points to calculate on the surface along one edge.

    % Compute the Bezier triangle points
    [u, v, w] = barycentricCoordinates(nPoints);
    trianglePoints = zeros(size(u, 1), 2);
    for i = 1:size(u, 1)
        trianglePoints(i, :) = computePoint(controlPoints, u(i), v(i), w(i));
    end

    % Delaunay triangulation to find the triangles
    triangles = delaunay(trianglePoints(:,1), trianglePoints(:,2));

    % Generate a colormap
    colors = jet(size(triangles, 1));

    % Plot the triangle with different colors
    trisurf(triangles, trianglePoints(:,1), trianglePoints(:,2), zeros(size(trianglePoints,1),1), 'FaceVertexCData', colors, 'FaceColor', 'flat');
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    title('Bezier Triangle Visualization - Colored Triangles');
    view(2); % view in 2D
    grid on;
end


function [u, v, w] = barycentricCoordinates(nPoints)
    % Generate barycentric coordinates in a uniform manner
    step = 1 / (nPoints - 1);
    [u, v] = meshgrid(0:step:1, 0:step:1);
    u = u(:);
    v = v(:);
    w = 1 - u - v;
    valid = (w >= 0);
    u = u(valid);
    v = v(valid);
    w = w(valid);
end

function point = computePoint(controlPoints, u, v, w)
    % Compute a point on the Bezier triangle
    n = (-1 + sqrt(1 + 8 * size(controlPoints, 1))) / 2 - 1; % Degree of the triangle
    point = zeros(1, 2);
    index = 1;
    for i = 0:n
        for j = 0:(n - i)
            k = n - i - j;
            bernstein = nchoosek(n, i) * nchoosek(n - i, j) * u^i * v^j * w^k;
            point = point + bernstein * controlPoints(index, :);
            index = index + 1;
        end
    end
end


