function curvePoints = cubicBezierCurve(P0, P1, P2, P3, numPoints)
    % Initialize the array to store the curve points
    curvePoints = zeros(numPoints, 2);

    % Compute the curve points using the cubic Bezier formula
    for i = 1:numPoints
        t = (i - 1) / (numPoints - 1);
        curvePoints(i, :) = (1 - t)^3 * P0 + 3 * (1 - t)^2 * t * P1 + 3 * (1 - t) * t^2 * P2 + t^3 * P3;
    end
end
