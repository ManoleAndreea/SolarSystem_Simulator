sim_r=out.sim_r;
sim_v=out.sim_v;

t_vec=out.sim_time.Time;

t_target=88*24*3600; 
[~, idx]=min(abs(t_vec-t_target));

fprintf('Analizez starea la t = %.2f zile (Pasul %d)\n', t_vec(idx)/(24*3600), idx);
fprintf('Referinta: JPL Horizons (Solar System Barycenter - SSB)\n');

ref_Mercur_Pos=[-1.706432930225717E+07, -6.848672591527940E+07, -3.980214156516876E+06]*1000; 
ref_Mercur_Vel=[ 3.752771807753827E+01, -9.226156853173199E+00, -4.195245153231530E+00]*1000;

ref_Venus_Pos =[ 4.538368658256619E+07,  9.691008179660912E+07, -1.278989735327207E+06]*1000; 
ref_Venus_Vel =[-3.182092260744652E+01,  1.468795661197712E+01,  2.038267750768406E+00]*1000;

ref_Pamant_Pos=[-1.455888651609805E+08, -3.667989275198931E+07,  2.109510861743800E+04]*1000; 
ref_Pamant_Vel=[ 6.663042942415205E+00, -2.901968125557824E+01,  2.071260660716945E-03]*1000;

ref_Marte_Pos=[ 1.957397953599764E+08, -6.591694768876468E+07, -6.154983933567345E+06]*1000; 
ref_Marte_Vel=[ 8.573234536981886E+00,  2.506943136954045E+01,  3.151533144272669E-01]*1000;

ref_Jupiter_Pos=[-3.518022569631472E+08,  7.007621824162264E+08,  4.966389030585051E+06]*1000;
ref_Jupiter_Vel=[-1.183316338736374E+01, -5.244637847712607E+00,  2.865260689421798E-01]*1000;

ref_Saturn_Pos=[ 1.413362346205410E+09,  1.150557851461577E+08, -5.827482552189734E+07]*1000;
ref_Saturn_Vel=[-1.317184210585850E+00,  9.606639902718586E+00, -1.144998290037549E-01]*1000;

ref_Uranus_Pos=[ 1.429790914313633E+09,  2.537170895952241E+09, -9.100385135417342E+06]*1000;
ref_Uranus_Vel=[-5.983255843404665E+00,  3.025999964018266E+00,  8.882683521432666E-02]*1000;

ref_Neptun_Pos=[ 4.467093983859947E+09,  1.207261788614958E+08, -1.054348698466234E+08]*1000;
ref_Neptun_Vel=[-1.820704834020314E-01,  5.465251353179370E+00, -1.090384448309889E-01]*1000;

fprintf('\n--------------------------------------------------------------\n');
fprintf(' REZULTATE FINALE\n');
fprintf('--------------------------------------------------------------\n');
fprintf('| %-10s | %-16s | %-16s |\n', 'Corp', 'Err Poz [km]', 'Err Vit [m/s]');
fprintf('--------------------------------------------------------------\n');

ids=[2, 3, 4, 5, 6, 7, 8, 9]; 
names={'Mercur', 'Venus', 'Pamant', 'Marte', 'Jupiter', 'Saturn', 'Uranus', 'Neptun'};
refs_pos={ref_Mercur_Pos, ref_Venus_Pos, ref_Pamant_Pos, ref_Marte_Pos, ref_Jupiter_Pos, ref_Saturn_Pos, ref_Uranus_Pos, ref_Neptun_Pos};
refs_vel={ref_Mercur_Vel, ref_Venus_Vel, ref_Pamant_Vel, ref_Marte_Vel, ref_Jupiter_Vel, ref_Saturn_Vel, ref_Uranus_Vel, ref_Neptun_Vel};

total_pos_err=0;
count_valid=0;

for k=1:length(ids)
 
 
    r_sim_metri=squeeze(sim_r(ids(k), :, idx)); 
    v_sim_ms=squeeze(sim_v(ids(k), :, idx));
  
    r_sim_metri=reshape(r_sim_metri, 1, 3);
    v_sim_ms=reshape(v_sim_ms, 1, 3);
    
    r_nasa_metri=refs_pos{k}; 
    v_nasa_ms=refs_vel{k};
    
    err_pos_metri=norm(r_sim_metri-r_nasa_metri);
    err_vel_ms=norm(v_sim_ms-v_nasa_ms);
    
    fprintf('| %-10s | %16.2f | %16.2f |\n', names{k}, err_pos_metri/1000, err_vel_ms);
    
    total_pos_err=total_pos_err+err_pos_metri;
    count_valid=count_valid+1;
end
fprintf('--------------------------------------------------------------\n');


