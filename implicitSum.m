function sum = implicitSum(k, f,t,i,x1,x2)
sum = 0;
B = [1427, -798, 482, -173, 27];
B = B/1440;
for j=1:k
    sum = sum + B(j) * f(t(i-j),x1(i-j),x2(i-j));
end
end
