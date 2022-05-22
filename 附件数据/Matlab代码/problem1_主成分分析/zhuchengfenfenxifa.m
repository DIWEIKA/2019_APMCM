clc,clear;
close all;
%% 下面是主成分分析法对经济指标进行分析

yszb = xlsread('2009-2018年东部地区指标汇总.xlsx'); %把原始数据保存在Excel中
% yszb = yszb';
zb = zscore(yszb(2:7,:));%数据标准化
r = corrcoef(zb); %计算相关系数矩阵,其中每一行都是观察值，每一列都是变量
%下面用相关系数矩阵进行主成分分析
[vec1,lamda,rate] = pcacov(r); %,vec1的列为r的特征向量，即主成分的系数,lamda为r的特征值，rate为各个主成分的贡献率
f = repmat(sign(sum(vec1)),size(vec1,1),1); %构造与x同维数的元素为±1的矩阵
vec1 = vec1.*f; %修改特征向量的正负号，每个特征向量乘以所有分量和的符号函数值
num = 3; %num为选取的主成分的个数
df = zb*vec1(:,1:num); %计算各个主成分的得分
tf = df*rate(1:num)/100;%计算综合得分
[stf,ind] = sort(tf,'descend');%把得分按照从高到低的次序排列
stf = stf'
ind = ind'
%  xlswrite('特征向量.xlsx',vec1,'Sheet1','B2') 
%  xlswrite('特征值和贡献率.xlsx',[lamda,rate],'Sheet1','B2');
%  xlswrite('评价值和排名.xlsx',ind,'Sheet1','B2') 
%  xlswrite('评价值和排名.xlsx',stf,'Sheet1','B3');


