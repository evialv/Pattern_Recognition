clc;
clear;
m1=[0 0 0]';
m2=[1 2 2]';
m3=[3 3 4]';
m=[m1 m2 m3];
p1=1/3;
p2=1/3;
p3=1/3;
randn('seed',1);
s=[0.8 0.2 0.1; 0.2 0.8 0.2;0.1 0.2 0.8];
ler1=mvnrnd(m1,s,3334);
ler2=mvnrnd(m2,s,3333);
ler3=mvnrnd(m3,s,3333);
X=[ler1;ler2;ler3]';
randn('seed',2);
t1=mvnrnd(m1,s,334);
t2=mvnrnd(m2,s,333);
t3=mvnrnd(m3,s,333);

X1=[t1;t2;t3]';


