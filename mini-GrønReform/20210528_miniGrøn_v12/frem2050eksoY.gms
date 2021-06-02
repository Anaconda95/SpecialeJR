display p.l;
* Yderligere eksogen nedjustering af fjernvarmeandelen fra kraftværker og affaldsforbrænding (for at undgå negative andele af fjervarme fra fjernvarmeværker)
$ontext
konstantKraft('490030a') = konstantKraft('490030a')*0.5;
konstantReno('490030a')  = konstantReno('490030a')*0.5;
konstantKraft('490030b') = konstantKraft('490030b')*0.25;
konstantReno('490030b')  = konstantReno('490030b')*0.25;
konstantKraft('50000a') = konstantKraft('50000a')*0.2;
konstantReno('50000a')  = konstantReno('50000a')*0.2;
konstantKraft('50000b') = konstantKraft('50000b')*0.25;
konstantReno('50000b')  = konstantReno('50000b')*0.25;
konstantKraft('51000a') = konstantKraft('51000a')*0.5;
konstantReno('51000a')  = konstantReno('51000a')*0.5;
konstantKraft('53000') = konstantKraft('53000')*0.5;
konstantReno('53000')  = konstantReno('53000')*0.5;
               350010b     490030a     490030b       53000

el_kraft      0.001343
FV_fjern                 -0.091126   -0.630331   -0.499713
FV_FjernVE               -0.002551   -0.017680   -0.012869
$offtext

konstantKraft('490030a') = konstantKraft('490030a')*0.5;
konstantReno('490030a')  = konstantReno('490030a')*0.5;
konstantKraft('490030b') = konstantKraft('490030b')*0.25;
konstantReno('490030b')  = konstantReno('490030b')*0.25;
konstantKraft('50000b') = konstantKraft('50000b')*0.5;
konstantReno('50000b')  = konstantReno('50000b')*0.5;
konstantKraft('53000') = konstantKraft('53000')*0.5;
konstantReno('53000')  = konstantReno('53000')*0.5;
* * * * * * * *
* Fremskrivning af eksogene parametre til 2050 med udgangspunkt i fremskriv_ekso2030
* * * * * * * *

* * * * * * Fremskrivning af befolkning, arbejdsstyrke og produktivitet * * * * * 

*Eksporten følger udviklingen i den indenlandske efterspørgsel. Det afspejler, at produktiviteten stiger lige så meget i udlandet som i DK.

display GDP.l, GDPf0.l;

d1UdlEftersp(j) = 1;
PF.lo(i) = -inf;
PF.up(i) = inf;


* Branchespecifik produktivitetsvækst
display thetaL.l;
thetaL.fx(j) = thetaL.l(j)*(1 + pvaekst(j)) ** (1/((L0(j) + Rest(j))/L0(j)))**20;
X0.fx(i) = X0.l(i)*1.005;
display thetaL.l;


solve static_fremskriv using cns;

display GDP.l, GDPf0.l;



*Fra DREAM:
*		2030	2050   (relativt til 2016)
*Befolkning 	1.062	1.109
*Arbejdsstyrke	1.085	1.147

N_Pop.fx = N_Pop.l * 1.109 / 1.062;
N_LabForce.fx = N_LabForce0 * 1.1;
X0.fx(i) = X0.l(i)*1.01;
solve static_fremskriv using cns;
display GDP.l, GDPf0.l;


N_LabForce.fx = N_LabForce0 * 1.12;
X0.fx(i) = X0.l(i)*1.02;
solve static_fremskriv using cns;
display GDP.l, GDPf0.l;


N_LabForce.fx = N_LabForce0 * 1.135;
X0.fx(i) = X0.l(i)*1.015;
solve static_fremskriv using cns;
display GDP.l, GDPf0.l;


N_LabForce.fx = N_LabForce0 * 1.147;
X0.fx(i) = X0.l(i)*1.01;
solve static_fremskriv using cns;
display GDP.l, GDPf0.l;
display p.l;


*Generel produktivitetsvækst sikrer eksogent niveau for BNP

*Fra DREAM:
*				2030	2050
*GDPf0				2610	3700


loop(loopstepGDPf0 $ (GDPf0.l lt 3700*0.98),
thetaL.fx(j) = thetaL.l(j) + 0.02; 
X0.fx(i)     = X0.l(i)*1.01;
X0.fx(i) $ (GDP.l LT GDPf0.l) = X0.l(i)*1.01;
solve static_fremskriv using cns;
Display GDPf0.l, GDP.l;
);

loop(loopstepPris $ (GDP.l LT GDPf0.l*0.95),
X0.fx(i) $ (GDP.l LT GDPf0.l*0.95) = X0.l(i)*1.005;
solve static_fremskriv using cns;
Display GDPf0.l, GDP.l;
);

loop(loopstepPris $ (GDP.l GT GDPf0.l*1.05),
X0.fx(i) $ (GDP.l GT GDPf0.l*1.05) = X0.l(i)*0.995;
solve static_fremskriv using cns;
Display GDPf0.l, GDP.l;
);

loop(loopstepGDPf0 $ (GDPf0.l lt 3700*0.995),
thetaL.fx(j) = thetaL.l(j) + 0.01; 
X0.fx(i)     = X0.l(i)*1.005;
X0.fx(i) $ (GDP.l LT GDPf0.l) = X0.l(i)*1.005;
solve static_fremskriv using cns;
Display GDPf0.l, GDP.l;
);

loop(loopstepPris $ (GDP.l LT GDPf0.l*0.98),
X0.fx(i) $ (GDP.l LT GDPf0.l*0.98) = X0.l(i)*1.001;
solve static_fremskriv using cns;
Display GDPf0.l, GDP.l;
);

loop(loopstepPris $ (GDP.l GT GDPf0.l*1.02),
X0.fx(i) $ (GDP.l GT GDPf0.l*1.02) = X0.l(i)*0.998;
solve static_fremskriv using cns;
Display GDPf0.l, GDP.l;
);


GDPf0.fx = 3700;

TFPtot.lo = -inf;
TFPtot.up = inf;

solve static_fremskriv using cns;

Display GDPf0.l, TFPtot.l, PE.l, PFV_energi.l;

GDPf0.lo = -inf;
GDPf0.up = inf;

TFPtot.fx = TFPtot.l;

* Eksport låses op og udlandspriser fixes igen
d1UdlEftersp(j) = 0;
PF.fx(j) = PF.l(j);


solve static_fremskriv using cns;

$include vis_andele.gms

display p.l, gdp.l, gdpf0.l;

