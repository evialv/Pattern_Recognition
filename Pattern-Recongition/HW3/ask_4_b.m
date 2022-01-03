
m1=[0 0 0]';
m2=[1 2 2]';
m3=[3 3 4]';
m=[m1 m2 m3];
p1=1/3;
p2=1/3;
p3=1/3;
randn('seed',0);
s=[0.8 0.2 0.1; 0.2 0.8 0.2;0.1 0.2 0.8];
ler1=mvnrnd(m1,s,3334);
ler2=mvnrnd(m2,s,3333);
ler3=mvnrnd(m3,s,3333);
X=[ler1;ler2;ler3]';
randn('seed',2);
t1=mvnrnd(m1,s,334);
t2=mvnrnd(m2,s,333);
t3=mvnrnd(m3,s,333);

X1=[t1;t2;t3]';
%-----------------b mahalanobis----------(selected)
[l,c]=size(m);
[l,N]=size(X1);
for i=1:N
    for j=1:c
        dm(j)=sqrt((X1(:,i)-m(:,j))'*s^-1*(X1(:,i)-m(:,j)));
    end
    [num,z(i)]=min(dm);
    
end

w1=(length(find(z(1:334)==1)));
w2=(length(find(z(335:667)==2)));
w3=(length(find(z(668:1000)==3)));
error=1-(w1+w2+w3)/1000;
disp("The Mahalanobis error is:");
disp(error);


%b -----------------euclidean----------------------
for i=1:N
    for j=1:c
        dm1(j)=sqrt((X1(:,i)-m(:,j))'*(X1(:,i)-m(:,j)));
    end
    [num,z(i)]=min(dm1);
    
end
w1=(length(find(z(1:334)==1)));
w2=(length(find(z(335:667)==2)));
w3=(length(find(z(668:1000)==3)));
error_euc_b=1-(w1+w2+w3)/1000;
disp("Euclidean Error");
disp(error_euc_b);

%-------------------------b bayesian------------------------
[l,c]=size(m);
[l,N]=size(X1);
lik=@(x,m,s,d) exp(-0.5*(x-m)'*inv(s)*(x-m))/(((2*pi)^(d/2))*det(s)^(0.5));
z=zeros(1,length(X1));
for i=1:N
    dm2=[p1*lik(X1(:,i),m1,s,3) p2*lik(X1(:,i),m2,s,3) p3*lik(X1(:,i),m3,s,3)];
    z(i)=find(dm2==max(dm2));    
end
w1=(length(find(z(1:334)==1)));
w2=(length(find(z(335:667)==2)));
w3=(length(find(z(668:1000)==3)));
error_b_bayes=1-(w1+w2+w3)/1000;
disp("The Bayes error is:");
disp(error_b_bayes);
