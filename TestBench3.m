% same (n, k) and all possible (d)
% get the optimal point of parallel repaire

optimalPoint = zeros(size(Parameter, 1), 2);
availNumNodes = zeros(size(Parameter, 1), 1);

for i = 1 : size(Parameter, 1)
    [optimalPointMBR, optimalPointMSR] = OptimalPoint(Parameter(i, :));

    optimalPoint(i, 1) = optimalPointMBR;
    optimalPoint(i, 2) = optimalPointMSR;

    availNumNodes(i, 1) = Parameter(i, 1) - Parameter(i, 3);
end

x = Parameter(:, 3);
optimalPointMBR = optimalPoint(:, 1);
optimalPointMSR = optimalPoint(:, 2);

plot(x, optimalPointMBR, '--r*', x, optimalPointMSR, '--b+', x, availNumNodes, '--ko')
axis([Parameter(1, 3) - 0.5, Parameter(end, 3) + 0.5, (optimalPointMSR(end, 1) - 1), (availNumNodes(1, 1) + 1)])
legend('E-MBR', 'E-MSR', 'max. ausgefallene Knoten')
xlabel('d');
ylabel('Optimalpunkt');
