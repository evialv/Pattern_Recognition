clc;
clear;
close all
% 2.a
P = [0.5 0.3 0.2]';
m = [2 1 3];
Sigma(:,:,1) = 0.5;
Sigma(:,:,2) = 1;
Sigma(:,:,3) = 1.2;
randn('seed',1);
[X_train,train_label] = generate_gauss_classes(m,Sigma,P,100);
randn('seed',2);
[X_test,test_label] = generate_gauss_classes(m,Sigma,P,1000);
% 2.b
disp("2.b");
for k=1:3
    X_knn{k} = k_nn_classifier(X_train,train_label,k,X_test);
    error_knn(k) = sum(X_knn{k}~=test_label)/length(test_label);
    disp([' The error is ',num2str(error_knn(k)),' for k = ',num2str(k)]);
end
X_knn_bayesian = bayes_classifier(m,Sigma,P,X_test);
error_bayesian = sum(X_knn_bayesian~=test_label)/length(test_label);
disp(['Ôhe error with the Bayesian classifier is = ',num2str(error_bayesian)]);

%2.b optional
disp("2.b Optional");
x_train_n=[X_train(1:40) X_train(51:74) X_train(81:96)];
train_label_n=[train_label(1:40) train_label(51:74) train_label(81:96)];

x_val_n=[X_train(41:50) X_train(75:80) X_train(97:100)];
val_label=[train_label(41:50) train_label(75:80) train_label(97:100)];

for k=1:60
    label_knn{k} = k_nn_classifier(x_train_n,train_label_n,k,x_val_n);
    pr_err_knn(k) = sum(label_knn{k}~=val_label)/length(val_label);
end
[min_error, min_error_k] = min(pr_err_knn);
figure('name','4.2 B optional)');
plot(pr_err_knn);
title('Error with several k');
xlabel('k');
ylabel('error');
disp(['minimum error of the validation set is: ',num2str(min_error),' with k = ',num2str(min_error_k)]);

%2.c
disp("2.c")
h = [0.01 0.03 0.05 0.1 0.6 1 ];
for j=1:length(h)
    px1=0.5*Parzen_gauss_kernel(X_train(1:50),h(j),-4,10);
    px2=0.3*Parzen_gauss_kernel(X_train(51:80),h(j),-4,10);
    px3=0.2*Parzen_gauss_kernel(X_train(81:100),h(j),-4,10);
    [num,z]=max([ px1; px2; px3]);
    psi=ceil((X_test+4)/h(j));
    answer=z(psi);
    
    err_windows(j)=sum(answer~=test_label)/length(test_label);
   
    disp(['The error with Parzen Windows is : ',num2str(err_windows(j)),' with a value of h = ',num2str(h(j))]);
end

figure('name','4.2 c)');
plot(h,err_windows);
title('Error with several h');
xlabel('h');
ylabel('error');

%2c optional
h1=0.001:0.01:2;
disp("2c Optional");
for j=1:length(h1)
    px1=0.5*Parzen_gauss_kernel(X_train(1:40),h1(j),-4,10);
    px2=0.3*Parzen_gauss_kernel(X_train(51:74),h1(j),-4,10);
    px3=0.2*Parzen_gauss_kernel(X_train(81:96),h1(j),-4,10);
    
 for i=1:length(x_val_n)
        % find which likelihood value corresponds to each test sample 
        index = ceil((x_val_n(i)+4)/h1(j));
        % classify
        [value, maxi]=max([px1(index) px2(index) px3(index)]);
        class_parzen(1,i)=maxi;
    end
    % error calculation
    error_parzen(1,j)=1-(length(find(class_parzen(1,:)==val_label))/length(val_label));
end
[value, min] = min(error_parzen);
disp(['Minimum error value of validation set is ',num2str(value),' for h=',num2str(h1(min))]);
figure; plot(h1,error_parzen);

%2.d
disp("2d");
net=parzenPNNlearn(X_train,train_label);
for j=1:length(h)
    [class,score,scores]=parzenPNNclassify(net,X_test,h(j));
    err_ParzenPNN=sum(class~=test_label)/length(test_label);
    
    disp(['The error for PNN classifier with Parzen Windows is : ',num2str(err_ParzenPNN),' with a value of h = ',num2str(h(j))]);
end



