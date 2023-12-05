tol = 1e-4;
method = 'DFP';
restart = 0;
printout = 1;
x0 = [0; 0];
[x, N_eval, N_iter, normg] = nonlinearmin(@rosenbrock, x0, method, tol, restart, printout);

