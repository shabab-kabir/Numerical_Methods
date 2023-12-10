function wangBezier(controlPoints, tolerance)
    global bezierPoints;
    bezierPoints = []; % Initialize an empty array to store bezier curve points

    % Start the recursive subdivision process
    recursiveSubdivide(controlPoints, tolerance);

    % Plot the collected Bezier curve points
    plot(bezierPoints(:,1), bezierPoints(:,2), 'b-', 'LineWidth', 2);
    hold on;
    plot(controlPoints(:,1), controlPoints(:,2), 'ro-'); % Plot control points
    legend('Bezier Curve', 'Control Points');
    grid on;
end

function recursiveSubdivide(points, tol)
    global bezierPoints;

    if isFlat(points, tol)
        % If the segment is flat, add its endpoints to the bezierPoints
        bezierPoints = [bezierPoints; points(1,:); points(end,:)];
    else
        % Subdivide the curve
        [left, right] = subdivideCurve(points);
        recursiveSubdivide(left, tol);  % Recurse for left part
        recursiveSubdivide(right, tol); % Recurse for right part
    end
end

function flat = isFlat(points, tol)
    % Implement a method to determine if the control points define a flat curve.
    % This could be based on the distance of control points from the line segment
    % joining the first and last control points.

    % Example flatness criterion (can be modified)
    lineVec = points(end,:) - points(1,:);
    lineDist = @(point) abs(det([lineVec; point - points(1,:)])) / norm(lineVec);
    maxDist = max(arrayfun(@(i) lineDist(points(i,:)), 2:size(points,1)-1));
    flat = maxDist < tol;
end

function [left, right] = subdivideCurve(points)
    % Subdivide the curve using De Casteljau's algorithm at t = 0.5
    n = size(points, 1);
    left = zeros(n, 2);
    right = zeros(n, 2);
    left(1,:) = points(1,:);
    right(end,:) = points(end,:);
    for j = 1:n-1
        points = (points(1:end-1,:) + points(2:end,:)) / 2;
        left(j+1,:) = points(1,:);
        right(n-j,:) = points(end,:);
    end
end


