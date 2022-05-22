%% 二次指数平滑法
% 使用二次指数平滑法进行长期预测
%1、alpha的取值精度提高，分度值改为0.001

clc, clear

yt = xlsread('2009-2018年东部地区指标汇总.xlsx');
yt = yt(5,:)'; %导入GDP
ind=length(yt):-1:1; yt=yt(ind); %将数组首位调换顺序，即按年份升序排列
alpha = 0.001;
kk = (1-alpha)/0.001; %计算标准差的个数
n = length(yt);
err = ones(1,kk);
st1(1) = yt(1); st2(1) = yt(1);
    
for j = 1:kk
    for i = 2:n
        st1(i) = alpha*yt(i) + (1-alpha)*st1(i-1);
        st2(i) = alpha*st1(i) + (1-alpha)*st2(i-1);
    end
    at = 2*st1 - st2;
    bt = alpha/(1-alpha)*(st1-st2);
    yhat = at + bt;
    err(1,j) = sqrt(mean((yt(2:n,:)-yhat(:,1:n-1)').^2)); %求标准差
    alpha = alpha+0.001;
end
minS=err(1,kk);min = kk;
for k = 1:kk
    if(minS>err(1,k)) 
        minS = err(1,k);
        min = k;
    end
end
alpha = 0.001*min; %最佳alpha的值
disp(['最佳alpha值为 ',num2str(alpha)]);
disp(['最小标准差为 ',num2str(minS)]);

%下面计算最佳alpha值时的预测值
for i = 2:n
        st1(i) = alpha*yt(i) + (1-alpha)*st1(i-1);
        st2(i) = alpha*st1(i) + (1-alpha)*st2(i-1);
end
at = 2*st1 - st2;
bt = alpha/(1-alpha)*(st1-st2);
yhat = at+bt;

%预测方程: yhatt_m = at(t)+bt(t)*m;
disp(['2028年预测值为 ',num2str(at(10)+bt(10)*10)]);
x = 2010:2018; %前12年的数据
plot(x, yt(2:n,:), '*', x, yhat(:,1:n-1)');
legend('Actual value','Predictive value','Location','northwest') %图注显示在左上角
