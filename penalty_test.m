x0 = [-2 2 2 -1 -1]';
x1 = [0 0 0 0 0]'; % does not move, gradient of auxiliary is 0
x2 = [1 0 0 0 0]';
x3 = [0 1 0 0 0]';
x4 = [0 0 10 0 0]';
x5 = [1 2 3 4 5]'; % devil very large!
x6 = [1 1 1 1 1]'; % comes back to around 1 0 0 0 0
x = x5;

%a = @(x) exp(x(1)*x(2)*x(3)*x(4)*x(5)) + 1e-2*penalty(x);
%b = [2 0 1 0 1]';

%[matlab_xmin, fval, exitflag, output] = fminunc(a, x6, options)
%[x, N_eval, N_iter, normg] = nonlinearmin(a, x6, 'D', 1e-6, 0, 0);
%x
%matlab_xmin
%f(x)
%f(matlab_xmin)

for n=0:0.1:1
    x = [n n n n n]';
    %[x_min] = mu_test(x);
end

xmin = mu_test(x)
function [x_min, N_eval, N_iter, normg] = mu_test(x0)

    tol_minor = 1e-4;
    tol_major = 1e-8;  % if tolerances get too low, line search fails
    method = 'DFP';
    MAX_ITER = 100;
    restart = 1;
    printout = 1;

    MU = 1e-10;
    phi = @(x, mu) exp(x(1)*x(2)*x(3)*x(4)*x(5)) + mu*penalty(x);
    x = x0;
    lastx = x0;

    i = 0;
    while i < MAX_ITER
        f = @(x) phi(x, MU);
        [x, N_eval, N_iter, normg] = nonlinearmin(f, x, method, tol_minor, restart, printout);
        
        options = optimoptions(@fminunc);
        matlab_x = fminunc(f, x, options)
        %diff = x - matlab_x;
        %norr = norm(diff)

        i = i + 1;
        MU = MU*sqrt(10);
        if (norm(x-lastx) < tol_major) && i > 25
            break
        end
        lastx = x;
    end
    x_min = x;
end





% at some points, matlab says "possible" and ours 
% the point gives same as matlab
% matlab vs our - diff decreases but starts pretty large 0.01
% too small tolerance on gradient can cause error. Prolly cause grad 1e-8
% we chose directional check since feeding linesearch too flat could get error
% Grad could be some magnitudes larger than directional. Overall this will
% terminate earlier