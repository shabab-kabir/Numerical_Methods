function bezierAnimation3DImproved()
    % Parameters
    numCurves = 15;
    numFrames = 300;
    videoFileName = 'BezierCurve3DImprovedAnimation.mp4';

    % Prepare the figure
    fig = figure;
    hold on;
    axis equal;
    xlim([0, 100]);
    ylim([0, 100]);
    zlim([0, 100]);
    set(gca, 'Color', 'k'); % Set background color to black
    view(3); % Set the view to 3D

    % Set up video writer
    writerObj = VideoWriter(videoFileName, 'MPEG-4');
    writerObj.FrameRate = 30; % Adjust frame rate as needed
    open(writerObj);

    % Initial random control points for Bézier curves in 3D
    controlPoints = rand(numCurves, 4, 3) * 100;
    colorPalette = hsv(numCurves); % Using HSV color palette for smoother color transitions

    for frame = 1:numFrames
        % Update each curve
        for i = 1:numCurves
            % Slowly and smoothly change control points
            controlPoints(i, :, :) = controlPoints(i, :, :) + sin(frame/20) * randn(1, 4, 3);

            % Ensure control points stay within bounds
            controlPoints(i, :, :) = min(max(controlPoints(i, :, :), 0), 100);

            % Extract control points for each curve
            P0 = squeeze(controlPoints(i, 1, :))';
            P1 = squeeze(controlPoints(i, 2, :))';
            P2 = squeeze(controlPoints(i, 3, :))';
            P3 = squeeze(controlPoints(i, 4, :))';

            % Draw Bézier curve in 3D
            t = linspace(0, 1, 100)';
            Bx = (1-t).^3 .* P0(1) + 3*(1-t).^2 .* t .* P1(1) + 3*(1-t) .* t.^2 .* P2(1) + t.^3 .* P3(1);
            By = (1-t).^3 .* P0(2) + 3*(1-t).^2 .* t .* P1(2) + 3*(1-t) .* t.^2 .* P2(2) + t.^3 .* P3(2);
            Bz = (1-t).^3 .* P0(3) + 3*(1-t).^2 .* t .* P1(3) + 3*(1-t) .* t.^2 .* P2(3) + t.^3 .* P3(3);

            % Plot the curve with consistent color
            plot3(Bx, By, Bz, 'LineWidth', 2, 'Color', [colorPalette(i, :), 0.7]);
        end

        % Adjust the view to enhance 3D effect
        view([sin(frame/100)*360, 25]);

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
