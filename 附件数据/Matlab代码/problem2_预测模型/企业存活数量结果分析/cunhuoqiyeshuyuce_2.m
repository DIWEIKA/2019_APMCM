clc,clear;
close all;

%% 下面对2009-2018年东部地区企业存活数量进行预测
% 使用拟合曲线进行短长期预测

f = xlsread('2009-2018年东部地区指标汇总.xlsx'); %把原始数据保存在Excel中
shuju = f(7,:); %导入2009-2018年东部地区企业存活数量
ind=length(shuju):-1:1; shuju=shuju(ind); %将数组首位调换顺序，即按年份升序排列
nianfen = 2009:1:2018;
m = 3; %m为拟合多项式的次数
[p,S] = polyfit(nianfen,shuju,m); %p为系数矩阵，S可用作polyval的输入以获得误差估计
 y = p(1)*nianfen.^3+p(2)*nianfen.^2+p(3)*nianfen+p(4); %用三次多项式拟合函数
plot(nianfen,shuju,'^r',nianfen,y,'*-b');
data = ones(1,10);
for i=1:1:10
    [data(1,i),DELTA] = polyval(p,i+2018,S); % DELTA是预测2018年的观测值时产生误差的标准偏差的估计值。
end
data' %输出2019-2028十年的预测值
legend('Actual value','Predictive value','Location','northwest') %图注显示在左上角
