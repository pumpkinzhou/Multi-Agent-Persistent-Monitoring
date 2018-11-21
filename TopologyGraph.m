s = [1 2 2 3 3 4];
t = [2 3 1 4 2 3];

G = digraph(s,t);

h = plot(G,'LineWidth',2);
camroll(-45)