function [lambda, deltaN, fval] = line_search(F, gradish)
    F0 = F(0);
    deltaN = 1; % from G0

    if isnan(F0)
        error("I was started in a NaN point!");
    elseif isinf(F0)
        error("I was started in an Inf point!");
    end

    gradf0 = gradish;
    
    
    % if nan or inf. try if f(x) is inf itself
    % if not: try stepping to smaller value
    % if f(x) is bad, we gotta rely on not stepping into bad areas.

    if isnan(gradf0) || isinf(gradf0)
        [lambda, fval, infnan_deltaN] = handle_infnan(F, F0);
        deltaN = deltaN + infnan_deltaN;
        return
    end

    if gradf0 == 0
        [lambda, fval, flat_deltaN] = handle_flat(F, F0);
        deltaN = deltaN + flat_deltaN;
        return 
    end
    
    
    lambda0 = 0.5;
    eps = 0.2;
    sigma = 0.5;
    alpha = 2;

    %hold off
    %plot(0, F(0), 'go'); hold on;
    [lambda, deltaN, fval] = wolf(F, lambda0, eps, sigma, alpha, gradf0, F0);
    
    %fprintf("Min value: %e at %e \n", G(lambda), lambda)

    %xx =  linspace(-lambda/10,  lambda*alpha, 1000);
    %if lambda < 0
    %    xx =  linspace(lambda*alpha,  abs(lambda)/10, 1000);
    %end
    
    %xlim([xx(1) xx(end)])
    
    %hold on
    %plot(xx, F(xx), 'b');
    %title('(Possibly) rescaled function')
    %hold on
    %plot(lambda, F(lambda), 'ro')
end