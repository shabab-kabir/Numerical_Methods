function [x, final_err, iter] = bisection(f, a, b, tol, maxiter)
    % Ensure the initial interval contains a zero
    if f(a)*f(b) > 0
        error('Function has same sign at both interval endpoints.');
    end

    iter = 1; % Initialization of iteration counter
    x = (a + b) / 2; % Initial midpoint calculation
    x_prev = NaN; % Initialize x_prev to NaN
    final_err = inf; % Initialize final_err to infinity

    while final_err > tol && iter < maxiter
        if ~isnan(x_prev)
            final_err = abs(x - x_prev); % Update the error if x_prev is not NaN
        end

        x_prev = x; % Update previous midpoint
        x = (a + b) / 2; % Update current midpoint

        % Debugging information
        fprintf('Iteration %d: a = %f, b = %f, x = %f, f(a) = %f, f(b) = %f, f(x) = %f\n', iter, a, b, x, f(a), f(b), f(x));
        fprintf('Checking condition: f(a) * f(x) < 0, which is %d\n', f(a) * f(x) < 0);

        % Update the bounds
        if f(x) == 0
            break; % x is an exact zero
        elseif f(a) * f(x) < 0
            b = x;
        else
            a = x;
        end

        iter = iter + 1; % Increment iteration counter
    end
end
