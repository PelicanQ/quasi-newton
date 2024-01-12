function [x, N_eval, N_iter, normg] = nonlinearmin(f, x0, method, tol, restart, printout)
    MAX_ITER = 1e4;
    useDFP = strcmp(method, 'DFP');
    N_iter = 0;

    N = length(x0); % Antal variabler
    
    Dk = eye(N, N); % Identity as first choice
    gk = grad(f, x0);
    normg = norm(gk);
    N_eval = N*2; % From grad
 
    dk = -gk;
    F = @(lambda) f(x0 + lambda*dk);
    gradf0 = dk' * gk;
    N_eval = N_eval+2; % from 1D derivative

    if gradf0 > 0
        warning("Exiting. Derivative to line search was positive.")
        return;
    end
    if normg <= tol
        x = x0;
        if printout
            print_iter(0, x0, F(0), normg, N_eval, 0)
        end
        return
    end
    
    [lambda, deltaN, fval] = line_search(F, gradf0);

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
            fprintf("Exiting: norm(grad) below tolerance\n\n")
            break
        end

        % Another iteration should be done. Get matrix Dk

        qk = gk - lastgk;
        pk = x - lastx;
        
        if restart && mod(N_iter, N) == 0
            Dk = eye(N, N);
        else
            if useDFP
                Dk = DFP(pk, qk, Dk);
            else
                Dk = BFGS(pk, qk, Dk);
            end
        end
       
        % Now perform wolf step

        dk = -Dk*gk;
        F = @(lambda) f(x+lambda*dk);
        gradf0 = dk' * gk;
         
        N_eval = N_eval + 2; % from 1D deriv

        if gradf0 > 0
            warning("Exiting. Derivative to line search was positive.")
            break
        end
        
        % 
        % if abs(gradf0) <= tol
        %     fprintf("Exiting: directional derivative size below tolerance\n\n")
        %     % we checked and sometimes the directional derivative is 100
        %     % times smaller than norm(gradient). This could cause errors
        %     break
        % end


        [lambda, deltaN, fval] = line_search(F, gradf0);
        

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

