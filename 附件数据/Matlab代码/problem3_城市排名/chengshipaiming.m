clc,clear;
close all;
%% 下面是主成分分析法对北上广深和其它主要二线城市进行排名

shuju = xlsread('2017年主要城市指标汇总.xlsx'); %把原始数据保存在Excel中

gj = zscore(shuju);%数据标准化
r = corrcoef(gj); %计算相关系数矩阵,其中每一行都是观察值，每一列都是变量
%下面用相关系数矩阵进行主成分分析
[vec1,lamda,rate] = pcacov(r) % vec1的列为r的特征向量，即主成分的系数
                    % rate为各个主成分的贡献率,lamda为r的特征值 
contr = cumsum(rate) %计算累计贡献率
f = repmat(sign(sum(vec1)),size(vec1,1),1); %构造与vec1同维数的元素为±1的矩阵
vec2 = vec1.*f %修改特征向量的正负号，使得每个特征向量的分量和为正
num = 4; %num为选取主成分的个数
df = gj*vec2(:,1:num); %计算各个主成分的得分
tf = df*rate(1:num)/100;%计算综合得分
[stf,ind] = sort(tf,'descend');%把得分按照从高到低的次序排列
stf = stf', ind = ind'
%  xlswrite('特征向量.xlsx',vec1,'Sheet1','B2') 
%  xlswrite('特征值和贡献率.xlsx',[lamda,rate],'Sheet1','B2');
 xlswrite('评价值和排名.xlsx',ind,'Sheet1','B2') 
 xlswrite('评价值和排名.xlsx',stf,'Sheet1','B3');



