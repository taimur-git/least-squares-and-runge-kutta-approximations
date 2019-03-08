%initialising
clc;clear;
%initial conidtions
x0 = [8, 8];
a = 0;b = 15;
interval = [a, b];


h0 = 0.01; %initial step
%declaring the functions
func=@(t,y) [y(2)+y(1)*(0.5-y(1)^2-y(2)^2);-y(1)+y(2)*(0.5-y(1)^2-y(2)^2)];
%error tolerances
eps_rel = 10^-6;%relative tolerance
eps_abs = 10^-4;%absolute tolerance
hmin = 10^-7;%minimum step size
h(2) = h0;
t(1) = a;
n = (b-a)/h(2);
x = x0';
t(2) = t(1) + h(2);
xtmp(:,1)=x(:,1);
i = 2;

while t<= b %while we are in range keep looping algorithm
    incrh = true;
    
    %Runge kutta method
    tj = t(i);
    k1 = h(i)*feval(func,tj,x(:,i-1));
    k2 = h(i)*feval(func,tj+h(i)/2,x(:,i-1)+k1/2);
    k3 = h(i)*feval(func,tj+h(i)/2,x(:,i-1)+k2/2);
    k4 = h(i)*feval(func,tj+h(i),x(:,i-1)+k3);
    x(:,i) = x(:,i-1) + (k1+2*k2+2*k3+k4)/6;
    %error calculation
    d1(i) = (x(1,i)-xtmp(1,1))/((2^4)-1);
    d2(i) = (x(2,i)-xtmp(2,1))/((2^4)-1);
    xtmp(:,1) = x(:,i);
    
    %calculation sa1 = s*alpha
    e(i) = (abs(x(1,i)))*eps_rel+eps_abs;
    sa1 = (e(i)/abs(d1(i)))^(1/5)*0.9;
    e(i) = (abs(x(2,i)))*eps_rel+eps_abs;
    sa2 = (e(i)/abs(d2(i)))^(1/5)*0.9;
    
    %selecting smaller sa as the new step size
    if sa1 < sa2
        nh = h(i)*sa1;
    else
        nh = h(i)*sa2;
    end
    %increasing until sa is smaller than 1
    while((sa1<1)&&(sa2<1))
        incrh = false;
        if nh>hmin
            h(i) = nh;
            break;
        else %if step size is smaller than hmin
            disp('Accuracy not possible to satisfy');
            break;
        end
    end
    if incrh == true %assigning new step sizes
        h(i+1) = min(nh,3*h(i));
    else
        h(i+1) = h(i);
    end
    if t(i)+h(i+1)>b
        break %if interval end is met then break
    end
    i = i+1;
    t(i) = t(i-1)+h(i);
end


%All figures

figure(1);
plot(t,x(1,:));
axis([0 15 -1 8])
hold on
grid on
title('USING RK4 VARIABLE STEP SIZE - TIME');
xlabel('t');ylabel('x');

plot(t,x(2,:),'r');
legend('x1','x2');


figure(2);
plot(x(1,:),x(2,:));
hold on
grid on
xlabel('x1'); ylabel('x2');
title('USING RK4 VARIABLE STEP SIZE - MOTION');



figure(3);
semilogy(t,h(1:length(t)));
axis([0 15 0 2.5])
grid on
title('STEP-SIZE OVER TIME');
xlabel('t');ylabel('h');
legend('Step-Size');

figure(4);
semilogy(t,e(1:length(t)));
axis([0 15 0 1.1*10^(-4)])
grid on
title('ERROR OVER TIME');
xlabel('t');ylabel('e');
legend('Error Estimate');

figure(5);
plot(t,abs(d1));
axis([0 15 0 6*10^(-5)])
hold on
grid on
title('ABSOLUTE ERROR OVER TIME');
xlabel('t');ylabel('error');
plot(t,abs(d2),'r');
legend('Error of x1','Error of x2');
