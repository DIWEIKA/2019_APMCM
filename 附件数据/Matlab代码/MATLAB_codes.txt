clc,clear;
close all;

%% Codes of Data Process

% % Find the number of surviving enterprises in 2009-2018
Srv_entrprs_2019 = xlsread('DATA.xlsx','Srv_entrprs_2019');...
%Importing the number of surviving companies in each province in 2019
Cty_entrprs = xlsread('DATA.xlsx','Cty_entrprs');...
%Number of companies that survived and died in 2009-2018 in major cities
Entrprs_Inc_2009_2018 = xlsread('DATA.xlsx','entrprs_Inc_2009_2018');...
%Incremental introduction of enterprises in the economic zone from 2009 to 2018

%Find the number of enterprises survival in the eastern region in 2019
E_entrprs_cunhuo = Srv_entrprs_2019(4,1)+Srv_entrprs_2019(5,1)+Srv_entrprs_2019(12,1)...
                +Srv_entrprs_2019(13,1)+Srv_entrprs_2019(21,1)+Srv_entrprs_2019(22,1)...
                +Srv_entrprs_2019(23,1)+Srv_entrprs_2019(27,1)+Srv_entrprs_2019(30,1)...
                +Srv_entrprs_2019(31,1);
%Find the survival rate of enterprises in the eastern region
E_rate_cunhuo = (Cty_entrprs(1,2)+Cty_entrprs(2,2)+Cty_entrprs(3,2)...
    +Cty_entrprs(4,2)+Cty_entrprs(7,2)+Cty_entrprs(8,2)+Cty_entrprs(9,2)...
    +Cty_entrprs(10,2)+Cty_entrprs(11,2)+Cty_entrprs(12,2)+Cty_entrprs(16,2))...
    /(Cty_entrprs(1,1)+Cty_entrprs(2,1)+Cty_entrprs(3,1)+Cty_entrprs(4,1)...
    +Cty_entrprs(7,1)+Cty_entrprs(8,1)+Cty_entrprs(9,1)+Cty_entrprs(10,1)...
    +Cty_entrprs(11,1)+Cty_entrprs(12,1)+Cty_entrprs(16,1));
%Find the number of surviving companies in the eastern region from 2009 to 2018
E_chs_2009_2018 = [2018,0;2017,0;2016,0;2015,0;2014,0;2013,0;2012,0;2011,0;2010,0;2009,0;];
tmp_cunhuo = E_entrprs_cunhuo;       
for i = 0:9
    E_cunhuo_Inc = E_rate_cunhuo.*Entrprs_Inc_2009_2018(10-i,2);
    E_chs_2009_2018(i+1,2) = tmp_cunhuo - E_cunhuo_Inc;
    tmp_cunhuo = E_chs_2009_2018(i+1,2); 
end
E_chs_2009_2018 = E_chs_2009_2018';

% % Fitting the data
%Write the obtained data to DATA.xlsx / 2009-2018 FAI
%Write the obtained data to DATA.xlsx / 2009-2018 HCL
Gudingzichantouzi = xlsread('DATA.xlsx','2009-2017 FAI');%importing 2009-2017 FAI
Juminxiaofeishuiping = xlsread('DATA.xlsx','2009-2017 HCL');%importing 2009-2017 Household consumption level
nianfen = [2017 2016 2015 2014 2013 2012 2011 2010 2009];
m = 1;
for i = 2:11
    [p,S] = polyfit(nianfen,Gudingzichantouzi(i,:),m); 
    [data2018,Delta] = polyval(p,2018,S); data2018
    Lamda = Delta/data2018 
end
for i = 2:11
    [p,S] = polyfit(nianfen,Juminxiaofeishuiping(i,:),m); 
    [data2018,Delta] = polyval(p,2018,S); data2018
    Lamda = Delta/data2018 
end

% % Sum of samples
%Sum the sample values of provinces or cities for each indicator in the eastern region by year
%Write the obtained data to DATA.xlsx / 2009-2018 Summary of Indicators for the Eastern Region
Gudingzichantouzi = xlsread('DATA.xlsx','2009-2018 FAI');%importing 2009-2018 FAI
Juminxiaofeishuiping = xlsread('DATA.xlsx','2009-2018 HCL');%importing 2009-2018 Household consumption level
GDP = xlsread('DATA.xlsx','2009-2018 GDP');%importing 2009-2018 GDP
CPI = xlsread('DATA.xlsx','2009-2018 CPI');%importing 2009-2018 CPI
Changzhurenkou = xlsread('DATA.xlsx','2009-2018 Permanent Residents');%importing 2009-2018 Permanent Residents
S1 = sum(Juminxiaofeishuiping(2:11,:),1)
S2 = sum(Gudingzichantouzi(2:11,:),1)
S3 = sum(GDP(2:11,:),1)
S4 = sum(CPI(2:11,:),1)
S5 = sum(Changzhurenkou(2:11,:),1)

