clc,clear;
close all;

%% �����2009-2018�궫��������ҵ�����������Ԥ��
% ʹ��������߽��ж̳���Ԥ��

f = xlsread('2009-2018�궫������ָ�����.xlsx'); %��ԭʼ���ݱ�����Excel��
shuju = f(7,:); %����2009-2018�궫��������ҵ�������
ind=length(shuju):-1:1; shuju=shuju(ind); %��������λ����˳�򣬼��������������
nianfen = 2009:1:2018;
m = 3; %mΪ��϶���ʽ�Ĵ���
[p,S] = polyfit(nianfen,shuju,m); %pΪϵ������S������polyval�������Ի��������
 y = p(1)*nianfen.^3+p(2)*nianfen.^2+p(3)*nianfen+p(4); %�����ζ���ʽ��Ϻ���
plot(nianfen,shuju,'^r',nianfen,y,'*-b');
data = ones(1,10);
for i=1:1:10
    [data(1,i),DELTA] = polyval(p,i+2018,S); % DELTA��Ԥ��2018��Ĺ۲�ֵʱ�������ı�׼ƫ��Ĺ���ֵ��
end
data' %���2019-2028ʮ���Ԥ��ֵ
legend('Actual value','Predictive value','Location','northwest') %ͼע��ʾ�����Ͻ�
