syms x;

%1o ερώτημα
p=sin(pi*x);
A=1/int(p,[0 1]);
disp(A);

%2o
syms r x
u=0:0.01:1;

y1= u.*sin(pi*u)*(pi/2) / double(int(r*sin(pi*r)*(pi/2),r,0,1));
y2= (u.^3).*((1-u).^2).*sin(pi*u)*(pi/2) / double(int(r^3*(1-r)^2*sin(pi*r)*(pi/2),r,0,1));
y3= (u.^7).*((1-u).^3).*sin(pi*u)*(pi/2) / double(int(r^7*(1-r)^3*sin(pi*r)*(pi/2),r,0,1));
hold on; 
axis([0 1 0 5]);
plot(u,y1,'r'),xlabel('\Theta'), ylabel('p(\Theta|D^n)');
plot(u,y2,'b'); 
plot(u,y3,'g'); grid on
h = legend('p(Theta|D^1)','p(Theta|D^5)','p(Theta|D^10)','location','northwest');
hold off
[q,w]=max(double(y3));
disp(['p(x=k|D^10=' num2str(q)])
disp(['for x=' num2str((w-1)/100)])
