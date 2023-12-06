function [T, Y] = rungeKutta45(fxn, tRange, y0, h)
    % fxn: Function handle for the derivatives (the "f" in dy/dt = f(t, y))
    % tRange: [t0, tn], the range of time over which to integrate
    % y0: Initial conditions
    % h: Step size

    % Setup
    t0 = tRange(1);
    tn = tRange(2);
    steps = floor((tn - t0) / h);
    
    % Preallocate arrays for efficiency
    T = linspace(t0, tn, steps+1);
    Y = zeros(length(y0), steps+1);
    Y(:,1) = y0;

    % Main loop
    for i = 1:steps
        t = T(i);
        y = Y(:,i);

        % Runge-Kutta-Fehlberg calculations
        k1 = fxn(t, y);
        k2 = fxn(t + 1/4 * h, y + 1/4 * h * k1);
        k3 = fxn(t + 3/8 * h, y + 3/32 * h * k1 + 9/32 * h * k2);
        k4 = fxn(t + 12/13 * h, y + 1932/2197 * h * k1 - 7200/2197 * h * k2 + 7296/2197 * h * k3);
        k5 = fxn(t + h, y + 439/216 * h * k1 - 8 * h * k2 + 3680/513 * h * k3 - 845/4104 * h * k4);
        k6 = fxn(t + 1/2 * h, y - 8/27 * h * k1 + 2 * h * k2 - 3544/2565 * h * k3 + 1859/4104 * h * k4 - 11/40 * h * k5);

        % Update the next value
        Y(:,i+1) = y + h * (25/216 * k1 + 1408/2565 * k3 + 2197/4104 * k4 - 1/5 * k5);
    end
end
