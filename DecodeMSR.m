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

    if(Parameter(3) > 2 * Parameter(2) - 2)
        messageMatrix = messageMatrixTZ;
    else
        messageMatrix = transpose(messageMatrixS12);
    end
