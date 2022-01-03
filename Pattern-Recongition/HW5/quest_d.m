clear;
clc;
read_the_dataset();
X=charact;
X=[ones(1,150);X]; 
y = [ones(1,50) ones(1,50).*(2) ones(1,50).*(3)];
figure(1), plot3(X(1,y==1),X(2,y==1),X(3,y==1),'r.',...
    X(1,y==2),X(2,y==2),X(3,y==2),'g.',...
    X(1,y==3),X(2,y==3),X(3,y==3),'b.')
axis equal; hold on; axis(axis); XA=axis;

y1=ones(1,150);
y2=ones(1,150);
y3=ones(1,150);
y1(51:150)=-1;
y2([1:50,101:150])=-1;
y3(1:100)=-1;
C=0.01;
[M,N]=size(X);
a1=inv(X*X'+C*eye(M))*(X*y1');

mis_clas1=sum(((a1'*X).*y1)<0);
disp('LS wrong classification for 1st class');
disp(mis_clas1);
a2=inv(X*X'+C*eye(M))*(X*y2');

mis_clas2=sum(((a2'*X).*y2)<0);
disp('LS wrong classification for 2nd class');
disp(mis_clas2);

a3=inv(X*X'+C*eye(M))*(X*y3');
mis_clas3=sum(((a3'*X).*y3)<0);
disp('LS wrong classification for 3rd class');
disp(mis_clas3);
[max,class_est]=max([a1'*X;a2'*X;a3'*X]);
correct_sse_class=sum(class_est==y)/150;
disp('Total Error');
disp(correct_sse_class);

