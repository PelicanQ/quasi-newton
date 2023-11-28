function [x,N_eval,N_iter,normg] = nonlinearmin(f,x0,method,tol,restart,printout)

% f is objective function
% x0 is initial point
% 'DFP' or 'BFGS' is the method
% tol is a user-defined tolerance
sigma = 0.5;
epsilon = 0.2;
alpha = 2;
lambda0 = 0.1;

N = length(x0); % Antal variabler
Dk = eye(N,N); % Enhetsmatrisen
N_eval = 1; 

gk = grad(f,x0);
N_eval = N_eval + N*2;

dk = -Dk*gk;
F = @(lambda) f(x0+lambda*dk);
[lambda,deltaN] = Wolf(F,lambda0,epsilon,sigma, alpha);
N_eval = N_eval + deltaN; 
x = x0 + lambda*dk;
lastx = x0;
lastgk = gk;
N_iter = 1;

while norm(gk) > tol N_iter mod

    gk = grad(f,x);
    N_eval = N_eval + N*2;
    qk = gk - lastgk;
    pk = x - lastx;
    
  
    if strcmp(method, 'DFP')
        Dk = DFP(pk,qk,Dk);
    else
        Dk = BFGS(pk,qk,Dk);
    end
   
    
    dk = -Dk*gk;
    F = @(lambda) f(x+lambda*dk);
    [lambda,deltaN] = Wolf(F,lambda0,epsilon,sigma, alpha);
    N_eval = N_eval + deltaN; 
    
    
    lastgk = gk;
    lastx = x;
    x = x + lambda*dk;
   
    N_iter = N_iter + 1;
end

    normg = norm(grad(f,x));
    N_eval = N_eval + 1;

end
