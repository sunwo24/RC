function messageMatrix = DecodeMBR(DecodeMatrix, DataCollectorMatrix, Parameter)
    
    decodeMatrixPhi = DecodeMatrix(:, 1:Parameter(2));
    decodeMatrixDelta = DecodeMatrix(:, (Parameter(2) + 1):end);

    decodeT = decodeMatrixPhi \ DataCollectorMatrix;
    tMessage = decodeT(:, (Parameter(2) + 1):end);

    sMessage = decodeMatrixPhi \ (DataCollectorMatrix(:, 1:Parameter(2)) - decodeMatrixDelta * transpose(tMessage));

    messageMatrix = [sMessage, tMessage];
