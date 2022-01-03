%1.a
clc;
close all;
clear;
m = 0;
S = 1;
P = 1/2;
N = [32 256 5000];
for i=1:3
    X{i}=2*rand(1,N(i));
end
h = [0.05 0.2];
figure('name','1.a)');

for i = 1:3
    subplot(2,3,i);
    hold on;
    pdfx_approx = Parzen_gauss_kernel(X{i},h(1),-1,3);
    plot(-1:h(1):3,pdfx_approx);
    title(['N = ',num2str(N(i)),' , h = ',num2str(h(1))]);
    hold off;
    
    subplot(2,3,i+3);
    hold on;
    pdfx_approx = Parzen_gauss_kernel(X{i},h(2),-1,3);
    plot(-1:h(2):3,pdfx_approx);
    title(['N = ',num2str(N(i)),' , h = ',num2str(h(2))]);
    hold off;
    
end
%1.b
k = [32 64 256];

figure('name','1.b)');
for i = 1:3
    subplot(3,1,i);
    hold on;
    pdfx_approx_b = knn_density_estimate(X{3},k(i),-1,3,0.1);
    plot(-1:0.1:3,pdfx_approx_b);
    title(['N = ',num2str(N(3)),' , k = ',num2str(k(i))]);
    hold off;
end