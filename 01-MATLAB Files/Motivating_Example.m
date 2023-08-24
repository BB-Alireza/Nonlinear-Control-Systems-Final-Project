clc; clear all; close all;
% Define the system parameters
lambda = 8;
k = 10;

% % Define the state space matrices
% A = [0 1; -3 0];
% B = [0; 1];

% Define the sliding surface and its derivative
s = @(x) x(2) + 2*lambda*x(1)^2;
s_dot = @(x) 2*lambda*2*x(1)*x(2);

% Define the switching function
h = @(s, s_dot) -k*sign(s) - 0.5*s_dot;

% Define the initial conditions
x0 = [1; -1];

% Define the simulation time span
tspan = [0 20];

% Define the dynamics function
dynamics = @(t, x) [x(2); -x(1)^3 + h(s(x), s_dot(x))+0.2*sin(2*t)];

% Simulate the system using ode45
[t, x] = ode45(dynamics, tspan, x0);

% Plot the results
figure;
plot(t, x(:, 1), 'b', 'LineWidth', 0.8);
hold on
plot(t, x(:, 2), 'r', 'LineWidth', 0.8);
xlabel('Time (s)');
legend('X_{1} (t)', 'X_{2} (t)');
ylim([-2.5 1.5]);
title('Dynamic Sliding Mode Control of a Nonlinear System');
grid on;
