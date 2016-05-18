function messageMatrix = MessageMatrixMSR(Message, Parameter, GF)

    messageMatrix = repmat(GF(1), Parameter(3), (Parameter(3) - Parameter(2) + 1));
    s1Matrix = repmat(GF(1), (Parameter(2) - 1), (Parameter(2) - 1));
    s2Matrix = repmat(GF(1), (Parameter(2) - 1), (Parameter(2) - 1));

    u = 0;

    % Construct symetric matrix s1Matrix
    for i = 1 : (Parameter(2) - 1)
        for j = 1 : i
            u = u + 1;
            s1Matrix(i, j) = GF(Message(u) + 1);
        end
    end
    s1Matrix = s1Matrix + transpose(s1Matrix) - diag(diag(s1Matrix));

    % Construct symetric matrix s2Matrix
    for i = 1 : (Parameter(2) - 1)
        for j = 1 : i
            u = u + 1;
            s2Matrix(i, j) = GF(Message(u) + 1);
        end
    end
    s2Matrix = s2Matrix + transpose(s2Matrix) - diag(diag(s2Matrix));

    messageMatrix(1 : (Parameter(2) - 1), 1 : (Parameter(2) - 1)) = s1Matrix;
    messageMatrix(Parameter(2) : (2 * Parameter(2) - 2), 1 : (Parameter(2) - 1)) = s2Matrix;

    % Construct tMatrix and zMatrix for the code whose (d > 2 * k - 2)
    if(Parameter(3) > 2 * Parameter(2) - 2)
        tMatrix = repmat(GF(1), (Parameter(2) - 1), (Parameter(3) - 2 * Parameter(2) + 2));
        zMatrix = repmat(GF(1), (Parameter(3) - 2 * Parameter(2) + 2), (Parameter(3) - 2 * Parameter(2) + 2));

        for i = 1 : (Parameter(2) - 1)
            for j = 1 : (Parameter(3) - 2 * Parameter(2) + 2)
                u = u + 1;
                tMatrix(i, j) = GF(Message(u) + 1);
            end
        end

        for i = 1 : (Parameter(3) - 2 * Parameter(2) + 2)
            u = u + 1;
            zMatrix(1, i) = GF(Message(u) + 1);
            zMatrix(i, 1) = GF(Message(u) + 1);
        end

        messageMatrix((2 * Parameter(2) - 1) : Parameter(3), 1 : (Parameter(2) - 1)) = transpose(tMatrix);
        messageMatrix(Parameter(2) : (2 * Parameter(2) - 2), Parameter(2) : (Parameter(3) - Parameter(2) + 1)) = tMatrix;
        messageMatrix((2 * Parameter(2) - 1) : Parameter(3), Parameter(2) : (Parameter(3) - Parameter(2) + 1)) = zMatrix;
    end
    
end
