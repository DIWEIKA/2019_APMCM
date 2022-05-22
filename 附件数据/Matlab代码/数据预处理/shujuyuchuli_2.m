clc;
close all;
%% ����Ԥ���� 
%��2009-2018��Ĵ����
Srv_entrprs_2019 = xlsread('Srv_entrprs_2019.xlsx'); %����2019�����ʡ�Ĵ����ҵ����
Cty_entrprs = xlsread('Cty_entrprs.xlsx');%����2009-2018����Ҫ���д����������ҵ����
entrprs_Inc_2009_2018 = xlsread('entrprs_Inc_2009_2018.xlsx');%����2009-2018�꾭������ҵ������

%�󶫲�����2019�����ҵ�����
E_entrprs_cunhuo = Srv_entrprs_2019(4,1)+Srv_entrprs_2019(5,1)+Srv_entrprs_2019(12,1)...
                +Srv_entrprs_2019(13,1)+Srv_entrprs_2019(21,1)+Srv_entrprs_2019(22,1)...
                +Srv_entrprs_2019(23,1)+Srv_entrprs_2019(27,1)+Srv_entrprs_2019(30,1)...
                +Srv_entrprs_2019(31,1);
%�󶫲���������ҵ�����
E_rate_cunhuo = (Cty_entrprs(1,2)+Cty_entrprs(2,2)+Cty_entrprs(3,2)+Cty_entrprs(4,2)...
           +Cty_entrprs(7,2)+Cty_entrprs(8,2)+Cty_entrprs(9,2)+Cty_entrprs(10,2)...
           +Cty_entrprs(11,2)+Cty_entrprs(12,2)+Cty_entrprs(16,2))...
         /(Cty_entrprs(1,1)+Cty_entrprs(2,1)+Cty_entrprs(3,1)+Cty_entrprs(4,1)...
           +Cty_entrprs(7,1)+Cty_entrprs(8,1)+Cty_entrprs(9,1)+Cty_entrprs(10,1)...
           +Cty_entrprs(11,1)+Cty_entrprs(12,1)+Cty_entrprs(16,1));
%�󶫲�����2009-2018������ҵ��  
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
    E_cunhuo_Inc = E_rate_cunhuo.*entrprs_Inc_2009_2018(10-i,2);%�󶫲�����2009-2018������ҵ������
    E_chs_2009_2018(i+1,2) = tmp_cunhuo - E_cunhuo_Inc;%��һ��Ĵ����
    tmp_cunhuo = E_chs_2009_2018(i+1,2); %��һ��Ĵ����
end
E_chs_2009_2018 = E_chs_2009_2018' ;



    