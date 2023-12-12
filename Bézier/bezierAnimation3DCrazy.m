function bezierAnimation3DDynamic()
    % Parameters
    numFrames = 500;
    videoFileName = 'BezierCurve3DDynamicAnimation.mp4';
    
    % Desired resolution
    videoResolution = [1920, 1080]; % For example, 1920x1080 for Full HD

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
    writerObj.Quality = 100; % Set the quality to maximum
    open(writerObj);

    % Animation loop
    for frame = 1:numFrames
        % Vary the number of curves
        numCurves = randi([10, 30]);

        % Generate new random control points for Bézier curves in 3D
        controlPoints = rand(numCurves, 4, 3) * 100;

        % Update each curve
        for i = 1:numCurves
            % Randomly change control points for more dynamic movement
            controlPoints(i, :, :) = controlPoints(i, :, :) + randn(1, 4, 3) * 5;

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

            % Plot the curve with changing colors and varying transparency
            color = rand(1, 3);
            transparency = rand * 0.8; % Random transparency between 0 and 0.8
            plot3(Bx, By, Bz, 'LineWidth', 2, 'Color', [color, transparency]);
        end

        % Adjust the view to enhance 3D effect
        view([sin(frame/50)*360, cos(frame/50)*360]);

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


