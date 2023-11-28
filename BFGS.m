function Dk1 = BFGS(p,q,D)
Dk1 = D + (1/(p'*q))*((1+q'*D*q/(p'*q))*p*p'-D*q*p'-p*q'*D);
end