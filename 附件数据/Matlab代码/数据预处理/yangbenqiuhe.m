clc,clear;
close all;
%% ���水��Ƚ����������ĸ���ָ���ʡ�ݻ���е�����ֵ���

%���水��Ƚ����������ĸ���ָ���ʡ�ݻ���е�����ֵ���
Gudingzichantouzi = xlsread('DATA.xlsx','2009-2018��̶��ʲ�Ͷ��');%����2009-2018��̶��ʲ�Ͷ��
Juminxiaofeishuiping = xlsread('DATA.xlsx','2009-2018���������ˮƽ');%����2009-2018���������ˮƽ
GDP = xlsread('DATA.xlsx','2009-2018��GDP');%����2009-2018��GDP
CPI = xlsread('DATA.xlsx','2009-2018��CPI');%����2009-2018��CPI
Changzhurenkou = xlsread('DATA.xlsx','2009-2018��ס�˿�');%����2009-2018�곣פ�˿�


    S1 = sum(Juminxiaofeishuiping(2:11,:),1)
    S2 = sum(Gudingzichantouzi(2:11,:),1)
    S3 = sum(GDP(2:11,:),1)
    S4 = sum(CPI(2:11,:),1)
    S5 = sum(Changzhurenkou(2:11,:),1)

