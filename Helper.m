function [helperMessage, helperMatrix] = Helper(codewordMatrix, generatorMatrix, failedNode, Helpers, GF)

    helperMessage = repmat(GF(1), length(Helpers), 1);
    helperMatrix = repmat(GF(1), length(Helpers), length(Helpers));
    bandwidth = 0;

    % Generate Helper-Vector
    for ind = 1 : length(Helpers)
        % Symboles on Helper nodes
        symboleHelper = codewordMatrix(Helpers(ind), :);

        bandwidth = bandwidth + length(symboleHelper);

        % Coefficient of failed node
        coeffFailedNode = generatorMatrix(failedNode,...
                          (length(generatorMatrix(Helpers(ind),:))...
                          - length(codewordMatrix(Helpers(ind), :)) + 1)...
                          : end);

        % Helper-Vector
        helperMessage(ind, 1) = symboleHelper * transpose(coeffFailedNode);

        helperMatrix(ind, :) = generatorMatrix(Helpers(ind),:);
    end

end
