clc,clear;
close all;
%% 下面按年度将东部地区的各个指标的省份或城市的样本值求和

%下面按年度将东部地区的各个指标的省份或城市的样本值求和
Gudingzichantouzi = xlsread('DATA.xlsx','2009-2018年固定资产投资');%导入2009-2018年固定资产投资
Juminxiaofeishuiping = xlsread('DATA.xlsx','2009-2018年居民消费水平');%导入2009-2018年居民消费水平
GDP = xlsread('DATA.xlsx','2009-2018年GDP');%导入2009-2018年GDP
CPI = xlsread('DATA.xlsx','2009-2018年CPI');%导入2009-2018年CPI
Changzhurenkou = xlsread('DATA.xlsx','2009-2018常住人口');%导入2009-2018年常驻人口


    S1 = sum(Juminxiaofeishuiping(2:11,:),1)
    S2 = sum(Gudingzichantouzi(2:11,:),1)
    S3 = sum(GDP(2:11,:),1)
    S4 = sum(CPI(2:11,:),1)
    S5 = sum(Changzhurenkou(2:11,:),1)

