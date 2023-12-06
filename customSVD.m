function [U, S, V] = customSVD(A, num_iterations)
    % Initialize U, S, and V
    [m, n] = size(A);
    U = randn(m, m); % Random initialization
    V = randn(n, n); % Random initialization
    
    % Power Iteration to find the left singular vectors
    for i = 1:num_iterations
        U = A * V;
        U = U / norm(U, 'fro');
    end
    
    % Lanczos Iteration to find the singular values and right singular vectors
    for i = 1:num_iterations
        V = A' * U;
        V = V / norm(V, 'fro');
        U = A * V;
        U = U / norm(U, 'fro');
    end
    
    % Calculate the singular values from the diagonal of S
    S = U' * A * V;

    % Return U, S, and V
end