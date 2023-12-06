function p5 = legendrePolynomial5()
    syms x;
    f = @(x, k) (x^2 - 1) ^ k;
    pp = @(x) f(x, 5);
    p = pp(x);
    for i = 1:5
        p = diff(p);
    end
    p = simplify(p);
    p5 = p / ((2^5) * factorial(5));
end
