clear; clc;
close all

load fisheriris.mat

X = meas';
[l,N1]=size(X);
X1=[X; ones(1,N1)];
y1=[ones(1,50) 2*ones(1,50) 3*ones(1,50)];
%--------- Multi class perceptron with Kesler structure -----------
data.X=X;  data.y=y1; %iputs data in format for STPRtool
options.tmax=1000; % max number of iterations
modelKESLER = mperceptron( data, options );
% figure; ppatterns( data ); pboundary( modelKESLER );
% calculates the error on the trainning set
for i=1:l
    w_allKESLER(i,:)=modelKESLER.W(i,:);
end
w_allKESLER(l+1,:)=modelKESLER.b';
[vali,class_est]=max(w_allKESLER'*X1);
errKESLER=sum(class_est~=y1)/N1
mis_clas=sum(class_est~=y1)
disp(w_allKESLER);