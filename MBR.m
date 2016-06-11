% Length of Message = k * (k + 1) / 2 + k * (d - k)
% Parameter = [n, k, d] MBR in GF(2^exp)
% failedNode = ID of the failed Node
% Helpers are randomly generated
% Vandemonder Matrix as Generator Matrix
function [MessageSize, CodedSize, RegeneratingBandwidth, DecodingBandwidth] = MBR(Parameter)
    
    % Generate message and GF
    [message, GF] = OrgnizedMessage('MBR', Parameter);
    MessageSize = length(message);

    % Generator Matrix n * d
    generatorMatrix = GeneratorMatrixMBR(Parameter, GF);
    %generatorMatrix = SysGeneratorMatrixMBR(Parameter, GF);

    tic;

    % Message Matrix d * d
    messageMatrix = MessageMatrixMBR(message, Parameter, GF);

    % Encode
    codewordMatrix = generatorMatrix * messageMatrix;
    CodedSize = size(codewordMatrix, 1) * size(codewordMatrix, 2);

    EncodingTimer = toc;

    % Decode
    tic;

    [decodeMatrix, dataCollectorMatrix] = DataCollector(codewordMatrix, generatorMatrix, Parameter);
    DecodingBandwidth = size(dataCollectorMatrix, 1) * size(dataCollectorMatrix, 2);
    decodedMessageMatrix = DecodeMBR(decodeMatrix, dataCollectorMatrix, Parameter);
    decodeMessage = GetMessageMBR(decodedMessageMatrix, Parameter, GF);

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
    [helperMessage, helperMatrix] = Helper(codewordMatrix, generatorMatrix,...
                                            failedNode, Helpers, GF);
    RegeneratingBandwidth = size(helperMessage, 1) * size(helperMessage, 2);
    repairedMessage = transpose(helperMatrix \ helperMessage);

    if (isequal(codewordMatrix(failedNode, :), repairedMessage))
        disp('Regenerating success!');
        RegeneratingTimer = toc;
    else
        disp('Regenerating fails!');
    end
end
