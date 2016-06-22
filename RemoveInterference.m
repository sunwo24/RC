function [parityMessage, parityMatrix] = RemoveInterference(RepairMatrix, RepairMessage, FailedNode, Parameter)

alphaSize = Parameter(3) - Parameter(2) + 1;

parityMatrix = RepairMatrix(:, alphaSize : size(RepairMatrix, 2));

systematicMatrix = transpose(RepairMatrix(:, 1 : (alphaSize - 1)));

interferenceMatrix = transpose(RepairMessage(alphaSize : Parameter(3)));
 
interferenceMatrix = [interferenceMatrix, transpose(systematicMatrix * parityMatrix)];

systematicMessage = transpose(RepairMessage(1 : (alphaSize - 1)));

parityMessage = interferenceMatrix(:, 1) - interferenceMatrix(:, 2 : end) * systematicMessage;

parityMatrix = parityMatrix(alphaSize * (FailedNode - 1) + 1 : alphaSize * FailedNode, :);
