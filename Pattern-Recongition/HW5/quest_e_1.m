clear; clc;
close all

load fisheriris.mat

% Minimum Square Error - MSE
% 1-2 
y = [ones(1,150)' meas(1:150,1:3)];
b1 = [ones(1,50) (-1)*ones(1,100)]';
% a12=pinv(y'*y)*y'*b12;
a1=SSErr(y',b1',0.00001);
mis_clas=sum((a1'*(y'.*b1')<0))
a1

% 2-3 
% y = [ones(1,100)' meas(51:end,1:3)];
b2 = [(-1)*ones(1,50) ones(1,50) (-1)*ones(1,50)]';
% a23=pinv(y'*y)*y'*b23;
a2=SSErr(y',b2',0.00001);
mis_clas=sum((a2'*(y'.*b2')<0))
a2

% 1-3 
% y2 = [ones(1,150)' [meas(1:50,1:3);meas(101:end,1:3)]];
b3 = [ones(1,100) (-1)*ones(1,50)]';
% a13=pinv(y'*y)*y'*b13;
a3=SSErr(y',b3',0.00001);
mis_clas=sum((a3'*(y'.*b3')<0))
a3


train = meas(:,1:3)';
labels=[ones(1,50) 2*ones(1,50) 3*ones(1,50)];
% 1. Plot X1, where points of different classes are denoted by different colors,
figure;
plot3(train(1,labels==1),train(2,labels==1),train(3,labels==1),'bo',...
train(1,labels==2),train(2,labels==2),train(3,labels==2),'ro',...
train(1,labels==3),train(2,labels==3),train(3,labels==3),'go')
 axis(axis);

figure;
plot3(train(1,labels==1),train(2,labels==1),train(3,labels==1),'bo',...
train(1,labels==2),train(2,labels==2),train(3,labels==2),'ro',...
train(1,labels==3),train(2,labels==3),train(3,labels==3),'go')
hold on; axis(axis);
y=[ones(1,150) ;train];

[x1,x2] = meshgrid(0:.5:8);
x3=(-a1(1)-a1(2)*x1-a1(3)*x2)/a1(4);
surf(x1,x2,x3,'FaceColor','b'); 
x3=(-a3(1)-a3(2)*x1-a3(3)*x2)/a3(4);
surf(x1,x2,x3,'FaceColor','g'); 
x3=(-a2(1)-a2(2)*x1-a2(3)*x2)/a2(4);
surf(x1,x2,x3,'FaceColor','r');  hold off
