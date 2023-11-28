function [lambda,deltaN] = armijo(lambda, F, epsilon, alpha, gradf0)
    f0 = F(0);
    deltaN = 1;
    while F(alpha*lambda) < f0 + epsilon * gradf0*alpha*lambda
        lambda = alpha *lambda;
        deltaN = deltaN +1;
    end
    deltaN = deltaN + 2;
    while F(lambda) > f0 + epsilon * gradf0*lambda
        lambda = lambda/alpha;
        deltaN = deltaN +1;
    end
end
