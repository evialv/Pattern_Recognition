clear;
clc;
read_the_dataset();

X=charact;
X=[X;ones(1,150)]; 
y=(-1)*ones(1,150);
y(51:100)=1;
[M,N]=size(X);
C=0.0001;

a=inv(X*X'+C*eye(M))*(X*y');

mis_clas=sum(((a'*X).*y)<0);
disp('LS error');
disp(mis_clas);
disp('LMS');
Xtrain=[X(:,1:45) X(:,51:95) X(:,101:145)];
Xtest=[X(:,46:50) X(:,96:100) X(:,146:150)];
y=zeros(1,135);
y(46:135)=1;
[test_targets, a, updates]=LMS_cc(Xtrain(2:5,:),y',Xtest(2:5,:),10000,0.01,0.001);
disp(a);
cla=(150-sum(test_targets))/150;
disp('Correctly classified samples');
disp(cla);



