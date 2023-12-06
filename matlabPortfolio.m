% This is a script to check all your matlab implementations.

% First, all of your matlab code should be saved in a single folder
% named code_surname where you replace surname with your own (e.g. my
% folder would be code_blanchard.
% Next, all the code in this document should run and pass these tests.
% At the end of the semester, when you submit your zipped code_surname, 
% I will run a very similar but distinct test script.
% Also, don't just put the equivalent built-in Matlab function inside your function name.
% My script will figure that out and we'll both be sad about an academic honesty case.
% Also, also, this should all be your code, not someone elses.  Someone else could be 
% a rando on the internet who posted code, a classmate, or an acquaintence who coded 
% something for you.  You write the code.  
% The code from assignments where you worked together can be shared code provided you 
% both contributed.  If you didn't contribute, write your own now.

% A test counter:

SmtnWrng = zeros(1,4);

% Chapter 1 - Solving Equations
% Three implementations from the homework.
% [x, err, iter] = bisection(fxn,lftpt,rghtpt,tol,maxiter)
% [x, err, iter] = fixedpt(fxn,xinit,tol,maxiter)
% [x, err, iter] = newton(fxn,dfxn,xinit,tol,maxiter)


fxn=@(x) exp(x)+sin(x) - 4;
fxptfxn = @(x) log(4-sin(x));
leftpt = -3;
rightpt = 2;
xinit = rightpt;
tol = 1e-8;
maxiter = 103;

dfxn=@(x) exp(x)+cos(x);

[Bx, Berr, Biter] = bisection(fxn,leftpt,rightpt,tol,maxiter);
[FPx, FPerr, FPiter] = fixedpt(fxptfxn,xinit,tol,maxiter);
[Nx, Nerr, Niter] = newton(fxn,dfxn,xinit,tol,maxiter);

oopsSum = round((Bx-FPx));
oopsSum = oopsSum+round(sum([Berr(end),FPerr(end),Nerr(end)]));
oopsSum = oopsSum+round((Nx(end)-FPx));

SmtnWrng(1) = oopsSum;

% Chapter 2 - Solving Linear Systems
% Three implementations from the homework.
% [L,U,P] = mylu(A)
% approx = lusolve(A,b)
% [x,err,iter] = gaussSeidel(A,b,xinit,tol,maxiter)

A = randn(5,5); 
for i=1:5
  A(:,i) = A(:,i)/norm(A(:,i));
  A(i,i) = A(i,i)+2*sign(A(i,i));
end

b = ones(5);
xinit = [1;1;1;1;1];
tol = 1e-8;
maxiter = 154;

[LL,UU,PP] = lu(A);
[L,U,P] = mylu(A);
approx = lusolve(A,b);
[x,err,iter] = gaussSeidel(A,b,xinit,tol,maxiter);

oopsSum = round(norm(PP'*LL*UU - P'*L*U,'fro'));
oopsSum = oopsSum + round(norm(approx - A\b));
oopsSum = oopsSum + round(norm(x-A\b));

SmtnWrng(2) = oopsSum;

% Chapter 3 - Interpolation
% One implementation to check.
% coeffs = newtondd(xvals,yvals)
xvals = 2.35:0.01:2.39;
yvals = [0.85442, 0.85866, 0.86289, 0.86710, 0.87129];
coeffs = newtondd(xvals,yvals);
fprintf('Coefficients: ');
disp(coeffs);
% for this check on your end you match this
correctCoeffs = [ 0.8544, 0.4240, -0.0500, -1.6667, 41.6667]';
SmtnWrng(3) = round(norm(correctCoeffs-coeffs));


% Chapter 5 - Numerical Integration
% Two implementations from the homework.
% approx = adaptiveMidpoint(fxn,lwrlim,upplim,tol)
% approx = gaussQuad(fxn,lwrlim,upplim,tol)

fxn=@(x) cos(x).*exp(-x);
lwrlim = 0;
upplim =2*pi;
tol = 1e-9;

AMapprox = adaptiveMidpoint(fxn,lwrlim,upplim,tol);
GQapprox = gaussQuad(fxn,lwrlim,upplim,5);
SmtnWrng(4) = round(norm(AMapprox-GQapprox));


% Chapter 6 - ODE Solvers
% One implementation to check
% [yout, appxList] = rungeKutta4(fxn, t0, y0, yn, h)

fxn = @(t,y) [-y(1)-2*y(2); y(1)*(4-y(1)*y(1))];
t0=1;
tn=30;
h=.001;
y0=[-2, -1];
% A built-in sovler
[ttt,yyy]=ode45(fxn,[t0 tn],y0);
ybuiltin = yyy(end);
[yw,yw_list]=rungeKutta4(fxn,t0,y0,tn,h);
SmtnWrng(5) = round(norm(yw-ybuiltin));


SmtnWrng

