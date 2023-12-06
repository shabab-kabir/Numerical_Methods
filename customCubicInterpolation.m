function interpolatedY = customCubicInterpolation(x, y, xq)
    % Custom cubic interpolation function
    % x: Input values
    % y: Output values
    % xq: Query points

    % Ensure x and y are column vectors
    x = x(:);
    y = y(:);

    % Compute differences
    h = diff(x);
    dy = diff(y);

    % Compute second differences
    d2y = diff(dy);

    % Initialize interpolated values
    interpolatedY = zeros(size(xq));

    % Interpolation loop
    for i = 1:length(xq)
        % Find the interval for interpolation
        idx = find(xq(i) >= x, 1, 'last');

        if isempty(idx)
            idx = 1;
        elseif idx == length(x)
            idx = length(x) - 1;
        end

        % Define variables for convenience
        xi = x(idx);
        xi1 = x(idx + 1);
        yi = y(idx);
        yi1 = y(idx + 1);
        hi = h(idx);
        t = (xq(i) - xi) / hi;
        t2 = t * t;
        t3 = t2 * t;

        % Perform cubic interpolation
        interpolatedY(i) = (2 * t3 - 3 * t2 + 1) * yi + (-2 * t3 + 3 * t2) * yi1 + (t3 - 2 * t2 + t) * hi * d2y(idx) + (t3 - t2) * hi * d2y(idx + 1);
    end
end
