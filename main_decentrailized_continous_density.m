clear;clc;
close all
% system param
T = 1000;
n = 100001; dt = 0.01; % time discretization
t = linspace(0,T,n);
L=45;
omega = 0:L; % space discretization

% target init
% tar = [5,10,15,20,25,30];  % tar pos set 1 symetric
%tar = [5,10,15,17,18,20,25,30,35,40,45];
tar = [5,10,15,20,25,30,35,40];
A0= zeros(1,L+1);A0(tar+1) = 0.5;
R0=zeros(1,L+1);R0(tar+1) = 1;
% agent param
rs= 3;
rc = 2*rs;
ri = 3*rs;
B= 5;
agnNum = 3;
s_init = linspace(0,L,agnNum);
u_init = zeros(1,agnNum);

% boundary
boundary = [max(min(tar)-rs,0) , min(max(tar)+rs,L)];
% event excitation
A_add(1,:) = densityGen(boundary(1), boundary(2),A0(1,:),1);
A = A0 + A_add;

%% opt param init
r_d = 1;

R = R0;
s = s_init;
u = u_init;
u_h = u;
Acc_R = 0; % accumulated R val vector

%% densityGen Test
%[V,~] = densityGen(min(tar), max(tar),R0,r_d);
% travel cost Test
% Q = travelCost(omega,s);

%% visual param
f = figure(1);
theta = cell(1,agnNum); % s traj record
% R traj
R_h(tar(1)+1) = 1;
R_est_h(1,tar(1)+1)=1;
R_est_h(2,tar(1)+1)=1;
% M =[]; % video record
R_est = repmat(R0,agnNum,1);
V_est = zeros(agnNum, L + 1);
R_est_h = R_est; R_h = R0;  % R traj record
tarID = 2;
J1 = 0; % J = \int_{t=0}^{t} \sum_{i} R_{i} dt
J2 = 0; % 
%%
cooperation = 1; limitRange = 1;
if cooperation == 1
    event = [1,1,1]; % event function indicator: 1; synchronize when leave the target  2: R depleted  3 enter a target
else
    event = [0,0,0];
end
V_est_show = zeros(1,agnNum);
V_est_show(1) = 0;
Vshow = 0;
for tCnt = t
    
    %partial info
    % R_est revise (agent self correction within sensing range)
    for j = 1 : agnNum
        R_est(j,(tar(abs(s(j)-tar) < rs)+1)) = R(tar(abs(s(j)-tar) < rs)+1);
    end
    
    %perfect info
    P = sensingP(omega,s,rs);
    R = R + A0.*dt;
    R  = max(R - B.*P*dt,0);
    [V,~] = densityGen(boundary(1), boundary(2),R,r_d);
    
    J1 = J1 + sum(R)*dt;  % obj J1
    
    J2 = dot(V,travelCost(omega,s))/sum(travelCost(omega,s));  % obj J2
    
    % R_est revise (info ex and update)
    R_est = EventDrivenInfoEx(R_est,R,s,rs,u,tar,dt,event);
    
    % V_j densityGen for each agent j
    for j = 1 : agnNum
        P_est = sensingP(omega,s(abs(s - s(j))<rc),rs);
        R_est(j,:) = R_est(j,:) + A0.*dt;
        R_est(j,:)  = max(R_est(j,:)  - B.*P_est*dt,0);
        if limitRange ==1
            [V_est(j,:) , ~] = densityGen(max(boundary(1),round(s(j) - ri)), min(round(s(j)+ri),boundary(2)),R_est(j,:),r_d);
        else
            [V_est(j,:) , ~] = densityGen(boundary(1), boundary(2),R_est(j,:),r_d);
        end
    end
    
    Acc_R = Acc_R + R*dt;
    % visualize V
    if mod(tCnt,1) == 0
        figure(1)
        visualization(f,tCnt+dt,s,rs,tar,V_est,V,R,L,V_est_show,Vshow,J1,J2);
        %plot([stepCnt,stepCnt+0.5],[R_est_h(1,6),R_est(1,6)],'b')
        %plot([stepCnt,stepCnt+0.5],[R_est_h(2,6),R_est(2,6)],'g')
        %plot([stepCnt,stepCnt+0.5],[R_h(6),R(6)],'r')
        %R_est_h(1,6) = R_est(1,6);
        %R_est_h(2,6) = R_est(2,6);
        %R_h(6) = R(6);
        if tCnt > 320
            break;
        end
        %         xlabel('Time t');
        %         ylabel('$$\bar{R_1}(t)$$','Interpreter','Latex');
        %         axis([0,300,0,25])
        %         legend({'$$\bar{R_1^1}(t)$$','$$\bar{R_1^2}(t)$$'},'Interpreter','Latex')
        
%         M = [M,getframe(f)];  % video record

        % R value tracking
%         figure(2)
%         hold on;
% %         plot(tCnt, R(tar(1)+1),'r*')
% %         plot(tCnt, R_est(1,tar(1)+1),'bo')
% %         plot(tCnt, R_est(2,tar(1)+1),'gs')  
%         plot([tCnt-1,tCnt],[R_h(tar(tarID)+1), R(tar(tarID)+1)],'r','LineWidth',2);
%         plot([tCnt-1,tCnt],[R_est_h(1,tar(tarID)+1), R_est(1,tar(tarID)+1)],'b');
%         plot([tCnt-1,tCnt],[R_est_h(2,tar(tarID)+1), R_est(2,tar(tarID)+1)],'g');
%         R_h(tar(tarID)+1) = R(tar(tarID)+1);
%         R_est_h(1,tar(tarID)+1) = R_est(1,tar(tarID)+1);
%         R_est_h(2,tar(tarID)+1) = R_est(2,tar(tarID)+1);
%         alpha(0.5)
        
    end
    
    
    % cal u (decision)
    u_h = u;
    u = gradientDescent(s,tar,V_est,omega);
    
    % agents repel each other
    %     if abs(s(1)-s(2))< rs/2
    %         u = [-1,1];
    %     end
    
    % update next pos
    s = s + u*dt;
    
    for j = 1 : agnNum
        if u_h(j) ~= u(j)
            theta{j} = [theta{j},s(j)];
            
        end
    end
    
end
%%
%% video record
% v = VideoWriter('newfile.avi');
% v.FrameRate = 10;
% open(v)
% writeVideo(v,M)
% close(v)

% figure(2)
% axis([0,300,0,6])
% xlabel('t','Interpreter','Latex');
% ylabel ('$$R_1$$','Interpreter','Latex')

W = cell(1,agnNum);
for j = 1 : agnNum
    W{j} = zeros(1,length(theta{j}));
end
%save('traj','theta','W');

T = 300;
color = ['b','g','m','c','y',[0.2417,0.4039,0.0965],[0.1320,0.9421,0.9561]];
figure
for j = 1:numel(s)
    %subplot(2,1,carID)
    hold on
    for ii = 1:L+1
        if A0(ii) ~= 0
            plot(0:T,(ii-1)*ones(1,length(0:T)),'r--','LineWidth',1);
        end
    end
    
    TrajectoryGeneral_Theta_W(theta{j},W{j},s_init(j),u_init(j),T,L,color(j));
    
    hold off
    %ylabel(['traj s',num2str(carID)]);
end
title('Decentralized opt traj with cooperation','Interpreter','Latex');
xlabel('Time t','Interpreter','Latex');
ylabel('s','Interpreter','Latex');
