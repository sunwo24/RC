function generatorMBR = GeneratorMatrixMBR(Parameter, GF)

    generatorMBR = repmat(GF(1), Parameter(1), Parameter(3));
    
    % Vandermonde Matrix
    for i = 1 : Parameter(1)
        for j = 1 : Parameter(3)
            generatorMBR(i, j) = GF(i + 1)^(j - 1);
        end
    end
    
end

