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

    % Plotting the control points
    plot(controlPoints(:,1), controlPoints(:,2), 'ro-'); % Plot control points
    hold on;

    % Plotting the Bézier curve with gradient effect
    numSegments = size(curve, 1) - 1;
    for i = 1:numSegments
        % Interpolate color from green (0,1,0) to magenta (1,0,1)
        color = [i/numSegments, 1 - i/numSegments, i/numSegments];
        plot(curve(i:i+1, 1), curve(i:i+1, 2), 'Color', color, 'LineWidth', 2);
    end

    % Enhancing the plot
    xlabel('X-axis');
    ylabel('Y-axis');
    title('Bézier Curve using Forward Difference Method');
    legend('Control Points', 'Bézier Curve');
    grid on;
    hold off;
end




