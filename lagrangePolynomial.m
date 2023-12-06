function L = lagrangePolynomial(x, nodes, index)
    % Initialize the Lagrange polynomial to 1
    L = 1;

    % Number of nodes
    n = length(nodes);

    % Calculate the Lagrange polynomial
    for i = 1:n
        if i ~= index
            L = L * (x - nodes(i)) / (nodes(index) - nodes(i));
        end
    end
end
