clc,clear;

%% �����2009-2018�궫��������ָ����о������

Crltn = xlsread('DATA.xlsx','��������ָ������ϵ������');
Dst = 1 - abs(Crltn); %�������ݽ����������ϵ������ת��Ϊ����
Dst = tril(Dst); 
Nzr = nonzeros(Dst); 
Nzr = Nzr'; 
Lkg = linkage(Nzr,'complete'); 
Clas = cluster(Lkg,'maxclust',4) %�ѱ�����Ϊ����
ind1 = find(Clas == 1); ind1 = ind1' %��ʾ��һ���Ӧ�ı������
ind2 = find(Clas == 2); ind2 = ind2'
ind3 = find(Clas == 3); ind3 = ind3'
ind4 = find(Clas == 4); ind4 = ind4'
Draw = dendrogram(Lkg); %������ͼ
set(Draw,'Color','k','LineWidth',1.3) %�Ѿ���ͼ����ɫ�ĳɺ�ɫ���߿�ӿ�

