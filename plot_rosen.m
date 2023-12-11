% Define the range for x1 and x2
x1 = linspace(-10, 10, 100);
x2 = linspace(-10, 10, 100);

% Create a grid of values for x1 and x2
[X1, X2] = meshgrid(x1, x2);

% Initialize the output matrix Y with zeros
Y = zeros(size(X1));

% Evaluate Rosenbrock's function at each point in the grid
for i = 1:numel(X1)
    Y(i) = rosenbrock([X1(i), X2(i)]);
end

% Plot the surface
figure;
surf(X1, X2, Y);
title('Rosenbrock Function');
xlabel('x1');
ylabel('x2');
zlabel('f(x)');
