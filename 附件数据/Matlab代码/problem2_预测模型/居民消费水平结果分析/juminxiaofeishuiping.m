clc,clear;
close all;

%% 下面对2009-2018年东部地区居民消费水平进行预测
% 使用三次指数平滑法模型进行短期预测

yt = xlsread('2009-2018年东部地区指标汇总.xlsx');
yt = yt(2,:)'; 
ind=length(yt):-1:1; yt=yt(ind); %将数组首位调换顺序，即按年份升序排列
n = length(yt);
alpha = 0.1;
err = ones(1,8);
st0 = mean(yt(1:3));
for j = 1:8
    %计算一次、二次、三次指数的平滑值
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
    err(1,j) = sqrt(mean((yt-yhat').^2))/10^5; %求方差
    alpha = alpha+0.1;
end
minS=err(1,8);min = 8;
for k = 1:8
    if(minS>err(1,k)) 
        minS = err(1,k);
        min = k;
    end
end
alpha = 0.1*min; %最佳alpha的值
disp(['最佳alpha值为 ',num2str(alpha)]);
disp(['最小方差为 ',num2str(minS)]);
%下面计算最佳alpha值时的预测值
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
 xlswrite('居民消费水平预测.xls',[st1',st2',st3'],'Sheet1','B2') %把数据写在前三列
 xlswrite('居民消费水平预测.xls',yhat','Sheet1','E3');%把数据写在第4列第2行开始的位置
 plot(1:n,yt,'D',2:n,yhat(1:end-1),'*')
 legend('实际值','预测值','Location','northwest') %图注显示在左上角
 xishu = [ct(end),bt(end),at(end)]; %二次预测多项式的系数向量
 