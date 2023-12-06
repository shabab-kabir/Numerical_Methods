function boundingBox = bezierBoundingBox(curvePoints)
    % Initialize bounding box coordinates
    minX = inf;
    minY = inf;
    maxX = -inf;
    maxY = -inf;

    % Loop through curve points to find minimum and maximum coordinates
    for i = 1:size(curvePoints, 1)
        x = curvePoints(i, 1);
        y = curvePoints(i, 2);
        
        minX = min(minX, x);
        minY = min(minY, y);
        maxX = max(maxX, x);
        maxY = max(maxY, y);
    end
    
    % Create the bounding box
    boundingBox = [minX, minY; maxX, minY; maxX, maxY; minX, maxY; minX, minY];
end
