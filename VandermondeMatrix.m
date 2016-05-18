function vandermondeMatrix = VandermondeMatrix(n, m, GF)

    vandermondeMatrix = repmat(GF(1), n, m);
    
    % Vandermonde Matrix
    for i = 1 : n
        for j = 1 : m
            vandermondeMatrix(i, j) = GF(i + 1)^(j - 1);
        end
    end
end
