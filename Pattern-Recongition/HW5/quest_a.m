clear;
clc;
read_the_dataset();
X=charact;
X=[ones(1,150);X]; 

y=ones(1,150);
y(51:150)=-1;
w=[1 1 1 1 1]';
rho=0.1;
[w1,iter,mis_class,wrong_class]=perce_with_plot(X,y,w,rho);
figure('Name','Perceptron misclassifications');
plot([1:iter],wrong_class);
xlabel('Iterations');
ylabel('Misclassifications');
disp("Weights when error reaches 0");
disp(w1);
disp("Number of iterations for the batch perceptron");
disp(iter);
disp("Misclassified elements ");
disp(mis_class);
X=charact;
y = [ones(1,50) (-1)*ones(1,50) (-1)*ones(1,50)];

[l,N]=size(X);
[test_targets, a,iter] = Relaxation_BM(X,y, X, [2000 1 0.01]);
disp('Misclassified elements with batch relaxation with margin')
mis_clas=N-sum(test_targets)
disp('Number of iterations');
iter

