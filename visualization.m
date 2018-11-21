function visualization(f,t,s,rs,tar,V_est,V,R,L,V_est_show,Vshow,J1,J2)

clf(f);
axis off;
axes('ycolor',get(f,'color'),'ytick',[])
hold on;
color = ['b','g','m','c','y',[0.2417,0.4039,0.0965],[0.1320,0.9421,0.9561]];
for j = 1: numel(s)
    plot(s(j),0, strcat('.',color(j)),'MarkerSize',69);
    plot([s(j)-rs,s(j)+rs],[0,0],color(j),'linewidth',3);
    if V_est_show(j) == 1
        bar(V_est(j,2:end),color(j));
    end
end
if Vshow == 1
    V_real = bar(V(2:end),'k');
end
R_real = bar(R(2:end),'r');

alpha(0.9)

%legend([V1,V2,V_real,R_real],'Agn1Est','Agn2Est','V','RVal')

set(gca,'Xlim',[0,L],'XTick',0:5:L)
set(gca,'Ylim',[0,30])
text(tar',R(tar+1),num2str(R(tar+1)','%0.2f'),...
    'HorizontalAlignment','center',...
    'VerticalAlignment','bottom')
text (1,25,['t = ' num2str(t,'%0.2f\n')],'Interpreter','Latex')
text (1,23,['$$\sum R_i$$ = ' num2str(sum(R),'%0.2f\n')],'Interpreter','Latex')
text (1,21,['$$J_1$$ = ' num2str(J1/t,'%0.2f\n')],'Interpreter','Latex')
text (1,19,['$$J_2$$ = ' num2str(J2,'%0.2f\n')],'Interpreter','Latex')
        
hold off;
drawnow