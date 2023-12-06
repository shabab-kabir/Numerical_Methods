function approx = gaussQuad(f, a, b, n)
    % Retrieve precomputed nodes and weights for the given n
    [nodes, weights] = getGaussianQuadratureData(n);

    % Rescale nodes from [-1, 1] to [a, b]
    rescaledNodes = ((b-a)/2) * nodes + (a+b)/2;

    % Evaluate the function at these nodes
    functionValues = arrayfun(f, rescaledNodes);

    % Calculate the approximation
    approx = ((b-a)/2) * sum(weights .* functionValues);
end