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

ON=20; % threshold number of elements for the elimination of a cluster.
OC=0; % threshold distance for the union of clusters.
OS=0.4;  % deviation typical threshold for the division of a cluster.
k=10;   % number (maximum) cluster.
L=2;   % maximum number of clusters that can be mixed in a single iteration.
I=50;  % maximum number of iterations allowed.
NO=1;  % extra parameter to automatically answer no to the request of cambial any parameter.
min_dist=2; % Minimum distance a point must be in each center. If you want to delete any point
SSE=0;       

[C_ISO, Xcluster, len, cluster]=wfIsodata_ND(X', k, L, I, ON, OC, OS, NO, min_dist);

disp('Total Number of Clusters:');
disp(len)
for i=1:len
    class=find(cluster==i);
    points=X(:,class);
    disp(['The number of samples in cluster ',num2str(i),' is:']);
    disp(length(class));
    for j=1:length(class)
        dist=sum((points(:,j)-C_ISO(i,:)').^2); %SSE for each cluster
        SSE=SSE+dist; 
    end
end
disp(['The SSE value is ',num2str(SSE)]);


    