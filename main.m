codeType = 'MBR'
Parameter = [30 10 20]

% GF(2^gfExp)
[gfExp, U] = BaseGF(codeType, Parameter);
GF = GaloisField(gfExp);

n = Parameter(1) - Parameter(3);
regeneratingBandwidth = zeros(1, n);
reconstructionBandwidth = zeros(1, n);
totalBandwidthRegenerating = 0;

if (strcmp(codeType, 'MBR'))
    % Generator Matrix n * d
    % generatorMatrix = GeneratorMatrixMBR(Parameter, GF);
    generatorMatrix = SysGeneratorMatrixMBR(Parameter, GF);

    % Original message
    message = RandMessage(gfExp, U);

    % Message Matrix d * d
    messageMatrix = MessageMatrixMBR(message, Parameter, GF);

    % Encode
    codewordMatrix = generatorMatrix * messageMatrix;

    % Decode
    [decodeMatrix, dataCollectorMatrix] = DataCollector(codewordMatrix, generatorMatrix, Parameter);
    bandwidthReconstruction = size(dataCollectorMatrix, 1) * size(dataCollectorMatrix, 2);
    decodedMessageMatrix = DecodeMBR(decodeMatrix, dataCollectorMatrix, Parameter);
    decodeMessage = GetMessageMBR(decodedMessageMatrix, Parameter, GF);

    if (isequal(message, decodeMessage))
        disp('Decoding success!');
    else
        error('Decoding fails!');
    end

    for round = 1 : n
        % Failed node ID
        failedNode = RandFailedNode(Parameter);

        % Helper Nodes /randomly
        Helpers = HelperNodes(Parameter, failedNode);
        
        % Regenerating
        [helperMessage, helperMatrix] = Helper(codewordMatrix,...
                                        generatorMatrix, failedNode, Helpers, GF);
        bandwidthRegenerating = size(helperMessage, 1) * size(helperMessage, 2);
        repairedMessage = transpose(helperMatrix \ helperMessage);

        if (isequal(codewordMatrix(failedNode, :), repairedMessage))
            disp('Regenerating success!');
        else
            error('Regenerating fails!');
        end

        totalBandwidthRegenerating = totalBandwidthRegenerating + bandwidthRegenerating;
        regeneratingBandwidth(round) = totalBandwidthRegenerating;
        reconstructionBandwidth(round) = bandwidthReconstruction;
    end
elseif (strcmp(codeType, 'MSR'))
    % Generator Matrix n * d
    generatorMatrix = GeneratorMatrixMSR(Parameter, GF);

    % Original message
    message = RandMessage(gfExp, U);

    % Message Matrix d * d
    messageMatrix = MessageMatrixMSR(message, Parameter, GF);

    % Encode
    codewordMatrix = generatorMatrix * messageMatrix;

    % Decode
    [decodeMatrix, dataCollectorMatrix] = DataCollector(codewordMatrix, generatorMatrix, Parameter);
    bandwidthReconstruction = size(dataCollectorMatrix, 1) * size(dataCollectorMatrix, 2);
    decodedMessageMatrix = DecodeMSR(decodeMatrix, dataCollectorMatrix, Parameter);
    decodeMessage = GetMessageMSR(decodedMessageMatrix, Parameter, GF);

    if (isequal(message, decodeMessage))
        disp('Decoding success!');
    else
        error('Decoding fails!');
    end

    for round = 1 : n
        % Failed node ID
        failedNode = RandFailedNode(Parameter);

        % Helper Nodes /randomly
        Helpers = HelperNodes(Parameter, failedNode);

        % Regenerating
        [helperMessage, helperMatrix] = Helper(codewordMatrix,...
                                        generatorMatrix, failedNode, Helpers, GF);
        bandwidthRegenerating = size(helperMessage, 1) * size(helperMessage, 2);
        repairedMessageRe = helperMatrix \ helperMessage;
        flambda = generatorMatrix(failedNode, 1);
        repairedMessage = transpose([flambda * (repairedMessageRe(1 : (Parameter(2) - 1), :))...
                          + (repairedMessageRe(Parameter(2) : (2 * Parameter(2) - 2), :));...
                          repairedMessageRe((2 * Parameter(2) - 1) : Parameter(3), :)]);

        if (isequal(codewordMatrix(failedNode, :), repairedMessage))
            disp('Regenerating success!');
        else
            error('Regenerating fails!');
        end
        
        totalBandwidthRegenerating = totalBandwidthRegenerating + bandwidthRegenerating;
        regeneratingBandwidth(round) = totalBandwidthRegenerating;
        reconstructionBandwidth(round) = bandwidthReconstruction;
    end
else
    error('wrong code type!!');
end

key = find((regeneratingBandwidth - reconstructionBandwidth) >= 0);
key(1)
plot((1 : n), regeneratingBandwidth, '-r*', (1 : n), reconstructionBandwidth, '-b+')
axis([0, (n + 2), 0, (regeneratingBandwidth(n) + regeneratingBandwidth(1))])
xlabel('Num of failed nodes');
ylabel('Bandwidth');
legend('Regenerating', 'Decoding');
