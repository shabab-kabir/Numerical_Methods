function [x, iter] = broyden(f, x0, tol, maxiter)
    % Initialization
    x = x0;
    iter = 0;
    B = eye(length(x0));  % Initial approximation of the Jacobian
    
    while iter < maxiter
        % Compute the update direction
        s = -B * f(x);
        
        % Line search to find the step size
        alpha = linesearch(f, x, s);
        
        % Update the solution
        x_new = x + alpha * s;
        
        % Compute the new residual
        delta_f = f(x_new) - f(x);
        
        % Update the Jacobian approximation using Broyden's formula
        B = B + (delta_f - B * s) * (s' * B) / (s' * B * s);
        
        x = x_new;
        iter = iter + 1;
        
        if norm(delta_f) < tol
            break;
        end
    end
end

function alpha = linesearch(f, x, s)
    % Backtracking line search
    alpha = 1.0;
    c = 0.1;
    rho = 0.5;
    
    while f(x + alpha * s) >= f(x)
        alpha = rho * alpha;
    end
end
