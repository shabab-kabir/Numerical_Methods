function distanceLUT = cumulativeDistanceLUT(curvePoints)
    % Initialize the distanceLUT array
    numPoints = size(curvePoints, 1);
    
    % Initialize the LUT with two columns: first for t values, second for distances
    distanceLUT = zeros(numPoints, 2);

    % Set the initial t value (assuming it starts at 0)
    distanceLUT(1, 1) = 0; % t value
    distanceLUT(1, 2) = 0; % cumulative distance

    % Compute the cumulative distances
    for i = 2:numPoints
        segmentLength = norm(curvePoints(i, :) - curvePoints(i - 1, :));
        distanceLUT(i, 1) = (i - 1) / (numPoints - 1); % Normalized t value
        distanceLUT(i, 2) = distanceLUT(i - 1, 2) + segmentLength;
    end
end