%% Codes of Question1 

% % Cluster analysis
Crltn_1 = xlsread('DATA.xlsx','Correlation_matrix_Eastern'); %importing Correlation coefficient matrix for eastern region indicators
Dst = 1 - abs(Crltn_1); 
Dst = tril(Dst); 
Nzr = nonzeros(Dst); 
Nzr = Nzr'; 
Lkg = linkage(Nzr,'complete'); 
Clas = cluster(Lkg,'maxclust',4) 
ind1 = find(Clas == 1); ind1 = ind1' 
ind2 = find(Clas == 2); ind2 = ind2'
ind3 = find(Clas == 3); ind3 = ind3'
ind4 = find(Clas == 4); ind4 = ind4'
Draw = dendrogram(Lkg); 
set(Draw,'Color','k','LineWidth',1.3)

% % PCA
Yszb_1 = xlsread('DATA.xlsx','2009-2018 Eastern Indicatiors'); %importing 2009-2018 Summary of Indicators for the Eastern Region
ZB = zscore(Yszb_1(2:7,:));
Crltn_2 = corrcoef(ZB);
[Vec1,~,rate] = pcacov(Crltn_2); 
Rmt = repmat(sign(sum(Vec1)),size(Vec1,1),1); 
Vec1 = Vec1.*Rmt; 
num = 3; 
DF = ZB*Vec1(:,1:num); 
ZHDF = DF*rate(1:num)/100;
[Stf,Ind] = sort(ZHDF,'descend');
Stf = Stf' %overall ratings
Ind = Ind' %rank

%% Codes of Question2 

% % Logistic makes short-term and long-term projections of the number of permanent residents
Yszb_2 = xlsread('DATA.xlsx','2009-2018 Eastern Indicatiors'); %importing 2009-2018 Summary of Indicators for the Eastern Region
Changzhurenkou_2 = Yszb_2(6,:)'; %importing data of the number of permanent residents
t = [2009:1:2018]';
t0 = t(1); x0 = Changzhurenkou_2(1);
fun = @(cs,td) cs(1)./(1+(cs(1)/x0-1)*exp(-cs(2)*(td-t0)));
cs = lsqcurvefit(fun,rand(2,1),t(2:end),Changzhurenkou_2(2:end),zeros(2,1));
Changzhurenkou_2hat = ones(1,10);
for i=1:10
    Changzhurenkou_2hat = fun(cs,2009-i)
end

