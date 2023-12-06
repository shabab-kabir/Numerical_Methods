function [L, U, P] = PA_LU(A)
    [n, m] = size(A);
    if n ~= m
        error('Matrix A must be square');
    end
    
    P = eye(n);
    L = zeros(n);
    U = A;
    
    for k = 1:n-1
        [~, max_index] = max(abs(U(k:n, k)));
        max_index = max_index + k - 1;
        if max_index ~= k
            U([k, max_index], :) = U([max_index, k], :);
            P([k, max_index], :) = P([max_index, k], :);
            if k >= 2
                L([k, max_index], 1:k-1) = L([max_index, k], 1:k-1);
            end
        end
        
        for i = k+1:n
            factor = U(i, k) / U(k, k);
            L(i, k) = factor;
            U(i, k:n) = U(i, k:n) - factor * U(k, k:n);
        end
    end
    
    L = L + eye(n);
end