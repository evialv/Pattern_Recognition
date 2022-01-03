clear;clc;
N=1000;

%3a

dice_throws=zeros(6,6);
x=ceil(6*rand(N,1));
y=ceil(6*rand(N,1));

for i=1:N
   dice_throws(x(i),y(i))=dice_throws(x(i),y(i))+1; 
end
prob_throws=dice_throws/N;
disp(prob_throws);
figure
bar(prob_throws,'hist');

%3b
x=ceil(6*rand(N,1));
y=ceil(6*rand(N,1));
dice_throws=zeros(1,12);
for i=1:N
    sum=x(i)+y(i);
   dice_throws(sum)=dice_throws(sum)+1; 
end
prob_throws=dice_throws/N;
disp(prob_throws);
figure
bar(prob_throws,'hist');

format long

%4b gradient descent
lr=0.02;
x=0;
reps=1;
new_x=x-lr*(4*(x-5)^3+3);
disp(abs(new_x-x));
while (abs(new_x-x)>(10^(-6)))
    x=new_x;
    new_x=x-lr*(4*(x-5)^3+3);
    disp(new_x);
    reps=reps+1;
end
disp(new_x);
disp(reps);


%4c

x=0;
reps=1;
new_x=x-1/(((x-5)^2)*12)*(4*(x-5)^3+3);
disp(abs(new_x-x));
while (abs(new_x-x)>(10^(-6)))
    x=new_x;
    new_x=x-1/(((x-5)^2)*12)*(4*(x-5)^3+3);
    disp(new_x);
    reps=reps+1;
end
disp(new_x);
disp(reps);
%}
