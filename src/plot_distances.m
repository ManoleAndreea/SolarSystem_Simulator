
sim_r=out.sim_r;
[~, ~, num_steps]=size(sim_r);

names={'Soare', 'Mercur', 'Venus', 'Pamant', 'Marte', 'Jupiter', 'Saturn', 'Uranus', 'Neptun'};
colors=[1.0, 0.9, 0.0; 0.7, 0.7, 0.7; 0.9, 0.8, 0.6; 0.2, 0.6, 1.0; 1.0, 0.4, 0.4; 0.9, 0.6, 0.3; 0.9, 0.8, 0.5; 0.4, 0.9, 0.9; 0.3, 0.4, 1.0];

time_seconds=(0:num_steps-1)*3600; 
% cream aici axa timpului, si presupunem ca o integrare a fost o ora
time_years=time_seconds/(365.25*24*3600);

sun_pos=squeeze(sim_r(1, :, :));% transforma o matrice in vector

figure('Name', 'Distanta fata de Soare (Cerinta 3)', 'Position', [100, 100, 1200, 800]);

subplot(2, 1, 1);
hold on; grid on;
set(gca, 'Color', 'w', 'XColor', 'k', 'YColor', 'k', 'FontSize', 10);
title('Distante - Planete Interioare (Mercur, Venus, Pamant, Marte)', 'Color', 'k', 'FontSize', 12);
ylabel('Distanta [Milioane km]', 'Color', 'k');
xlabel('Timp [Ani]', 'Color', 'k');

for i=2:5 % iau planetele cele mai apropiate de soare, adica mercur, venus, pamant si marte
    planet_pos=squeeze(sim_r(i, :, :));
    rel_pos=planet_pos-sun_pos; % formula pt vectoeul de pozitie relativa
    dist_m=sqrt(sum(rel_pos.^2, 1)); % calculam aici magnitudinea vectorului
    dist_Mkm=dist_m/1e9;
    plot(time_years, dist_Mkm, 'Color', colors(i,:), 'LineWidth', 1.5, 'DisplayName', names{i});
end
legend('show', 'Location', 'eastoutside', 'Color', 'none', 'TextColor', 'k');

subplot(2, 1, 2);
hold on; grid on;
set(gca, 'Color', 'w', 'XColor', 'k', 'YColor', 'k', 'FontSize', 10);
title('Distante - Giganti Gazosi (Jupiter, Saturn, Uranus, Neptun)', 'Color', 'k', 'FontSize', 12);
ylabel('Distanta [Miliarde km]', 'Color', 'k');
xlabel('Timp [Ani]', 'Color', 'k');

for i=6:9
    planet_pos=squeeze(sim_r(i, :, :));
    rel_pos=planet_pos-sun_pos;
    dist_m=sqrt(sum(rel_pos.^2, 1));
    dist_Gkm=dist_m/1e12;
    plot(time_years, dist_Gkm, 'Color', colors(i,:), 'LineWidth', 1.5, 'DisplayName', names{i});
end
legend('show', 'Location', 'eastoutside', 'Color', 'none', 'TextColor', 'k');

sgtitle('Variatia Distantei fata de Soare (Periheliu - Afeliu)', 'Color', 'k', 'FontSize', 16);