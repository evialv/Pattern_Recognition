clear; clc; 
close all
global figt4

X1 = [0 0; 0 1; 1 0; 1 1]';
y1 = [1 -1 -1 1];
l=2; % dimensionality
N=4; % number of vectors

figt4=1;

% Plot the training set X1
figure(1), plot(X1(1,y1==1),X1(2,y1==1),'r.',X1(1,y1==-1),X1(2,y1==-1),'bo')
figure(1), axis equal

kernel='poly'
kpar1=0; 
kpar2=2; 
C=4;
tol=0.001;
steps=100000;
eps=10^(-10);
method=1;
[alpha, b, w, evals, stp, glob] = SMO2(X1', y1', kernel, kpar1, kpar2, C, tol, steps, eps, method);

mag=0.1;
xaxis=1;
yaxis=2;
input = zeros(1,size(X1',2));
bias=-b;  
aspect=0;
svcplot_book(X1',y1',kernel,kpar1,kpar2,alpha,bias,aspect,mag,xaxis,yaxis,input);

figure(figt4), axis equal

X_sup=X1(:,alpha'~=0);
alpha_sup=alpha(alpha~=0)';
y_sup=y1(alpha~=0);

% Classification of the training set
for i=1:N
    t=sum((alpha_sup.*y_sup).*CalcKernel(X_sup',X1(:,i)',kernel,kpar1,kpar2)')-b;
    if(t>0)
        out_train(i)=1;
    else
        out_train(i)=-1;
    end
end

% Computing the training error
Pe_train=sum(out_train.*y1<0)/length(y1)


%Counting the number of support vectors
sup_vec=sum(alpha>0)

x1=sym('x1','real');
x2=sym('x2','real');
func=sum((alpha_sup.*y_sup).*(x1*X_sup(1,:)+x2*X_sup(2,:)).^2)-b;
f_func=simplify(func);
ff_func=vpa(f_func,10);
disp("The non linear function is:");
disp(ff_func);
