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
it_complete_er_rates = max(er_rates(:,338:562)')';
gpm1_er_rates = max(er_rates(:,563:573)')';
gpm2_er_rates = max(er_rates(:,574:584)')';
gpm1_complete_er_rates = max(er_rates(:,585:595)')';
gpm2_complete_er_rates = max(er_rates(:,596:606)')';
gpm1_selected_er_rates = er_rates(:,607);
gpm2_selected_er_rates = er_rates(:,608);
gpm1_complete_selected_er_rates = er_rates(:,609);
gpm2_complete_selected_er_rates = er_rates(:,610);



figure; hold on;
plot(0.1:0.2:2.1, sdp_er_rates, '-_', 'LineWidth', 1.5, 'Color', [0.1 0.5 0.8]);
plot(0.1:0.2:2.1, gpm1_er_rates, '-^', 'LineWidth', 1.5, 'Color', [0.9 0.2 0.2]);
plot(0.1:0.2:2.1, gpm2_er_rates, '-x', 'LineWidth', 1.5, 'Color', [0.6 0.2 0.8]);
hold off;
ylim([0, 1]); xlim([0, 2.2]);
xticks(0:0.2:2.2);
xlabel({'$\frac{\psi(\mathcal{G}_{J,J})}{\phi(\mathcal{G}_{J,J})}$'}, 'FontSize', 20,'Interpreter','latex'); 
ylabel('Exact Recovery Rate', 'FontSize', 16); 
title({'(a)',''}, 'position', [0.1, 0.9], 'FontSize', 15);
legend({'SDP', 'GPM Algorithm 2', 'GPM Algorithm 3'}, 'FontSize', 9);
box on;

f = gcf;
set(f, 'Position',  [100, 100, 365, 340])

exportgraphics(f,strcat('comparison1_gpm.png'),'Resolution', 300)


figure; hold on;
plot(0.1:0.2:2.1, sdp_complete_er_rates, '--_', 'LineWidth', 1.5, 'Color', [0.1 0.7 0.1]);
plot(0.1:0.2:2.1, gpm1_complete_er_rates, '--^', 'LineWidth', 1.5, 'Color', [0.9 0.6 0.2]);
plot(0.1:0.2:2.1, gpm2_complete_er_rates, '--x', 'LineWidth', 1.5, 'Color', [0.9 0.2 0.9]);
hold off;
ylim([0, 1]); xlim([0, 2.2]);
xticks(0:0.2:2.2);
xlabel({'$\frac{\psi(\mathcal{G}_{J,J})}{\phi(\mathcal{G}_{J,J})}$'}, 'FontSize', 20,'Interpreter','latex'); 
ylabel('Exact Recovery Rate', 'FontSize', 16); 
title({'(b)',''}, 'position', [0.1, 0.9], 'FontSize', 15);
legend({'SDP with completion', 'GPM Algorithm 2 with completion', 'GPM Algorithm 3 with completion'}, 'FontSize', 9);
box on;

f = gcf;
set(f, 'Position',  [100, 100, 365, 340])

exportgraphics(f,strcat('comparison1_gpm_completion.png'),'Resolution', 300)


figure; hold on;
plot(0.1:0.2:2.1, sdp_selected_er_rates, '-_', 'LineWidth', 1.5, 'Color', [0.1 0.5 0.8]);
plot(0.1:0.2:2.1, gpm1_selected_er_rates, '-^', 'LineWidth', 1.5, 'Color', [0.9 0.2 0.2]);
plot(0.1:0.2:2.1, gpm2_selected_er_rates, '-x', 'LineWidth', 1.5, 'Color', [0.6 0.2 0.8]);
hold off;
ylim([0, 1]); xlim([0, 2.2]);
xticks(0:0.2:2.2);
xlabel({'$\frac{\psi(\mathcal{G}_{J,J})}{\phi(\mathcal{G}_{J,J})}$'}, 'FontSize', 20,'Interpreter','latex'); 
ylabel('Exact Recovery Rate', 'FontSize', 16); 
title({'(a)',''}, 'position', [0.1, 0.9], 'FontSize', 15);
legend({'SDP', 'GPM Algorithm 2', 'GPM Algorithm 3'}, 'FontSize', 9);
box on;

f = gcf;
set(f, 'Position',  [100, 100, 365, 340])

exportgraphics(f,strcat('comparison2_gpm.png'),'Resolution', 300)


figure; hold on;
plot(0.1:0.2:2.1, sdp_complete_selected_er_rates, '--_', 'LineWidth', 1.5, 'Color', [0.1 0.7 0.1]);
plot(0.1:0.2:2.1, gpm1_complete_selected_er_rates, '--^', 'LineWidth', 1.5, 'Color', [0.9 0.6 0.2]);
plot(0.1:0.2:2.1, gpm2_complete_selected_er_rates, '--x', 'LineWidth', 1.5, 'Color', [0.9 0.2 0.9]);
hold off;
ylim([0, 1]); xlim([0, 2.2]);
xticks(0:0.2:2.2);
xlabel({'$\frac{\psi(\mathcal{G}_{J,J})}{\phi(\mathcal{G}_{J,J})}$'}, 'FontSize', 20,'Interpreter','latex'); 
ylabel('Exact Recovery Rate', 'FontSize', 16); 
title({'(b)',''}, 'position', [0.1, 0.9], 'FontSize', 15);
legend({'SDP with completion', 'GPM Algorithm 2 with completion', 'GPM Algorithm 3 with completion'}, 'FontSize', 9);
box on;

f = gcf;
set(f, 'Position',  [100, 100, 365, 340])

exportgraphics(f,strcat('comparison2_gpm_completion.png'),'Resolution', 300)