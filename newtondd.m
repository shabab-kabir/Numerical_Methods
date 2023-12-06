function coeffs = newtondd(xvals, yvals)
    n = length(xvals);
    % Create a divided difference table initialized with f(x) values
    ddTable = zeros(n, n);
    ddTable(:,1) = yvals(:);
    
    for j = 2:n
        for i = 1:(n-j+1)
            ddTable(i,j) = (ddTable(i+1,j-1) - ddTable(i,j-1)) / (xvals(i+j-1) - xvals(i));
        end
    end
    
    % The coefficients are the diagonal of the table
    coeffs = ddTable(1,:);
end