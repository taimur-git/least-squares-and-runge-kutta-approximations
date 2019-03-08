function b = gauss(A,b)
%gauss function
n = length(b);
for i = 1 : (n-1)
    [d, maxi] = max(abs(A(i:n,i))); %maximum value on ith column from ith value to nth value
    maxi = maxi + i - 1; 
    if d < 1e-15
        b = NaN; %if max accuracy is reached b is NaN
        return
    end
    
    %switching ith row with maxith row
    A([i;maxi],:) = A([maxi;i],:); 
    b([i;maxi]) = b([maxi;i]);
    
    for j = (i+1) : n %row substitution
        d = A(j,i)/A(i,i); %row j by row i 
        A(j,:) = A(j,:) - d * A(i,:); %row j = row j - d * row i 
        b(j) = b(j) - d * b(i); %solution vector also gets decreased
    end
    
end
for i = n : -1 : 2 %from n to 2
    b(i) = b(i) / A(i,i); 
    j = 1 : (i-1);
    b(j) = b(j) - A(j,i) * b(i);
end
b(1) = b(1) / A(1,1);

end

        