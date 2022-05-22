%% ����ָ��ƽ����
%ʹ�ö���ָ��ƽ�������ж���Ԥ��
clc, clear

yt = xlsread('2009-2018�궫������ָ�����.xlsx');
yt = yt(5,:)'; %����GDP
ind=length(yt):-1:1; yt=yt(ind); %��������λ����˳�򣬼��������������
n = length(yt);
alpha = 0.1;
st1(1) = yt(1); st2(1) = yt(1);  % ��ʼֵѡʵ�ʳ�ʼֵ
err = ones(1,9);
for j = 1:9
    for i = 2:n
        st1(i) = alpha*yt(i) + (1-alpha)*st1(i-1);
        st2(i) = alpha*st1(i) + (1-alpha)*st2(i-1);
    end
    at = 2*st1 - st2;
    bt = alpha/(1-alpha)*(st1-st2);
    yhat = at + bt;
    err(1,j) = sqrt(mean((yt(2:10,:)-yhat(:,1:9)').^2))/10^5; %���׼��
    alpha = alpha+0.1;
end
minS=err(1,9);min = 9;
for k = 1:9
    if(minS>err(1,k)) 
        minS = err(1,k);
        min = k;
    end
end
alpha = 0.1*min; %���alpha��ֵ
disp(['���alphaֵΪ ',num2str(alpha)]);
disp(['��С����Ϊ ',num2str(minS)]);

%����������alphaֵʱ��Ԥ��ֵ
for i = 2:n
        st1(i) = alpha*yt(i) + (1-alpha)*st1(i-1);
        st2(i) = alpha*st1(i) + (1-alpha)*st2(i-1);
end
at = 2*st1 - st2;
bt = alpha/(1-alpha)*(st1-st2);
yhat = at+bt;
%Ԥ�ⷽ��: yhatt_m = at(t)+bt(t)*m;
disp(['2019��Ԥ��ֵΪ ',num2str(at(10)+bt(10))]);
disp(['2020��Ԥ��ֵΪ ',num2str(at(10)+bt(10)*2)]);
disp(['2021��Ԥ��ֵΪ ',num2str(at(10)+bt(10)*3)]);
x = 2010:2018;
plot(x, yt(2:10,:), '*', x, yhat(:,1:9)');
legend('Actual value','Predictive value','Location','northwest') 
yhat = yhat'; st1 = st1'; st2 = st2';

