clc,clear;
close all;
%% ���������ɷַ������Ծ���ָ����з���

yszb = xlsread('2009-2018�궫������ָ�����.xlsx'); %��ԭʼ���ݱ�����Excel��
% yszb = yszb';
zb = zscore(yszb(2:7,:));%���ݱ�׼��
r = corrcoef(zb); %�������ϵ������,����ÿһ�ж��ǹ۲�ֵ��ÿһ�ж��Ǳ���
%���������ϵ������������ɷַ���
[vec1,lamda,rate] = pcacov(r); %,vec1����Ϊr�����������������ɷֵ�ϵ��,lamdaΪr������ֵ��rateΪ�������ɷֵĹ�����
f = repmat(sign(sum(vec1)),size(vec1,1),1); %������xͬά����Ԫ��Ϊ��1�ľ���
vec1 = vec1.*f; %�޸����������������ţ�ÿ�����������������з����͵ķ��ź���ֵ
num = 3; %numΪѡȡ�����ɷֵĸ���
df = zb*vec1(:,1:num); %����������ɷֵĵ÷�
tf = df*rate(1:num)/100;%�����ۺϵ÷�
[stf,ind] = sort(tf,'descend');%�ѵ÷ְ��մӸߵ��͵Ĵ�������
stf = stf'
ind = ind'
%  xlswrite('��������.xlsx',vec1,'Sheet1','B2') 
%  xlswrite('����ֵ�͹�����.xlsx',[lamda,rate],'Sheet1','B2');
%  xlswrite('����ֵ������.xlsx',ind,'Sheet1','B2') 
%  xlswrite('����ֵ������.xlsx',stf,'Sheet1','B3');


