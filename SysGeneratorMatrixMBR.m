function sysGeneratorMBR = SysGeneratorMatrixMBR(Parameter, GF)

    sysGeneratorMBR = repmat(GF(1), Parameter(1), Parameter(3));
    
    for i = 1 : Parameter(2)
        sysGeneratorMBR(i, i) = GF(2);
    end
    
    vandermondeMatrix = VandermondeMatrix((Parameter(1) - Parameter(2)), Parameter(3), GF);

    sysGeneratorMBR((Parameter(2) + 1) : Parameter(1), :) = vandermondeMatrix;
end
