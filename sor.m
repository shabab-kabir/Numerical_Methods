function [x, errors, iter] = sor(A, b, x0, omega, tol, maxiter)
    % Check for optional arguments
    if nargin < 4
        omega = 1.2; % Default relaxation parameter (optimal for many cases)
    end
    if nargin < 5
        tol = 1e-5;
    end
    if nargin < 6
        maxiter = 1000;
    end
    
    % Check if A is square
    [m, n] = size(A);
    if m ~= n
        error('Matrix A must be square');
    end
    
    % Check compatibility of A, b, and x0
    if length(b) ~= n || length(x0) ~= n
        error('Dimensions of A, b, and x0 are incompatible');
    end
    
    x = x0;
    errors = zeros(maxiter, 1);

    for iter = 1:maxiter
        x_old = x;
        for i = 1:n
            sum1 = A(i, 1:i-1) * x(1:i-1);
            sum2 = A(i, i+1:end) * x_old(i+1:end);
            x(i) = (1 - omega) * x_old(i) + (omega / A(i,i)) * (b(i) - sum1 - sum2);
        end
        errors(iter) = norm(x - x_old, inf);
        if errors(iter) < tol
            errors = errors(1:iter);
            return;
        end
    end
end
