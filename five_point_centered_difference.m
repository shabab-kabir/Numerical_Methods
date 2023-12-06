function second_derivative = five_point_centered_difference(f, x, h)
    % Compute the second derivative of the function f at point x using the
    % five-point centered difference formula.
    
    % f: Function handle for the function to be differentiated.
    % x: The point at which the second derivative is to be approximated.
    % h: The step size for finite differences.
    
    if h == 0
        error('Step size (h) must be nonzero');
    end
    
    % Compute the second derivative using the five-point centered difference formula
    f_x_plus_h = f(x + h);
    f_x_minus_h = f(x - h);
    f_x_plus_2h = f(x + 2 * h);
    f_x_minus_2h = f(x - 2 * h);
    
    second_derivative = (f_x_plus_2h - 2 * f_x_plus_h + 2 * f_x_minus_h - f_x_minus_2h) / (2 * h^2);
end
