function [P, err] = QRleastSquare(x, y, n)
n = n + 1;
M = gram(x, n);
[Q,R] = QR(M); %QR factorization from QR function
b = Q' * y;
P = zeros(n, 1);
for i = n : -1 : 1 %from n to 1
    P(i) = b(i);
    P(i) = P(i) - R(i,(i+1):n) * P((i+1):n);
    P(i) = P(i)/R(i,i);
end
err = norm(M' * M * P - M' * y, 2);
P = P';

end