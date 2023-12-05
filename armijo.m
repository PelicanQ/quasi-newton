function [lambda, armijoDeltaN] = armijo(lambda, F, epsilon, alpha, gradf0, f0)
    armijoDeltaN = 0;
    while F(alpha*lambda) < f0 + epsilon * gradf0*alpha*lambda
        lambda = alpha * lambda;
        armijoDeltaN = armijoDeltaN +1;
    end
    armijoDeltaN = armijoDeltaN + 2;
    while F(lambda) > f0 + epsilon * gradf0*lambda
        lambda = lambda/alpha;
        armijoDeltaN = armijoDeltaN + 1;
    end
end