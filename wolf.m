function [lambda, deltaN, fval] = wolf(F, lambda0, epsilon, sigma, alpha, gradf0)
    if gradf0 > 0
        error('positive derivative was given')
    end

    f0 = F(0);
    deltaN = 1; % from f0
    
    if abs(gradf0) < 1e-30 || abs(gradf0) > 1e30
        lambda = lambda0;
        fval = f0;
        return
        % if we're given a tiny derivative, we take the small lambda0 step
        % anyways
    end
    
    a = 0;

    [lambda, armijoDeltaN]= armijo(lambda0, F, epsilon, alpha, gradf0, f0);
    deltaN = deltaN + armijoDeltaN; % from armijo

    deltaN = deltaN + 2; % from grad in if
    
    if abs(grad(F,lambda)) > -sigma*gradf0
        
        deltaN = deltaN + 2; % from grad in next while  
        while(grad(F, lambda)) < 0
             
            deltaN = deltaN + 2;
            a = lambda;
            lambda = alpha*lambda;

            deltaN = deltaN + 2; % from next grad in if
            if abs(grad(F, lambda)) <= -sigma*gradf0
                % wolfe satisfied
                break;
            end
        end 
        b = lambda;
        lambda = (a+b)/2;
        
        % Now start bracketing
        
        deltaN = deltaN + 2; % from next grad
        while abs(grad(F,lambda)) > -sigma*gradf0
            deltaN = deltaN + 2;
            if grad(F,lambda) < 0
                a = lambda;
            else
                b = lambda;
            end
            deltaN = deltaN +2;
            lambda = (a+b)/2;

        end
    end
    fval = F(lambda);
    deltaN = deltaN + 1;
    % delete below when done debuggning

    if (isnan(fval) || fval > f0)
        error('Bad job of the line search!')
    end
end