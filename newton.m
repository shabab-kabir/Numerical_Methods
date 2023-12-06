function [x, err, iter] = newton(f, df, x0, tol, maxiter)
    % Initialization
    iter = 0; 
    x = zeros(maxiter, 1); 
    x(1) = x0;
    err_list = [];
    
    while iter < maxiter
        x_new = x(iter + 1) - f(x(iter + 1))/df(x(iter + 1));
        
        err_current = abs(x_new - x(iter + 1));
        err_list = [err_list; err_current];
        
        iter = iter + 1;
        x(iter + 1) = x_new;
        
        if err_current < tol
            break;
        end
    end
    
    x = x(1:iter);
    err = err_list;
end