clc,clear;
close all;
%% ���������ɷַ������Ա��Ϲ����������Ҫ���߳��н�������

shuju = xlsread('2017����Ҫ����ָ�����.xlsx'); %��ԭʼ���ݱ�����Excel��

gj = zscore(shuju);%���ݱ�׼��
r = corrcoef(gj); %�������ϵ������,����ÿһ�ж��ǹ۲�ֵ��ÿһ�ж��Ǳ���
%���������ϵ������������ɷַ���
[vec1,lamda,rate] = pcacov(r) % vec1����Ϊr�����������������ɷֵ�ϵ��
                    % rateΪ�������ɷֵĹ�����,lamdaΪr������ֵ 
contr = cumsum(rate) %�����ۼƹ�����
f = repmat(sign(sum(vec1)),size(vec1,1),1); %������vec1ͬά����Ԫ��Ϊ��1�ľ���
vec2 = vec1.*f %�޸����������������ţ�ʹ��ÿ�����������ķ�����Ϊ��
num = 4; %numΪѡȡ���ɷֵĸ���
df = gj*vec2(:,1:num); %����������ɷֵĵ÷�
tf = df*rate(1:num)/100;%�����ۺϵ÷�
[stf,ind] = sort(tf,'descend');%�ѵ÷ְ��մӸߵ��͵Ĵ�������
stf = stf', ind = ind'
%  xlswrite('��������.xlsx',vec1,'Sheet1','B2') 
%  xlswrite('����ֵ�͹�����.xlsx',[lamda,rate],'Sheet1','B2');
 xlswrite('����ֵ������.xlsx',ind,'Sheet1','B2') 
 xlswrite('����ֵ������.xlsx',stf,'Sheet1','B3');



