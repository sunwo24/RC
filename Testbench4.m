% Evaluate Disk-I/O by regenerating

MSRCode = zeros(size(Parameter, 1), 3);
MISERCode = zeros(size(Parameter, 1), 3);

for i = 1 : size(Parameter, 1)
    [MessageSizeMSR, CodedSizeMSR, RegeneratingBandwidthMSR, DecodingBandwidthMSR, diskIOMSR] = MSR(Parameter(i, :));
    [MessageSizeMISER, CodedSizeMISER, RegeneratingBandwidthMISER, diskIOMISER] = MISER(Parameter(i, :));

    MSRCode(i, 1) = diskIOMSR;
    MSRCode(i, 2) = MessageSizeMSR;
    MSRCode(i, 3) = RegeneratingBandwidthMSR;
    
    MISERCode(i, 1) = diskIOMISER;
    MISERCode(i, 2) = MessageSizeMISER;
    MISERCode(i, 3) = RegeneratingBandwidthMISER;
end

x = transpose(Parameter(:, 2));

figure
s(1) = subplot(2, 1, 1);
plot(x, MSRCode(:, 1), ':r+', x, MISERCode(:, 1), '--bo', x, MSRCode(:, 2), ':r*', x, MISERCode(:, 2), '--bs')
axis([Parameter(1, 2) - 0.5, Parameter(end, 2) + 0.5, (MISERCode(1, 1) - 3), (MSRCode(end, 1) + 3)])
legend('E-MSR Disk-I/O', 'MISER Disk-I/O', 'MSR Nachrichte', 'MISER Nachrichte')
xlabel('k');
ylabel('Disk-I/O');

s(2) = subplot(2, 1, 2);
plot(x, MSRCode(:, 3), ':r+', x, MISERCode(:, 3), '--bo', x, MSRCode(:, 2), ':r*', x, MISERCode(:, 2), '--bs')
axis([Parameter(1, 2) - 0.5, Parameter(end, 2) + 0.5, (MISERCode(1, 3) - 3), (MSRCode(end, 2) + 3)])
legend('E-MSR Regenerating', 'MISER Regenerating', 'MSR Nachrichte', 'MISER Nachrichte')
xlabel('k');
ylabel('Regenerating-Bandbreite');
