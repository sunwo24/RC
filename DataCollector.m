function [decodeMatrix, dataCollectorMatrix] = DataCollector(CodewordMatrix, GeneratorMatrix, Parameter)

    dataCollectorID = randperm(Parameter(1), Parameter(2));
    % dataCollectorID = [1, 2, 3];

    dataCollectorMatrix = CodewordMatrix(dataCollectorID, :);
    diskIO = size(dataCollectorMatrix, 1) * size(dataCollectorMatrix, 2);

    decodeMatrix = GeneratorMatrix(dataCollectorID, :);
