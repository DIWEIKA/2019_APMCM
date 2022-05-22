clc,clear;

%% 下面对2009-2018年东部地区的指标进行聚类分析

Crltn = xlsread('DATA.xlsx','东部地区指标的相关系数矩阵');
Dst = 1 - abs(Crltn); %进行数据交换，把相关系数矩阵转化为距离
Dst = tril(Dst); 
Nzr = nonzeros(Dst); 
Nzr = Nzr'; 
Lkg = linkage(Nzr,'complete'); 
Clas = cluster(Lkg,'maxclust',4) %把变量化为三类
ind1 = find(Clas == 1); ind1 = ind1' %显示第一类对应的变量标号
ind2 = find(Clas == 2); ind2 = ind2'
ind3 = find(Clas == 3); ind3 = ind3'
ind4 = find(Clas == 4); ind4 = ind4'
Draw = dendrogram(Lkg); %画聚类图
set(Draw,'Color','k','LineWidth',1.3) %把聚类图的颜色改成黑色，线宽加宽

