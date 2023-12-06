function [Q, R] = gramSchmidtQR(A)
    % A is the input matrix
    [m, n] = size(A);

    Q = gramSchmidt(A);
    R = zeros(n, n);

    for i = 1:n
        for j = i:n
            R(i, j) = Q(:, i)' * A(:, j);
        end
    end
end
