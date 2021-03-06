w1=zeros(10,3);
w2=zeros(10,3);
w3=zeros(10,3);
w1(:,1)=[-5.01; -5.43; 1.08; 0.86; -2.67; 4.94; -2.51; -2.25; 5.56; 1.03;];
w1(:,2)=[-8.12 -3.48 -5.52 -3.78 0.63 3.29 2.09 -2.13 2.86 -3.33];
w1(:,3)=[-3.68 -3.54 1.66 -4.11 7.39 2.08 -2.59 -6.94 -2.26 4.33];
w2(:,1)=[-0.91 1.30 -7.75 -5.47 6.14 3.6 5.37 7.18 -7.39 -7.50];
w2(:,2)=[-0.18 -2.06 -4.54 0.5 5.72 1.26 -4.63 1.46 1.17 -6.32];
w2(:,3)=[-0.05 -3.53 -0.95 3.92 -4.85 4.36 -3.65 -6.66 6.30 -0.31];
w3(:,1)=[5.35 5.12 -1.34 4.48 7.11 7.17 5.75 0.77 0.9 3.52];
w3(:,2)=[2.26 3.22 -5.31 3.42 2.39 4.33 3.97 0.27 -0.43 -0.36];
w3(:,3)=[8.13 -2.66 -9.87 5.19 9.21 -0.98 6.65 2.41 -8.71 6.43];
n=10;
P1=0.5;
P2=0.5;
mean_w1=[sum(w1(:,1))/n; sum(w1(:,2))/n;sum(w1(:,3))/n];
mean_w2=[sum(w2(:,1))/n; sum(w2(:,2))/n;sum(w2(:,3))/n];
Sw1=[sum(power(w1(:,1)- mean_w1(1),2))/n 0 0;0 sum(power(w1(:,2)-mean_w1(2),2))/n 0;0 0 sum(power(w1(:,3)-mean_w1(3),2))/n];
Sw2=[sum(power(w2(:,1)- mean_w2(1),2))/n 0 0;0 sum(power(w2(:,2)-mean_w2(2),2))/n 0; 0 0 sum(power(w2(:,3)-mean_w2(3),2))/n];

len=length(mean_w1);
x = sym('x',[len 1]);

g1=g_calculation(mean_w1,Sw1,P1,x);
g2=g_calculation(mean_w2,Sw2,P2,x);
dec=g1-g2;
D=matlabFunction(dec);
dec=vpa(D);
dec=simplify(dec);
disp(dec);
ew1=0;
ew2=0;
for i=1:10
    if (D(w1(i,1),w1(i,2),w1(i,3))<0)
        ew1=ew1+1;
    end
    if (D(w2(i,1),w2(i,2),w2(i,3))>0)
        ew2=ew2+1;
    end
end
ew1=ew1/10;
ew2=ew2/10;

