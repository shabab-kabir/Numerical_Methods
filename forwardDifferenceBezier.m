function forwardDifferenceBezier(controlPoints, nPoints)
    % controlPoints: An 4x2 matrix of control points for a cubic Bezier curve.
    % nPoints: Number of points to calculate on the curve.

    % Calculate the coefficients for the cubic Bezier curve
    a = -controlPoints(1,:) + 3*controlPoints(2,:) - 3*controlPoints(3,:) + controlPoints(4,:);
    b = 3*controlPoints(1,:) - 6*controlPoints(2,:) + 3*controlPoints(3,:);
    c = -3*controlPoints(1,:) + 3*controlPoints(2,:);
    d = controlPoints(1,:);

    % Calculate the step size
    deltaT = 1 / (nPoints - 1);

    % Initial forward differences
    delta1 = (a * deltaT^3) + (b * deltaT^2) + (c * deltaT);
    delta2 = (6 * a * deltaT^3) + (2 * b * deltaT^2);
    delta3 = 6 * a * deltaT^3;

    % Initialize the array for curve points
    curve = zeros(nPoints, 2);
    curve(1,:) = d;

    % Iteratively calculate the points on the curve
    for i = 2:nPoints
        d = d + delta1;
        delta1 = delta1 + delta2;
        delta2 = delta2 + delta3;
        curve(i,:) = d;
    end

    % Plot the curve
    plot(curve(:,1), curve(:,2), 'b-', 'LineWidth', 2);
    hold on;
    plot(controlPoints(:,1), controlPoints(:,2), 'ro-'); % Plot control points
    legend('Bezier Curve', 'Control Points');
    grid on;
end


