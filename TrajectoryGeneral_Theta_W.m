function TrajectoryGeneral_Theta_W(theta,W1,s_init,u_init,T,L,color)

tt = 0;
s1 = s_init;
t1 = tt;
s2 = theta(1);
if u_init > 0
    t2 = theta(1) - s1;
else
    t2 = s1 - theta(1);
end
counter_dwell = 1;
counter_switching = 2;
hold on
while tt < T+1
    plot([t1,t2],[s1,s2],color,'LineWidth',1.5);
    s1 = s2;
    t1 = t2;
    t2 = t1 + W1(counter_dwell);
    counter_dwell = counter_dwell + 1;
    plot([t1,t2],[s1,s2]);
    t1 = t2;
    s2 = theta(counter_switching);
    counter_switching = counter_switching + 1;
    t2 = t1 + abs(s2 - s1);
    tt = t2;
end
axis([0,T,0,L]);
