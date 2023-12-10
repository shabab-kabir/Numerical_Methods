function bezier_surface_draw
    % Initialize figure and 3D axes
    fig = figure;
    ax = axes('Parent', fig);
    hold(ax, 'on');
    title(ax, 'Left click to add/move points, right-click on point to delete, press Enter to finish');
    view(3); % Set the view to 3D
    
    % Set initial axes limits
    xlim(ax, [0, 10]);
    ylim(ax, [0, 10]);
    zlim(ax, [0, 10]);

    % Initialize empty control points array
    controlPoints = [];
    gridSize = [0, 0]; % To be determined based on the number of control points

    % Set callbacks
    set(fig, 'WindowButtonDownFcn', @mouseClick);
    set(fig, 'KeyPressFcn', @keyPress);

    % Wait for the user to press Enter
    waitforbuttonpress;
    
    % Mouse click function
    function mouseClick(~, ~)
        cp = ax.CurrentPoint; % Get current point in 3D
        x = cp(1,1);
        y = cp(1,2);
        z = cp(1,3);

        clickType = get(fig, 'SelectionType');
        switch clickType
            case 'normal' % Left-click
                addOrMovePoint(x, y, z);
            case 'alt' % Right-click
                removePoint(x, y, z);
        end
    end

    % Add or move a control point
    function addOrMovePoint(x, y, z)
        minDist = inf;
        minIndex = -1;

        % Find the closest control point
        for i = 1:size(controlPoints, 1)
            dist = norm(controlPoints(i,:) - [x, y, z]);
            if dist < minDist
                minDist = dist;
                minIndex = i;
            end
        end

        % Move or add the point
        if minDist < 1 % Threshold for considering a point 'close'
            controlPoints(minIndex, :) = [x, y, z];
        else
            controlPoints = [controlPoints; x, y, z];
            updateGridSize();
        end

        updateSurface();
    end

    % Remove a control point
    function removePoint(x, y, z)
        minDist = inf;
        minIndex = -1;

        % Find the closest control point
        for i = 1:size(controlPoints, 1)
            dist = norm(controlPoints(i,:) - [x, y, z]);
            if dist < minDist
                minDist = dist;
                minIndex = i;
            end
        end

        % Remove the point
        if minDist < 1 % Threshold
            controlPoints(minIndex, :) = [];
            updateGridSize();
        end

        updateSurface();
    end

    % Update the grid size based on the number of control points
    function updateGridSize()
        % Assuming a square grid for simplicity
        sideLength = ceil(sqrt(size(controlPoints, 1)));
        gridSize = [sideLength, sideLength];
    end

    % Update the Bezier surface
    function updateSurface()
        cla(ax); % Clear axes

        % Plot control points
        plot3(ax, controlPoints(:,1), controlPoints(:,2), controlPoints(:,3), 'ro');

        % Check if enough points to form a surface
        if size(controlPoints, 1) >= 4 % Minimal points for a simple surface
            % Plot Bezier surface
            plotBezierSurface();
        end
    end

    % Plot Bezier surface based on control points
    function plotBezierSurface()
        % Generate a grid of points (u, v) in [0, 1] range
        [u, v] = meshgrid(linspace(0, 1, 20), linspace(0, 1, 20));
        surfacePoints = zeros(size(u, 1), size(u, 2), 3);

        for i = 1:size(u, 1)
            for j = 1:size(u, 2)
                surfacePoints(i, j, :) = computeBezierSurfacePoint(u(i, j), v(i, j));
            end
        end

        surf(ax, surfacePoints(:,:,1), surfacePoints(:,:,2), surfacePoints(:,:,3));
    end

    % Compute a point on Bezier surface
    function point = computeBezierSurfacePoint(u, v)
        if size(controlPoints, 1) < 4
            point = [0, 0, 0];
            return;
        end

        m = gridSize(1);
        n = gridSize(2);
        point = zeros(1, 3);

        % Compute the Bezier surface point
        for i = 1:m
            for j = 1:n
                if ((i-1) * n + j) <= size(controlPoints, 1)
                    bernsteinU = nchoosek(m-1, i-1) * u^(i-1) * (1-u)^(m-i);
                    bernsteinV = nchoosek(n-1, j-1) * v^(j-1) * (1-v)^(n-j);
                    point = point + bernsteinU * bernsteinV * controlPoints((i-1) * n + j, :);
                end
            end
        end
    end
end
