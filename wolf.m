function [lambda, deltaN, fval] = wolf(F, lambda0, epsilon, sigma, alpha, gradf0)
    a = 0;
    f0 = F(0);
    deltaN = 1;
    lambda = armijo(lambda0, F, epsilon, alpha, gradf0, f0);
    deltaN = deltaN +2;
    
    if abs(grad(F,lambda)) > -sigma*gradf0
        deltaN = deltaN +2;
        while(grad(F,lambda)) < 0 
            deltaN = deltaN + 2;
            a = lambda;
            lambda = alpha*lambda;
            deltaN = deltaN +2;

            if abs(grad(F, lambda)) <= -sigma*gradf0
                % wolfe satisfied
                break;
            end
        end 
        b = lambda;
        lambda = (a+b)/2;
        deltaN = deltaN +2;
        while abs(grad(F,lambda)) > -sigma *gradf0
            deltaN = deltaN +2;
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