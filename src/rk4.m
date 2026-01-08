% mai intai rulam solar_system si simulink da?

h=600; % pasul de integrare: 600 secunde (10 minute)
zile_simulare=7; % orizont redus (1 saptamana)
t_final_rk=zile_simulare*24*3600; % in secunde ofc
steps=ceil(t_final_rk/h);

rk_r=zeros(N, 3, steps+1);
rk_v=zeros(N, 3, steps+1);
time_rk=zeros(1, steps+1);

rk_r(:,:,1)=r0; % pozitiile de start
rk_v(:,:,1)=v0; % vitezele de start
time_rk(1)=0;
disp(['Incepem integrarea RK4 (h=', num2str(h), 's) pentru ', num2str(zile_simulare), ' zile...']);
curr_r=r0;
curr_v=v0;

tic;
for k=1:steps
    % pasul 1: k1=f(t, y)
    k1_v=curr_v; % dr/dt=v
    k1_a=calcul_acceleratie(curr_r, m, g); % dv/dt=a
  
    % pasul 2: k2=f(t+h/2, y+h*k1/2)
    r2=curr_r+(h/2)*k1_v;
    v2=curr_v+(h/2)*k1_a;
    k2_v=v2;
    k2_a=calcul_acceleratie(r2, m, g);
        
    % pasul 3: k3=f(t+h/2, y+h*k2/2)
    r3=curr_r+(h/2)*k2_v;
    v3=curr_v+(h/2)*k2_a;
    k3_v=v3;
    k3_a=calcul_acceleratie(r3, m, g);
   
    % pasul 4: k4=f(t+h, y+h*k3)
    r4=curr_r+h*k3_v;
    v4=curr_v+h*k3_a;
    k4_v=v4;
    k4_a=calcul_acceleratie(r4, m, g);
    
    % calculam media ponderata
    curr_r=curr_r+(h/6)*(k1_v+2*k2_v+2*k3_v+k4_v);
    curr_v=curr_v+(h/6)*(k1_a+2*k2_a+2*k3_a+k4_a);
    
    % salvam rezultatul
    rk_r(:, :, k+1)=curr_r;
    rk_v(:, :, k+1)=curr_v;
    time_rk(k+1)=k*h;
end
elapsed=toc;
disp(['Integrare terminata in ', num2str(elapsed), ' secunde.']);

sim_r_data=out.sim_r; 
vect_timp_simulink=out.sim_time.Time;
figure('Name', 'Comparatie RK4 vs Simulink', 'Color', 'w');
hold on; grid on; axis equal;

% cautam datele date de simulink pana la 7 zile
limit_sim=find(vect_timp_simulink>=t_final_rk, 1);

plot3(squeeze(sim_r_data(4, 1, 1:limit_sim)), squeeze(sim_r_data(4, 2, 1:limit_sim)), squeeze(sim_r_data(4, 3, 1:limit_sim)), 'b-', 'LineWidth', 2, 'DisplayName', 'Simulink (ode45)');
plot3(squeeze(rk_r(4, 1, :)), squeeze(rk_r(4, 2, :)), squeeze(rk_r(4, 3, :)), 'r--', 'LineWidth', 1.5, 'DisplayName', 'RK4 Manual (h=600s)');
      
legend show;
title('Validare RK4: Orbita Pamantului (7 zile)');
xlabel('X [m]'); ylabel('Y [m]');
view(2); % Vedere de sus


fprintf('\ANALIZA COMPARATIVA DETALIATA\n');
fprintf('| %-10s | %-15s |\n', 'Planeta', 'Eroare Pozitie [km]');
fprintf('------------------------------------\n');

names={'Soare', 'Mercur', 'Venus', 'Pamant', 'Marte', 'Jupiter', 'Saturn', 'Uranus', 'Neptun'};

for i=1:N
    pos_sim=squeeze(sim_r_data(i, :, limit_sim))';
    pos_rk4=squeeze(rk_r(i, :, end))';
    eroare_m=norm(pos_sim-pos_rk4);
    eroare_km=eroare_m/1000;
    fprintf('| %-10s | %15.4e |\n', names{i}, eroare_km);
end
fprintf('------------------------------------\n');

function a=calcul_acceleratie(r, m, g)
    N=size(r, 1);
    a=zeros(N, 3);
    for i=1:N
        for j=1:N
            if i~=j
                r_ij=r(j,:)-r(i,:);
                dist=norm(r_ij);
                if dist>0
                    a(i,:)=a(i,:)+g*m(j)*(r_ij/(dist^3));
                end
            end
        end
    end
end
