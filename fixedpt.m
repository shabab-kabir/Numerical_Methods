function [x, err, iter] = fixedpt(f, x0, tol, maxiter)
    % Initialization
    iter = 0; 
    err = tol + 1; % Set error bigger than tol initially
    x = x0;
    err_list = [];
    
    while err > tol && iter < maxiter
        x_prev = x;
        x = f(x_prev);
        err = abs(x - x_prev);
        err_list = [err_list; err];
        iter = iter + 1;
    end
    err = err_list;
end