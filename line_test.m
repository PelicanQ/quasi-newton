%% Quadratic
a=-10; 
% try a = 2, a = -2 too, then a = 5 and -5, then a = 10 and -10
F=@(lambda) (1-10^a*lambda).^2;
[x, ~, val] = line_search_debug(F)

%% Flat. Should take only 1 or 0 steps
F = @(x) 1 + 0*x;
[x, ~, val] = line_search_debug(F)


%% Exp
F = @(x) exp(-x);
[x, ~, val] = line_search_debug(F)

%% Inf
F = @(lambda) (1e58*lambda-1).^100;

[x, ~, val] = line_search_debug(F)


%% Inf/NaN
F = @(lambda) (1e-58*lambda-1).^2;
[x, ~, val] = line_search_debug(F);