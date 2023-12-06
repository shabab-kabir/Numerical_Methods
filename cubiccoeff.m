function coeff = cubiccoeff(X, Y, type, endpoint)
% CUBICCOEFF Computes coefficients for a cubic spline.
% This function takes data points (x,y) for x in X and y in Y and returns
% the coefficients for a cubic spline. The 'type' parameter specifies endpoint conditions with
% the default being a natural cubic spline. Endpoint options are:
%   0 = Natural cubic spline (second derivatives at endpoints are zero)
%   1 = Clamped cubic spline (first derivatives at endpoints are specified)
%   2 = Not-a-knot cubic spline (continuity of third derivatives at second/penultimate points)

if nargin < 3
  type = 0;
end

if nargin >= 3
  if nargin < 4
    warning('No endpoint conditions specified, default [0 0] enforced.');
    endpoint = [0 0];
  end
end

% Ensure column vectors for input
[m, n] = size(X);
if m > 1
  if n ~= 1
    error('Input must be a vector')
  else
    X = X';
  end
end

if size(X) ~= size(Y)
  Y = Y';
  [mm, nn] = size(Y);
  if nn > 1
    error('Input must be a vector.')
  end
end

n = length(X);

% Compute differences in Y and X, and initialize z
D = Y(2:end) - Y(1:end-1);
d = X(2:end) - X(1:end-1);
z = zeros(n, 1);
z(2:end-1) = 3 * (D(2:end)./d(2:end) - D(1:end-1)./d(1:end-1));

% Construct matrix A based on distances between points
A = zeros(n);
for j = 2:n-1
  A(j, j) = 2 * (d(j-1) + d(j));
  A(j, j-1) = d(j-1);
  A(j, j+1) = d(j);
end

% Set up endpoint conditions based on type
switch type
  case 0
    A(1, 1) = 1;
    A(n, n) = 1;
    z(n) = 0;
  case 1
    A(1, 1) = 2 * d(1);
    A(1, 2) = d(1);
    A(n, n-1) = d(n-1);
    A(n, n) = 2 * d(n-1);
    z(1) = 3 * ((Y(2) - Y(1)) / (X(2) - X(1)) - endpoint(1));
    z(n) = 3 * (endpoint(2) - (Y(n) - Y(n-1)) / (X(n) - X(n-1)));
  case 2
    A(1, 1) = 2;
    A(n, n) = 2;
    z(1) = endpoint(1);
    z(n) = endpoint(2);
  otherwise
    error('I have not finished the other endpoint conditions.')
end

% Solve for the coefficients
c = A\z;

% Calculate spline coefficients
b = D./d - d.*(2*c(1:end-1) + c(2:end))/3;
d = (c(2:end) - c(1:end-1)) ./ (3 * d);
a = Y(1:end-1);
c = c(1:end-1);

% Ensure column vectors for spline coefficients
b = b(:); % Ensure b is a column vector
d = d(:); % Ensure d is a column vector
a = a(:); % Ensure a is a column vector (if not already)
c = c(:); % Ensure c is a column vector (if not already)

coeff = [a b c d];