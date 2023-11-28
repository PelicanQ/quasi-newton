tol = 1e-4;
method = 'DP';
restart = 0;
printout = 0;
x0 = [40;-20];
[x,N_eval,N_iter,normg] = nonlinearmin(@rosenbrock,x0,method,tol,restart,printout);

x
N_eval
N_iter
normg

