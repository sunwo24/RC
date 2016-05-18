function generatorMSR = GeneratorMatrixMSR(Parameter, GF)

    % generatorMSR = [(lambdaMatrix * phiMatrix) | phiMatrix | deltaMatrix ]
    generatorMSR = repmat(GF(1), Parameter(1), Parameter(3));
    lambdaMatrix = repmat(GF(1), Parameter(1), Parameter(1));
    phiMatrix = repmat(GF(1), Parameter(1), (Parameter(2) - 1));

    % Construct diagonal lambdaMatrix
    diagLambda = repmat(GF(1), 1, Parameter(1));
    diagLambda(1 : Parameter(1)) = GF(2 : (Parameter(1) + 1));
    lambdaMatrix = diag(diagLambda);

    % Construct phiMatrix
    for i = 1 : Parameter(1)
        for j = 1 : (Parameter(2) - 1)
            phiMatrix(i, j) = GF(i + 1)^(2 * (j - 1));
        end
    end

    generatorMSR(1 : Parameter(1), 1 : (Parameter(2) - 1)) = lambdaMatrix * phiMatrix;
    generatorMSR(1 : Parameter(1), Parameter(2) : (2 * Parameter(2) - 2)) = phiMatrix;

    % Construct deltaMatrix for the code whose (d > 2 * k - 2)
    if(Parameter(3) > 2 * Parameter(2) - 2)
        deltaMatrix = repmat(GF(1), Parameter(1), (Parameter(3) - 2 * Parameter(2) + 2));
        for i = 1 : Parameter(1)
            for j = 1 : (Parameter(3) - 2 * Parameter(2) + 2)
                deltaMatrix(i, j) = GF(i + 1)^(2 * Parameter(2) - 3 + j);
            end
        end
        generatorMSR(1 : Parameter(1), (2 * Parameter(2) - 1) : Parameter(3)) = deltaMatrix;
    end

end
