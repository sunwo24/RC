codeType = 'MSR';
Parameter = [7 3 5];

% Failed node ID
failedNode = RandFailedNode(Parameter);

% GF(2^gfExp)
[gfExp, U] = BaseGF(codeType, Parameter);
GF = GaloisField(gfExp);

% Original message
message = RandMessage(gfExp, U);

if (strcmp(codeType, 'MBR'))
    % Generator Matrix n * d
    % generatorMatrix = GeneratorMatrixMBR(Parameter, GF);
    generatorMatrix = SysGeneratorMatrixMBR(Parameter, GF);

    % Message Matrix d * d
    messageMatrix = MessageMatrixMBR(message, Parameter, GF);

    % Encode
    codewordMatrix = generatorMatrix * messageMatrix;

    % Helper Nodes /randomly
    Helpers = HelperNodes(Parameter, failedNode);
    
    % Regenerating
    [helperMessage, helperMatrix] = Helper(codewordMatrix,...
                                    generatorMatrix, failedNode, Helpers, GF);
    repairedMessage = transpose(helperMatrix \ helperMessage);

    % Decode
    [decodeMatrix, dataCollectorMatrix] = DataCollector(codewordMatrix, generatorMatrix, Parameter);
    decodedMessageMatrix = DecodeMBR(decodeMatrix, dataCollectorMatrix, Parameter);
    decodeMessage = GetMessageMBR(decodedMessageMatrix, Parameter, GF);

elseif (strcmp(codeType, 'MSR'))
    % Generator Matrix n * d
    generatorMatrix = GeneratorMatrixMSR(Parameter, GF);

    % Message Matrix d * d
    messageMatrix = MessageMatrixMSR(message, Parameter, GF);

    % Encode
    codewordMatrix = generatorMatrix * messageMatrix;

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

    % Decode
    [decodeMatrix, dataCollectorMatrix] = DataCollector(codewordMatrix, generatorMatrix, Parameter);
    decodedMessageMatrix = DecodeMSR(decodeMatrix, dataCollectorMatrix, Parameter);
    decodeMessage = GetMessageMSR(decodedMessageMatrix, Parameter, GF);
    
else
    error('wrong code type!!');
end

if (isequal(codewordMatrix(failedNode, :), repairedMessage))
    disp('Regenerating success!');
else
    error('Regenerating fails!');
end

if (isequal(message, decodeMessage))
    disp('Decoding success!');
else
    error('Decoding fails!');
end
