function integral = adaptiveMidpoint(fxn, lwrlim, upplim, tol)
    % Initialize previousValues as an empty container map
    previousValues = containers.Map('KeyType', 'double', 'ValueType', 'double');
    
    % Call the adaptiveMidpointRule function with the provided arguments
    integral = adaptiveMidpointRule(fxn, lwrlim, upplim, tol, previousValues);
end

function integral = adaptiveMidpointRule(f, a, b, tol, previousValues)
    % Compute the midpoint rule for the whole interval
    mid = (a + b) / 2;
    whole = computeOrRetrieve(f, mid, (b - a), previousValues);
    
    % Compute the midpoint rule for the left and right halves
    left_mid = (a + mid) / 2;
    right_mid = (mid + b) / 2;
    left = computeOrRetrieve(f, left_mid, (mid - a), previousValues);
    right = computeOrRetrieve(f, right_mid, (b - mid), previousValues);
    
    % Check if the tolerance criterion is met
    if abs(left + right - whole) < tol
        integral = left + right;
    else
        % Apply the adaptive midpoint rule to each half
        integral_left = adaptiveMidpointRule(f, a, mid, tol / 2, previousValues);
        integral_right = adaptiveMidpointRule(f, mid, b, tol / 2, previousValues);
        integral = integral_left + integral_right;
    end
end

function value = computeOrRetrieve(f, x, width, previousValues)
    if isKey(previousValues, x)
        value = width * previousValues(x);
    else
        fx = f(x);
        previousValues(x) = fx;
        value = width * fx;
    end
end
