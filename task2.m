%initialising
clc;clear;
%declaring the set of ordinary differential equations
f1 = @(t,x1,x2) (x2+(x1*(0.5-(x1)^2-(x2)^2)));
f2 = @(t,x1,x2) (-x1+(x2*(0.5-(x1)^2-(x2)^2)));
%initial conidtions
x0 = [8, 8];
a = 0;b = 15;
interval = [a, b];

%using ODE45---------------------------
func=@(t,y) [y(2)+y(1)*(0.5-y(1)^2-y(2)^2);-y(1)+y(2)*(0.5-y(1)^2-y(2)^2)];
[t, y] = ode45(func, interval, x0);

%plotting trajectory
figure(1);
plot(y(:,1),y(:,2));
hold on;
grid on;
title('USING ODE45 - MOTION');
legend ('trajectory');
%plotting time
figure(2);
plot(t,y);
hold on;
grid on;
title('USING ODE45 - TIME');
legend ('x1','x2');

%plotting for RK4 different constant step sizes------------------------
figure(3);
for h = [0.018,0.015,0.01,0.005,0.001]
    [x1,x2] = RK4CStep(a,b,h,f1,f2,x0(1),x0(2));

    switch h
        case 0.018
            plot(x1,x2,'b');
        case 0.015
            plot(x1,x2,'r--');
        case 0.010
            plot(x1,x2,'y--');
        case 0.005
            plot(x1,x2,'g');
        case 0.001
            plot(x1,x2,'b--');
    end

    grid on;
    hold on;
end
legend('0.018', '0.015', '0.010', '0.005', '0.001');
title('USING RUNGE-KUTTA - MOTION');
%plotting with time
figure(4);
[x1,x2, t] = RK4CStep(a,b,0.005,f1,f2,x0(1),x0(2));
plot(t,x1);
hold on;
grid on;
plot(t,x2);
title('USING RUNGE-KUTTA - TIME');
legend ('x1','x2');

%using adams PC------------------------------------
figure(5);
for h = [0.018,0.005]
    [x1,x2] = AdamsPC(a,b,h,f1,f2,x0(1),x0(2));
    switch h
        case 0.018
            plot(x1,x2,'b');
        case 0.005
            plot(x1,x2,'r');
    end
    grid on;
    hold on;
end
legend('0.018','0.005');
title('USING ADAMS PC - MOTION');
%plotting with time
figure(6);
[x1,x2, t] = AdamsPC(a,b,0.005,f1,f2,x0(1),x0(2));
plot(t,x1);
hold on;
grid on;
plot(t,x2);
title('USING ADAMS PC - TIME');
legend ('x1','x2');

%}

