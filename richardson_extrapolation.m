function second_derivative = richardson_extrapolation(f, x, h, method)
    % Compute the second derivative of the function f at point x using
    % Richardson extrapolation with a specified numerical differentiation method.
    
    % f: Function handle for the function to be differentiated.
    % x: The point at which the second derivative is to be approximated.
    % h: The step size for finite differences.
    % method: Function handle for the numerical differentiation method.
    
    if h == 0
        error('Step size (h) must be nonzero');
    end
    
    % Calculate the second derivative using the specified method and step size
    D1 = method(f, x, h);
    D2 = method(f, x, h / 2);
    
    % Apply Richardson extrapolation
    second_derivative = (4 * D2 - D1) / 3;
end
