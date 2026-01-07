N=9; % numarul de corpuri 
m=zeros(1, N); % masele
r0=zeros(N, 3); % pozitiile initiale
v0=zeros(N, 3); % vitezele initiale

% pentru ca masa data de jpl horizons este aproximativa, o vom calcula prin
% relatia : M=GM(dat de NASA)/G(din cerinta).

gm_soare=132712440041.93938;
g=6.6743e-11;
m_soare=gm_soare*1e9/g; % inmultim cu 10^9 pentru ca gm e in km, iar g e in
% m.
r0(1,:)=[-4.535009730392948E+05, -8.276240601849944E+05, 1.959795032855688E+04]*1000;
% aici avem pozitiile X, Y si Z de la t0

v0(1,:)=[1.240375092325877E-02, 3.873975780199613E-04, -2.356885107264090E-04]*1000;
% aici avem vitezele VX, VY si VZ de la t0

% inmultim cu 1000 pentru ca noi avem distantele initiale in km, si
% vitezele in km/s, si le vrem in m.

% pe pozitia 1 vom avea datele pentru soare

gm_mercur=22031.86855;
m_mercur=gm_mercur*1e9/g;
r0(2,:)=[-1.725638476578435E+07, -6.847116336943071E+07, -3.967235543816123E+06]*1000;
v0(2,:)=[3.751067246681647E+01, -9.297052633695110E+00, -4.199349661701157E+00]*1000;

gm_venus=324858.592;
m_venus=gm_venus*1e9/g;
r0(3,:)=[2.758094804453601E+07, -1.059763879135754E+08, -3.042557781955853E+06]*1000;
v0(3,:)=[3.361486930895880E+01, 8.902510172636759E+00, -1.816786024333041E+00]*1000;

gm_pamant=398600.435436;
m_pamant=gm_pamant*1e9/g;
r0(4,:)=[-3.927646859820704E+07, 1.410593370461926E+08, 1.119207233132422E+04]*1000;
v0(4,:)=[-2.919513669277936E+01, -7.964631213612466E+00, 1.436626821936127E-03]*1000;

gm_marte=42828.375662;
m_marte=gm_marte*1e9/g;
r0(5,:)=[6.098833276565664E+07, -2.046615209852258E+08, -5.758544734869510E+06]*1000;
v0(5,:)=[2.412766725882330E+01, 9.075980874779180E+00, -4.013901140907534E-01]*1000;

gm_jupiter=126686531.900;
m_jupiter=gm_jupiter*1e9/g;
r0(6,:)=[-2.592743523725272E+08, 7.349316451797373E+08, 2.753995766984075E+06]*1000;
v0(6,:)=[-1.247741310139767E+01, -3.726637890871185E+00, 2.946698029909107E-01]*1000;

gm_saturn=37931206.234;
m_saturn=gm_saturn*1e9/g;
r0(7,:)=[1.421472382755634E+09, 4.189136386443628E+07, -5.732507555609393E+07]*1000;
v0(7,:)=[-8.163707792764154E-01, 9.634554989795502E+00, -1.351529553437127E-01]*1000;

gm_uranus=5793950.6103;
m_uranus=gm_uranus*1e9/g;
r0(8,:)=[1.475056352186085E+09, 2.513771282272994E+09, -9.773633874493241E+06]*1000;
v0(8,:)=[-5.923737733388961E+00, 3.129100045039781E+00, 8.844125683836435E-02]*1000;

gm_neptun=6835099.97;
m_neptun=gm_neptun*1e9/g;
r0(9,:)=[4.468290303502041E+09, 7.916612195644584E+07, -1.046065897679704E+08]*1000;
v0(9,:)=[-1.316384688834186E-01, 5.466271211561168E+00, -1.102415019415171E-01]*1000;

m=[m_soare, m_mercur, m_venus, m_pamant, m_marte, m_jupiter, m_saturn, m_uranus, m_neptun];

% pentru a simula sistemul solar pentru 88 zile vom avea timpul final:
t_final=58440*24*3600; % in secunde
