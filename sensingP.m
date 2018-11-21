function P = sensingP(omega,s,r)

p = zeros(length(s),length(omega));

for j = 1 : length(s)    
    p(j,:)= max(1- abs(omega - s(j))/r, 0);    
end

P = 1-prod(1-p,1);

