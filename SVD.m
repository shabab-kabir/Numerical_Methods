function [U, S, V] = SVD(A, bidiagonalize, diagonalizeBidiagonal)
    % Check for special cases (e.g., zero matrix, rank deficiency)
    if isempty(A) || ~any(A(:))
        U = [];
        S = [];
        V = [];
        return;
    end

    % Step 1: Bidiagonalization
    [U, B, V] = bidiagonalize(A);

    % Step 2: Diagonalization of Bidiagonal Matrix
    [U_B, S, V_B] = diagonalizeBidiagonal(B, @gramSchmidtQR);

    % Step 3: Formation of U and V
    U = U * U_B;
    V = V * V_B;
end
