function bezier_draw
    % Initialize figure
    fig = figure;
    ax = axes('Parent', fig);
    hold(ax, 'on');
    title(ax, 'Left click to add/move points, right-click on point to delete, press ''n'' for new curve, Enter to finish');
    
    % Set initial axes limits
    initialXLim = [0, 10];
    initialYLim = [0, 10];
    xlim(ax, initialXLim);
    ylim(ax, initialYLim);

    % Initialize empty points array
    points = {};
    currentCurve = 1;
    points{currentCurve} = [];
    hPoints = [];

    % Set callbacks
    set(fig, 'WindowButtonDownFcn', @mouseClick);
    set(fig, 'KeyPressFcn', @keyPress);

    % Wait for the user to press Enter
    waitforbuttonpress;
    
    % Function to handle mouse click events
    function mouseClick(~, ~)
        cp = ax.CurrentPoint;  % Get current point
        x = cp(1,1);  % X-coordinate
        y = cp(1,2);  % Y-coordinate
        
        % Determine type of click (left or right)
        clickType = get(fig, 'SelectionType');
        
        switch clickType
            case 'normal'   % Left-click: add/move point
                addOrMovePoint(x, y);
            case 'alt'      % Right-click: remove point
                removePoint(x, y);
        end
    end
    
    % Function to handle key press events
    function keyPress(src, event)
        % 'n' key for new curve
        if strcmp(event.Key, 'n')
            currentCurve = currentCurve + 1;
            points{currentCurve} = [];
        end
    end

    % Add or move a point
    function addOrMovePoint(x, y)
        minDist = inf;
        minIndex = -1;
        
        % Check if we are close to an existing point
        for i = 1:size(points{currentCurve},1)
            dist = sqrt((x - points{currentCurve}(i,1))^2 + (y - points{currentCurve}(i,2))^2);
            if dist < minDist
                minDist = dist;
                minIndex = i;
            end
        end
        
        % If close to a point, move it
        if minDist < 0.5
            points{currentCurve}(minIndex,:) = [x,y];
        else
            % Add new point
            points{currentCurve} = [points{currentCurve}; x, y];
        end
        
        % Update plots
        updatePlots();
    end

    % Remove a point
    function removePoint(x, y)
        minDist = inf;
        minIndex = -1;
        
        % Find the closest point
        for i = 1:size(points{currentCurve},1)
            dist = sqrt((x - points{currentCurve}(i,1))^2 + (y - points{currentCurve}(i,2))^2);
            if dist < minDist
                minDist = dist;
                minIndex = i;
            end
        end
        
        % If close enough, remove the point
        if minDist < 0.5
            points{currentCurve}(minIndex,:) = [];
        end
        
        % Update plots
        updatePlots();
    end

    % Function to update the plots
    function updatePlots()
        cla(ax);  % Clear axes
        for c = 1:currentCurve
            if ~isempty(points{c})
                % Plot control points
                plot(ax, points{c}(:,1), points{c}(:,2), 'ro-');
                % Plot Bézier curve
                plotBezierCurve(points{c});
            end
        end
        % Reset axes limits to initial values
        xlim(ax, initialXLim);
        ylim(ax, initialYLim);
    end

    % Function to plot Bézier curve
    function plotBezierCurve(ctrlPoints)
        t = linspace(0, 1, 100);
        bezierPoints = zeros(length(t), 2);
        
        for i = 1:length(t)
            bezierPoints(i,:) = computeBezierPoint(ctrlPoints, t(i));
        end
        
        plot(ax, bezierPoints(:,1), bezierPoints(:,2), 'b-');
    end

    % Function to compute a point on Bézier curve
    function point = computeBezierPoint(ctrlPoints, t)
        n = size(ctrlPoints, 1) - 1;
        point = [0, 0];
        
        for i = 0:n
            bernsteinPoly = nchoosek(n, i) * t^i * (1 - t)^(n - i);
            point = point + bernsteinPoly * ctrlPoints(i+1,:);
        end
    end
end
