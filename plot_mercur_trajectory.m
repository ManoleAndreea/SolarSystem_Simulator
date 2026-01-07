sim_r=out.sim_r; %(bineinteles, mai intai rulam simulink...)
sim_time=out.sim_time;

r_mercur=squeeze(sim_r(2,:,:));
r_pamant=squeeze(sim_r(4,:,:));

% formula pt pozitia relativa (vector):
r_rel=r_mercur-r_pamant;

% calculam raza:
raza=sqrt(r_rel(1,:).^2+r_rel(2,:).^2+r_rel(3,:).^2);

% calculam coordonatele ecplitice:
lambda=atan2(r_rel(2,:), r_rel(1,:));
beta=asin(r_rel(3,:)./raza);

% am calculat lambda si beta in radieni, dar e mai usor de trasat graficul
% in grade, deci vom converti:
lambda_grade=rad2deg(lambda);
beta_grade=rad2deg(beta);

% pentru ca de la -180 la 180 se formeaza linii drepte, vom taia acele
% drepte
jump_threshold=300;
diff_lambda=abs(diff(lambda_grade));
jump_indices=find(diff_lambda>jump_threshold);

lambda_plot=lambda_grade;
beta_plot=beta_grade;

lambda_plot(jump_indices)=NaN;
beta_plot(jump_indices)=NaN;

figure('Name', 'Cerinta 4 - Miscare Retrograda Mercur', 'Color', 'w', 'Position', [100, 100, 1000, 600]);
plot(lambda_plot, beta_plot, 'b.-', 'LineWidth', 0.5, 'MarkerSize', 2);
grid on;
xlabel('Longitudine Ecliptica \lambda [grade]', 'FontSize', 12);
ylabel('Latitudine Ecliptica \beta [grade]', 'FontSize', 12);
title('Traiectoria Aparenta a lui Mercur vazuta de pe Pamant', 'FontSize', 14);


xlim([-180 180]);
ylim([-10 10]); 
yline(0, 'k--', 'Ecliptica');
disp('Grafic generat. Buclele observate reprezinta miscarea retrograda.');

% pentru ca avem 160 de ani de date, graficul e prea aglomerat.
% extragem doar primii 2 ani pentru a vedea clar buclele retrograde.

% 2 ani*365 zile*24 ore=17520 pasi 
pasi_zoom=18000; 
pasi_zoom=min(pasi_zoom, length(lambda_plot));
figure('Name', 'Cerinta 4 - Detaliu Retrogradare (2 Ani)', 'Color', 'w', 'Position', [100, 100, 1000, 600]);
plot(lambda_plot(1:pasi_zoom), beta_plot(1:pasi_zoom), 'b.-', 'LineWidth', 1, 'MarkerSize', 4);

grid on;
xlabel('Longitudine Ecliptica \lambda [grade]', 'FontSize', 12);
ylabel('Latitudine Ecliptica \beta [grade]', 'FontSize', 12);
title('Detaliu: Miscarea Retrograda a lui Mercur (Zoom 2 Ani)', 'FontSize', 14);

xlim([-180 180]);
ylim([-10 10]); 
yline(0, 'k--', 'Ecliptica');

text(-160, 8, 'Fiecare bucla = O perioada de retrogradare', 'Color', 'r', 'FontSize', 10);

