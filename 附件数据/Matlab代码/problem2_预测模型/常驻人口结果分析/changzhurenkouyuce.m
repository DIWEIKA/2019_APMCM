%clc,clear;
close all;

%% 下面对2009-2018年东部地区常驻人口数量进行预测
% 使用logistic非线性最小二乘估计

f = xlsread('2009-2018年东部地区指标汇总.xlsx'); %把原始数据保存在Excel中
x = f(6,:)'; %提取出常驻人口数量的数据
t = [2009:1:2018]';
t0 = t(1); x0 = x(1);
%下面是人口增长模型的解
fun = @(cs,td) cs(1)./(1+(cs(1)/x0-1)*exp(-cs(2)*(td-t0)));
%cs(1) = xm,cs(2) = r cs里有两个参数，一个是最大人口数xm,一个是增长率r
cs = lsqcurvefit(fun,rand(2,1),t(2:end),x(2:end),zeros(2,1))
%从rand(2,1)开始，找到系数cs以使fun中的非线性函数最适合数据x(1:10)（在最小二乘意义上）
%xhat = ones(1,10);
for i=1:10
xhat = fun(cs,2009-i)
end
%disp(['2009后十年的预测值为 ',num2str(xhat)]);
