function f = cubicspline(X, Y, type, endpoint)
% CUBICSPLINE Constructs a cubic spline from given data points.
% It takes data points (x,y) for x in X and y in Y and returns a function handle
% for a cubic spline. The 'type' parameter specifies endpoint conditions with
% the default being a natural cubic spline. Endpoint options are:
%   0 = Natural cubic spline (second derivatives at endpoints are zero)
%   1 = Clamped cubic spline (first derivatives at endpoints are specified)
%   2 = Not-a-knot cubic spline (third derivatives at second/penultimate points equal those at endpoints)
% For types 1 and 2, a fourth input defining the values for the endpoint conditions is required.

% Handle input arguments and compute spline coefficients
if nargin < 3
  coeff = cubiccoeff(X, Y);
elseif nargin == 3
  warning('No endpoint conditions specified, default [0 0] enforced.');
  coeff = cubiccoeff(X, Y, type, [0 0]);
else
  coeff = cubiccoeff(X, Y, type, endpoint);
end

% Return a function handle to the cubic spline
f = @(z) cubicinterp(z, coeff, X);