function y = cubicinterp(x, coeff, X)
% CUBICINTERP Performs cubic interpolation.
% Given a point x, coefficients of cubic polynomials, and data points X,
% it estimates the value of the function at x.

n = length(X);

% Initialize search indices for binary search
maxind = n; minind = 1;
mid = ceil((maxind + minind)/2);
j = 1;

% Perform binary search to find the interval containing x
while (j <= ceil(log2(n))) && (maxind-minind > 1)
  if x <= X(mid)
    maxind = mid;
  else
    minind = mid;
  end
  mid = ceil((maxind + minind)/2);
  j = j + 1;
end
mid = mid - 1;

% Evaluate the cubic polynomial using Horner's method
xxx = X(mid);
y = coeff(mid,1) + (x-xxx)*(coeff(mid,2) + (x-xxx)*(coeff(mid,3) + (x-xxx)*coeff(mid,4)));