function distanceLUT = cumulativeDistanceLUT(curvePoints)
    % Initialize the distanceLUT array
    numPoints = size(curvePoints, 1);
    distanceLUT = zeros(numPoints, 1);

    % Compute the cumulative distances
    for i = 2:numPoints
        segmentLength = norm(curvePoints(i, :) - curvePoints(i - 1, :));
        distanceLUT(i) = distanceLUT(i - 1) + segmentLength;
    end
end
