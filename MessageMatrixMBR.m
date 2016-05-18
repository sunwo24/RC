function messageMatrix = MessageMatrixMBR(Message, Parameter, GF)

    messageMatrix = repmat(GF(1), Parameter(3), Parameter(3));
    sMessage = repmat(GF(1), Parameter(2), Parameter(2));
    tMessage = repmat(GF(1), Parameter(2), (Parameter(3) - Parameter(2)));

    u = 0;

    for i = 1 : Parameter(2)
        for j = 1 : i
            u = u + 1;
            sMessage(i, j) = GF(Message(u) + 1);
        end
    end
    sMessage = sMessage + transpose(sMessage) - diag(diag(sMessage));

    for i = 1 : Parameter(2)
        for j = 1 : (Parameter(3) - Parameter(2))
            u = u + 1;
            tMessage(i, j) = GF(Message(u) + 1);
        end
    end

    messageMatrix(1 : Parameter(2), 1 : Parameter(2)) = sMessage;
    messageMatrix(1 : Parameter(2), (Parameter(2) + 1) : Parameter(3)) = tMessage;
    messageMatrix((Parameter(2) + 1) : Parameter(3), 1 : Parameter(2)) = transpose(tMessage);

end

