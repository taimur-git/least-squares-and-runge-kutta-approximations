function [Q,R] = QR(M)
[m,n] = size(M); %dimensions of the matrix M 
Q = zeros(m,n); 
R = zeros(n,n);

for i = 1:n
    Q(:,i) = M(:,i);
    R(i,i) = 1;
    N = Q(:,i)' * Q(:,i);
    for j = (i+1):n
        R(i,j) = (Q(:,i)' * M(:,j))/N; %rij = ((ith column of q)' * jth column of m)/N
        M(:,j) = M(:,j) - R(i,j) * Q(:,i); %j column M = Mj - Rij*ith column Q
    end
    N = norm(Q(:,i),2);
    Q(:,i) = Q(:,i)/N;
    R(i,i:n) = N * R(i,i:n);
end

end