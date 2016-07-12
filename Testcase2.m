% Bandwidth and time by parallel repaire
% Same (n, k, d) and max. (n - d) node fail

Parameter = [15, 4, 7];

[regBandwidthMBR, decodeBandwidthMBR, regTimeMBR, decodeTimeMBR, optPointMBR, messageSizeMBR] = ParallelRepair('MBR', Parameter);

[regBandwidthMSR, decodeBandwidthMSR, regTimeMSR, decodeTimeMSR, optPointMSR, messageSizeMSR] = ParallelRepair('MSR', Parameter);

for i = 1 : (Parameter(1) - Parameter(3))
    regBandwidthMBR(i) = regBandwidthMBR(i) / messageSizeMBR;
    decodeBandwidthMBR(i) = decodeBandwidthMBR(i) / messageSizeMBR;
    
    regBandwidthMSR(i) = regBandwidthMSR(i) / messageSizeMSR;
    decodeBandwidthMSR(i) = decodeBandwidthMSR(i) / messageSizeMSR;
end

x = 1 : (Parameter(1) - Parameter(3));

figure
s(1) = subplot(2, 2, 1);
plot(x, regBandwidthMBR, '--r+', x, decodeBandwidthMBR, '--r*')
axis([0, x(end) + 1, (min(regBandwidthMBR(1), decodeBandwidthMBR(1)) - 0.5), (max(regBandwidthMBR(end), decodeBandwidthMBR(end)) + 0.5)])
legend('PR E-MBR', 'MDSR E-MBR')
xlabel('Anzahl der ausgefallenen Knoten');
ylabel('Reparatur-Bandbreite %');

s(2) = subplot(2, 2, 3);
plot(x, regBandwidthMSR, '--b+', x, decodeBandwidthMSR, '--b*')
axis([0, x(end) + 1, (regBandwidthMSR(1) - 0.5), (regBandwidthMSR(end) + 0.5)])
legend('PR E-MSR', 'MDSR E-MSR')
xlabel('Anzahl der ausgefallenen Knoten');
ylabel('Reparatur-Bandbreite %');

s(3) = subplot(2, 2, 2);
plot(x, regTimeMBR, '--r+',x, decodeTimeMBR, '--r*')
axis([0, x(end) + 1, 0, regTimeMBR(end) + 0.1])
legend('PR E-MBR', 'MDSR E-MBR')
xlabel('Anzahl der ausgefallenen Knoten');
ylabel('Zeit / s');

s(4) = subplot(2, 2, 4);
plot( x, regTimeMSR, '--b+', x, decodeTimeMSR, '--b*')
axis([0, x(end) + 1, 0, regTimeMSR(end) + 0.1])
legend('PR E-MSR', 'MDSR E-MSR')
xlabel('Anzahl der ausgefallenen Knoten');
ylabel('Zeit / s');

