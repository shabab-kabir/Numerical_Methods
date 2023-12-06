function derivative = three_point_centered_difference(f, x, h)
    % Compute the derivative of the function f at point x using the
    % three-point centered difference formula.
    
    % f: Function handle for the function to be differentiated.
    % x: The point at which the derivative is to be approximated.
    % h: The step size for the finite difference.
    
    if h == 0
        error('Step size (h) must be nonzero');
    end
    
    % Apply the centered difference formula
    derivative = (f(x + h) - f(x - h)) / (2 * h);
end
