clear;clc;
close all

data = readtable('iris.txt');
data.Properties.VariableNames{1} = 'sepal_length';
data.Properties.VariableNames{2} = 'sepal_width';
data.Properties.VariableNames{3} = 'petal_length';
data.Properties.VariableNames{4} = 'petal_width';
data.Properties.VariableNames{5} = 'species';

x1 = table2array(data(:,1));
x2 = table2array(data(:,2));
x3 = table2array(data(:,3));
x4 = table2array(data(:,4));

X     = [x1 x2 x3 x4]';
y     = [ones(1,50) ones(1,50).*2 ones(1,50).*3];
 
k=3; 
l=4;

m=3; % number of clusters
q=9; % fuzzifier
[theta,U,obj_fun]=fuzzy_c_means(X,m,q);
% choose the class with max grade of membership for each sample
[grade,class]=max(U'); 
disp('The number of samples in cluster 1 is:');
disp(sum(class==1));
disp('The number of samples in cluster 2 is:');
disp(sum(class==2));
disp('The number of samples in cluster 3 is:');
disp(sum(class==3)); 

figure; 
plot3(theta(1,:),theta(2,:),theta(3,:), 'ko', 'MarkerFaceColor','k');
hold on
plot3(X(1,1:50),X(2,1:50),X(3,1:50),'ro',...
X(1,51:100),X(2,51:100),X(3,51:100),'bo',...
X(1,101:150),X(2,101:150),X(3,101:150),'go')
title('Plot for correct classification using features 1, 2 & 3');
axis(axis); grid on
hold off  
first=find(class==1);
points1=X(:,first); 
second=find(class==2);
points2=X(:,second); 
third=find(class==3);
points3=X(:,third);    

figure; 
plot3(theta(1,:),theta(2,:),theta(3,:), 'ko', 'MarkerFaceColor','k');
hold on  
plot3(points1(1,:),points1(2,:),points1(3,:),'ro',...
points2(1,:),points2(2,:),points2(3,:),'bo',...
points3(1,:),points3(2,:),points3(3,:),'go')
title('Fuzzy c-means clusters for features 1, 2 & 3');
axis(axis); grid on
hold off
