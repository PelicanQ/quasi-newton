function Dk1 = DFP(p,q,D)
Dk1 = D + p*p'/(p'*q) - D*q*q'*D/(q'*D*q);

end
