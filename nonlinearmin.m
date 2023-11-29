% f: objective function
% x0: initial point
% method: 'DFP' or 'BFGS'
% tol: user-defined termination tolerance
function [x, N_eval, N_iter, normg] = nonlinearmin(f, x0, method, tol, restart, printout)
    
    sigma = 0.5;
    epsilon = 0.2;
    alpha = 2;
    lambda0 = 0.1;
    
    N = length(x0); % Antal variabler
    
    Dk = eye(N,N); % Identity as first choice
    gk = grad(f,x0);
    N_eval = N*2; % From grad

    dk = -gk;
    F = @(lambda) f(x0+lambda*dk);
    [lambda, deltaN] = Wolf(F, lambda0, epsilon, sigma, alpha);
    
    N_eval = N_eval + deltaN; % Add amount evals from wolf

    x = x0 + lambda*dk;
    lastx = x0;
    lastgk = gk;

    N_iter = 2; % We have already done iteration 1 at this point
    
    normg = norm(gk);
    while normg > tol
    
        gk = grad(f, x);
        N_eval = N_eval + N*2; %from grad
        normg = norm(gk);

        qk = gk - lastgk;
        pk = x - lastx;
        
        if mod(N_iter, N) == 0
            Dk = eye(N, N);
        else
            if strcmp(method, 'DFP')
                Dk = DFP(pk, qk, Dk);
            else
                Dk = BFGS(pk, qk, Dk);
            end
        end
       
        
        dk = -Dk*gk;
        F = @(lambda) f(x+lambda*dk);
        [lambda, deltaN, fval] = Wolf(F, lambda0, epsilon, sigma, alpha);
        N_eval = N_eval + deltaN;  % from wolf
        
        
        print_iter(N_iter, x, fval, normg)

        
        lastgk = gk;
        lastx = x;
        x = x + lambda*dk;
    
        N_iter = N_iter + 1;
    end

    normg = norm(grad(f,x));
    N_eval = N_eval + 2*N; % from grad

    

end
