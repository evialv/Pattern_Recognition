
m1=2;
d=1.5;
sum=2;
syms x;
g=-(1/2)*(transpose(x-m1))*(inv(sum(x-m1)))-(d/2)*log(2*pi)-(1/2)log(sum
%probabilities of a point belonging to the class w1 and w2 respectively
p1=1/3;
p2=2/3;
%calculating the sum of points classified in the N(2,0.5) distribution but
%belong in the  N(1.5,0.2) distribution and vice versa
sum1=0;
sum2=0;
for(i=1:500)
    sum1=sum1+(dist1(i,1)<0.4039 || dist1(i,1)>1.9260);
    sum2=sum2+(dist2(i,1)>=0.4039 && dist2(i,1)<=1.9260);
end
disp(sum1);
disp(sum2);
%inserting the L array parameters
L11=1;
L12=2;
L21=3;
L22=1;
%calculating the total cost by dividing the sum(which is the total points
%misclassified in each class )by 500(which is the total points in each
%class)
total_cost=((sum1/500)*L11+((500-sum1)/500)*L21)*p1+((sum2/500)*L22+((500-sum2)/500)*L12)*p2;
disp(total_cost);
