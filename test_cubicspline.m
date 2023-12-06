% samples from a wiggly curve
xvals = [0 0.6 1.5 1.7 1.9 2.1 2.3 2.6 2.8 3.0];
yvals = [-0.8 -0.34 0.59 0.59 0.23 0.1 0.28 1.03 1.5 1.44];

% Use your interpolatingPolynomial implementation
P = interpolatingPolynomial(xvals, yvals);

% Check that it interpolates
numwronginterp = sum(yvals - P(xvals));

% Plot just this polynomial and the points
figure(1);
scatter(xvals, yvals);
hold on;
fplot(P, [0, 3]);

% Pause for 5 seconds to look at the figure
pause(5);

% Continue with cubic spline interpolation
% Assuming cubicspline is a function that you have
S = cubicspline(xvals, yvals);
figure(2);
scatter(xvals, yvals);
hold on;
fplot(S, [0, 3], 'r');

% Add extra points, create new interpolants, make the plots
xtra = [3.6 4.7 5.2 5.7 5.8 6.0 6.4 6.9 7.6 8.0];
ytra = [0.74 -0.82 -1.27 -0.92 -0.92 -1.04 -0.79 -0.06 1.0 0.0];

% Combine the original and additional points
xvals_combined = [xvals, xtra];
yvals_combined = [yvals, ytra];

% Recreate interpolants with combined data
P_combined = interpolatingPolynomial(xvals_combined, yvals_combined);
S_combined = cubicspline(xvals_combined, yvals_combined);

% Plot combined data
figure(3);
scatter(xvals_combined, yvals_combined);
hold on;
fplot(P_combined, [0, 8]);

figure(4);
scatter(xvals_combined, yvals_combined);
hold on;
fplot(S_combined, [0, 8], 'r');
