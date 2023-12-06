function ci = gaussianQuadratureCoefficients(n, tol)
    % Find the roots of the n-th Legendre polynomial (nodes)
    disp('Computing Legendre roots...');
    nodes = findLegendreRoots(n);

    % Initialize coefficients vector
    ci = zeros(1, n);

    % Loop over each node to compute each coefficient
    for i = 1:n
        fprintf('Computing coefficient %d of %d...\n', i, n);
        % Define Li(x)^2
        LiSquared = @(x) (lagrangePolynomial(x, nodes, i))^2;
        
        % Compute the integral of Li(x)^2 over [-1, 1]
        ci(i) = adaptiveMidpointRule(LiSquared, -1, 1, tol);
    end
    disp('Computation completed.');
end
