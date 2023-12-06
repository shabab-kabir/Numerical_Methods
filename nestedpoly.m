function out = nestedpoly(in,coeffs,basepts)

[m,n]=size(coeffs);

if m==1 & n ~=1
  coeffs = coeffs';
end

n = length(coeffs);

if nargin < 3
  numbasepts = 0;
else
  numbasepts = length(basepts);
end

if numbasepts & (numbasepts ~= (n-1))
  error(sprintf('There are %d coefficients but %d basepoints.  There should be one less basepoint than coefficients.', n,numbasepts))
end

out = coeffs(n);

if numbasepts
  for idx = n-1: -1 : 1
    out = out.*(in - basepts(idx)) + coeffs(idx);  
  end
else
  for idx = n-1: -1 : 1
    out = out.*(in) + coeffs(idx); 
  end
end



