%% 二次指数平滑法
% 使用二次指数平滑法进行长期预测
%1、将13年的数据作为原始数据，预测第20年的值
%2、利用王慈光的研究理论确定初始值


clc, clear

yt = xlsread('2009-2021年东经济指标汇总.xlsx');
yt = yt(4,:)'; %导入GDP
ind=length(yt):-1:1; yt=yt(ind); %将数组首位调换顺序，即按年份升序排列
alpha = 0.9; 
n = length(yt);
%     在数列两端各取三个值加以平均，得到两个点（t1,yt1）和（t2,yt2）
    yt1 = mean(yt(1)+yt(2)+yt(3)); yt2 = mean(yt(11)+yt(12)+yt(13));
    t1 = 2010; t2 = 2020;
%     由这两个点建立线性趋势方程解出a和b
    b = (yt2-yt1)/(t2-t1); a = yt1 - b*t1;
%     带入式（8.10）解出st1(1)和st2(1)即为一次二次的初始平滑值
    st1(1) = a - (1-alpha)/alpha*b;
    st2(1) = 2*st1(1) - a;
    
    for i = 2:n
        st1(i) = alpha*yt(i) + (1-alpha)*st1(i-1);
        st2(i) = alpha*st1(i) + (1-alpha)*st2(i-1);
    end
    at = 2*st1 - st2;
    bt = alpha/(1-alpha)*(st1-st2);
    yhat = at + bt;
%预测方程: yhatt_m = at(t)+bt(t)*m;
disp(['2028年预测值为 ',num2str(at(13)+bt(13)*7)]);
x = 2010:2021; %前12年的数据
plot(x, yt(2:n,:), '*', x, yhat(:,1:n-1)');
legend('Actual value','Predictive value','Location','northwest') %图注显示在左上角

