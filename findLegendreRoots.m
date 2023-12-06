function roots = findLegendreRoots(n)
    % Ensure symbolic toolbox is available
    assert(license('test', 'Symbolic_Toolbox'), ...
        'Symbolic Math Toolbox is required for this function.');

    % Define the Legendre polynomial of order n
    syms x;
    Pn = legendreP(n, x);

    % Calculate the derivative of the Legendre polynomial
    dPn = diff(Pn, x);

    % Convert symbolic expressions to MATLAB functions
    Pn_func = matlabFunction(Pn);
    dPn_func = matlabFunction(dPn);

    % Initialize the roots vector
    roots = zeros(1, n);

    % Generate initial guesses for roots using Chebyshev (of the first kind) 
    initialGuesses = cos(pi * (4*(1:n) - 1) / (4*n + 2));

    % Newton-Raphson method for root finding
    for i = 1:length(initialGuesses)
        x = initialGuesses(i);
        for j = 1:10000 % Maximum iterations
            x_new = x - Pn_func(x) / dPn_func(x);
            if abs(x_new - x) < 1e-15 % Convergence criterion
                break;
            end
            x = x_new;
        end
        roots(i) = vpa(x, 12); % Use variable-precision arithmetic
    end

    % Sort the roots for consistency
    roots = sort(roots);
end
