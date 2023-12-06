function [Q, R] = gramSchmidtQR(A)
    [m, n] = size(A);

    Q = gramSchmidt(A);
    R = zeros(n, n); % Change this to match A's dimensions

    for i = 1:n
        for j = i:n
            R(i, j) = Q(:, i)' * A(:, j);
        end
    end

    % Adjust R for the non-square case
    if m > n
        R = [R; zeros(m-n, n)]; % Pad R with zeros at the bottom if m > n
    elseif m < n
        Q = [Q, zeros(m, n-m)]; % Pad Q with zeros on the right if m < n
    end
end
