% Define the function for the ODE
fxn = @(t, y) double([-y(1)-2*y(2); y(1)*(4-y(1)^2)]);

% Prepare the data with more initial conditions
t0 = 1;
tn = 30;
numSteps = 1000; % Original number of steps
newNumSteps = 2000; % Increased number of steps for interpolation
totalFrames = 1500; % Total length of the animation
initialConditions = double([-2 -1; 1 2; 0 1.5; 0.25 1.9; -1 1; 2 -0.9; -1 -2; 0 1; 1 -1; -1 0; 2 2; -2 -2]);

% Define colors for each trajectory
colors = {'#00968E', '#00BFFF', '#000099', '#CC0066', '#ABDD2F', '#DA70D6', '#9932CC', '#FF4500', '#FF6347', '#FF0000', '#48116A', '#0077FF'};

% Compute and interpolate trajectories using rungeKutta45
interpolatedTrajectories = cell(size(initialConditions, 1), 1);
tInterp = linspace(t0, tn, newNumSteps); % New time vector for interpolation
h = (tn - t0) / newNumSteps; % Calculate step size for Runge-Kutta

for i = 1:size(initialConditions, 1)
    [t, y] = rungeKutta45(fxn, [t0, tn], initialConditions(i, :), h);
    interpolatedY = customCubicInterpolation(t, y', tInterp); % Use custom cubic interpolation
    interpolatedTrajectories{i} = interpolatedY';
end

% Number of particles per trajectory
numParticles = 100; % Increase the number of particles

% Create figure with specific size
figurePosition = [100, 100, 1920, 1080];
figure('Position', figurePosition);
ax = gca;
set(ax, 'Color', 'k', 'XColor', 'w', 'YColor', 'w', 'ZColor', 'w');
set(gcf, 'Color', 'k');
xlim(ax, [-2, 2]);
ylim(ax, [-3, 3]);
hold(ax, 'on');
title(ax, 'Phase Plane Trajectories', 'Color', 'w');
xlabel(ax, 'y1', 'Color', 'w');
ylabel(ax, 'y2', 'Color', 'w');

% Create video writer
v = VideoWriter('trajectories2.mp4', 'MPEG-4');
v.Quality = 100;
v.FrameRate = 60; % Increased frame rate
open(v);

% Initialize and display interpolated particles with semi-transparency
alphaValue = 0.6; % Adjust this value for desired transparency (0 to 1)
lineHandles = gobjects(size(initialConditions, 1), 1);
particleHandles = cell(size(initialConditions, 1), numParticles); % Use cell array

for i = 1:size(initialConditions, 1)
    y = interpolatedTrajectories{i};
    lineHandles(i) = line('XData', NaN, 'YData', NaN, 'Color', [hex2rgb(colors{i}) 0.5], 'LineWidth', 2);
    
    % Determine the maximum number of particles for this trajectory
    maxParticles = min(numParticles, size(y, 1));
    
    particleHandles{i} = gobjects(maxParticles, 1); % Initialize cell array
    
    for j = 1:maxParticles
        startIdx = 1 + (j-1) * round(newNumSteps / maxParticles);
        particleHandles{i}(j) = scatter(ax, y(startIdx, 1), y(startIdx, 2), 36, 'filled', 'MarkerFaceColor', colors{i}, 'MarkerEdgeAlpha', alphaValue, 'MarkerFaceAlpha', alphaValue, 'Visible', 'on');
    end
end

% Start a timer
startTime = tic;

% Animation loop with interpolated trajectories
for frame = 1:totalFrames
    for i = 1:size(initialConditions, 1)
        y = interpolatedTrajectories{i};

        % Update existing particles and lines
        if frame <= newNumSteps
            set(lineHandles(i), 'XData', y(1:frame, 1), 'YData', y(1:frame, 2));
            for j = 1:numParticles
                particleIdx = max(1, min(newNumSteps, frame + (j-1) * round(newNumSteps / numParticles)));
                set(particleHandles(i, j), 'XData', y(particleIdx, 1), 'YData', y(particleIdx, 2));
            end
        end

        % Fade out lines after reaching newNumSteps
        if frame > newNumSteps
            fadeAlpha = max(0, 0.5 - (frame - newNumSteps) / (totalFrames - newNumSteps) * 0.5);
            set(lineHandles(i), 'Color', [hex2rgb(colors{i}) fadeAlpha]);
        end

        % Introduce new particles
        if frame > newNumSteps
            if mod(frame, 10) == 0 % Add new particles every 10 frames
                randomIdx = randi(size(initialConditions, 1));
                [~, newY] = ode45(fxn, [t0, tn], initialConditions(randomIdx, :));
                if size(newY, 1) > 1
                    newParticleHandle = scatter(ax, newY(end, 1), newY(end, 2), 36, 'filled', 'MarkerFaceColor', colors{randomIdx});
                end
            end
        end
    end

    % Update progress, frame number, and ETA
    if mod(frame, 10) == 0
        elapsedTime = toc(startTime);
        progressPercentage = frame / totalFrames;
        avgTimePerFrame = elapsedTime / frame;
        remainingTime = avgTimePerFrame * (totalFrames - frame);
        eta = datestr(remainingTime / 86400, 'HH:MM:SS');
        fprintf('Frame: %d, Progress: %d%%, ETA: %s\n', frame, round(progressPercentage * 100), eta);
    end

    drawnow;
    writeVideo(v, getframe(gcf));
end

% Close video writer
close(v);

% Function to convert hex color to RGB
function rgb = hex2rgb(hexStr)
    hexStr = strrep(hexStr, '#', '');
    rgb = sscanf(hexStr, '%2x%2x%2x', [1 3]) ./ 255;
end
