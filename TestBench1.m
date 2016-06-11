% same n, k of MBR and MSR
% compare disk size, regenerating bandwidth and decoding bandwidth with all possible d.

%res = cell(size(Parameter, 1), 5);
sameNKMBR = zeros(size(Parameter, 1), 5);
sameNKMSR = zeros(size(Parameter, 1), 5);

for i = 1 : size(Parameter, 1)
    [MessageSizeMBR, CodedSizeMBR, RegeneratingBandwidthMBR, DecodingBandwidthMBR] = MBR(Parameter(i, :));
    [MessageSizeMSR, CodedSizeMSR, RegeneratingBandwidthMSR, DecodingBandwidthMSR] = MSR(Parameter(i, :));

%     res{i, 1} = MessageSizeMBR;
%     res{i, 2} = CodedSizeMBR;
%     res{i, 3} = RegeneratingBandwidthMBR;
%     res{i, 4} = DecodingBandwidthMBR;
%     res{i, 5} = 0;

    sameNKMBR(i, 1) = MessageSizeMBR/MessageSizeMBR;
    sameNKMBR(i, 2) = CodedSizeMBR/MessageSizeMBR;
    sameNKMBR(i, 3) = RegeneratingBandwidthMBR/MessageSizeMBR;
    sameNKMBR(i, 4) = DecodingBandwidthMBR/MessageSizeMBR;
    sameNKMBR(i, 5) = Parameter(i, 1)/Parameter(i, 2);

    sameNKMSR(i, 1) = MessageSizeMSR/MessageSizeMSR;
    sameNKMSR(i, 2) = CodedSizeMSR/MessageSizeMSR;
    sameNKMSR(i, 3) = RegeneratingBandwidthMSR/MessageSizeMSR;
    sameNKMSR(i, 4) = DecodingBandwidthMSR/MessageSizeMSR;
    sameNKMSR(i, 5) = 1/Parameter(i, 2);

end

x = transpose(Parameter(:, 3));
percMessageSizeMBR = sameNKMBR(:, 1);
percCodedSizeMBR = sameNKMBR(:, 2);
percRegeneratingBandwidthMBR = sameNKMBR(:, 3);
percDecodingBandwidthMBR = sameNKMBR(:, 4);
codeRate = sameNKMBR(:, 5);

percMessageSizeMSR = sameNKMSR(:, 1);
percCodedSizeMSR = sameNKMSR(:, 2);
percRegeneratingBandwidthMSR = sameNKMSR(:, 3);
percDecodingBandwidthMSR = sameNKMSR(:, 4);
minRegeneratingBandwidth = sameNKMSR(:, 5);

figure
s(1) = subplot(1, 3, 1);
plot(x, percCodedSizeMBR, '--r+', x, percCodedSizeMSR, '--b+', x, codeRate, ':ko')
axis([Parameter(1, 3), Parameter(end, 3), (codeRate(1, 1) - 0.3), (percCodedSizeMBR(1, 1) + 0.3)])
legend('MBR', 'MSR', 'Koderate')
xlabel('d');
ylabel('Speicher %');

s(2) = subplot(1, 3, 2);
plot(x, percRegeneratingBandwidthMBR, '--r+', x, percRegeneratingBandwidthMSR, '--b+', x, minRegeneratingBandwidth, ':kd')
axis([Parameter(1, 3), Parameter(end, 3), (minRegeneratingBandwidth(end) - 0.05), (percRegeneratingBandwidthMSR(1) + 0.1)])
legend('MBR', 'MSR', 'min. Bandbreite')
xlabel('d');
ylabel('Bandbreite %');

s(3) = subplot(1, 3, 3);
plot(x, percDecodingBandwidthMBR, '--r+', x, percDecodingBandwidthMSR, '--b+', x, percMessageSizeMBR, ':ks')
axis([Parameter(1, 3), Parameter(end, 3), 0.9, (percDecodingBandwidthMBR(1, 1) + 0.1)])
legend('MBR', 'MSR', 'Nachrichte')
xlabel('d');
ylabel('Bandbreite %');


% figure
% for i = 1 : size(Parameter, 1)
%     subplot(size(Parameter, 1), 2, (2*(i - 1) + 1))
%     y1 = res{i, 1};
%     y2 = res{i, 2};
%     x = [1 : length(y1)];
%     plot(x, y1, '-r*', x, y2, '-b+')
%     axis([0, (Parameter(i, 1) - Parameter(i, 2)), 0, (max(y1(end), y2(end)) + y1(1))])
%     xlabel('num of failed nodes');
%     ylabel('bandwidth/symbol');
% 
%     subplot(size(Parameter, 1), 2, (2*(i - 1) + 2))
%     y3 = res{i, 3};
%     y4 = res{i, 4};
%     x = [1 : length(y3)];
%     plot(x, y3, '-r*', x, y4, '-b+')
%     axis([0, (Parameter(i, 1) - Parameter(i, 2)), 0, (max(y3(end), y4(end)) + y3(1))])
%     xlabel('num of failed nodes');
%     ylabel('time/s');
% end
