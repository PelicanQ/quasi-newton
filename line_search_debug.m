function [lambda, deltaN, fval] = line_search_debug(F)
    F0 = F(0);
    deltaN = 1; % from F0

    if isnan(F0)
        error("I was started in a NaN point!");
    elseif isinf(F0)
        error("I was started in an Inf point!");
    end

    gradf0 = grad(F, 0);
    
    
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

    hold off
    plot(0, F(0), 'go'); hold on;
    [lambda, deltaN, fval] = wolf_debug(F, lambda0, eps, sigma, alpha, gradf0, F0);
    
    fprintf("Min value: %e at %e \n", F(lambda), lambda)

    xx =  linspace(-lambda/10,  lambda*alpha, 1000);
    if lambda < 0
        xx =  linspace(lambda*alpha,  abs(lambda)/10, 1000);
    end
    
    xlim([xx(1) xx(end)])
    
    hold on
    plot(xx, F(xx), 'b');
    title("obj function y = "+func2str(F))
    
    hold on
    plot(lambda, F(lambda), 'ro')
    xlabel('x')
    ylabel('y')
end