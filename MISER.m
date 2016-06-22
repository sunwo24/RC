% (n, k, d) = (2k, k, 2k-1)MISER

function [MessageSize, CodedSize, RegeneratingBandwidth, diskIO] = MISER(Parameter)
    
    % Generate message and GF
    [message, GF] = OrgnizedMessage('MISER', Parameter);
    MessageSize = length(message);

    % Generator Matrix (alphaSize * k) * (alphaSize * n)
    generatorMatrix = GeneratorMatrixMISER(Parameter, GF);

    % Message Matrix
    messageMatrix = message;

    % Encoding
    codewordMatrix = messageMatrix * generatorMatrix;
    CodedSize = size(codewordMatrix, 1) * size(codewordMatrix, 2);

    % Failed node ID
    failedNode = FailedNodeMISER(Parameter);

    % Regenerating
    Helpers = sort(HelperNodes(Parameter, failedNode));
    [helperMessage, helperMatrix, diskIO] = HelperMISER(codewordMatrix, Helpers, failedNode, generatorMatrix, Parameter, GF);
    RegeneratingBandwidth = size(helperMessage, 1) * size(helperMessage, 2);
    [parityMessage, parityMatrix] = RemoveInterference(helperMatrix, helperMessage, failedNode, Parameter);

    repairedMessage = transpose(parityMessage) / parityMatrix;

    if (isequal(codewordMatrix(1, (failedNode - 1) * (Parameter(3) - Parameter(2) + 1) + 1 : failedNode * (Parameter(3) - Parameter(2) + 1)), repairedMessage))
        disp('Regenerating success!');
    else
        disp('Regenerating fails!');
    end

    CodedSize = 0;
