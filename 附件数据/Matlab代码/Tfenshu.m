%求第一问各个指标的T分数

a = [4.4724 2.3936 1.1168 -1.847 -3.061 -3.075];
junzhi = mean(a);
a = a';
biaozhuncha = std(a);
Z = (a - junzhi)./biaozhuncha;
T = 50 + 10*Z

