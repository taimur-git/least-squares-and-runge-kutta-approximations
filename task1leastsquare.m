%initialising
clc;
clear;
format short;

%interval
a = -5;
b = 5;
x = (a : b)';

%values of y
y = [   -79.1639
        -40.7900
        -18.7814
        -6.3530
        -0.4392
        0.8270
        0.0585
        -1.7477
        -3.4384
        -6.3580
        -9.3875];
 
X = a : 0.01 : b;

%different values of polynomial
for n = [1, 2, 3, 4, 5, 7, 10, 15, 20]
    %print degree of polynomial
    display(n);
    
    %method without QR
    display('Method without QR');
    [P, err] = leastSquare(x, y, n);
    display(P);
    display(err);
    figure;
    plot(X, polyval(P,X),x,y,'o');
    xlabel('x');
    ylabel('y');
    title(['Solution without QR Factorisation for n = ' int2str(n)]);
    
    %method with QR
    display('Method with QR');
    [P, err] = QRleastSquare(x,y,n);
    display(P);
    display(err);
    figure;
    plot(X, polyval(P,X),x,y,'o');
    xlabel('x');
    ylabel('y');
    title(['Solution with QR Factorisation for n = ' int2str(n)]);
    
end