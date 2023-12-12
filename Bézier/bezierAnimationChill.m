function bezierAnimationChill()
    % Parameters
    numCurves = 20;
    numFrames = 200;
    videoFileName = 'BezierCurveChillAnimation.mp4';
    
    % Desired resolution
    videoResolution = [1920, 1080]; % For example, 1920x1080 for Full HD

    % Prepare the figure
    fig = figure;
    hold on;
    axis equal;
    xlim([0, 100]);
    ylim([0, 100]);
    set(gca, 'Color', 'k'); % Set background color to black

    % Set up video writer
    writerObj = VideoWriter(videoFileName, 'MPEG-4');
    writerObj.FrameRate = 30; % Adjust frame rate as needed
    writerObj.Quality = 100; % Set the quality to maximum
    open(writerObj);

    % Initial random control points for Bézier curves
    controlPoints = rand(numCurves, 4, 2) * 100;
    colorPalette = rand(numCurves, 3); % Random color palette

    for frame = 1:numFrames
        % Update each curve
        for i = 1:numCurves
            % Slowly change control points
            controlPoints(i, :, :) = controlPoints(i, :, :) + randn(1, 4, 2) * 0.5; % Smaller multiplier for smoother movement

            % Ensure control points stay within bounds
            controlPoints(i, :, :) = min(max(controlPoints(i, :, :), 0), 100);

            % Extract control points for each curve
            P0 = squeeze(controlPoints(i, 1, :))';
            P1 = squeeze(controlPoints(i, 2, :))';
            P2 = squeeze(controlPoints(i, 3, :))';
            P3 = squeeze(controlPoints(i, 4, :))';

            % Draw Bézier curve
            t = linspace(0, 1, 100)';
            Bx = (1-t).^3 .* P0(1) + 3*(1-t).^2 .* t .* P1(1) + 3*(1-t) .* t.^2 .* P2(1) + t.^3 .* P3(1);
            By = (1-t).^3 .* P0(2) + 3*(1-t).^2 .* t .* P1(2) + 3*(1-t) .* t.^2 .* P2(2) + t.^3 .* P3(2);

            % Plot the curve with a consistent color palette
            plot(Bx, By, 'LineWidth', 2, 'Color', [colorPalette(i, :), 0.6]); % Fixed color for each curve
        end

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


