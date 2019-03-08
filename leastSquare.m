function [P, err] = leastSquare(x, y, n)
n = n + 1; %for the gram function

M = gram(x,n); %getting matrix formed from gram
A = M' * M; %positive definite symmetric matrix
b = M' * y; %MT with vector y gives solution vector b
P = gauss(A,b)'; %solve the equation with gaussian elimination
err = norm(A * P' - b, 2); %error

end