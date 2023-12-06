function [yout, approxList] = rungeKutta4(fxn, t0, y0, tn, h)
    % Ensure y0 is a column vector
    y0 = y0(:); 

    % Number of steps
    steps = floor((tn - t0) / h);
    
    % Initialize y and time
    y = y0;
    t = t0;
    
    % Initialize approxList with an extra column for time
    approxList = zeros(steps + 1, length(y0) + 1);
    
    % Store initial conditions
    approxList(1, :) = [t, y0']; % Store initial conditions

    % Iterate using RK4 method
    for i = 1:steps
        k1 = fxn(t, y);
        k2 = fxn(t + 0.5 * h, y + 0.5 * h * k1);
        k3 = fxn(t + 0.5 * h, y + 0.5 * h * k2);
        k4 = fxn(t + h, y + h * k3);

        % Update y and t
        y = y + h * (k1 + 2 * k2 + 2 * k3 + k4) / 6;
        t = t + h;

        % Store the results
        approxList(i + 1, :) = [t, y']; % Store the results
    end
    
    % Final approximation
    yout = y;
end
