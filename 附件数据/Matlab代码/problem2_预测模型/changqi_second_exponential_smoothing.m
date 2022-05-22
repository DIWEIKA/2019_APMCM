%% ����ָ��ƽ����
% ʹ�ö���ָ��ƽ�������г���Ԥ��
%1����13���������Ϊԭʼ���ݣ�Ԥ���20���ֵ
%2���������ȹ���о�����ȷ����ʼֵ


clc, clear

yt = xlsread('2009-2021�궫����ָ�����.xlsx');
yt = yt(4,:)'; %����GDP
ind=length(yt):-1:1; yt=yt(ind); %��������λ����˳�򣬼��������������
alpha = 0.9; 
n = length(yt);
%     ���������˸�ȡ����ֵ����ƽ�����õ������㣨t1,yt1���ͣ�t2,yt2��
    yt1 = mean(yt(1)+yt(2)+yt(3)); yt2 = mean(yt(11)+yt(12)+yt(13));
    t1 = 2010; t2 = 2020;
%     ���������㽨���������Ʒ��̽��a��b
    b = (yt2-yt1)/(t2-t1); a = yt1 - b*t1;
%     ����ʽ��8.10�����st1(1)��st2(1)��Ϊһ�ζ��εĳ�ʼƽ��ֵ
    st1(1) = a - (1-alpha)/alpha*b;
    st2(1) = 2*st1(1) - a;
    
    for i = 2:n
        st1(i) = alpha*yt(i) + (1-alpha)*st1(i-1);
        st2(i) = alpha*st1(i) + (1-alpha)*st2(i-1);
    end
    at = 2*st1 - st2;
    bt = alpha/(1-alpha)*(st1-st2);
    yhat = at + bt;
%Ԥ�ⷽ��: yhatt_m = at(t)+bt(t)*m;
disp(['2028��Ԥ��ֵΪ ',num2str(at(13)+bt(13)*7)]);
x = 2010:2021; %ǰ12�������
plot(x, yt(2:n,:), '*', x, yhat(:,1:n-1)');
legend('Actual value','Predictive value','Location','northwest') %ͼע��ʾ�����Ͻ�

