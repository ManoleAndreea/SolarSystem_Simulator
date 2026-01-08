% mai intai trebuie sa rulam solar_system si simulink ca sa ne asiguram ca
% avem datele necesare pt a trasa graficele

sim_r=out.sim_r;
[~, ~, num_steps]=size(sim_r);
names={'Soare', 'Mercur', 'Venus', 'Pamant', 'Marte', 'Jupiter', 'Saturn', 'Uranus', 'Neptun'};
colors=[1.0, 0.9, 0.0; 0.7, 0.7, 0.7; 0.9, 0.8, 0.6; 0.2, 0.6, 1.0; 1.0, 0.4, 0.4; 0.9, 0.6, 0.3; 0.9, 0.8, 0.5; 0.4, 0.9, 0.9; 0.3, 0.4, 1.0];

figure('Name', 'Sistem Solar - High Speed', 'Color', 'k', 'Position', [50, 50, 1400, 700]);

points_limit=5000; % vom avea maxim 5000 de puncte pt fiecare traiectorie trasata
step_draw=max(1, floor(num_steps/points_limit)); 

subplot(1, 2, 1); hold on; grid on; axis equal;
set(gca, 'Color', 'k', 'XColor', [0.3 0.3 0.3], 'YColor', [0.3 0.3 0.3], 'ZColor', [0.3 0.3 0.3]);
title('Perspectiva 3D', 'Color', 'w'); view(3);
h_orbits_3d=gobjects(1, 9); h_planets_3d=gobjects(1, 9);
for i=1:9
    Xt=squeeze(sim_r(i, 1, :)); % squeeze ia matricea 3d si o face intr un vector 1d ca sa poata fi desenat
    Yt=squeeze(sim_r(i, 2, :)); 
    Zt=squeeze(sim_r(i, 3, :));
    h_orbits_3d(i)=plot3(Xt(1:step_draw:end), Yt(1:step_draw:end), Zt(1:step_draw:end), ':', 'Color', [colors(i,:) 0.4], 'LineWidth', 0.5);
    msize=6;
    if i==1
        msize=8; 
    end 
    h_planets_3d(i)=plot3(Xt(1), Yt(1), Zt(1), 'o', 'MarkerSize', msize, 'MarkerFaceColor', colors(i,:), 'MarkerEdgeColor', 'none');
end

subplot(1, 2, 2); hold on; grid on; axis equal;
set(gca, 'Color', 'k', 'XColor', [0.3 0.3 0.3], 'YColor', [0.3 0.3 0.3], 'ZColor', [0.3 0.3 0.3]);
title('Planul Ecliptic (Top View)', 'Color', 'w');
view(0, 90);
h_orbits_top=gobjects(1, 9);
h_planets_to =gobjects(1, 9);

for i=1:9
    Xt=squeeze(sim_r(i, 1, :)); 
    Yt=squeeze(sim_r(i, 2, :)); 
    Zt=squeeze(sim_r(i, 3, :));
    
    h_orbits_top(i)=plot3(Xt(1:step_draw:end), Yt(1:step_draw:end), Zt(1:step_draw:end),':', 'Color', [colors(i,:) 0.4], 'LineWidth', 0.5);
    
    msize=6;
    if i==1
        msize=8; 
    end 
    h_planets_top(i)=plot3(Xt(1), Yt(1), Zt(1), 'o', 'MarkerSize', msize, 'MarkerFaceColor', colors(i,:), 'MarkerEdgeColor', 'none');
end
legend(h_planets_top, names, 'TextColor', 'w', 'Color', 'none', 'EdgeColor', 'none', 'Location', 'northeast');


disp('Rulare...');
skip_step=200; 
for k=1:skip_step:num_steps
    for i=1:9
        x=sim_r(i, 1, k);
        y=sim_r(i, 2, k);
        z=sim_r(i, 3, k);
        set(h_planets_3d(i), 'XData', x, 'YData', y, 'ZData', z);
        set(h_planets_top(i), 'XData', x, 'YData', y, 'ZData', z);
    end
    days=(k*3600)/86400; 
    years=days/365.25;
    sgtitle(['Anul simulat: ', num2str(years, '%.1f')], 'Color', 'w', 'FontSize', 14);
    
    drawnow limitrate;
end
disp('Gata!');