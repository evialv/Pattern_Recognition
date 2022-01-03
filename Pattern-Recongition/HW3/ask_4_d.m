clc;
p1=1/6;
p2=1/6;
p3=2/3;
p=[1/6 1/6 2/3];
m1=[0 0 0]';
m2=[1 2 2]';
m3=[3 3 4]';
m=[m1 m2 m3];
randn('seed',0);
s(:,:,1)=[0.8 0.2 0.1; 0.2 0.8 0.2;0.1 0.2 0.8];
s(:,:,2)=[0.6 0.2 0.01; 0.2 0.8 0.01; 0.01 0.01 0.6];
s(:,:,3)=[0.6 0.1 0.1; 0.1 0.6 0.1; 0.1 0.1 0.6];
ler1=mvnrnd(m1,s(:,:,1),ceil(p1*10000));
ler2=mvnrnd(m2,s(:,:,2),ceil(p2*10000));
ler3=mvnrnd(m3,s(:,:,3),floor(p3*10000));
X=[ler1;ler2;ler3]';
randn('seed',2);
t1=mvnrnd(m1,s(:,:,1),ceil(p1*1000));
t2=mvnrnd(m2,s(:,:,2),ceil(p2*1000));
t3=mvnrnd(m3,s(:,:,3),floor(p3*1000));
X1=[t1;t2;t3]';
%bayesian
[l,c]=size(m);
[l,N]=size(X1);
lik=@(x,m,s,d) exp(-0.5*(x-m)'*inv(s)*(x-m))/(((2*pi)^(d/2))*det(s)^(0.5));
z=zeros(1,length(X1));
for i=1:N
    dm=[p1*lik(X1(:,i),m1,s(:,:,1),3) p2*lik(X1(:,i),m2,s(:,:,2),3) p3*lik(X1(:,i),m3,s(:,:,3),3)];
    z(i)=find(dm==max(dm));    
end
w1=(length(find(z(1:167)==1)));
w2=(length(find(z(168:334)==2)));
w3=(length(find(z(335:1000)==3)));
error=1-(w1+w2+w3)/1000;
disp("The Bayesian error for new b is:");
disp(error);
%-----------------b mahalanobis----------
[l,c]=size(m);
[l,N]=size(X1);
for i=1:N
    for j=1:c
        dm=[sqrt((X1(:,i)-m1)'*s(:,:,1)^-1*(X1(:,i)-m1)),sqrt((X1(:,i)-m2)'*s(:,:,2)^-1*(X1(:,i)-m2)),sqrt((X1(:,i)-m3)'*s(:,:,3)^-1*(X1(:,i)-m3))];
    end
    [num,z(i)]=min(dm);
    
end

w1=(length(find(z(1:167)==1)));
w2=(length(find(z(168:334)==2)));
w3=(length(find(z(335:1000)==3)));
error=1-(w1+w2+w3)/1000;
disp("The Mahalanobis error for new b is:");
disp(error);
%---------------------β euclidean--------------
dme=@(x,m)sqrt(sum((x-m).^2));
for i=1:N
    for j=1:c
        dm3=[dme(X1(:,i),m1),dme(X1(:,i),m2),dme(X1(:,i),m3)];
    end
    [num,z(i)]=min(dm3);
    
end
w1=(length(find(z(1:167)==1)));
w2=(length(find(z(168:334)==2)));
w3=(length(find(z(335:1000)==3)));
error3=1-(w1+w2+w3)/1000;
disp("The Euclidean Error for new b is:");
disp(error3);

%new 4.c-------bayesian
x1=X(:,1:ceil(p1*10000));
x2=X(:,ceil(p1*10000)+1:ceil(p1*10000)+ceil(p2*10000));
x3=X(:,ceil(p1*10000)+ceil(p2*10000)+1:end);
m_hat1=(1/length(x1)).*sum(x1,2);
m_hat2=(1/length(x2)).*sum(x2,2);
m_hat3=(1/length(x3)).*sum(x3,2);
S1=0;S2=0;S3=0;
for k=1:length(x1)
   S1=S1 + (x1(:,k)-m_hat1)*(x1(:,k)-m_hat1)';
    S2=S2 + (x2(:,k)-m_hat2)*(x2(:,k)-m_hat2)';
end
for k=1:length(x3)
   S3=S3 + (x3(:,k)-m_hat3)*(x3(:,k)-m_hat3)';
end

S_new1=(1/length(x1))*S1;
S_new2=(1/length(x2))*S2;
S_new3=(1/length(x3))*S3;
%κατηγοριοποίηση των test
z=zeros(1,length(X1));

for i=1:N
    dm=[p1*lik(X1(:,i),m_hat1,S_new1,3) p2*lik(X1(:,i),m_hat2,S_new2,3) p3*lik(X1(:,i),m_hat3,S_new3,3)];
    z(i)=find(dm==max(dm));    
end
w1=(length(find(z(1:167)==1)));
w2=(length(find(z(168:334)==2)));
w3=(length(find(z(335:1000)==3)));
error2=1-(w1+w2+w3)/1000;
disp("The Bayesian error for new c is:");
disp(error2);

%------------------ c Mahalanobis

%κατηγοριοποίηση των test
m_new=[m_hat1 m_hat2 m_hat3];
[l,c]=size(m);
[l,N]=size(X1);
for i=1:N
    for j=1:c
        dm=[sqrt((X1(:,i)-m_hat1)'*S_new1^-1*(X1(:,i)-m_hat1)),sqrt((X1(:,i)-m_hat2)'*S_new2^-1*(X1(:,i)-m_hat2)),sqrt((X1(:,i)-m_hat3)'*S_new3^-1*(X1(:,i)-m_hat3))];
    end
    [num,z(i)]=min(dm);
    
end

w1=(length(find(z(1:167)==1)));
w2=(length(find(z(168:334)==2)));
w3=(length(find(z(335:1000)==3)));
error2=1-(w1+w2+w3)/1000;
disp("The Mahalanobis error for new c is:");
disp(error2);

%---------------------c euclidean--------------
dme=@(x,m)sqrt(sum((x-m).^2));
for i=1:N
    for j=1:c
        dm3=[dme(X1(:,i),m_hat1),dme(X1(:,i),m_hat2),dme(X1(:,i),m_hat3)];
    end
    [num,z(i)]=min(dm3);
    
end
w1=(length(find(z(1:167)==1)));
w2=(length(find(z(168:334)==2)));
w3=(length(find(z(335:1000)==3)));
error3=1-(w1+w2+w3)/1000;
disp("The Euclidean Error for new c is:");
disp(error3);

