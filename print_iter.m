function print_iter(it_num, x, fval, grad_norm, num_calls, lambda)
    fprintf('\n%12s %12s %12s %12s %12s %12s\n\n', 'iter', 'x  ', 'f(x)', 'norm(grad)', 'ls fun evals', 'lambda');
    fprintf('%12d %12.4f %12.4f %12.4f %12d %12.4f\n', it_num, x(1), fval, grad_norm, num_calls, lambda)
    for i = 2:length(x)
        fprintf('%12s %12.4f\n', '', x(i))
    end
    fprintf('\n')
end