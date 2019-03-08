function sum = explicitSum(k,f,t,i,x1,x2)
sum = 0;
%b = [1901/720, -2774/720, 2616/720, -1274/720, 251/720];
B = [1901, -2774, 2616, -1274, 251];
B = B/720;
for j=1:k
    sum = sum + B(j)*f(t(i-j),x1(i-j),x2(i-j));
end
end