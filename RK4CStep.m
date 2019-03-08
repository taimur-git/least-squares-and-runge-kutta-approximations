%runge kutta constant step
%start, stop = interval
%h = step size
%f1, f2 = function 1 and 2 
%y1, y2 = initial conditions
%x1, x2 = values of x1, x2
%t = time
function [x1, x2, t] = RK4CStep(start,stop,h,f1,f2,y1,y2)

%number of steps in interval 
iter = ceil(stop/h);

%preallocation
t = zeros(1,iter);
x1 = zeros(1,iter);
x2 = zeros(1,iter);

%initial conditions
t(1) = start;
x1(1) = y1;
x2(1) = y2;

%loops through all points 
for i = 1:iter
    t(i+1) = t(i) + h;
    %runge kutta of 4th order
    k11 = f1(t(i),x1(i),x2(i));
    k21 = f2(t(i),x1(i),x2(i));
    k12 = f1(t(i)+h/2,x1(i)+(h/2)*k11,x2(i)+(h/2)*k21);
    k22 = f2(t(i)+h/2,x1(i)+(h/2)*k11,x2(i)+(h/2)*k21);
    k13 = f1(t(i)+h/2,x1(i)+(h/2)*k12,x2(i)+(h/2)*k22);
    k23 = f2(t(i)+h/2,x1(i)+(h/2)*k12,x2(i)+(h/2)*k22);
    k14 = f1(t(i)+h,x1(i)+h*k13,x2(i)+h*k23);
    k24 = f2(t(i)+h,x1(i)+h*k13,x2(i)+h*k23);
    
    x1(i+1) = x1(i) + (h/6)*(k11 + 2*k12 + 2*k13 + k14);
    x2(i+1) = x2(i) + (h/6)*(k21 + 2*k22 + 2*k23 + k24);
end

end
