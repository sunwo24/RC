function [gfExp, U] = BaseGF(codeType, Parameter)

    k = Parameter(2);
    d = Parameter(3);

    if (strcmp(codeType, 'MSR'))
        if (d >= 2 * k - 2)
            U = k * (d - k + 1);
        else
            error('wrong parameter!');
        end
    elseif (strcmp(codeType, 'MBR'))
        U = k * (k + 1) / 2 + k * (d - k);
    else
        error('wrong code type!!');
    end

    [F, gfExp] = log2(U);

end
