clear,clc;
close all;
%% ��̶��ʲ�Ͷ�ʺ;�������ˮƽ����ָ��û��2018������ݣ��ʶ�������ָ��������
%���������3%���ڵ�Ԥ��ֵ���Խ���

Gudingzichantouzi = xlsread('DATA.xlsx','2009-2017��̶��ʲ�Ͷ��');%����2009-2017��̶��ʲ�Ͷ��
Juminxiaofeishuiping = xlsread('DATA.xlsx','2009-2017���������ˮƽ');%����2009-2017���������ˮƽ
nianfen = [2017 2016 2015 2014 2013 2012 2011 2010 2009];
m = 1; %mΪ��϶���ʽ�Ĵ���
for i = 2:11
    [p,S] = polyfit(nianfen,Gudingzichantouzi(i,:),m); %pΪϵ������S������polyval�������Ի��������
    [data2018,Delta] = polyval(p,2018,S); data2018
     Lamda = Delta/data2018 %����2018���������
end
for i = 2:11
    [p,S] = polyfit(nianfen,Juminxiaofeishuiping(i,:),m); %pΪϵ������S������polyval�������Ի��������
    [data2018,Delta] = polyval(p,2018,S); data2018
     Lamda = Delta/data2018 %����2018���������
end
