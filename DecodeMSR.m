function messageMatrix = DecodeMSR(DecodeMatrix, DataCollectorMatrix, Parameter)

    % Decode tMatrix and zMatrix for the code whose (d > 2 * k - 2)
    if(Parameter(3) > 2 * Parameter(2) - 2)
        decodeMatrixPhiDelta = DecodeMatrix(:, Parameter(2):(2 * Parameter(2) - 1));
        decodeMatrixDelta = DecodeMatrix(:, (2 * Parameter(2)):end);
        dataCollectorMatrixL = DataCollectorMatrix(:, 1: (Parameter(2) - 1));
        dataCollectorMatrixR = DataCollectorMatrix(:, Parameter(2):end);

        messageMatrixTZ = decodeMatrixPhiDelta \ dataCollectorMatrixR;
        if(size(messageMatrixTZ,2) > 1)
            z1 = messageMatrixTZ(end, 2:end);
            messageMatrixTZ1 = decodeMatrixPhiDelta \ (dataCollectorMatrixR(:, 1) - decodeMatrixDelta * transpose(z1));
            messageMatrixTZ = [messageMatrixTZ1, messageMatrixTZ(:, 2:end)];
        end

        messageMatrixS12 = dataCollectorMatrixL - DecodeMatrix(:, (2 * Parameter(2) - 1):end)...
                           * transpose(messageMatrixTZ(1:(Parameter(2) - 1), :));
    else
        messageMatrixS12 = DataCollectorMatrix;
    end
        
    decodeMatrixPhi = DecodeMatrix(:, Parameter(2):(2 * Parameter(2) - 2));
    decodeMatrixLambda = transpose(DecodeMatrix(:, 1));

    messageMatrixP = messageMatrixS12 * transpose(decodeMatrixPhi);

    messageMatrixS1k = messageMatrixP - messageMatrixP;
    messageMatrixS2k = messageMatrixP - messageMatrixP;
    for i = 1 : size(messageMatrixP, 1)
        for j = 1 : i
            if (i ~= j)
                messageMatrixS1k(i, j) = (messageMatrixP(i, j) - messageMatrixP(j, i)) / (decodeMatrixLambda(i) - decodeMatrixLambda(j));
                messageMatrixS2k(i, j) = (decodeMatrixLambda(j) * messageMatrixP(i, j) - decodeMatrixLambda(i) * messageMatrixP(j, i))...
                                         / (decodeMatrixLambda(j) - decodeMatrixLambda(i));
            end
        end
    end

    messageMatrixS1 = transpose(messageMatrixS1k);
    messageMatrixS1 = messageMatrixS1k(:, 1:(end - 1)) + messageMatrixS1(:, 2:end);
    for i = 1 : size(messageMatrixS1, 1)
        decodeMatrixPhiT = transpose(decodeMatrixPhi);
        index = true(1, size(decodeMatrixPhiT,2));
        index(i) = false;
        messageMatrixS1(i, :) = messageMatrixS1(i, :) / decodeMatrixPhiT(:, index);
    end
    messageMatrixS1 = decodeMatrixPhi(1:(end - 1), :) \ messageMatrixS1(1:(end - 1),:);

    messageMatrixS2 = transpose(messageMatrixS2k);
    messageMatrixS2 = messageMatrixS2k(:, 1:(end - 1)) + messageMatrixS2(:, 2:end);
    for i = 1 : size(messageMatrixS2, 1)
        decodeMatrixPhiT = transpose(decodeMatrixPhi);
        index = true(1, size(decodeMatrixPhiT,2));
        index(i) = false;
        messageMatrixS2(i, :) = messageMatrixS2(i, :)/decodeMatrixPhiT(:, index);
    end
    messageMatrixS2 = decodeMatrixPhi(1:(end - 1), :) \ messageMatrixS2(1:(end - 1),:);

    if(Parameter(3) > 2 * Parameter(2) - 2)
        messageMatrix = [messageMatrixS1, (messageMatrixS1(:, 1) - messageMatrixS1(:, 1));...
                         messageMatrixS2, (messageMatrixTZ(1:size(messageMatrixS2, 1), 1));...
                         transpose(messageMatrixTZ)];
    else
        messageMatrix = [messageMatrixS1;...
                         messageMatrixS2];
    end
