% This script will use RK4 to create and return a trajectory according to an initial value problem.
% It will then plot that trajectory for the 2x2 system of equations in a phase plane.

% create the handle for the function defining the ODE.
fxn = @(t,y) [-y(1)-2*y(2), y(1)*(4-y(1)*y(1))];

t0=1;
tn=30;
h=.001;
w0=[-2, -1];
z0=[1, 2];
x0=[0, -2];
v0=[-1, 1];
u0=[2, -1]; % New initial condition
s0=[-1, -2]; % New initial condition

[yw,yw_list]=rungeKutta4(fxn,t0,w0,tn,h);
[yz,yz_list]=rungeKutta4(fxn,t0,z0,tn,h);
[yx,yx_list]=rungeKutta4(fxn,t0,x0,tn,h);
[yv,yv_list]=rungeKutta4(fxn,t0,v0,tn,h);
[yu,yu_list]=rungeKutta4(fxn,t0,u0,tn,h);
[ys,ys_list]=rungeKutta4(fxn,t0,s0,tn,h);

figure(1)
hold off
plot(yw_list(:,2),yw_list(:,3),'r');
hold on
plot(yz_list(:,2),yz_list(:,3),'b');
plot(yx_list(:,2),yx_list(:,3),'g');
plot(yv_list(:,2),yv_list(:,3),'m');
plot(yu_list(:,2),yu_list(:,3),'c'); % Plot for u0
plot(ys_list(:,2),ys_list(:,3),'k'); % Plot for s0

% Enhancements for better visualization
title('Phase Plane Trajectories');
xlabel('y1');
ylabel('y2');
legend({'Initial Condition [-2, -1]', 'Initial Condition [1, 2]', 'Initial Condition [0, -2]', 'Initial Condition [-1, 1]', 'Initial Condition [2, -1]', 'Initial Condition [-1, -2]'}, 'Location', 'eastoutside');
grid on;

% Optional: Set axis limits if necessary
% xlim([xmin xmax]);
% ylim([ymin ymax]);

% Optional: Set a larger font size for better readability
set(gca, 'FontSize', 12);
