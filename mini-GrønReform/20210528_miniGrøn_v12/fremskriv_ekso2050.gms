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


* * * *  * 

* Eksogenisering og fremskrivning af output fra Nordsøen

*Fra DREAM:
*	2030	2050
*Olie 	0.5948	0.0065
*Gas	0.7380	0.0002

*Nordsøproduktionen sænkes så meget som muligt...

display y.l, p.l;

*set loopstep6 /1*2/;

*loop(loopstep6,

*markup.fx('060000a') = markup.l('060000a')*1.05;
*markup.fx('060000b') = markup.l('060000b')*1.05;

*thetaL.fx('060000a') = thetaL.l('060000a')*0.95;
*thetaL.fx('060000b') = thetaL.l('060000b')*0.95;

$ontext
Y.fx('060000a') = Y.l('060000a')*0.95;
Y.fx('060000b') = Y.l('060000b')*0.95;
TFP.fx(j) = TFP.l(j);
J_TFP.lo(j) = -inf;
J_TFP.up(j) =  inf;
TFP.lo('060000a') = -inf;
TFP.up('060000a') = inf;
TFP.lo('060000b') = -inf;
TFP.up('060000b') = inf;

P.fx('060000a') = P.l('060000a');
P.fx('060000b') = P.l('060000b');
markup.lo('060000a') = -inf;
markup.up('060000a') = inf;
markup.lo('060000b') = -inf;
markup.up('060000b') = inf;
$offtext

*solve static_fremskriv using cns;

*Display markup.l, y.l, p.l;
*$include vis_andele.gms

*);



* Markups låses op og output eksogeniseres i Nordsøen
$ontext
markup.lo('060000a') = -inf;
markup.up('060000a') = inf;

markup.lo('060000b') = -inf;
markup.up('060000b') = inf;

Y.fx('060000a') = Y.l('060000a');
Y.fx('060000b') = Y.l('060000b');
$offtext
*Y.fx('060000a') = Y.l('060000a')*0.0065/0.5948;
*Y.fx('060000b') = Y.l('060000b')*0.0002/0.7380;

*solve static_fremskriv using cns;

* * * * * Verdensmarkedspriser på fossile brændsler * * * * * 

*Fra IEA:

*			2018	2030	2050
*			Råolie DKK2018/tønde
*Current Policies	430	701	992
*Stated Policies	430	556	745
*Sustainable Development430	392	354
*			Naturgas DKK2018/Mbtu
*Current Policies	48	56	69
*Stated Policies	48	51	62
*Sustainable Development48	47	47

*Eksporten holdes konstant for at afspejle uændret konkurrenceevne overfor omverdenen, hvilket er en approksimation af virkeligheden
*Bemærk at importen påvirkes, når udlandsprisen tilpasses

*Alternativ forklaring: Verdensmarkedspriser for fossile brændsler tilpasses. Det antages nettoeksporten fra alle andre brancher ikke påvirkes, 
*da en højere energipris påvirker udenlandske virksomheder lige så negativt som danske. 
*Nettoeksporten af dansk produceret energi kan dog godt stige, hvis udenlandske energipriser stiger som følge af en grønnere energipolitik i udlandet.

*NYTNYT Eksogen prisstigning og eksogen generel efterspørgselstilpasning ift. generelt prisniveau

$ontext

Ex.fx(j) = Ex.l(j);

Ex.up('060000a') = inf;
Ex.lo('060000a') = -inf;

Ex.up('190000a') = inf;
Ex.lo('190000a') = -inf;

*PF.up(j)$Ex.l(j) = inf;
*PF.lo(j)$Ex.l(j) = -inf;
X0.up(j)$Ex.l(j) = inf;
X0.lo(j)$Ex.l(j) = -inf;
X0.fx('060000a') = X0.l('060000a');
X0.fx('190000a') = X0.l('190000a');

$offtext


* Verdensmarkedspris på olie
Parameter PF_060000a_temp, PF_190000a_temp;
PF_060000a_temp = PF.l('060000a');
PF_190000a_temp = PF.l('190000a');

$ontext
set loopstepPF /1*9/;

loop(loopstepPF,
PF.fx('060000a') = PF.l('060000a')*(1+((745/430)/(556/430)-1)/10);
PF.fx('190000a') = PF.l('190000a')*(1+((745/430)/(556/430)-1)/10);
solve static_fremskriv using cns;
);
$offtext

PF.fx('060000a') = PF_060000a_temp*(745/430)/(556/430);
PF.fx('190000a') = PF_060000a_temp*(745/430)/(556/430);

solve static_fremskriv using cns;


display gdp.l, gdpf0.l;

* Verdensmarkedspris på naturgas
$ontext
Ex.up('350020a') = inf;
Ex.lo('350020a') = -inf;
$offtext

PF.fx('060000b') = PF.l('060000b')*(62/48)/(51/48);
PF.fx('350020a') = PF.l('350020a')*(62/48)/(51/48);

*X0.fx('060000b') = X0.l('060000b');
*X0.fx('350020a') = X0.l('350020a');

solve static_fremskriv using cns;

display gdp.l, gdpf0.l;

*PF.fx(j) = PF.l(j);

*Ex.up(j)$Ex.l(j) = inf;
*Ex.lo(j)$Ex.l(j) = -inf;

* * * *  * 
solve static_fremskriv using cns;

display BoP.l;
execute_unload "gekko\gdx_work\Basis2050_ekso.gdx";

$include vis_andele.gms

display X0.l, PF.l, gdp.l, gdpf0.l;