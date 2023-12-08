function bezierAbstractArt()
    % Number of curves
    numCurves = 20;

    % Generate random control points for Bézier curves
    controlPoints = rand(numCurves, 4, 2) * 100; 

    % Create figure
    figure;
    hold on;
    axis equal;
    xlim([0, 100]);
    ylim([0, 100]);
    set(gca, 'Color', 'k'); % Set background color to black

    % Loop to draw Bézier curves
    for i = 1:numCurves
        % Extract control points for each curve
        P0 = squeeze(controlPoints(i, 1, :))';
        P1 = squeeze(controlPoints(i, 2, :))';
        P2 = squeeze(controlPoints(i, 3, :))';
        P3 = squeeze(controlPoints(i, 4, :))';

        % Draw Bézier curve
        t = linspace(0, 1, 100)';
        Bx = (1-t).^3 .* P0(1) + 3*(1-t).^2 .* t .* P1(1) + 3*(1-t) .* t.^2 .* P2(1) + t.^3 .* P3(1);
        By = (1-t).^3 .* P0(2) + 3*(1-t).^2 .* t .* P1(2) + 3*(1-t) .* t.^2 .* P2(2) + t.^3 .* P3(2);

        % Plot the curve
        plot(Bx, By, 'LineWidth', 2, 'Color', rand(1,3));
    end

    hold off;
end

