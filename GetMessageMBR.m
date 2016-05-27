function messageMBR = GetMessageMBR(MessageMatrix, Parameter, GF)
    
    u = 0;

    for i = 1 : Parameter(2)
        for j = 1 : i
            u = u + 1;
            messageMBR(u) = find(GF == MessageMatrix(i, j)) - 1;
        end
    end

    for i = 1 : Parameter(2)
        for j = (Parameter(2) + 1) : size(MessageMatrix, 2)
            u = u + 1;
            messageMBR(u) = find(GF == MessageMatrix(i, j)) - 1;
        end
    end
end
