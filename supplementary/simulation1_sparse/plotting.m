s = 10;

figure;
t=tiledlayout(1,2);
t.TileSpacing = 'compact';
nexttile; hold on;
i = 1;
for spec_gap = [1 2 5 10]
    res = readmatrix(strcat(['../../simulation1/results/s', int2str(s), '_spec_gap', int2str(spec_gap), '.csv']));

    tbl = table(res(:,1), res(:,10));
    stats = grpstats(tbl,"Var1");
   
    if i == 1
        plot(stats.Var1+1, stats.mean_Var2, '-_', 'LineWidth', 1, 'Color', [0.9 0.2 0.2])
    elseif i == 2
        plot(stats.Var1+1, stats.mean_Var2, '-o', 'LineWidth', 1, 'Color', [0.1 0.7 0.1])
    elseif i == 3
        plot(stats.Var1+1, stats.mean_Var2, '-^', 'LineWidth', 1, 'Color', [0.1 0.5 0.8])
    elseif i == 4
        plot(stats.Var1+1, stats.mean_Var2, '-x', 'LineWidth', 1, 'Color', [0.6 0.2 0.8])
    end
    i = i+1;
end
ylim([0, 1]); xlim([0, 18]);
xticks(0:2:18);
xlabel({'$\frac{\psi(\mathcal{G}_{J,J})}{\phi(\mathcal{G}_{J,J})}$'}, 'FontSize', 30,'Interpreter','latex'); 
ylabel('Exact Recovery Rate', 'FontSize', 16); 
title({'50% of observation rate',''}, 'position', [9, 0.9], 'FontSize', 15);
legend({'$\bar{\lambda}(\textbf{\textit{M}}^*)=1$', ...
    '$\bar{\lambda}(\textbf{\textit{M}}^*)=2$', ...
    '$\bar{\lambda}(\textbf{\textit{M}}^*)=5$', ...
    '$\bar{\lambda}(\textbf{\textit{M}}^*)=10$'},...
    'Interpreter', 'latex', 'FontSize', 13);
box on;
hold off;
    
clear all

s = 10;

nexttile; hold on;
i = 1;
for spec_gap = [1 2 5 10]
    res = readmatrix(strcat(['results/s', int2str(s), '_spec_gap', int2str(spec_gap), '.csv']));

    tbl = table(res(:,1), res(:,10));
    stats = grpstats(tbl,"Var1");
    
    if i == 1
        plot(stats.Var1+1, stats.mean_Var2, '-_', 'LineWidth', 1, 'Color', [0.9 0.2 0.2])
    elseif i == 2
        plot(stats.Var1+1, stats.mean_Var2, '-o', 'LineWidth', 1, 'Color', [0.1 0.7 0.1])
    elseif i == 3
        plot(stats.Var1+1, stats.mean_Var2, '-^', 'LineWidth', 1, 'Color', [0.1 0.5 0.8])
    elseif i == 4
        plot(stats.Var1+1, stats.mean_Var2, '-x', 'LineWidth', 1, 'Color', [0.6 0.2 0.8])
    end
    i = i+1;
end
ylim([0, 1]); xlim([0, 18]);
xticks(0:2:18);
xlabel({'$\frac{\psi(\mathcal{G}_{J,J})}{\phi(\mathcal{G}_{J,J})}$'}, 'FontSize', 30,'Interpreter','latex'); 
ylabel('Exact Recovery Rate', 'FontSize', 16); 
title({'25% of observation rate',''}, 'position', [9, 0.9], 'FontSize', 15);
legend({'$\bar{\lambda}(\textbf{\textit{M}}^*)=1$', ...
    '$\bar{\lambda}(\textbf{\textit{M}}^*)=2$', ...
    '$\bar{\lambda}(\textbf{\textit{M}}^*)=5$', ...
    '$\bar{\lambda}(\textbf{\textit{M}}^*)=10$'},...
    'Interpreter', 'latex', 'FontSize', 13);
box on;
hold off;

f = gcf;
set(f, 'Position',  [100, 100, 700, 320])

exportgraphics(f,strcat('simulation1_sparse.png'),'Resolution', 300)