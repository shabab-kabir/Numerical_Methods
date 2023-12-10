function bezierSurface(controlPoints, nPoints)
    % controlPoints: A MxNx3 matrix of control points, where M and N are the number of control points in the u and v directions, respectively.
    % nPoints: Number of points to calculate on the surface in each direction.

    [m, n, ~] = size(controlPoints);
    u = linspace(0, 1, nPoints);
    v = linspace(0, 1, nPoints);
    surfacePoints = zeros(nPoints, nPoints, 3);

    for i = 1:nPoints
        for j = 1:nPoints
            surfacePoints(i, j, :) = computePoint(controlPoints, u(i), v(j), m, n);
        end
    end

    % Plot the surface
    surf(surfacePoints(:,:,1), surfacePoints(:,:,2), surfacePoints(:,:,3));
    hold on;

    % Optionally plot control points grid
    for i = 1:m
        plot3(controlPoints(i,:,1), controlPoints(i,:,2), controlPoints(i,:,3), 'ro-');
    end
    for j = 1:n
        plot3(controlPoints(:,j,1), controlPoints(:,j,2), controlPoints(:,j,3), 'ro-');
    end
    
    % Plot Labels
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    title('Bezier Surface  Visualization');
end

function point = computePoint(controlPoints, u, v, m, n)
    point = [0, 0, 0];
    for i = 1:m
        for j = 1:n
            bernsteinU = nchoosek(m-1, i-1) * u^(i-1) * (1-u)^(m-i);
            bernsteinV = nchoosek(n-1, j-1) * v^(j-1) * (1-v)^(n-j);
            point = point + bernsteinU * bernsteinV * squeeze(controlPoints(i,j,:))';
        end
    end
end


