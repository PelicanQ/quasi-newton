tol = 1e-4;
method = 'DFP';
restart = 1;
printout = 1;
x0 = [1; 1];
x1 = [0; 0];
x2 = [3; 5];
x3 = [-10; 20];

%%
[x, N_eval, N_iter, normg] = nonlinearmin(@rosenbrock, x0, method, tol, restart, printout);

%%
[x, N_eval, N_iter, normg] = nonlinearmin(@rosenbrock, x1, method, tol, restart, printout);

%%
[x, N_eval, N_iter, normg] = nonlinearmin(@rosenbrock, x2, method, tol, restart, printout);

%%
[x, N_eval, N_iter, normg] = nonlinearmin(@rosenbrock, x3, method, tol, restart, printout);
