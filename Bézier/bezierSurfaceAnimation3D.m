function bezierSurfaceAnimation3D()
    % Parameters
    numSurfaces = 5; % Number of Bezier surfaces
    numFrames = 600; % Number of frames in the animation
    videoFileName = 'BezierSurface3DAnimation.mp4'; % Output video file name
    
    % Prepare the figure
    fig = figure;
    hold on;
    axis equal;
    xlim([0, 100]);
    ylim([0, 100]);
    zlim([0, 100]);
    set(gca, 'Color', 'k'); % Set background color to black
    view(3); % Set the view to 3D
    grid on; % Enable grid
    lighting gouraud; % Set lighting to improve visual depth
    camlight; % Add a camera light

    % Set up video writer
    writerObj = VideoWriter(videoFileName, 'MPEG-4');
    writerObj.FrameRate = 60; % Adjust frame rate as needed
    writerObj.Quality = 100; % Set the quality to maximum
    open(writerObj);

    % Initial random control points for Bezier surfaces in 3D
    gridSize = [4, 4]; % Grid size for each surface
    controlPoints = rand(numSurfaces, gridSize(1), gridSize(2), 3) * 100;
    colorPalette = hsv(numSurfaces); % Using HSV color palette for color transitions

    for frame = 1:numFrames
        % Update each surface
        for i = 1:numSurfaces
            % More dynamic movement of control points
            controlPoints(i, :, :, :) = controlPoints(i, :, :, :) + 10 * sin(frame/10) * randn(1, gridSize(1), gridSize(2), 3);

            % Ensure control points stay within bounds
            controlPoints(i, :, :, :) = min(max(controlPoints(i, :, :, :), 0), 100);

            % Draw Bezier surface
            surfacePoints = computeBezierSurface(squeeze(controlPoints(i, :, :, :)));
            s = surf(surfacePoints(:, :, 1), surfacePoints(:, :, 2), surfacePoints(:, :, 3));

            % Set surface properties
            set(s, 'EdgeColor', 'w', 'LineWidth', 0.1); % White gridlines
            set(s, 'FaceColor', 'interp'); % Interpolate face colors
            set(s, 'FaceAlpha', 0.6); % Slightly transparent

            % Dynamic coloring based on Z-coordinate and time
            zData = surfacePoints(:,:,3);
            cData = (zData - min(zData(:))) / (max(zData(:)) - min(zData(:))); % Normalize Z data
            dynamicColor = colorPalette(i, :) .* (0.5 + 0.5 * sin(frame/10));
            coloredCData = repmat(cData, [1, 1, 3]);
            for k = 1:3
                coloredCData(:,:,k) = coloredCData(:,:,k) * dynamicColor(k);
            end
            set(s, 'CData', coloredCData, 'CDataMapping', 'scaled');
        end

        % Adjust the view to enhance 3D effect
        view([sin(frame/200)*360, 25]); % Slower view rotation

        % Capture the frame
        frameImg = getframe(fig);
        writeVideo(writerObj, frameImg);

        % Clear the axes for the next frame
        cla;
    end

    % Close the video file
    close(writerObj);
    hold off;
end

function surfacePoints = computeBezierSurface(controlPoints)
    [m, n, ~] = size(controlPoints);
    [u, v] = meshgrid(linspace(0, 1, 30), linspace(0, 1, 30)); % Increase resolution
    surfacePoints = zeros(size(u, 1), size(u, 2), 3);

    for i = 1:size(u, 1)
        for j = 1:size(u, 2)
            point = zeros(1, 3);
            for mi = 1:m
                for ni = 1:n
                    bernsteinU = nchoosek(m-1, mi-1) * u(i, j)^(mi-1) * (1-u(i, j))^(m-mi);
                    bernsteinV = nchoosek(n-1, ni-1) * v(i, j)^(ni-1) * (1-v(i, j))^(n-ni);
                    point = point + bernsteinU * bernsteinV * squeeze(controlPoints(mi, ni, :))';
                end
            end
            surfacePoints(i, j, :) = point;
        end
    end
end
