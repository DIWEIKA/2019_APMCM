clc,clear;
close all;

%% �����2009-2018�궫��������������ˮƽ����Ԥ��
% ʹ������ָ��ƽ����ģ�ͽ��ж���Ԥ��

yt = xlsread('2009-2018�궫������ָ�����.xlsx');
yt = yt(2,:)'; 
ind=length(yt):-1:1; yt=yt(ind); %��������λ����˳�򣬼��������������
n = length(yt);
alpha = 0.1;
err = ones(1,8);
st0 = mean(yt(1:3));
for j = 1:8
    %����һ�Ρ����Ρ�����ָ����ƽ��ֵ
    st1(1) = alpha*yt(1)+(1-alpha)*st0;
    st2(1) = alpha*st1(1)+(1-alpha)*st0;
    st3(1) = alpha*st2(1)+(1-alpha)*st0;
    for i = 2:n
        st1(i) = alpha*yt(i)+(1-alpha)*st1(i-1);
        st2(i) = alpha*st1(i)+(1-alpha)*st2(i-1);
        st3(i) = alpha*st2(i)+(1-alpha)*st3(i-1);
    end
    at = 3*st1 - 3*st3 + st3;
    bt = 0.5*alpha^2/(1-alpha)^2*((6-5*alpha)*st1-2*(5-4*alpha)*st2+(4-3*alpha)*st3);
    ct = 0.5*alpha^2/(1-alpha)^2*(st1-2*st2+st3);
    yhat = at+bt+ct;
    err(1,j) = sqrt(mean((yt-yhat').^2))/10^5; %�󷽲�
    alpha = alpha+0.1;
end
minS=err(1,8);min = 8;
for k = 1:8
    if(minS>err(1,k)) 
        minS = err(1,k);
        min = k;
    end
end
alpha = 0.1*min; %���alpha��ֵ
disp(['���alphaֵΪ ',num2str(alpha)]);
disp(['��С����Ϊ ',num2str(minS)]);
%����������alphaֵʱ��Ԥ��ֵ
st1(1) = alpha*yt(1)+(1-alpha)*st0;
st2(1) = alpha*st1(1)+(1-alpha)*st0;
st3(1) = alpha*st2(1)+(1-alpha)*st0;
 for i = 2:n
    st1(i) = alpha*yt(i)+(1-alpha)*st1(i-1);
    st2(i) = alpha*st1(i)+(1-alpha)*st2(i-1);
    st3(i) = alpha*st2(i)+(1-alpha)*st3(i-1);
 end
 at = 3*st1 - 3*st3 + st3;
 bt = 0.5*alpha^2/(1-alpha)^2*((6-5*alpha)*st1-2*(5-4*alpha)*st2+(4-3*alpha)*st3);
 ct = 0.5*alpha^2/(1-alpha)^2*(st1-2*st2+st3);
 yhat = at+bt+ct;
 xlswrite('��������ˮƽԤ��.xls',[st1',st2',st3'],'Sheet1','B2') %������д��ǰ����
 xlswrite('��������ˮƽԤ��.xls',yhat','Sheet1','E3');%������д�ڵ�4�е�2�п�ʼ��λ��
 plot(1:n,yt,'D',2:n,yhat(1:end-1),'*')
 legend('ʵ��ֵ','Ԥ��ֵ','Location','northwest') %ͼע��ʾ�����Ͻ�
 xishu = [ct(end),bt(end),at(end)]; %����Ԥ�����ʽ��ϵ������
 