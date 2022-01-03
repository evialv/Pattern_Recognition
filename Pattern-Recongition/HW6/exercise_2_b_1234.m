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
train = [charact(1:30,:);charact(51:80,:);charact(101:130,:)];
% Validation Set
valid = [charact(31:40,:);charact(81:90,:);charact(131:140,:)];
% Test Set
test = [charact(41:50,:);charact(91:100,:);charact(141:150,:)];
y_train = [ones(1,30) (-1)*ones(1,30) ones(1,30)];

y_valid = [ones(1,10) (-1)*ones(1,10) ones(1,10)];
y_test = [ones(1,10) (-1)*ones(1,10) ones(1,10)];
SVMModel = fitcsvm(train,y_train,'Standardize',false,'OptimizeHyperparameters',{'BoxConstraint','KernelScale','KernelFunction','PolynomialOrder'});
classOrder = SVMModel.ClassNames;
sv = SVMModel.SupportVectors;
Train_Error       = loss(SVMModel,train,y_train)
Validation_Error  = loss(SVMModel,valid,y_valid)
Test_Error        = loss(SVMModel,test,y_test)