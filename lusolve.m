function [x] = lusolve(A, b)
    [L, U, P] = PA_LU(A);
    y = forward_substitution(L, P*b);
    x = backward_substitution(U, y);
end