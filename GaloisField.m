% Return GF(2^gfExp)
function GF = GaloisField(gfExp)

    eleGF = zeros(1, 2^gfExp);

    for i = 0 : (2^gfExp - 1)
        eleGF(i + 1) = mod(i, 2^gfExp);
    end

    GF = gf(eleGF, gfExp);

end
