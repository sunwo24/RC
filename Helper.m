function [helperMessage, helperMatrix] = Helper(codewordMatrix, generatorMatrix, failedNode, Helpers, GF)

    helperMessage = repmat(GF(1), length(Helpers), 1);
    helperMatrix = repmat(GF(1), length(Helpers), length(Helpers));

    for ind = 1 : length(Helpers)
        helperMessage(ind, 1) = codewordMatrix(Helpers(ind), :) * transpose(generatorMatrix(failedNode, (length(generatorMatrix(Helpers(ind),:)) - length(codewordMatrix(Helpers(ind), :)) + 1) : end));
        helperMatrix(ind, :) = generatorMatrix(Helpers(ind),:);
    end

end
