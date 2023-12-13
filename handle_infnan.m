function [lambda, fval, infnan_deltaN] = handle_infnan(G, G0)
    fprintf("NaN/Inf derivative calculated. Backtracking\n")
    a = 1e-8;
    Ga = G(a);
    infnan_deltaN = 1; % from Ga

    while isnan(Ga) || isinf(Ga)
        a = a*0.1;
        if a < 1e-300
            error('Failed to backtrack to non-Inf/non-NaN in line search. step too tiny')
        end
        Ga = G(a);
        infnan_deltaN = infnan_deltaN + 1; % from Ga
    end
    % a real a is found. Keep backtracking and pick smallest
    
    min_val = G0;
    x_min = 0;
   
    while a > 1e-300
        %loglog(a, G(a),'b*'); hold on;
        if Ga < min_val
            min_val = Ga;
            x_min = a;
        end
        a = a*0.1;
        Ga = G(a);
        infnan_deltaN = infnan_deltaN + 1; % from Ga
    end

    lambda = x_min;
    fval = min_val;
end