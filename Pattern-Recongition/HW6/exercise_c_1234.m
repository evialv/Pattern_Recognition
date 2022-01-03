clear;
clc;
close all;
data = readtable('iris.txt');

x1 = table2array(data(:,1));
x2 = table2array(data(:,2));
x3 = table2array(data(:,3));
x4 = table2array(data(:,4));
charact=([x1 x2 x3 x4]);

% Training Set
train = [charact(21:50,:);charact(51:80,:);charact(101:130,:)];
% Validation Set
valid = [charact(1:10,:);charact(91:100,:);charact(141:150,:)];
% Test Set
test = [charact(11:20,:);charact(81:90,:);charact(131:140,:)];
train_Scores=zeros(90,3);
val_Scores=zeros(30,3);
test_Scores=zeros(30,3);
N=90; 
kernel='linear'
kpar1=0; 
kpar2=2; 
C=15;
tol=0.001;
steps=100000;
eps=10^(-10);
method=1;
%124 linear 1rst one vs all
y_train = [ones(1,30) (-1)*ones(1,30) (-1)*ones(1,30)];

y_valid = [ones(1,10) (-1)*ones(1,10) (-1)*ones(1,10)];
y_test = [ones(1,10) (-1)*ones(1,10) (-1)*ones(1,10)];
SVMModel_1 = fitcsvm(train,y_train,'Standardize',false,'KernelFunction',kernel);
%training score
[~,score1]=predict(SVMModel_1,train);
train_Scores(:,1)=score1(:,2);
%validation score
[~,val_score1]=predict(SVMModel_1,valid);
val_Scores(:,1)=val_score1(:,2);
%test score
[~,test_score1]=predict(SVMModel_1,test);
test_Scores(:,1)=test_score1(:,2);

%124 linear 2nd class one vs all
y_train = [(-1)*ones(1,30) ones(1,30) (-1)*ones(1,30)];

y_valid = [(-1)*ones(1,10) ones(1,10) (-1)*ones(1,10)];
y_test = [(-1)*ones(1,10)  ones(1,10) (-1)*ones(1,10)];
SVMModel_2 = fitcsvm(train,y_train,'Standardize',false,'KernelFunction',kernel);
%train score
[~,score2]=predict(SVMModel_2,train);
train_Scores(:,2)=score2(:,2);% Second column contains positive-class scores
%validation score
[~,val_score2]=predict(SVMModel_2,valid);
val_Scores(:,2)=val_score2(:,2);
%test score
[~,test_score2]=predict(SVMModel_2,test);
test_Scores(:,2)=test_score2(:,2);

%124 linear 3rd class one vs all
y_train = [(-1)*ones(1,30) (-1)*ones(1,30) ones(1,30)];

y_valid = [(-1)*ones(1,10) (-1)*ones(1,10) ones(1,10)];
y_test = [(-1)*ones(1,10)  (-1)*ones(1,10) ones(1,10)];
SVMModel_3 = fitcsvm(train,y_train,'Standardize',false,'KernelFunction',kernel);
%train scores
[~,score3]=predict(SVMModel_3,train);
train_Scores(:,3)=score3(:,2);% Second column contains positive-class scores
%validation score
[~,val_score3]=predict(SVMModel_3,valid);
val_Scores(:,3)=val_score3(:,2);
%test score
[~,test_score3]=predict(SVMModel_3,test);
test_Scores(:,3)=test_score3(:,2);

%find the maximum probability and assign each sample to its maximum
%probability for all the sets
[~,train_maxScore]=max(train_Scores,[],2);
[~,val_maxScore]=max(val_Scores,[],2);
[~,test_maxScore]=max(test_Scores,[],2);
%assign true labels 1 2 3 for each class 
y_train = [ones(1,30) (2)*ones(1,30) 3*ones(1,30)];
y_valid = [ones(1,10) 2*ones(1,10) 3*ones(1,10)];
y_test = [ones(1,10) 2*ones(1,10) 3*ones(1,10)];

tr_error =sum((train_maxScore'~=y_train))/length(y_train);
disp("The error for all the characteristics with the one versus all method for the training set is:");
disp(tr_error);
val_error =sum((test_maxScore'~=y_valid))/length(y_valid);
disp("The error for all the characteristics with the one versus all method for the validation set is:");
disp(val_error);
test_error =sum((test_maxScore'~=y_test))/length(y_test);
disp("The error for all the characteristics  with the one versus all method for the test set is:");
disp(test_error);