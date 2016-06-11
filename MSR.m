% Length of Message = k * (d - k + 1)
% Parameter = [n, k, d >= 2k - 2] PM-MSR in GF(2^gfb)
% failedNode = ID of the failed Node
% Helpers are randomly generated
% Length of Message = k * (d - k + 1)
% Parameter = [n, k, d >= 2k - 2] MSR in GF(2^exp)
% failedNode = ID of the failed Node
% Helpers are randomly generated
% Modified Vandemonder Matrix as Generator Matrix
function [MessageSize, CodedSize, RegeneratingBandwidth, DecodingBandwidth] = MSR(Parameter)
    
     % Generate message and GF
    [message, GF] = OrgnizedMessage('MSR', Parameter);
    MessageSize = length(message);

    % Generator Matrix n * d
    generatorMatrix = GeneratorMatrixMSR(Parameter, GF);

    tic;

    % Message Matrix d * d
    messageMatrix = MessageMatrixMSR(message, Parameter, GF);

    % Encode
    codewordMatrix = generatorMatrix * messageMatrix;
    CodedSize = size(codewordMatrix, 1) * size(codewordMatrix, 2);

    EncodingTimer = toc;

    % Decode
    tic;

    [decodeMatrix, dataCollectorMatrix] = DataCollector(codewordMatrix, generatorMatrix, Parameter);
    DecodingBandwidth = size(dataCollectorMatrix, 1) * size(dataCollectorMatrix, 2);
    decodedMessageMatrix = DecodeMSR(decodeMatrix, dataCollectorMatrix, Parameter);
    decodeMessage = GetMessageMSR(decodedMessageMatrix, Parameter, GF);

    if (isequal(message, decodeMessage))
        disp('Decoding success!');
        DecodingTimer = toc;
    else
        disp('Decoding fails!');
    end

    % Failed node ID
    failedNode = RandFailedNode(Parameter);

    % Helper Nodes /randomly
    tic;

    Helpers = HelperNodes(Parameter, failedNode);

    % Regenerating
    [helperMessage, helperMatrix] = Helper(codewordMatrix,...
                                    generatorMatrix, failedNode, Helpers, GF);
    RegeneratingBandwidth = size(helperMessage, 1) * size(helperMessage, 2);
    repairedMessageRe = helperMatrix \ helperMessage;
    flambda = generatorMatrix(failedNode, 1);
    repairedMessage = transpose([flambda * (repairedMessageRe(1 : (Parameter(2) - 1), :))...
                    + (repairedMessageRe(Parameter(2) : (2 * Parameter(2) - 2), :));...
                    repairedMessageRe((2 * Parameter(2) - 1) : Parameter(3), :)]);

    if (isequal(codewordMatrix(failedNode, :), repairedMessage))
        disp('Regenerating success!');
        RegeneratingTimer = toc;
    else
        disp('Regenerating fails!');
    end
    
end
