%% ����ָ��ƽ����
% ʹ�ö���ָ��ƽ�������г���Ԥ��
%1��alpha��ȡֵ������ߣ��ֶ�ֵ��Ϊ0.001

clc, clear

yt = xlsread('2009-2018�궫������ָ�����.xlsx');
yt = yt(5,:)'; %����GDP
ind=length(yt):-1:1; yt=yt(ind); %��������λ����˳�򣬼��������������
alpha = 0.001;
kk = (1-alpha)/0.001; %�����׼��ĸ���
n = length(yt);
err = ones(1,kk);
st1(1) = yt(1); st2(1) = yt(1);
    
for j = 1:kk
    for i = 2:n
        st1(i) = alpha*yt(i) + (1-alpha)*st1(i-1);
        st2(i) = alpha*st1(i) + (1-alpha)*st2(i-1);
    end
    at = 2*st1 - st2;
    bt = alpha/(1-alpha)*(st1-st2);
    yhat = at + bt;
    err(1,j) = sqrt(mean((yt(2:n,:)-yhat(:,1:n-1)').^2)); %���׼��
    alpha = alpha+0.001;
end
minS=err(1,kk);min = kk;
for k = 1:kk
    if(minS>err(1,k)) 
        minS = err(1,k);
        min = k;
    end
end
alpha = 0.001*min; %���alpha��ֵ
disp(['���alphaֵΪ ',num2str(alpha)]);
disp(['��С��׼��Ϊ ',num2str(minS)]);

%����������alphaֵʱ��Ԥ��ֵ
for i = 2:n
        st1(i) = alpha*yt(i) + (1-alpha)*st1(i-1);
        st2(i) = alpha*st1(i) + (1-alpha)*st2(i-1);
end
at = 2*st1 - st2;
bt = alpha/(1-alpha)*(st1-st2);
yhat = at+bt;

%Ԥ�ⷽ��: yhatt_m = at(t)+bt(t)*m;
disp(['2028��Ԥ��ֵΪ ',num2str(at(10)+bt(10)*10)]);
x = 2010:2018; %ǰ12�������
plot(x, yt(2:n,:), '*', x, yhat(:,1:n-1)');
legend('Actual value','Predictive value','Location','northwest') %ͼע��ʾ�����Ͻ�
