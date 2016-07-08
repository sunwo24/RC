% same (n, k) and all possible (d)
% get the optimal point of parallel repaire

optimalPoint = zeros(size(Parameter, 1), 3);
availNumNodes = zeros(size(Parameter, 1), 2);

for i = 1 : size(Parameter, 1)
    [optimalPointMBR, optimalPointMSR, optimalPointRC] = OptimalPoint(Parameter(i, :));

    optimalPoint(i, 1) = optimalPointMBR;
    optimalPoint(i, 2) = optimalPointMSR;
    optimalPoint(i, 3) = optimalPointRC;

    availNumNodes(i, 1) = Parameter(i, 1) - Parameter(i, 3);
    availNumNodes(i, 2) = Parameter(i, 1) - Parameter(i, 2);
end

x = Parameter(:, 3);
optimalPointMBR = optimalPoint(:, 1);
optimalPointMSR = optimalPoint(:, 2);
optimalPointRC = optimalPoint(:, 3);
availNumNodesPR = availNumNodes(:, 1);
availNumNodesMDSR = availNumNodes(:, 2);

figure
subplot(2, 1, 1);
plot(x, optimalPointMBR, '--r*', x, optimalPointMSR, '--b+', x, availNumNodesPR, '--ko', x, availNumNodesMDSR, '--ks')
axis([Parameter(1, 3) - 0.5, Parameter(end, 3) + 0.5, (optimalPointMSR(end, 1) - 1), (availNumNodes(1, 2) + 2)])
legend('E-MBR', 'E-MSR', 'max. PR |f|', 'max. MDSR |f|')
xlabel('d');
ylabel('Optimalpunkt |f|');

subplot(2, 1, 2);
plot(x, optimalPointMBR, '--r*', x, optimalPointMSR, '--b+', x, optimalPointRC, '--ko')
axis([Parameter(1, 3) - 1, Parameter(end, 3) + 1, (optimalPointMSR(end, 1) - 1), (optimalPointMBR(1, 1) + 2)])
legend('E-MBR', 'E-MSR', 'E-RC')
xlabel('d');
ylabel('Optimalpunkt |f|');
