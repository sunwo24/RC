function [optimalPointMBR, optimalPointMSR, optimalPointRC] = OptimalPoint(Parameter)

[regBandwidthMBR, decodeBandwidthMBR, regTimeMBR, decodeTimeMBR, optPointMBR, messageSizeMBR] = ParallelRepaire('MBR', Parameter);

[regBandwidthMSR, decodeBandwidthMSR, regTimeMSR, decodeTimeMSR, optPointMSR, messageSizeMSR] = ParallelRepaire('MSR', Parameter);

for i = 1 : (Parameter(1) - Parameter(3))
    regBandwidthMBR(i) = regBandwidthMBR(i) / messageSizeMBR;
    decodeBandwidthMBR(i) = decodeBandwidthMBR(i) / messageSizeMBR;
    if (regBandwidthMBR(i) <= decodeBandwidthMBR(i))
      optimalPointMBR = i;
    end

    regBandwidthMSR(i) = regBandwidthMSR(i) / messageSizeMSR;
    decodeBandwidthMSR(i) = decodeBandwidthMSR(i) / messageSizeMSR;
    if (regBandwidthMSR(i) <= decodeBandwidthMSR(i))
      optimalPointMSR = i;
    end
    
    if ((regBandwidthMBR(i) <= decodeBandwidthMSR(i)) || (regBandwidthMSR(i) <= decodeBandwidthMSR(i)))
        optimalPointRC = i;
    end
end
