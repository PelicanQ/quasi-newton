%% Flat. Should take only 1 or 0 steps
F = @(x) 1 + 0*x;
test(F)
%% Quadratic
F = @(x) 1 + (x-5).^2;
test(F)

%% Exp
F = @(x) exp(-(x-10));
test(F)

function test(F)
    close all
    gradf0 = grad(F, 0);
    lambda0 = 0.1;
    eps = 0.2;
    sigma = 0.5;
    alpha = 2;

    xx = -10 : 0.01 : 10;
    
    plot(xx, F(xx), 'b');
    hold on
    %plot(0, F(0), 'go')
    [lambda, deltaN, fval] = wolf_test(F, lambda0, eps, sigma, alpha, gradf0);
    %plot(lambda, F(lambda), 'ro')
    
end