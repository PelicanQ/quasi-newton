epsilon = 0.1;
tol = 1e-4;
restart = 0;
printout = 0;
fprintf('\n%12s %12s %12s %12s %12s %15s\n\n','Method','N', 'iter', 'f(x)', 'norm(grad)', 'ls fun evals');
%
%% Test 1

N = 10;
A = 10 * rand(N, N);
A = A*A' + epsilon*eye(N);

F = @(x) x' * A * x;
x0 = 5 *rand(10, 1);

[x, N_eval, N_iter, normg] = nonlinearmin(F, x0, 'DFP', tol, restart, printout);
fprintf('%12s %12.4f %12.4f %12.4f %12f %12.4f\n','DFP', N, N_iter, F(x), normg, N_eval)

%% Test 2

[x, N_eval, N_iter, normg] = nonlinearmin(F, x0, 'BFGS', tol, restart, printout);
fprintf('%12s %12.4f %12.4f %12.4f %12f %12.4f\n','BFGS', N, N_iter, F(x), normg, N_eval)

%% Test 3

N = 20;
A = 10 * rand(N, N);
A = A*A' + epsilon*eye(N);

F = @(x) x' * A * x;
x0 = 5 *rand(N, 1);

[x, N_eval, N_iter, normg] = nonlinearmin(F, x0, 'DFP', tol, restart, printout);
fprintf('%12s %12.4f %12.4f %12.4f %12f %12.4f\n','DFP', N, N_iter, F(x), normg, N_eval)

%% Test 4

[x, N_eval, N_iter, normg] = nonlinearmin(F, x0, 'BFGS', tol, restart, printout);
fprintf('%12s %12.4f %12.4f %12.4f %12f %12.4f\n','BFGS', N, N_iter, F(x), normg, N_eval)

%% Test 5

N = 30;
A = 10 * rand(N, N);
A = A*A' + epsilon*eye(N);

F = @(x) x' * A * x;
x0 = 5 *rand(N, 1);

[x, N_eval, N_iter, normg] = nonlinearmin(F, x0, 'DFP', tol, restart, printout);
fprintf('%12s %12.4f %12.4f %12.4f %12f %12.4f\n','DFP', N, N_iter, F(x), normg, N_eval)

%% Test 6

[x, N_eval, N_iter, normg] = nonlinearmin(F, x0, 'BFGS', tol, restart, printout);
fprintf('%12s %12.4f %12.4f %12.4f %12f %12.4f\n','BFGS', N, N_iter, F(x), normg, N_eval)

%% Test 7

N = 40;
A = 10 * rand(N, N);
A = A*A' + epsilon*eye(N);

F = @(x) x' * A * x;
x0 = 5 *rand(N, 1);

[x, N_eval, N_iter, normg] = nonlinearmin(F, x0, 'DFP', tol, restart, printout);
fprintf('%12s %12.4f %12.4f %12.4f %12f %12.4f\n','DFP', N, N_iter, F(x), normg, N_eval)

%% Test 8

[x, N_eval, N_iter, normg] = nonlinearmin(F, x0, 'BFGS', tol, restart, printout);
fprintf('%12s %12.4f %12.4f %12.4f %12f %12.4f\n','BFGS', N, N_iter, F(x), normg, N_eval)

%% Test 9

N = 100;
A = 10 * rand(N, N);
A = A*A' + epsilon*eye(N);

F = @(x) x' * A * x;
x0 = 5 *rand(N, 1);

[x, N_eval, N_iter, normg] = nonlinearmin(F, x0, 'DFP', tol, restart, printout);
fprintf('%12s %12.4f %12.4f %12.4f %12f %12.4f\n','DFP', N, N_iter, F(x), normg, N_eval)

%% Test 10

[x, N_eval, N_iter, normg] = nonlinearmin(F, x0, 'BFGS', tol, restart, printout);
fprintf('%12s %12.4f %12.4f %12.4f %12f %12.4f\n','BFGS', N, N_iter, F(x), normg, N_eval)

%% Test 11

N = 2;
A = 10 * rand(N, N);
A = A*A' + epsilon*eye(N);

F = @(x) x' * A * x;
x0 = 5 *rand(N, 1);

[x, N_eval, N_iter, normg] = nonlinearmin(F, x0, 'DFP', tol, restart, printout);
fprintf('%12s %12.4f %12.4f %12.4f %12f %12.4f\n','DFP', N, N_iter, F(x), normg, N_eval)

%% Test 12

[x, N_eval, N_iter, normg] = nonlinearmin(F, x0, 'BFGS', tol, restart, printout);
fprintf('%12s %12.4f %12.4f %12.4f %12f %12.4f\n','BFGS', N, N_iter, F(x), normg, N_eval)

% %% Test Rosenbrock
% printout = 1;
% F = @(x) rosenbrock(x);
% fprintf('Rosenbrock without restart \nDFP: \n')
% [x, N_eval, N_iter, normg] = nonlinearmin(F, [0;0], 'DFP', tol, restart, printout);
% 
% %% BFGS
% fprintf('BFGS: \n')
% [x, N_eval, N_iter, normg] = nonlinearmin(F, [0;0], 'BFGS', tol, restart, printout);
% 
% %% With restart
% restart = 1;
% 
% fprintf('Rosenbrock with restart \nDFP: \n')
% [x, N_eval, N_iter, normg] = nonlinearmin(F, [0;0], 'DFP', tol, restart, printout);
% 
% %% BFGS
% fprintf('BFGS: \n')
% [x, N_eval, N_iter, normg] = nonlinearmin(F, [0;0], 'BFGS', tol, restart, printout);


















