function [lambda, fval, flat_deltaN] = handle_flat(G, G0)
    fprintf("Flat derivative calculated. Stepping forwards.\n")
    a = 1e-8;
    min_x = 0;
    min_val = G0;
    Ga = G(a);
    flat_deltaN = 1; % from Ga

    while a < 1e300
        %loglog(a, G(a),'b*'); hold on;
        if Ga < min_val
            min_val = Ga;
            min_x = a;
            
        end
        a = a*10;
        Ga = G(a);
        flat_deltaN = flat_deltaN + 1; % from Ga
    end
    fprintf("Stepping ended at lambda=%e val=%e \n\n", min_x, min_val)
    lambda = min_x;
    fval = min_val;
end