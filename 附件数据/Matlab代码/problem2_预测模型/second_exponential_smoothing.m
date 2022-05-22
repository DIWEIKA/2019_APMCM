%% 二次指数平滑法
%使用二次指数平滑法进行短期预测
clc, clear

yt = xlsread('2009-2018年东部地区指标汇总.xlsx');
yt = yt(5,:)'; %导入GDP
ind=length(yt):-1:1; yt=yt(ind); %将数组首位调换顺序，即按年份升序排列
n = length(yt);
alpha = 0.1;
st1(1) = yt(1); st2(1) = yt(1);  % 初始值选实际初始值
err = ones(1,9);
for j = 1:9
    for i = 2:n
        st1(i) = alpha*yt(i) + (1-alpha)*st1(i-1);
        st2(i) = alpha*st1(i) + (1-alpha)*st2(i-1);
    end
    at = 2*st1 - st2;
    bt = alpha/(1-alpha)*(st1-st2);
    yhat = at + bt;
    err(1,j) = sqrt(mean((yt(2:10,:)-yhat(:,1:9)').^2))/10^5; %求标准差
    alpha = alpha+0.1;
end
minS=err(1,9);min = 9;
for k = 1:9
    if(minS>err(1,k)) 
        minS = err(1,k);
        min = k;
    end
end
alpha = 0.1*min; %最佳alpha的值
disp(['最佳alpha值为 ',num2str(alpha)]);
disp(['最小方差为 ',num2str(minS)]);

%下面计算最佳alpha值时的预测值
for i = 2:n
        st1(i) = alpha*yt(i) + (1-alpha)*st1(i-1);
        st2(i) = alpha*st1(i) + (1-alpha)*st2(i-1);
end
at = 2*st1 - st2;
bt = alpha/(1-alpha)*(st1-st2);
yhat = at+bt;
%预测方程: yhatt_m = at(t)+bt(t)*m;
disp(['2019年预测值为 ',num2str(at(10)+bt(10))]);
disp(['2020年预测值为 ',num2str(at(10)+bt(10)*2)]);
disp(['2021年预测值为 ',num2str(at(10)+bt(10)*3)]);
x = 2010:2018;
plot(x, yt(2:10,:), '*', x, yhat(:,1:9)');
legend('Actual value','Predictive value','Location','northwest') 
yhat = yhat'; st1 = st1'; st2 = st2';

