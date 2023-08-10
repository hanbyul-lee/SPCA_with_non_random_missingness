s = 10;

figure;
t=tiledlayout(1,2);
t.TileSpacing = 'compact';
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
title({'      (a)',''}, 'position', [0, 0.9], 'FontSize', 15);
legend({'$\bar{\lambda}(\textbf{\textit{M}}^*)=1$', ...
    '$\bar{\lambda}(\textbf{\textit{M}}^*)=2$', ...
    '$\bar{\lambda}(\textbf{\textit{M}}^*)=5$', ...
    '$\bar{\lambda}(\textbf{\textit{M}}^*)=10$'},...
    'Interpreter', 'latex', 'FontSize', 13);
box on;
hold off;
    
rscld_list = 0:100:1400;
nexttile; hold on;
i = 1;
for spec_gap = [1 2 5 10]
    res = readmatrix(strcat(['results/s', int2str(s), '_spec_gap', int2str(spec_gap), '.csv']));

    rescaled = ((max(res(:,4)-res(:,5),s-res(:,3)-res(:,6)).*res(:,7)) ...
        + s*res(:,8) + res(:,9)/sqrt(s))./(res(:,5).*spec_gap/(s*sqrt(s)));
    
    rescaled_freq = ones(size(rescaled))*Inf;
    for k = rscld_list
        rescaled_freq(rescaled > k & rescaled <= k+100) = k+50;
    end
    
    tbl = table(rescaled_freq, res(:,10));
    stats = grpstats(tbl,"rescaled_freq");
    
    if i == 1
        plot(stats.rescaled_freq+50, stats.mean_Var2, '-_', 'LineWidth', 1, 'Color', [0.9 0.2 0.2])
    elseif i == 2
        plot(stats.rescaled_freq+50, stats.mean_Var2, '-o', 'LineWidth', 1, 'Color', [0.1 0.7 0.1])
    elseif i == 3
        plot(stats.rescaled_freq+50, stats.mean_Var2, '-^', 'LineWidth', 1, 'Color', [0.1 0.5 0.8])
    elseif i == 4
        plot(stats.rescaled_freq+50, stats.mean_Var2, '-x', 'LineWidth', 1, 'Color', [0.6 0.2 0.8])
    end
    i = i+1;
end
ylim([0, 1]); xlim([0, 1400]);
xticks(0:200:1400);
xlabel({'Rescaled'}, 'FontSize', 20); 
ylabel('Exact Recovery Rate', 'FontSize', 16); 
legend({'$\bar{\lambda}(\textbf{\textit{M}}^*)=1$', ...
    '$\bar{\lambda}(\textbf{\textit{M}}^*)=2$', ...
    '$\bar{\lambda}(\textbf{\textit{M}}^*)=5$', ...
    '$\bar{\lambda}(\textbf{\textit{M}}^*)=10$'},...
    'Interpreter', 'latex', 'FontSize', 13);
title({'      (b)',''}, 'position', [0, 0.9], 'FontSize', 15);
box on;
hold off;

f = gcf;
set(f, 'Position',  [100, 100, 700, 320])

exportgraphics(f,strcat('simulation1.png'),'Resolution', 300)
