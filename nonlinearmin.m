% f: objective function
% x0: initial point
% method: 'DFP' or 'BFGS'
% tol: user-defined termination tolerance
function [x, N_eval, N_iter, normg] = nonlinearmin(f, x0, method, tol, restart, printout)
    MAX_ITER = 1e5;
    sigma = 0.5;
    epsilon = 0.2;
    alpha = 2;
    lambda0 = 0.1;
    
    N = length(x0); % Antal variabler
    
    Dk = eye(N,N); % Identity as first choice
    gk = grad(f,x0);
    N_eval = N*2; % From grad
 
    dk = -gk;
    gradf0 = dk' * gk;
    F = @(lambda) f(x0+lambda*dk);
  
    [lambda, deltaN, fval] = wolf(F, lambda0, epsilon, sigma, alpha, gradf0);
    
    N_eval = N_eval + deltaN; % Add amount evals from wolf
    N_iter = 1; % one iteration completed

    x = x0 + lambda*dk;
   
    lastx = x0;
    lastgk = gk;
    
    while true
        % We enter this loop with a fresh new x

        gk = grad(f, x);
        N_eval = N_eval + N*2; %from grad
        normg = norm(gk);
        
        if printout
            print_iter(N_iter, x, fval, normg, N_eval, lambda) % Print the iteration which got us to x
        end
        if normg <= tol
            break
        end

        % Another iteration should be done. Get matrix Dk

        qk = gk - lastgk;
        pk = x - lastx;
        
        if restart && mod(N_iter, N) == 0
            Dk = eye(N, N);
        else
            if strcmp(method, 'DFP')
                Dk = DFP(pk, qk, Dk);
            else
                Dk = BFGS(pk, qk, Dk);
            end
        end
       
        % Now perform wolf step

        dk = -Dk*gk;
        F = @(lambda) f(x+lambda*dk);
        gradf0 = dk' * gk;
        [lambda, deltaN, fval] = wolf(F, lambda0, epsilon, sigma, alpha, gradf0);

        N_eval = N_eval + deltaN;  % from wolf
        N_iter = N_iter + 1;
        
        lastx = x;
        x = x + lambda*dk;
        lastgk = gk;    


        if N_iter >= MAX_ITER
            error('Max iterations reached.')
        end
    end
    
end

% Testa linje sök algoritmer
% Testa hela på kvadratiska metoder
% 
% Hur genererar vi ca 50 dimension kvadratisk funktion med positivt def?
% Om vi tar en random 50x50 A så blir A'A har vi en positivt semidefinit
% Sen plussa pytteliten I för att få den pos definit
% 
% wolf, man måste inte lägga in esp = 0.2 för armijo, man slipper några
% derivator om med eps = 0;
% bracketing är som armijo med eps = 0.

