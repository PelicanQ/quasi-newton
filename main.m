tol = 1e-4;
method = 'DFP';
restart = 0;
printout = 0;
x0 = [0; 0];
t = @(x) x(1)^2 + x(1)*x(2) + 0.5*x(2)^2 - x(2);
[x, N_eval, N_iter, normg] = nonlinearmin(t, x0, method, tol, restart, printout);

x
N_eval
N_iter
normg

