clear; clc;
close all;
%2a
N=20;
dice_throws=ceil(6*rand(1,N));
disp(dice_throws);
format long;
%2b version 1
%{
  %manually (VERSION 1)

rep_N=[20,100,1000];
for i=1:length(rep_N)
    dice_throws=ceil(6*rand(1,rep_N(i)));
    figure
    h1=histogram(dice_throws);
    yt=get(gca,'YTick');
    set(gca,'YTick',yt,'YTickLabel',yt/N);
    values1=h1.Values;
    values1=values1./N;
    disp(values1)
end
%}
%2b version 2
%or with the help of the build in function
rep_N=[20,100,1000];
disp("Οι pdf τιμες για Ν=20, Ν=100, Ν=1000 για καθε τιμή ζαριού είναι:");
for i=1:length(rep_N)
    dice_throws=ceil(6*rand(1,rep_N(i)));
    figure('Name',sprintf('For %.0f bars', i),'NumberTitle','off');
    hold on;
    
    h = histogram(dice_throws,'Normalization','pdf'); 
    values=h.Values;
    
    figure('Name',sprintf('For %.0f stem', i),'NumberTitle','off');
    h2 = stem(1:6,h.Values); 
    values=h.Values;
    
    disp(values)
end

%2c
rep_times=[10, 20, 50, 100, 500,1000];
all_values=zeros(length(rep_times),4);
disp("O πίνακας με τα mean, var, skewness και kurtosis ειναι ο εξης:");
for k=1:length(rep_times)
        dice_throws=ceil(6*rand(1,rep_times(k)));
        all_values(k,1)=mean(dice_throws);
        all_values(k,2)=var(dice_throws);
        all_values(k,3)= skewness(dice_throws);
        all_values(k,4)=kurtosis(dice_throws);
end
 
%2e
rep_times2=[10, 20,50, 100, 500,1000];
mean_values=zeros(4,length(rep_times2));
var_values=zeros(4,length(rep_times2));
skewness_values=zeros(4,length(rep_times2));
kurtosis_values=zeros(4,length(rep_times2));

for j=1:4
    
    for k=1:length(rep_times2)
        dice_throws=ceil(6*rand(1,rep_times2(k)));
        mean_values(j,k)=mean(dice_throws);
        var_values(j,k)=var(dice_throws);
        skewness_values(j,k)= skewness(dice_throws);
        kurtosis_values(j,k)=kurtosis(dice_throws);
    end
end
disp("O πίνακας με τα mean(γραμμες οι επαναλήψεις με τα ιδια Ν στήλες τα διαφορετικα Ν)");
disp(mean_values);
disp("O πίνακας με τα var(γραμμες οι επαναλήψεις με τα ιδια Ν στήλες τα διαφορετικα Ν)");
disp(var_values);
disp("O πίνακας με τα skewness(γραμμες οι επαναλήψεις με τα ιδια Ν στήλες τα διαφορετικα Ν)");
disp(skewness_values);
disp("O πίνακας με τα kurtosis(γραμμες οι επαναλήψεις με τα ιδια Ν στήλες τα διαφορετικα Ν)");
disp(kurtosis_values);

figure('Name','Mean value in 4 repetitions plot','NumberTitle','off');
hold on;
plot(rep_times2,[3.5 3.5 3.5 3.5 3.5 3.5]);
plot(rep_times2, mean_values); 
legend({'Theoritical Mean','1st run','2nd run','3rd run','4th run',},'Location','southeast');
title('Mean value in 4 repetitions');
xlabel('Number of dice throws');
ylabel('Mean value measured');
hold off;

figure('Name','Variance in 4 repetitions plot','NumberTitle','off');
hold on;
plot(rep_times2,[2.916666667 2.916666667 2.916666667 2.916666667 2.916666667 2.916666667]);
plot(rep_times2, var_values); 
legend({'Theoritical Variance','1st run','2nd run','3rd run','4th run',},'Location','southeast');
title('Variance value in 4 repetitions');
xlabel('Number of dice throws');
ylabel('Variance measured');
hold off;

figure('Name','Skewness in 4 repetitions plot','NumberTitle','off');
hold on;
plot(rep_times2,[0 0 0 0 0 0]);
plot(rep_times2, skewness_values); 
legend({'Theoritical Skewness','1st run','2nd run','3rd run','4th run',},'Location','southeast');
title('Skewness value in 4 repetitions');
xlabel('Number of dice throws');
ylabel('Skewness measured');
hold off;

figure('Name','kurtosis in 4 repetitions plot','NumberTitle','off');
hold on;
plot(rep_times2,[1.73142898 1.73142898 1.73142898 1.73142898 1.73142898 1.73142898]);
plot(rep_times2, kurtosis_values); 
legend({'Theoritical kurtosis','1st run','2nd run','3rd run','4th run',},'Location','northeast');
title('kurtosis value in 4 repetitions');
xlabel('Number of dice throws');
ylabel('kurtosis measured');
hold off;

