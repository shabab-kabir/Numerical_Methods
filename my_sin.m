% Global variables for coefficients and x values
global coeffs xvals

% Choose data points from the sine function over [0, pi]
num_points = 10; % Adjust this for accuracy
xvals = linspace(0, pi, num_points);
yvals = sin(xvals);

% Calculate coefficients using Newton's divided differences
coeffs = newtondd(xvals, yvals);

% Example usage
x_test = 1.2; % Example x value
sin_approx = mysin(x_test);

% Display the result
disp(['sin(' num2str(x_test) ') ≈ ' num2str(sin_approx)]);

% Newton's Divided Difference Function
function coeffs = newtondd(xvals, yvals)
    n = length(xvals);
    ddTable = zeros(n, n);
    ddTable(:,1) = yvals(:);

    for j = 2:n
        for i = 1:(n-j+1)
            ddTable(i,j) = (ddTable(i+1,j-1) - ddTable(i,j-1)) / (xvals(i+j-1) - xvals(i));
        end
    end

    coeffs = ddTable(1,:);
end

% Custom Sine Function
function y = mysin(x)
    global coeffs xvals
    % Map x to the fundamental domain [0, pi]
    x = mod(x, 2*pi);
    if x > pi
        x = 2*pi - x;
    end
    y = interpolatingPolynomial(x);
end

% Interpolating Polynomial Function
function y = interpolatingPolynomial(x)
    global coeffs xvals
    n = length(coeffs);
    y = coeffs(1);
    for i = 2:n
        term = coeffs(i);
        for j = 1:(i-1)
            term = term * (x - xvals(j));
        end
        y = y + term;
    end
end
