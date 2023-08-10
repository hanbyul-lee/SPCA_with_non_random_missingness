res = readtable("result_num_edges100_sd1e-01.csv");

tbl = table(res{:,4}, res{:,7:end});
stats = grpstats(tbl,"Var1");

er_rates = stats.mean_Var2;
sdp_selected_er_rates = er_rates(:,1);
sdp_complete_selected_er_rates = er_rates(:,2);
sdp_er_rates = max(er_rates(:,3:42)')';
sdp_complete_er_rates = max(er_rates(:,43:82)')';
dt_er_rates = max(er_rates(:,83:97)')';
it_er_rates = max(er_rates(:,98:322)')';
dt_complete_er_rates = max(er_rates(:,323:337)')';
it_complete_er_rates = max(er_rates(:,338:end)')';

t = tiledlayout('flow','TileSpacing','compact');
nexttile; hold on;
plot(0.1:0.2:2.1, sdp_selected_er_rates, '-_', 'LineWidth', 1.5);
plot(0.1:0.2:2.1, er_rates(:,4:2:42), '-_');
hold off;
ylim([0, 1]); xlim([0, 2.2]);
xticks(0:0.2:2.2);
xlabel({'$\frac{\psi(\mathcal{G}_{J,J})}{\phi(\mathcal{G}_{J,J})}$'}, 'FontSize', 20,'Interpreter','latex'); 
ylabel('Exact Recovery Rate', 'FontSize', 16); 
title({'(a)',''}, 'position', [0.1, 0.9], 'FontSize', 15);
lgd = legend({'Selected $\rho$ by $C_\rho$', ...
    '$\rho=0.05$', '$\rho=0.1$', '$\rho=0.15$', '$\rho=0.2$', ...
    '$\rho=0.25$', '$\rho=0.3$', '$\rho=0.35$', '$\rho=0.4$', ...
    '$\rho=0.45$', '$\rho=0.5$', '$\rho=0.55$', '$\rho=0.6$', ...
    '$\rho=0.65$', '$\rho=0.7$', '$\rho=0.75$', '$\rho=0.8$', ...
    '$\rho=0.85$', '$\rho=0.9$', '$\rho=0.95$', '$\rho=1$'},...
    'Interpreter', 'latex', 'FontSize', 8);
lgd.Layout.Tile = 'east';
box on;

f = gcf;
set(f, 'Position',  [100, 100, 500, 350])

exportgraphics(f,strcat('tuning.png'),'Resolution', 300)


figure; hold on;
plot(0.1:0.2:2.1, sdp_selected_er_rates, '-_', 'LineWidth', 1.5, 'Color', [0.1 0.5 0.8]);
plot(0.1:0.2:2.1, sdp_complete_selected_er_rates, '--_', 'LineWidth', 1.5, 'Color', [0.1 0.7 0.1]);
plot(0.1:0.2:2.1, dt_er_rates, '-^', 'LineWidth', 1.5, 'Color', [0.9 0.2 0.2]);
plot(0.1:0.2:2.1, dt_complete_er_rates, '--^', 'LineWidth', 1.5, 'Color', [0.9 0.6 0.2]);
plot(0.1:0.2:2.1, it_er_rates, '-x', 'LineWidth', 1.5, 'Color', [0.6 0.2 0.8]);
plot(0.1:0.2:2.1, it_complete_er_rates, '--x', 'LineWidth', 1.5, 'Color', [0.9 0.2 0.9]);
hold off;
ylim([0, 1]); xlim([0, 2.2]);
xticks(0:0.2:2.2);
xlabel({'$\frac{\psi(\mathcal{G}_{J,J})}{\phi(\mathcal{G}_{J,J})}$'}, 'FontSize', 20,'Interpreter','latex'); 
ylabel('Exact Recovery Rate', 'FontSize', 16); 
title({'(b)',''}, 'position', [0.1, 0.9], 'FontSize', 15);
legend({'SDP', 'SDP with completion', 'DTSPCA', 'DTSPCA with completion', 'ITSPCA', 'ITSPCA with completion'}, 'FontSize', 9);
box on;

f = gcf;
set(f, 'Position',  [100, 100, 365, 340])

exportgraphics(f,strcat('comparison.png'),'Resolution', 300)