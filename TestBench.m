res = cell(size(Parameter, 1), 5);

for i = 1 : size(Parameter, 1)
    [reBw, deBw, reTime, deTime, optPoint] = Test(codeType, Parameter(i, :));

    res{i, 1} = reBw;
    res{i, 2} = deBw;
    res{i, 3} = reTime;
    res{i, 4} = deTime;
    res{i, 5} = optPoint;
end

figure
for i = 1 : size(Parameter, 1)
    subplot(size(Parameter, 1), 2, (2*(i - 1) + 1))
    y1 = res{i, 1};
    y2 = res{i, 2};
    x = [1 : length(y1)];
    plot(x, y1, '-r*', x, y2, '-b+')
    axis([0, (Parameter(i, 1) - Parameter(i, 2)), 0, (max(y1(end), y2(end)) + y1(1))])
    xlabel('num of failed nodes');
    ylabel('bandwidth/symbol');

    subplot(size(Parameter, 1), 2, (2*(i - 1) + 2))
    y3 = res{i, 3};
    y4 = res{i, 4};
    x = [1 : length(y3)];
    plot(x, y3, '-r*', x, y4, '-b+')
    axis([0, (Parameter(i, 1) - Parameter(i, 2)), 0, (max(y3(end), y4(end)) + y3(1))])
    xlabel('num of failed nodes');
    ylabel('time/s');
end
