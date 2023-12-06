function [U, B, V] = bidiagonalize(A)
    [m, n] = size(A);
    U = eye(m);
    V = eye(n);
    B = A;

    for i = 1:min(m, n)
        % Householder transformation for column i
        [P, beta] = householder(B(i:end, i));
        B(i:end, i:end) = B(i:end, i:end) - beta * P * (P' * B(i:end, i:end));
        U(i:end, :) = U(i:end, :) - beta * P * (P' * U(i:end, :));

        if i < n - 1
            % Householder transformation for row i
            [P, beta] = householder(B(i, i+1:end)');
            B(i:end, i+1:end) = B(i:end, i+1:end) - (B(i:end, i+1:end) * P) * beta * P';
            V(:, i+1:end) = V(:, i+1:end) - V(:, i+1:end) * (P * beta * P');
        end
    end
end

function [P, beta] = householder(x)
    sigma = x(2:end)' * x(2:end);
    P = [1; x(2:end)];
    if sigma == 0
        beta = 0;
    else
        mu = sqrt(x(1)^2 + sigma);
        if x(1) <= 0
            P(1) = x(1) - mu;
        else
            P(1) = -sigma / (x(1) + mu);
        end
        beta = 2 * P(1)^2 / (sigma + P(1)^2);
        P = P / P(1);
    end
end
