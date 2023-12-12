function B = bernsteinPoly(n, i, t)
    % n: Degree of the polynomial
    % i: Order of the polynomial
    % t: Parameter value (can be a scalar or a vector)

    % Validate inputs
    if n < 0 || i < 0 || i > n
        error('Invalid inputs for Bernstein polynomial.');
    end

    % Calculate the Bernstein polynomial
    B = nchoosek(n, i) * (t.^i) .* ((1 - t).^(n - i));
end
