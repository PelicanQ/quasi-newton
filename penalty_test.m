tol_minor = 1e-4;
tol_major = 1e-4;  % if tolerances get too low, line search fails
method = 'DFP';
MAX_ITER = 50;
restart = 1;
printout = 0;
x = [
   -2; 
    2; 
    2; 
   -1; 
   -1
];

mu = 0.001;
phi = @(x) exp(x(1)*x(2)*x(3)*x(4)*x(5)) + mu*penalty(x);
lastx = x;
i = 0;
while i < MAX_ITER
    mu = mu*2;
    [x, N_eval, N_iter, normg] = nonlinearmin(phi, x, method, tol_minor, restart, printout);
    i = i + 1;
    norm(x-lastx)
    if norm(x-lastx) < tol_major
        break
    end
    lastx = x;
    
end
