function M = gram(x,n)
m = length(x); %length of x (a to b) = 11
M = zeros(m,n); %zero matrix thats 11 x degree of polynomial (+1)
v = ones(m,1); %column vector filled with ones with 11 elements
for i = n : -1 : 1 %counts down from degree of polynomial (+1) to 1
    M(:, i) = v; %replaces zero column with v
    v = v .* x; %v is then multiplied with x
end

end
