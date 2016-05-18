function helpers = HelperNodes(Parameter, failedNode)
    
    helpers = zeros(1, Parameter(3));
    tmp = randperm(Parameter(1), (Parameter(3) + 1));
    flag = 0;

    for i = 1 : Parameter(3)
        if (tmp(i) == failedNode)
            helpers(i) = tmp(Parameter(3) + 1);
        else
            helpers(i) = tmp(i);
        end
    end

end
