x0 = [-2 2 2 -1 -1]';
x1 = [0 0 0 0 0]'; % does not move, gradient of auxiliary is 0
x2 = [1 0 0 0 0]';
x3 = [0 1 0 0 0]';
x4 = [0 10 0 0 0]';
x5 = [0 0 1 0 0]';
x6 = [0 0 10 0 0]';
x7 = [0 0 0 1 0]';
x8 = [0 0 0 0 1]';
x9 = [1 2 3 4 5]'; 
x10 = [1 -1 -1 -1 -1]'; 
x14 = [1 1 1 1 1]'; 
x15 = [-1 40 -13 0.1 11]'; % comes back to around 1 0 0 0 0
x = x10;

xmin = mu_test(x);
function [x_min, N_eval, N_iter, normg] = mu_test(x0)

    tol_minor = 1e-4;
    tol_major = 1e-6;  % if tolerances get too low, line search fails
    method = 'BFGS';
    MAX_ITER = 200;
    restart = 1;
    printout = 0;
    F = @(x) exp(x(1)*x(2)*x(3)*x(4)*x(5));

    MU = 1e-20;
    
    phi = @(x, mu) F(x) + mu*penalty(x);

    x = x0;
    lastx = x0;

    i = 0;
    while i < MAX_ITER
        %fprintf("new mu=%e\n", MU);
        f = @(x) phi(x, MU);
        [x, N_eval, N_iter, normg] = nonlinearmin(f, x, method, tol_minor, restart, printout);
        
        %options = optimoptions(@fminunc);
        %matlab_x = fminunc(f, x, options);
        %norr = norm(diff)

        i = i + 1;
        MU = MU*2;
        if (norm(x-lastx) < tol_major) && i > 40 % enforce a minimum number of iterations
            break
        end
        lastx = x;
    end
    x_min = x;
    val = f(x)
    x = x
end

%%



% at some points, matlab says "possible" and ours 
% the point gives same as matlab
% matlab vs our - diff decreases but starts pretty large 0.1
% too small tolerance on gradient can cause error. Prolly cause grad 1e-8

% we chose directional check since feeding linesearch too flat could get error
% Grad could be some magnitudes larger than directional. Overall this will
% terminate earlier

%TODO show good line search
% plot mu iterations, see increase like theory
% show difference to matlabs x
% see även matlab cannot decrease in search direction. So not weird that we
% get positive derivative also
% då derivata ändras snabbt kan vara problematiskt.
% Kanske i sånna punkter som dk väljs dåligt.

% say why some points dont move anywhere (gradient is zero)
