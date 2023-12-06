function [app, recLevel] = adaptiveSimpson(f,a,b,tol,Sab,rec_count);
% This performs adaptive quadrature using Simpon's Method.
% The last two input arguments are for recursion, the first
% to save on a computation and the second to control recursion.
% The second argument is a recursion level and we force a recursion
% quit after 21 levels of recursions as we have then divided the interval
% to (b-a)/(2^20) which is one million subintervals.  When calling the function
% only the first four inputs are useful.  The fourth argument, tol, can be 
% ommitted in the initial call and a default of 1e-12 is used.


app=0;
recLevel = 0;
c=(b+a)/2;
h=(b-a)/2;
if nargin < 6
  rec_count = 1;
  if nargin < 5
    if nargin < 4
      tol = 1e-9;
    end 
    Sab = (h/3)*(f(a) + 4*f(c) + f(b));
  end
end

h=h/2;
Sac = (h/3)*(f(a) + 4*f((c+a)/2) + f(c));
Scb = (h/3)*(f(c) + 4*f((b+c)/2) + f(b));

approx = Sac+Scb;
if (abs(Sab-approx) >= 10*tol) && (rec_count < 21)
  %tol=tol/2;
  rec_count = rec_count+1;
  [appa, reca]=adaptiveSimpson(f,a,c,tol/2,Sac,rec_count);
  [appb, recb]=adaptiveSimpson(f,c,b,tol/2,Scb,rec_count);
  app = app + appa + appb;
  recLevel = max([rec_count,reca,recb]);
else
  app=app+approx;
end
