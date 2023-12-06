function Q = gramSchmidt(A)
    % A is the input matrix
    [m, n] = size(A);

    Q = zeros(m, n);
    for j = 1:n
        v = A(:, j);
        for i = 1:j-1
            v = v - (Q(:, i)' * A(:, j)) * Q(:, i);
        end
        Q(:, j) = v / norm(v);
    end
end
