function [lambda, armijoDeltaN] = armijo_debug(lambda, F, epsilon, alpha, gradf0, f0)
    armijoDeltaN = 0;

    
    plot(lambda, F(lambda), 'k*'); hold on;
    while F(alpha*lambda) < f0 + epsilon * gradf0*alpha*lambda
        lambda = alpha * lambda;
        plot(lambda, F(lambda), 'k*');
        armijoDeltaN = armijoDeltaN + 1;
    end
    
    plot(lambda*alpha, F(lambda*alpha), 'r*'); hold on;
    
    armijoDeltaN = armijoDeltaN + 2;
    while F(lambda) > f0 + epsilon * gradf0*lambda
        lambda = lambda/alpha;
        plot(lambda*alpha, F(lambda*alpha), 'm*'); hold on;
        armijoDeltaN = armijoDeltaN + 1;
    end
    plot(lambda, F(lambda), 'g*'); hold on;
    plot([0 lambda*alpha], [f0 f0+gradf0*lambda*alpha*epsilon], 'g'); hold on;
end