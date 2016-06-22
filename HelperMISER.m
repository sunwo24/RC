function [helperMessage, helperMatrix, diskIO] = HelperMISER(CodewordMatrix, Helpers, FailedNode, GeneratorMatrix, Parameter, GF)
    
    alphaSize = Parameter(3) - Parameter(2) + 1;
    diskIO = 0;

    helperMessage = repmat(GF(1), 1, Parameter(3));
    for i = 1 : length(Helpers)
        helperMessage(1, i) = CodewordMatrix(1, ((Helpers(i) - 1) * alphaSize + FailedNode));
        diskIO = diskIO + 1;
    end
  
    helperMatrix = repmat(GF(1), size(GeneratorMatrix, 1), Parameter(3));
    for i = 1 : length(Helpers)
        helperMatrix(:, i) = GeneratorMatrix(:, ((Helpers(i) - 1) * alphaSize + FailedNode));
    end

