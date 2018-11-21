function u = gradientDescent(s,tar,V_est,omega)

%[~,ind1]=min(abs(s(1)-tar));
%[~,ind2]=min(abs(s(2)-tar));

% perfect info
% log

%         u(1) = -sign(sum(V.*sign(s(1)-omega)./(abs(s(1)-omega)+1)) );
%         u(2) = -sign(sum(V.*sign(s(2)-omega)./(abs(s(2)-omega)+1)) );
%         u(1) = -sign(sum(V.*sign(s(1)-omega)./(abs(s(1)-omega)+1)) + 0.1*sign(s(1) - tar(ind1)));
%         u(2) = -sign(sum(V.*sign(s(2)-omega)./(abs(s(2)-omega)+1)) + 0.1*sign(s(2) - tar(ind2)));

% prod
%u1 = -sign(sum(abs(s(2)-omega).*V.*sign(s(1)-omega)) + sign(s(1) - tar(ind1)));
%u2 = -sign(sum(abs(s(1)-omega).*V.*sign(s(2)-omega)) + sign(s(2) - tar(ind2)));

% summation
%         u1 = -sign(sum(V.*sign(s1-omega))+ 0.1*sign(s1 - tar(ind1)));
%         u2 = -sign(sum(V.*sign(s2-omega))+ 0.1*sign(s2 - tar(ind2)));

% partial info
% log
for  j = 1 : numel(s)
    u(j) = -sign(sum(V_est(j,:).*sign(s(j)-omega)./(abs(s(j)-omega)+1)) );
end

%     if agnNum == 3
%         u1 = -sign(sum(abs(s3-omega).*abs(s2-omega).*V.*sign(s1-omega)));
%         u2 = -sign(sum(abs(s3-omega).*abs(s1-omega).*V.*sign(s2-omega)));
%         u3 = -sign(sum(abs(s1-omega).*abs(s2-omega).*V.*sign(s3-omega)));
%     end