clc;
close all;
%% 数据预处理 
%求2009-2018年的存活数
Srv_entrprs_2019 = xlsread('Srv_entrprs_2019.xlsx'); %导入2019年各个省的存活企业数量
Cty_entrprs = xlsread('Cty_entrprs.xlsx');%导入2009-2018年主要城市存活死亡的企业数量
entrprs_Inc_2009_2018 = xlsread('entrprs_Inc_2009_2018.xlsx');%导入2009-2018年经济区企业的增量

%求东部地区2019年的企业存活数
E_entrprs_cunhuo = Srv_entrprs_2019(4,1)+Srv_entrprs_2019(5,1)+Srv_entrprs_2019(12,1)...
                +Srv_entrprs_2019(13,1)+Srv_entrprs_2019(21,1)+Srv_entrprs_2019(22,1)...
                +Srv_entrprs_2019(23,1)+Srv_entrprs_2019(27,1)+Srv_entrprs_2019(30,1)...
                +Srv_entrprs_2019(31,1);
%求东部地区的企业存活率
E_rate_cunhuo = (Cty_entrprs(1,2)+Cty_entrprs(2,2)+Cty_entrprs(3,2)+Cty_entrprs(4,2)...
           +Cty_entrprs(7,2)+Cty_entrprs(8,2)+Cty_entrprs(9,2)+Cty_entrprs(10,2)...
           +Cty_entrprs(11,2)+Cty_entrprs(12,2)+Cty_entrprs(16,2))...
         /(Cty_entrprs(1,1)+Cty_entrprs(2,1)+Cty_entrprs(3,1)+Cty_entrprs(4,1)...
           +Cty_entrprs(7,1)+Cty_entrprs(8,1)+Cty_entrprs(9,1)+Cty_entrprs(10,1)...
           +Cty_entrprs(11,1)+Cty_entrprs(12,1)+Cty_entrprs(16,1));
%求东部地区2009-2018年存活企业数  
E_chs_2009_2018 = [2018,0;
                   2017,0;
                   2016,0;
                   2015,0;
                   2014,0;
                   2013,0;
                   2012,0;
                   2011,0;
                   2010,0;
                   2009,0;];

tmp_cunhuo = E_entrprs_cunhuo;       
for i = 0:9
    E_cunhuo_Inc = E_rate_cunhuo.*entrprs_Inc_2009_2018(10-i,2);%求东部地区2009-2018年存活企业的增量
    E_chs_2009_2018(i+1,2) = tmp_cunhuo - E_cunhuo_Inc;%上一年的存活数
    tmp_cunhuo = E_chs_2009_2018(i+1,2); %这一年的存活数
end
E_chs_2009_2018 = E_chs_2009_2018' ;



    