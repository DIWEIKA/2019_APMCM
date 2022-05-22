clear,clc;
close all;
%% 因固定资产投资和居民消费水平两项指标没有2018年的数据，故对这两项指标进行拟合
%假设误差在3%以内的预测值可以接受

Gudingzichantouzi = xlsread('DATA.xlsx','2009-2017年固定资产投资');%导入2009-2017年固定资产投资
Juminxiaofeishuiping = xlsread('DATA.xlsx','2009-2017年居民消费水平');%导入2009-2017年居民消费水平
nianfen = [2017 2016 2015 2014 2013 2012 2011 2010 2009];
m = 1; %m为拟合多项式的次数
for i = 2:11
    [p,S] = polyfit(nianfen,Gudingzichantouzi(i,:),m); %p为系数矩阵，S可用作polyval的输入以获得误差估计
    [data2018,Delta] = polyval(p,2018,S); data2018
     Lamda = Delta/data2018 %计算2018年的相对误差
end
for i = 2:11
    [p,S] = polyfit(nianfen,Juminxiaofeishuiping(i,:),m); %p为系数矩阵，S可用作polyval的输入以获得误差估计
    [data2018,Delta] = polyval(p,2018,S); data2018
     Lamda = Delta/data2018 %计算2018年的相对误差
end
