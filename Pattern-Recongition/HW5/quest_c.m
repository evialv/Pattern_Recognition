clear;
clc;
read_the_dataset();
X=charact(:,1:150);
X=[ones(1,150);X]; 
y=ones(1,150);
y(51:100)=-1;
C=0.01;
[M,N]=size(X);
a=inv(X*X'+C*eye(M))*(X*y');

mis_clas=sum(((a'*X).*y)<0);
disp('LS misclassifications');
disp(mis_clas);

[a,b]=Ho_Kashyap_cc(X,y, 0, 100,10,0.1);
mis_clas=sum(((a'*X).*y)<0);
disp('Kashyap misclassifications');
disp(mis_clas);
