function [U_B, S, V_B] = diagonalizeBidiagonal(B, gramSchmidtQR)
    maxIter = 1000; % Maximum number of iterations
    tol = 1e-10; % Tolerance for convergence
    [m, n] = size(B);
    
    U_B = eye(m);
    V_B = eye(n);
    S = B;

    for iter = 1:maxIter
        % Apply QR factorization to S
        [Q, R] = gramSchmidtQR(S);
        S = R * Q';
        V_B = V_B * Q(:,1:n); % Adjust Q to be n x n for multiplication with V_B

        % Apply QR factorization to S' (transpose of S)
        [Q, R] = gramSchmidtQR(S');
        S = Q * R';
        U_B = U_B * Q(:,1:m); % Adjust Q to be m x m for multiplication with U_B

        % Check for convergence
        offDiag = sqrt(sum(sum(triu(S, 1).^2)));
        if offDiag < tol
            break;
        end
    end

    % Ensure S is diagonal and non-negative
    S = abs(diag(S));
end
