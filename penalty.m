function pen = penalty(x)
    h1 = norm(x)^2 - 10;
    h2 = x(2)*x(3) - 5*x(4)*x(5);
    h3 = x(1)^3 + x(3)^3 + 1;
    
    pen = h1^2 + h2^2 + h3^2;
    
