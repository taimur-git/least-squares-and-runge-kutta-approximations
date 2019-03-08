%Adams PC Method
%start, stop = interval
%h = step size
%f1, f2 = function 1 and 2 
%y1, y2 = initial conditions
%x1, x2 = values of x1, x2
%t = time
function [x1, x2, t] = AdamsPC(start, stop, h, f1, f2, y1, y2)
B0 = 475/1440; %B0 from table
k = 5; %P5EC5E, k = 5
tfin = (k*h)-start; %for 5point runge-kutta approximation
iter = ceil((stop - start)/h);
t = zeros(1,iter);%preallocation
[x1, x2] = RK4CStep(start,tfin,h,f1,f2,y1,y2);%initial points from RK4
for i=6:iter
    t(1+i) = t(i)+h;
    %prediction - explicit sum
    x1(i+1) = x1(i) + h*explicitSum(k,f1,t,i,x1,x2);
    x2(i+1) = x2(i) + h*explicitSum(k,f2,t,i,x1,x2);
    %evaluation
    fn1 = f1(t(i+1),x1(i+1),x2(i+1));
    fn2 = f2(t(i+1),x1(i+1),x2(i+1));
    %correction - implicit sum 
    x1(i+1) = x1(i) + h*implicitSum(k,f1,t,i,x1,x2)+h*B0*fn1;
    x2(i+1) = x2(i) + h*implicitSum(k,f2,t,i,x1,x2)+h*B0*fn2;
end
end