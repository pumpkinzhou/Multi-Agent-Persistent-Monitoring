function Q = travelCost(omega,s)

Q = zeros(1,length(omega));

for j = 1 : length(s)    
    Q = Q + abs(omega - s(j));
end