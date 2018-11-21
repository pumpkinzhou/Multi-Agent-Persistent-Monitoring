function Gui_PM(handles)
global stop;
% system param
color = ['b','g','m','c','y',[0.2417,0.4039,0.0965],[0.1320,0.9421,0.9561]];

s_init = str2num(handles.sInit.String);
tar = str2num(handles.tarPos.String); 
u_init = str2num(handles.uInit.String);
MSpace = str2num(handles.MSpace.String);
A = str2double(handles.A_Val.String);
B = str2double(handles.B_Val.String);

if handles.Cooperation.Value
    event = [1,1,1]; % event function indicator
else
    event = [0,0,0]; % event function indicator
end

if handles.ShortTerm.Value
    shortTerm = 1; % short term decision indicator
else
    shortTerm = 0; 
end


L=MSpace(2);
T = 1000;
% time discretization
n = 100001; dt = 0.01;
t = linspace(0,T,n);
% space discretization
omega = 0:L;

A0= zeros(1,L+1);A0(tar+1) = A;
R0=zeros(1,L+1);R0(tar+1) = 1;

% agent param
rs= str2double(handles.SensingRange.String);
rc = 2*rs;
ri = 3*rs;
% boundary
boundary = [max(min(tar)-rs,0) , min(max(tar)+rs,L)];

%% opt param init
r_d = 1;
agnNum = numel(s_init);
R = R0;
s = s_init;
u = u_init;
Acc_R = 0; % accumulated R val vector

%% visual param
R_est = repmat(R0,agnNum,1);
V_est = zeros(agnNum, L + 1);

%%
J=0;
axes(handles.axes1);
for tCnt = t
    if stop == 1
        break;
    end
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
    
    %Q = travelCost(omega,s);
    %J2 = dot(Q,V)/sum(Q);
    J = J + sum(R)*dt;
    
    % R_est revise (info ex and update)
    R_est = EventDrivenInfoEx(R_est,R,s,rs,u,tar,dt,event);
    
    % V_j densityGen for each agent j
    for j = 1 : agnNum
        P_est = sensingP(omega,s(abs(s - s(j))<rc),rs);
        R_est(j,:) = R_est(j,:) + A0.*dt;
        R_est(j,:)  = max(R_est(j,:)  - B.*P_est*dt,0);
        if shortTerm == 0
            [V_est(j,:) , ~] = densityGen(boundary(1), boundary(2),R_est(j,:),r_d);
        else
            [V_est(j,:) , ~] = densityGen(max(boundary(1),round(s(j) - ri)), min(round(s(j)+ri),boundary(2)),R_est(j,:),r_d);
        end
            
    end
    
    Acc_R = Acc_R + R*dt;
    % visualize V
    if mod(tCnt,1) == 0
        
        cla;  
        hold on;
        for j = 1: numel(s)
            plot(s(j),0, strcat('.',color(j)),'MarkerSize',69);
            plot([s(j)-rs,s(j)+rs],[0,0],color(j),'linewidth',3);
            %bar(V_est(j,2:end),color(j));
        end
        
                
        if handles.V_est1.Value == 1
            bar(V_est(1,2:end),color(1));
        end
        
        if handles.V_estN.Value == 1
            bar(V_est(agnNum,2:end),color(2));
        end

        
        if handles.V.Value == 1
            bar(V(2:end),'k');
        end
        
        if handles.R.Value == 1
            bar(R(2:end),'r');
        end
        
        alpha(0.9)
        % tar val
        text(tar',R(tar+1),num2str(R(tar+1)','%0.2f'),...
            'HorizontalAlignment','center',...
            'VerticalAlignment','bottom')
        % tar location
        text(tar',-ones(1,numel(tar)),num2str(tar','%0.0f'),...
            'HorizontalAlignment','center')
        % time
        text (1,25,['t = ' num2str(tCnt,'%0.2f\n')],'Interpreter','Latex');
        % J
        text (1,23,['$$\sum R_i$$ = ' num2str(sum(R),'%0.2f\n')],'Interpreter','Latex');
        text (1,21,['J = ' num2str(J/(tCnt+dt),'%0.2f\n')],'Interpreter','Latex');
        
        set(gca,'Xlim',[0,L],'XTick',0:5:L)
        
        hold off;
        drawnow
    end
    
    
    % cal u (decision)
    u = gradientDescent(s,tar,V_est,omega);
    
    % update next pos
    s = s + u*dt;
    
end

