function generatorMISER = GeneratorMatrixMISER(Parameter, GF)

    alphaSize = (Parameter(3) - Parameter(2) + 1);

    % alpha * (n - k) Vandermonde Matrix
    vandermondeMatrix = VandermondeMatrix(alphaSize, (Parameter(1) - Parameter(2)), GF);

    % systimatical 
    generatorMISER = repmat(GF(1), alphaSize * Parameter(2), alphaSize * Parameter(1));
    for i = 1 : size(generatorMISER, 1)
        generatorMISER(i, i) = GF(2);
    end

    % parity
    for i = 1 : Parameter(2)
        for j = 1 : alphaSize
            tmpM = repmat(GF(1), alphaSize, alphaSize);
            tmpM(:, j) = vandermondeMatrix(:, i);
            for t = 1 : alphaSize
                if tmpM(t, t) == 0
                    tmpM(t, t) = vandermondeMatrix(j, i);
                end
            end
            generatorMISER((alphaSize * (j - 1) + 1) : (alphaSize * (j - 1) + alphaSize), ...
                            (alphaSize * (Parameter(2) + i - 1) + 1) : (alphaSize * (Parameter(2) + i - 1) + alphaSize)) = tmpM;
        end
    end

