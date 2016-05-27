% Length of Message = k * (k + 1) / 2 + k * (d - k)
% Parameter = [n, k, d] MBR in GF(2^exp)
% failedNode = ID of the failed Node
% Helpers are randomly generated
% Vandemonder Matrix as Generator Matrix
function MBR(Parameter)
    
    % Generate message and GF
    [message, GF] = OrgnizedMessage('MBR', Parameter);

    % Generator Matrix n * d
    generatorMatrix = GeneratorMatrixMBR(Parameter, GF);
    %generatorMatrix = SysGeneratorMatrixMBR(Parameter, GF);

    % Message Matrix d * d
    messageMatrix = MessageMatrixMBR(message, Parameter, GF)

    % Encode
    codewordMatrix = generatorMatrix * messageMatrix

    % Decode
    [decodeMatrix, dataCollectorMatrix] = DataCollector(codewordMatrix, generatorMatrix, Parameter);
    decodedMessageMatrix = DecodeMBR(decodeMatrix, dataCollectorMatrix, Parameter);
    decodeMessage = GetMessageMBR(decodedMessageMatrix, Parameter, GF)

    if (isequal(message, decodeMessage))
        disp('Decoding success!');
    else
        disp('Decoding fails!');
    end

    % Failed node ID
    failedNode = RandFailedNode(Parameter)

    % Helper Nodes /randomly
    Helpers = HelperNodes(Parameter, failedNode);
    
    % Regenerating
    [helperMessage, helperMatrix] = Helper(codewordMatrix, generatorMatrix,...
                                            failedNode, Helpers, GF);
    repairedMessage = transpose(helperMatrix \ helperMessage)

    if (isequal(codewordMatrix(failedNode, :), repairedMessage))
        disp('Regenerating success!');
    else
        disp('Regenerating fails!');
    end
    
end
