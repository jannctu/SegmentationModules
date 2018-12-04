names = cell(1449,1);
for name=1:1449
    %randomIntegers = randi([1,1449]);
    ss = ['0000' num2str(name)];
    %ss = ['0000' num2str(randomIntegers)];
    while(length(ss) < 8)
        ss = strcat('0',ss);
    end
    names{name} = [ss];
end
