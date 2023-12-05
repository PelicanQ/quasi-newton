epsilon = 0.1;
tol = 1e-4;
restart = 0;
printout = 1;

%% Test 1

N = 10;
A = 10 * rand(N, N);
A = A*A' + epsilon*eye(N);

F = @(x) x' * A * x;
x0 = 5 *rand(10, 1);

[x, N_eval, N_iter, normg] = nonlinearmin(F, x0, 'DFP', tol, restart, printout);

