function [L, U, P] = mylu(A)
    % Initialize the size of the matrix
    [m, n] = size(A);
    
    % Initialize matrices L and U
    L = eye(m); % Initialize L as an identity matrix
    U = A; % Initialize U as a copy of A
    
    % Initialize the permutation matrix P as an identity matrix
    P = eye(m);
    
    for k = 1:min(m, n)
        % Find the pivot element and its row index
        [~, pivot_row] = max(abs(U(k:m, k)));
        pivot_row = pivot_row + k - 1; % Adjust the index
        
        % Perform row interchange in U, L, and P
        U([k, pivot_row], k:n) = U([pivot_row, k], k:n);
        L([k, pivot_row], 1:k-1) = L([pivot_row, k], 1:k-1);
        P([k, pivot_row], :) = P([pivot_row, k], :);
        
        % Calculate multipliers and update U and L
        for i = k+1:m
            multiplier = U(i, k) / U(k, k);
            L(i, k) = multiplier;
            U(i, k:n) = U(i, k:n) - multiplier * U(k, k:n);
        end
    end
end
