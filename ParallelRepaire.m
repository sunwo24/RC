% Parallel Repaire
% for (n - d) nodes fails

function [regeneratingBandwidth, reconstructionBandwidth, regeneratingTime, reconstructionTime, optPoint, messageSize] = ParallelRepaire(codeType, Parameter)
    % GF(2^gfExp)
    [gfExp, U] = BaseGF(codeType, Parameter);
    GF = GaloisField(gfExp);

    n = Parameter(1) - Parameter(3);
    regeneratingBandwidth = zeros(1, n);
    regeneratingTime = zeros(1, n);
    reconstructionBandwidth = zeros(1, n);
    reconstructionTime = zeros(1, n);
    totalBandwidthRegenerating = 0;
    totalTimeRegenerating = 0;

    if (strcmp(codeType, 'MBR'))
        % Generator Matrix n * d
        generatorMatrix = GeneratorMatrixMBR(Parameter, GF);
        %generatorMatrix = SysGeneratorMatrixMBR(Parameter, GF);

        tic;
        % Original message
        message = RandMessage(gfExp, U);
        messageSize = length(message);

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
            timeReconstruction = toc;
        else
            error('Decoding fails!');
        end

        for round = 1 : n
            % Failed node ID
            failedNode = RandFailedNode(Parameter);

            tic;

            % Helper Nodes /randomly
            Helpers = HelperNodes(Parameter, failedNode);
            
            % Regenerating
            [helperMessage, helperMatrix] = Helper(codewordMatrix,...
                                            generatorMatrix, failedNode, Helpers, GF);
            bandwidthRegenerating = size(helperMessage, 1) * size(helperMessage, 2);
            repairedMessage = transpose(helperMatrix \ helperMessage);

            if (isequal(codewordMatrix(failedNode, :), repairedMessage))
                disp('Regenerating success!');
                timeRegenerating = toc;
            else
                error('Regenerating fails!');
            end

            totalBandwidthRegenerating = totalBandwidthRegenerating + bandwidthRegenerating;
            regeneratingBandwidth(round) = totalBandwidthRegenerating;
            reconstructionBandwidth(round) = bandwidthReconstruction;

            totalTimeRegenerating = totalTimeRegenerating + timeRegenerating;
            regeneratingTime(round) = totalTimeRegenerating;
            reconstructionTime(round) = timeReconstruction;
        end
    elseif (strcmp(codeType, 'MSR'))
        % Generator Matrix n * d
        generatorMatrix = GeneratorMatrixMSR(Parameter, GF);

        tic;

        % Original message
        message = RandMessage(gfExp, U);
        messageSize = length(message);

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
            timeReconstruction = toc;
        else
            error('Decoding fails!');
        end

        for round = 1 : n
            % Failed node ID
            failedNode = RandFailedNode(Parameter);

            tic;

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
                timeRegenerating = toc;
            else
                error('Regenerating fails!');
            end
            
            totalBandwidthRegenerating = totalBandwidthRegenerating + bandwidthRegenerating;
            regeneratingBandwidth(round) = totalBandwidthRegenerating;
            reconstructionBandwidth(round) = bandwidthReconstruction;

            totalTimeRegenerating = totalTimeRegenerating + timeRegenerating;
            regeneratingTime(round) = totalTimeRegenerating;
            reconstructionTime(round) = timeReconstruction;
        end
    else
        error('wrong code type!!');
    end

    % Find the optimal point of regenerating
    key = find((regeneratingBandwidth - reconstructionBandwidth) <= 0);
    optPoint = key(end);
end
