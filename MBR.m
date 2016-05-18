% Length of Message = k * (k + 1) / 2 + k * (d - k)
% Parameter = [n, k, d] PM-MBR in GF(2^gfb)
% failedNode = ID of the failed Node
% Helpers are randomly generated
% Vandemonder Matrix as Generator Matrix
function [codewordMatrix, repairedMessage] = MBR(Parameter)
    
    % Generate message and GF
    [message, GF] = OrgnizedMessage('MBR', Parameter);

    % Generator Matrix n * d
    % generatorMatrix = GeneratorMatrixMBR(Parameter, GF);
    generatorMatrix = SysGeneratorMatrixMBR(Parameter, GF);

    % Message Matrix d * d
    messageMatrix = MessageMatrixMBR(message, Parameter, GF);

    % Encode
    codewordMatrix = generatorMatrix * messageMatrix;

    % Failed node ID
    failedNode = RandFailedNode(Parameter)

    % Helper Nodes /randomly
    Helpers = HelperNodes(Parameter, failedNode);
    
    % Regenerating
    [helperMessage, helperMatrix] = Helper(codewordMatrix, generatorMatrix,...
                                            failedNode, Helpers, GF);
    repairedMessage = transpose(helperMatrix \ helperMessage);
    
end
