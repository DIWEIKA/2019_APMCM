clc,clear;
close all;

%% �����2009-2018�궫��������������ˮƽ����Ԥ��
% ʹ�û�ɫԤ��ģ�ͽ��ж���Ԥ��

f = xlsread('2009-2018�궫������ָ�����.xlsx'); %��ԭʼ���ݱ�����Excel��
y = f(2,:); 
n=length(y);
%���ȼ���
lamda = y(1,1:n-1)./y(1,2:n); %���㼶��
range = minmax(lamda) %���㼶�ȵķ�Χ
yy=ones(n,1);
yy(1)=y(1);
for i=2:n
    yy(i)=yy(i-1)+y(i); %�����ۼ���������
end
B=ones(n-1,2);
for i=1:(n-1)
    B(i,1)=-(yy(i)+yy(i+1))/2; %�����ֵ��������
    B(i,2)=1;
end
BT=B'; %��B��ΪB��ת��
for j=1:n-1
    YN(j)=y(j+1); %������������Ǻ�Y
end
YN=YN'; %��Y���������
A = inv(BT*B)*BT*YN; %����u�Ĺ���ֵ
a=A(1);
u=A(2);
t=u/a;
i=1:n+2;
yys(i+1)=(y(1)-t).*exp(-a.*i)+t; %Ԥ��ֵ���㹫ʽ
yys(1)=y(1);
for j=n+2:-1:2
    ys(j)=yys(j)-yys(j-1);
end
x=1:n;
xs=2:n+2
yn=ys(2:n+2)
plot(x,y,'^r',xs,yn,'*-b'); %x��yΪԭʼֵ��xs��ynΪģ�ͻ�ԭֵ��Ԥ��ֵ��
                             ...��ɫ����ԭʼ���ݣ���ɫ����Ԥ��������
det=0;

%�����Ǻ�����ֵ�ļ���Ͳ�������Ӧ��Ԥ�ⲥ��
sum1=0;
sumpe=0;
for i=1:n
    sumpe=sumpe+y(i);
end
pe=sumpe/n;
for i=1:n;
    sum1=sum1+(y(i)-pe).^2;
end
s1=sqrt(sum1/n);
sumce=0;
for i=2:n
    sumce=sumce+(y(i)-yn(i));
end
ce=sumce/(n-1);
sum2=0;
for i=2:n;
    sum2=sum2+(y(i)-yn(i)-ce).^2;
end
s2=sqrt(sum2/(n-1));
c=(s2)/(s1);
disp(['������ֵΪ��',num2str(c)]); %disp()��ʾ����
                                     ...num2str()���ڽ�����ת��Ϊ�ַ���
if c<0.35
    disp('ϵͳԤ�⾫�Ⱥ�')
else if c<0.5
        disp('ϵͳԤ�⾫�Ⱥϸ�')
    else if c<0.65
            disp('ϵͳԤ�⾫����ǿ')
        else
            disp('ϵͳԤ�⾫�Ȳ��ϸ�')
        end
    end
end

%�����Ǻ�����Ԥ��ֵ
disp(['�¸����ֵΪ ',num2str(ys(n+1))]);
disp(['���¸����ֵΪ',num2str(ys(n+2))]);