% % Second-exponential Smoothing makes short-term forecasts for each of the four economic indicators
% Take index = 2, 3, 4, and 5 to predict household consumption levels, FAI, GDP, and CPI, respectively.
Yszb_3 = xlsread('DATA.xlsx','2009-2018 Eastern Indicatiors'); %importing 2009-2018 Summary of Indicators for the Eastern Region
index = 2; 
Yszb_3 = Yszb_3(index,:)'; 
ind=length(Yszb_3):-1:1; 
Yszb_3=Yszb_3(ind); 
n = length(Yszb_3);
alpha = 0.1;
st1(1) = Yszb_3(1); st2(1) = Yszb_3(1);  
err = ones(1,9);
for j = 1:9
    for i = 2:n
        st1(i) = alpha*Yszb_3(i) + (1-alpha)*st1(i-1);
        st2(i) = alpha*st1(i) + (1-alpha)*st2(i-1);
    end
    at = 2*st1 - st2;
    bt = alpha/(1-alpha)*(st1-st2);
    Yszb_3hat = at + bt;
    err(1,j) = sqrt(mean((Yszb_3(2:10,:)-Yszb_3hat(:,1:9)').^2))/10^5; 
    alpha = alpha+0.1;
end
minS=err(1,9);min = 9;
for k = 1:9
    if(minS>err(1,k)) 
        minS = err(1,k);
        min = k;
    end
end
alpha = 0.1*min;
disp(['Best alpha value',num2str(alpha)]);
disp(['The minimum standard deviation is ',num2str(minS)]);
for i = 2:n     %Let's calculate the predicted value at the best alpha value
        st1(i) = alpha*Yszb_3(i) + (1-alpha)*st1(i-1);
        st2(i) = alpha*st1(i) + (1-alpha)*st2(i-1);
end
at = 2*st1 - st2;
bt = alpha/(1-alpha)*(st1-st2);
Yszb_3hat = at+bt;
disp(['2019 forecast ',num2str(at(10)+bt(10))]);
disp(['2020 forecast ',num2str(at(10)+bt(10)*2)]);
disp(['2021 forecast ',num2str(at(10)+bt(10)*3)]);
x_9 = 2010:2018;
plot(x_9, Yszb_3(2:10,:), '*', x_9, Yszb_3hat(:,1:9)');
legend('Actual value','Predictive value','Location','northwest') 

% % Second-exponential Smoothing makes long-term forecasts for each of the four economic indicators
% Long-term predictions using quadratic exponential smoothing
% The value of alpha is improved, and the division value is changed to 0.001.
Yszb_4 = xlsread('DATA.xlsx','2009-2018 Eastern Indicatiors'); %importing 2009-2018 Summary of Indicators for the Eastern Region
Yszb_4 = Yszb_4(5,:)'; %importing GDP
ind=length(Yszb_4):-1:1; Yszb_4=Yszb_4(ind); 
alpha2 = 0.001;
kk = (1-alpha2)/0.001; 
n2 = length(Yszb_4);
err2 = ones(1,kk);
st1_2(1) = Yszb_4(1); st2_2(1) = Yszb_4(1);
for j = 1:kk
    for i = 2:n2
        st1_2(i) = alpha2*Yszb_4(i) + (1-alpha2)*st1_2(i-1);
        st2_2(i) = alpha2*st1_2(i) + (1-alpha2)*st2_2(i-1);
    end
    at2 = 2*st1_2 - st2_2;
    bt2 = alpha2/(1-alpha2)*(st1_2-st2_2);
    Yszb_4hat = at2 + bt2;
    err2(1,j) = sqrt(mean((Yszb_4(2:n2,:)-Yszb_4hat(:,1:n2-1)').^2)); 
    alpha2 = alpha2+0.001;
end
minS_2=err2(1,kk);min2 = kk;
for k = 1:kk
    if(minS_2>err2(1,k)) 
        minS_2 = err2(1,k);
        min2 = k;
    end
end
alpha2 = 0.001*min2; 
disp(['Best alpha value ',num2str(alpha2)]);
disp(['The minimum standard deviation is ',num2str(minS_2)]);
for i = 2:n2   %Let's calculate the predicted value at the best alpha value
        st1_2(i) = alpha2*Yszb_4(i) + (1-alpha2)*st1_2(i-1);
        st2_2(i) = alpha2*st1_2(i) + (1-alpha2)*st2_2(i-1);
end
at2 = 2*st1_2 - st2_2;
bt2 = alpha2/(1-alpha2)*(st1_2-st2_2);
Yszb_4hat = at2+bt2;
disp(['2028 forecast ',num2str(at2(10)+bt2(10)*10)]);
x_12 = 2010:2018; %Data for the previous 12 years
plot(x_12, Yszb_4(2:n,:), '*', x_12, Yszb_4hat(:,1:n-1)');
legend('Actual value','Predictive value','Location','northwest') 

% % Cubic polynomial fitting makes short-term and long-term predictions of the number of businesses to survive
% Short-term and long-term predictions using fitted curves
Yszb_5 = xlsread('DATA.xlsx','2009-2018 Eastern Indicatiors'); %importing 2009-2018 Summary of Indicators for the Eastern Region
Yszb_5 = Yszb_5(7,:); 
ind=length(Yszb_5):-1:1; Yszb_5=Yszb_5(ind); 
nianfen2 = 2009:1:2018;
m = 3; 
[p,S] = polyfit(nianfen2,Yszb_5,m); 
Polyfit = p(1)*nianfen2.^3+p(2)*nianfen2.^2+p(3)*nianfen2+p(4); %Fit function with cubic polynomial
plot(nianfen2,Yszb_5,'^r',nianfen2,Polyfit,'*-b');
legend('Actual value','Predictive value','Location','northwest') 
data = ones(1,10);
for i=1:1:10
    [data(1,i),DELTA] = polyval(p,i+2018,S); 
end
data' 

%% Codes of Question3

% % PCA ranks cities in Annex 3
MainCty = xlsread('DATA.xlsx','2017 City Indicators'); %importing summary of main city indicators in 2017
gj = zscore(MainCty);
Crltn_2 = corrcoef(gj); 
[Vec1_2,lamda,rate2] = pcacov(Crltn_2);
contr = cumsum(rate2); 
ff = repmat(sign(sum(Vec1_2)),size(Vec1_2,1),1); 
Vec2 = Vec1_2.*ff; 
num2 = 4; 
DF2 = gj*Vec2(:,1:num2); 
ZHDF2 = DF2*rate2(1:num2)/100;
[Stf2,Ind2] = sort(ZHDF2,'descend');
Stf2 = Stf2'
Ind2 = Ind2'


