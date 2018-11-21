function R_est = EventDrivenInfoEx(R_est,R,s,rs,u,tar,dt,event)

% event 1; synchronize when leave the target
if event(1) == 1
    for j = 1 : numel(s)
        if (sum(abs(s(j) - tar - rs) < dt/2 ) > 0 && u(j) == 1)
            RInd = tar(abs(s(j) - tar - rs) < dt/2) + 1;
            R_est(:,RInd) = R_est(j,RInd)*ones(numel(s),1);
        elseif (sum(abs(tar - s(j) - rs) < dt/2 ) > 0 && u(j) == -1)
            RInd = tar(abs(tar - s(j) - rs) < dt/2 ) + 1;
            R_est(:,RInd) = R_est(j,RInd)*ones(numel(s),1);
        end
    end
end

% event 2: R depleted
if event(2) == 1
    for j = 1 : numel(s)
        R_est(j,:) = (R ~= 0).* R_est(j,:);
    end
end

% event 3; synchronize when enter the target
if event(3) == 1
    for j = 1 : numel(s)
        if (sum(abs(s(j) - tar + rs) < dt/2 ) > 0 && u(j) == 1)
            RInd = tar(abs(s(j) - tar + rs) < dt/2) + 1;
            R_est(:,RInd) = R_est(j,RInd)*ones(numel(s),1);
        elseif (sum(abs(tar - s(j) + rs) < dt/2 ) > 0 && u(j) == -1)
            RInd = tar(abs(tar - s(j) + rs) < dt/2 ) + 1;
            R_est(:,RInd) = R_est(j,RInd)*ones(numel(s),1);
        end
    end
%     for j = 1 : numel(s)
%         if (sum(abs(s(j) - tar) < rs ) > 0 )
%             RInd = tar(abs(s(j) - tar) < rs ) + 1;
%             R_est(:,RInd) = R_est(j,RInd)*ones(numel(s),1);       
%         end
%     end
end