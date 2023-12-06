function p = interpolatingPolynomial(xvals, yvals)
    coeffs = newtondd(xvals, yvals);
    n = length(coeffs);
    
    % Create the interpolating polynomial using nested multiplication
    p = @(x) coeffs(1) + nestedPolyMult(coeffs(2:n), x, xvals(1:n-1));
end