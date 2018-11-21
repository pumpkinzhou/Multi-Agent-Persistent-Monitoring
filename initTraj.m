function [theta, W] = initTraj(theta_init_a, theta_init_b, w_init, Max_switch,mode,tar)
%mode 1 : a--> b -->a ... mode 2: target stop
theta = zeros(1,Max_switch);
switch mode
    case 1
        for i = 1:Max_switch
            if mod(i,2) == 1
                theta(i) = theta_init_b;
            else
                theta(i) = theta_init_a;
            end
        end
    case 2
        tar = tar(tar >= theta_init_a & tar <= theta_init_b);
        order = [tar , fliplr(tar(1:length(tar)-1) )];
        for i = 1:length(order)-1:Max_switch
            theta(i: i + length(order)-1 ) = order;
        end       
        theta = theta(1:Max_switch);
end
W = w_init * ones(1,Max_switch);
