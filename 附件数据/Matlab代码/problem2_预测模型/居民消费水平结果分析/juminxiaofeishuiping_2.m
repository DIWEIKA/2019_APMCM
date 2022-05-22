clc,clear;
close all;

%% 下面对2009-2018年东部地区居民消费水平进行预测
% 使用灰色预测模型进行短期预测

f = xlsread('2009-2018年东部地区指标汇总.xlsx'); %把原始数据保存在Excel中
y = f(2,:); 
n=length(y);
%级比检验
lamda = y(1,1:n-1)./y(1,2:n); %计算级比
range = minmax(lamda) %计算级比的范围
yy=ones(n,1);
yy(1)=y(1);
for i=2:n
    yy(i)=yy(i-1)+y(i); %计算累加生成序列
end
B=ones(n-1,2);
for i=1:(n-1)
    B(i,1)=-(yy(i)+yy(i+1))/2; %计算均值生成序列
    B(i,2)=1;
end
BT=B'; %将B变为B的转置
for j=1:n-1
    YN(j)=y(j+1); %引入矩阵向量记号Y
end
YN=YN'; %将Y变成列向量
A = inv(BT*B)*BT*YN; %计算u的估计值
a=A(1);
u=A(2);
t=u/a;
i=1:n+2;
yys(i+1)=(y(1)-t).*exp(-a.*i)+t; %预测值计算公式
yys(1)=y(1);
for j=n+2:-1:2
    ys(j)=yys(j)-yys(j-1);
end
x=1:n;
xs=2:n+2
yn=ys(2:n+2)
plot(x,y,'^r',xs,yn,'*-b'); %x、y为原始值；xs、yn为模型还原值（预测值）
                             ...红色的是原始数据，蓝色的是预测后的数据
det=0;

%下面是后验差比值的计算和并给出相应的预测播报
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
disp(['后验差比值为：',num2str(c)]); %disp()显示数列
                                     ...num2str()用于将数字转换为字符串
if c<0.35
    disp('系统预测精度好')
else if c<0.5
        disp('系统预测精度合格')
    else if c<0.65
            disp('系统预测精度勉强')
        else
            disp('系统预测精度不合格')
        end
    end
end

%下面是后两个预测值
disp(['下个拟合值为 ',num2str(ys(n+1))]);
disp(['再下个拟合值为',num2str(ys(n+2))]);