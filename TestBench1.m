% same n, k of MBR and MSR
% compare disk size, regenerating bandwidth and decoding bandwidth with all possible d.

sameNKMBR = zeros(size(Parameter, 1), 7);
sameNKMSR = zeros(size(Parameter, 1), 7);
codeRate = zeros(size(Parameter, 1), 1);

for i = 1 : size(Parameter, 1)
    [MessageSizeMBR, CodedSizeMBR, RegeneratingBandwidthMBR, DecodingBandwidthMBR, diskIO] = MBR(Parameter(i, :));
    [MessageSizeMSR, CodedSizeMSR, RegeneratingBandwidthMSR, DecodingBandwidthMSR, diskIO] = MSR(Parameter(i, :));

    sameNKMBR(i, 1) = MessageSizeMBR/MessageSizeMBR;
    sameNKMBR(i, 2) = CodedSizeMBR/MessageSizeMBR;
    sameNKMBR(i, 3) = RegeneratingBandwidthMBR/MessageSizeMBR;
    sameNKMBR(i, 4) = DecodingBandwidthMBR/MessageSizeMBR;
    sameNKMBR(i, 5) = Parameter(i, 3)/MessageSizeMBR;
    sameNKMBR(i, 6) = CodedSizeMBR;
    sameNKMBR(i, 7) = RegeneratingBandwidthMBR;

    sameNKMSR(i, 1) = MessageSizeMSR/MessageSizeMSR;
    sameNKMSR(i, 2) = CodedSizeMSR/MessageSizeMSR;
    sameNKMSR(i, 3) = RegeneratingBandwidthMSR/MessageSizeMSR;
    sameNKMSR(i, 4) = DecodingBandwidthMSR/MessageSizeMSR;
    sameNKMSR(i, 5) = Parameter(i, 3)/MessageSizeMSR;
    sameNKMSR(i, 6) = CodedSizeMSR;
    sameNKMSR(i, 7) = RegeneratingBandwidthMSR;

    codeRate(i, 1) = Parameter(i, 1)/Parameter(i, 2);
end

x = transpose(Parameter(:, 3));
percMessageSizeMBR = sameNKMBR(:, 1);
percCodedSizeMBR = sameNKMBR(:, 2);
percRegeneratingBandwidthMBR = sameNKMBR(:, 3);
percDecodingBandwidthMBR = sameNKMBR(:, 4);
minRegeneratingBandwidthMBR = sameNKMBR(:, 5);
CodedSizeMBR = sameNKMBR(:, 6);
RegeneratingBandwidthMBR = sameNKMBR(:, 7);

percMessageSizeMSR = sameNKMSR(:, 1);
percCodedSizeMSR = sameNKMSR(:, 2);
percRegeneratingBandwidthMSR = sameNKMSR(:, 3);
percDecodingBandwidthMSR = sameNKMSR(:, 4);
minRegeneratingBandwidthMSR = sameNKMSR(:, 5);
CodedSizeMSR = sameNKMSR(:, 6);
RegeneratingBandwidthMSR = sameNKMSR(:, 7);

figure
s(1) = subplot(4, 1, 1);
plot(x, percCodedSizeMBR, '--r+', x, percCodedSizeMSR, '--b+', x, codeRate, ':ko')
axis([Parameter(1, 3) - 1, Parameter(end, 3) + 1, (codeRate(1, 1) - 0.3), (percCodedSizeMBR(1, 1) + 0.3)])
legend('E-MBR', 'E-MSR', 'Koderate')
xlabel('d');
ylabel('Speicher %');

s(2) = subplot(4, 1, 2);
plot(x, percRegeneratingBandwidthMBR, '--r+', x, percRegeneratingBandwidthMSR, '--b+', x, minRegeneratingBandwidthMBR, ':rd', x, minRegeneratingBandwidthMSR, ':bd')
axis([Parameter(1, 3) - 1, Parameter(end, 3) + 1, (percRegeneratingBandwidthMBR(end) - 0.05), (percRegeneratingBandwidthMSR(1) + 0.05)])
legend('SR E-MBR', 'SR E-MSR', 'ges. Bandbreite MBR', 'ges. Bandbreite MSR')
xlabel('d');
ylabel('Reparatur-Bandbreite %');

s(3) = subplot(4, 1, 3);
plot(x, RegeneratingBandwidthMBR, '--r+', x, RegeneratingBandwidthMSR, '--bo')
axis([Parameter(1, 3) - 1, Parameter(end, 3) + 1, (RegeneratingBandwidthMBR(1, 1) - 3), (RegeneratingBandwidthMBR(end, 1) + 3)])
legend('SR E-MBR', 'SR E-MSR')
xlabel('d');
ylabel('Reparatur-Bandbreite');

s(4) = subplot(4, 1, 4);
plot(x, percDecodingBandwidthMBR, '--r+', x, percDecodingBandwidthMSR, '--b+', x, percMessageSizeMBR, ':ks')
axis([Parameter(1, 3) - 1, Parameter(end, 3) + 1, 0.9, (percDecodingBandwidthMBR(1, 1) + 0.1)])
legend('E-MBR', 'E-MSR', 'Datenobjekt')
xlabel('d');
ylabel('Dekodierung-Bandbreite %');

