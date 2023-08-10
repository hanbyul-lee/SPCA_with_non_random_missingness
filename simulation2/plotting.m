d = 50; s = 10; spec_gap = 20;

figure;
t=tiledlayout(1,2);
t.TileSpacing = 'compact';
nexttile; hold on;
i = 1;
for sd = [0.1 0.3 0.5 0.7]
    res = readmatrix(strcat(['results/s', int2str(s), '_spec_gap', int2str(spec_gap), '_sd', num2str(sd,'%.0e'), '.csv']));

    tbl = table(res(:,1), res(:,11));
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
title({'      (c)',''}, 'position', [0, 0.9], 'FontSize', 15);
legend({'$\sigma=0.1$', '$\sigma=0.3$', '$\sigma=0.5$', '$\sigma=0.7$'}, ...
    'Interpreter', 'latex', 'FontSize', 15);
box on;
hold off;
    
rscld_list = 0:100:1400;
nexttile; hold on;
i = 1;
for sd = [0.1 0.3 0.5 0.7]
    res = readmatrix(strcat(['results/s', int2str(s), '_spec_gap', int2str(spec_gap), '_sd', num2str(sd,'%.0e'), '.csv']));

    rescaled = ((max(res(:,4)-res(:,5),s-res(:,3)-res(:,6)).*res(:,8)) + ...
        sd*sqrt(res(:,4)*log(s)) + ...
        sd*s*sqrt(res(:,7)*log(d)) + ...
        s*res(:,9) + res(:,10)/sqrt(s))./(res(:,5).*spec_gap/(s*sqrt(s)));
    
    rescaled_freq = ones(size(rescaled))*Inf;
    for k = rscld_list
        rescaled_freq(rescaled > k & rescaled <= k+100) = k+50;
    end
    
    tbl = table(rescaled_freq, res(:,11));
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
legend({'$\sigma=0.1$', '$\sigma=0.3$', '$\sigma=0.5$', '$\sigma=0.7$'}, ...
    'Interpreter', 'latex', 'FontSize', 15);
title({'      (d)',''}, 'position', [0, 0.9], 'FontSize', 15);
box on;
hold off;

f = gcf;
set(f, 'Position',  [100, 100, 700, 320])

exportgraphics(f,strcat('simulation2.png'),'Resolution', 300)

