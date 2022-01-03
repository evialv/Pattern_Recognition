clc;

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
randn('seed',4);
t1=mvnrnd(m1,s,334);
t2=mvnrnd(m2,s,333);
t3=mvnrnd(m3,s,333);

X1=[t1;t2;t3]';

%------------------ c Mahalanobis ----------
[l,c]=size(m);
[l,N]=size(X1);
x1=X(:,1:3334);
x2=X(:,3335:6667);
x3=X(:,6668:10000);
m_hat1=(1/length(x1)).*sum(x1,2);
m_hat2=(1/length(x2)).*sum(x2,2);
m_hat3=(1/length(x3)).*sum(x3,2);
S1=0;S2=0;S3=0;
for k=1:length(x2)
    S1=S1 + (x1(:,k)-m_hat1)*(x1(:,k)-m_hat1)';
    S2=S2 + (x2(:,k)-m_hat2)*(x2(:,k)-m_hat2)';
    S3=S3 + (x3(:,k)-m_hat3)*(x3(:,k)-m_hat3)';
end
S1=S1+(x1(:,length(x1))-m_hat1)*(x1(:,length(x1))-m_hat1)';
S_hat=(1/3)*((1/length(x1))*S1+(1/length(x2))*S2+(1/length(x3))*S3)';
%κατηγοριοποίηση των test
m=[m_hat1 m_hat2 m_hat3];
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
error2=1-(w1+w2+w3)/1000;
disp("The Mahalanobis error is:");
disp(error2);

%---------------------c euclidean----------------------

for i=1:N
    for j=1:c
        dm3(j)=sqrt((X1(:,i)-m(:,j))'*(X1(:,i)-m(:,j)));
    end
    [num,z(i)]=min(dm3);
    
end
w1=(length(find(z(1:334)==1)));
w2=(length(find(z(335:667)==2)));
w3=(length(find(z(668:1000)==3)));
error3=1-(w1+w2+w3)/1000;
disp("Euclidean Error");
disp(error3);

%------------------- c bayesian-----------------------

z=zeros(1,length(X1));
lik=@(x,m,s,d) exp(-0.5*(x-m)'*inv(s)*(x-m))/(((2*pi)^(d/2))*det(s)^(0.5));

for i=1:N
    dm5=[p1*lik(X1(:,i),m_hat1,S_hat,3) p2*lik(X1(:,i),m_hat2,S_hat,3) p3*lik(X1(:,i),m_hat3,S_hat,3)];
    z(i)=find(dm5==max(dm5));    
end
w1=(length(find(z(1:334)==1)));
w2=(length(find(z(335:667)==2)));
w3=(length(find(z(668:1000)==3)));
error_c_bay=1-(w1+w2+w3)/1000;
disp("Bayesian Error");
disp(error_c_bay);