tol_minor = 1e-4;
tol_major = 1e-6;  % if tolerances get too low, line search fails
method = 'BFGS';
MAX_ITER = 40;
restart = 1;
printout = 1;

x0 = [-2 2 2 -1 -1]';
x1 = [0 0 0 0 0]'; % does not move, gradient of auxiliary is 0
x2 = [1 0 0 0 0]';
x3 = [0 1 0 0 0]';
x4 = [0 0 10 0 0]';
x5 = [1 2 3 4 5]'; % devil very large!
x6 = [1 1 1 1 1]'; % comes back to around 1 0 0 0 0
x = x6./10;

mu = 1e-8;
phi = @(x) exp(x(1)*x(2)*x(3)*x(4)*x(5)) + mu*penalty(x);
lastx = x;
i = 0;
while i < MAX_ITER
    mu = mu*10;
    [x, N_eval, N_iter, normg] = nonlinearmin(phi, x, method, tol_minor, restart, printout);
    i = i + 1;
    if norm(x-lastx) < tol_major
        break
    end
    lastx = x;
    
end
i
x