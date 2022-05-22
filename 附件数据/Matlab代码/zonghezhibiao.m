%% 下面计算综合指标

f = xlsread('2009-2018年东部地区指标汇总2.xlsx');
x1 = f(2,:); ind=length(x1):-1:1; x1=x1(ind); %将数组首位调换顺序，即按年份升序排列
x2 = f(3,:); ind=length(x2):-1:1; x2=x2(ind); 
x3 = f(4,:); ind=length(x3):-1:1; x3=x3(ind);
x4 = f(5,:); ind=length(x4):-1:1; x4=x4(ind);
x5 = f(6,:); ind=length(x5):-1:1; x5=x5(ind);
x6 = f(7,:); ind=length(x6):-1:1; x6=x6(ind);

for i = 1:14
    Y(1,i) = 64.2553*x3(:,i) + 57.6294*x1(:,i) + 53.5598*x2(:,i) + 44.1130*x5(:,i) + 40.2435* x6(:,i) + 40.1989* x4(:,i)
end

x = [2009:2021,2028];
plot(x, Y, '-*');
