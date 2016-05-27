function messageMSR = GetMessageMSR(MessageMatrix, Parameter, GF)

    u = 0;

    messageS1 = MessageMatrix(1:(Parameter(2) - 1), 1:(Parameter(2) - 1));
    messageS2 = MessageMatrix(Parameter(2):(2 * Parameter(2) - 2), 1:(Parameter(2) - 1));

    for i = 1 : size(messageS1, 1)
        for j = 1 : i
            u = u + 1;
            messageMSR(u) = find(GF == messageS1(i, j)) - 1;
        end
    end

    for i = 1 : size(messageS2, 1)
        for j = 1 : i
            u = u + 1;
            messageMSR(u) = find(GF == messageS2(i, j)) - 1;
        end
    end

    if(Parameter(3) > 2 * Parameter(2) - 2)
        messageTZ = MessageMatrix((2 * Parameter(2) - 1):end, :);
        for i = 1 : size(messageTZ, 2)
            for j = 1 : size(messageTZ, 1)
                u = u + 1;
                messageMSR(u) = find(GF == messageTZ(j, i)) - 1;
            end
        end
    end
end
