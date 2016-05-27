% Length of Message = k * (d - k + 1)
% Parameter = [n, k, d >= 2k - 2] PM-MSR in GF(2^gfb)
% failedNode = ID of the failed Node
% Helpers are randomly generated
% Length of Message = k * (d - k + 1)
% Parameter = [n, k, d >= 2k - 2] MSR in GF(2^exp)
% failedNode = ID of the failed Node
% Helpers are randomly generated
% Modified Vandemonder Matrix as Generator Matrix
function MSR(Parameter)
    
     % Generate message and GF
    [message, GF] = OrgnizedMessage('MSR', Parameter);

    % Generator Matrix n * d
    generatorMatrix = GeneratorMatrixMSR(Parameter, GF);

    % Message Matrix d * d
    messageMatrix = MessageMatrixMSR(message, Parameter, GF)

    % Encode
    codewordMatrix = generatorMatrix * messageMatrix;

    % Decode
    [decodeMatrix, dataCollectorMatrix] = DataCollector(codewordMatrix, generatorMatrix, Parameter);
    decodedMessageMatrix = DecodeMSR(decodeMatrix, dataCollectorMatrix, Parameter)

    if (isequal(messageMatrix(:, 1:(Parameter(2) - 1)), decodedMessageMatrix))
        disp('Decoding success!');
    else
        disp('Decoding fails!');
    end

    % Failed node ID
    failedNode = RandFailedNode(Parameter);

    % Helper Nodes /randomly
    Helpers = HelperNodes(Parameter, failedNode);

    % Regenerating
    [helperMessage, helperMatrix] = Helper(codewordMatrix,...
                                    generatorMatrix, failedNode, Helpers, GF);
    repairedMessageRe = helperMatrix \ helperMessage;
    flambda = generatorMatrix(failedNode, 1);
    repairedMessage = transpose([flambda * (repairedMessageRe(1 : (Parameter(2) - 1), :))...
                    + (repairedMessageRe(Parameter(2) : (2 * Parameter(2) - 2), :));...
                    repairedMessageRe((2 * Parameter(2) - 1) : Parameter(3), :)]);

    if (isequal(codewordMatrix(failedNode, :), repairedMessage))
        disp('Regenerating success!');
    else
        disp('Regenerating fails!');
    end
    
end
