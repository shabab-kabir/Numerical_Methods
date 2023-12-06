function computeGaussianQuadratureDataToFile(upToN, tol)
    fileName = 'GaussianQuadratureData.m';
    fileID = fopen(fileName, 'w');
    
    fprintf(fileID, '%% Gaussian Quadrature Data\n\n');
    
    for n = 2:upToN
        fprintf('Processing Case %d...\n', n);
        
        % Compute nodes and weights
        nodes = findLegendreRoots(n);
        weights = gaussianQuadratureCoefficients(n, tol);

        % Combine nodes and weights
        C_Case = [nodes, weights];

        % Write to file
        fprintf(fileID, 'C_Case_%d = [\n', n);
        fprintf(fileID, '%.15f\n', C_Case);
        fprintf(fileID, '];\n\n');
    end

    fclose(fileID);
    disp(['Data written to ', fileName]);
end
