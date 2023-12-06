function result = nestedPolyMult(coeffs, x, basePoints)
    n = length(coeffs);
    
    if nargin < 3 || isempty(basePoints)
        % Evaluate as a standard polynomial
        result = coeffs(1);  % Start with the first coefficient
        for i = 2:n
            result = result .* x + coeffs(i); % element-wise multiplication
        end
    else
        % Evaluate as a polynomial in Newton's form with base points
        result = coeffs(n);  % Start with the last coefficient
        
        for i = n-1:-1:1
            result = result .* (x - basePoints(i)) + coeffs(i); % element-wise multiplication
        end
    end
end
