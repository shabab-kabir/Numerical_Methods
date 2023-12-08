function bezierAnimationDynamic()
    % Parameters
    numCurves = 30;
    numFrames = 300;
    videoFileName = 'BezierCurveDynamicAnimation.mp4';

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
    open(writerObj);

    % Initial random control points for Bézier curves
    controlPoints = rand(numCurves, 4, 2) * 100;

    for frame = 1:numFrames
        % Update each curve
        for i = 1:numCurves
            % Dynamically change control points
            controlPoints(i, :, :) = controlPoints(i, :, :) + randn(1, 4, 2) * 3; % Adjust the multiplier for more/less movement

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

            % Plot the curve with changing colors
            plot(Bx, By, 'LineWidth', 2, 'Color', [rand(1,3), 0.6]); % Adjust opacity as needed
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
