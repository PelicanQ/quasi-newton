function [lambda, deltaN, fval] = wolf_debug(F, lambda0, epsilon, sigma, alpha, gradf0, f0)
    if gradf0 > 0
        error('positive derivative was given')
    end

    deltaN = 0; 
    a = 0;

    [lambda, armijoDeltaN] = armijo_debug(lambda0, F, epsilon, alpha, gradf0, f0);
    
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
        
        % Now start bracketing
        b = lambda;
        lambda = (a+b)/2;
        
        %hold on
        %plot([a a], [F(a) F(a)+0.1])
        %plot([b b], [F(b) F(b)-0.1])
        %hold on
        
        deltaN = deltaN + 2; % from next grad
        while abs(grad(F,lambda)) > -sigma*gradf0
            
            deltaN = deltaN + 2;
            if grad(F,lambda) < 0
                a = lambda;
                %plot([a a], [F(a) F(a)+0.1]); hold on;
            else
                b = lambda;
                %plot([b b], [F(b) F(b)-0.1]); hold on;
            end
            deltaN = deltaN +2;
            lambda = (a+b)/2;
                
            
            % stop if interval is too small.
            if b-a < 1e-6
                fprintf("Exiting due to small interval in bracketing!!\n")
                break
            end
        end
    end
    fval = F(lambda);
    deltaN = deltaN + 1;
    % delete below when done debuggning

    if (isnan(fval) || fval > f0)
        error('Bad job of the line search!')
    end
end