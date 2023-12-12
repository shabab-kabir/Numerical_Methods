function bezierCurve = deCasteljau(controlPoints, t)
    % controlPoints: An Nx2 matrix of control points, where N is the number of control points.
    % t: A vector of parameter values (between 0 and 1) at which to evaluate the curve.

    n = size(controlPoints, 1) - 1; % Degree of the Bezier curve
    numPoints = length(t);
    bezierCurve = zeros(numPoints, 2); % Initialize the output matrix

    for i = 1:numPoints
        b = controlPoints; % Copy of control points for modification
        for k = 1:n
            for j = 1:n-k+1
                b(j,:) = (1-t(i)) * b(j,:) + t(i) * b(j+1,:); % De Casteljau's algorithm
            end
        end
        bezierCurve(i,:) = b(1,:); % Store the computed point
    end
end


