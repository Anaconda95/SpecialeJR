* * * * - - - - Pejlemærker - - - - * * * *

*Display Y.l, N_Pop.l, N_LabForce.l, GDPf0.l, GDP.l;
*Display CO2En_EloV.l, CO2En_Olier.l, CO2En_Indv.l, CO2En_Fora.l, CO2En_Luft.l, CO2En_Vej_hh.l,CO2En_Vej_virk.l, CO2En_Jernb.l, CO2En_Soe.l, CO2En_SeOff.l, CO2En_hh.l, CO2En_Lmv.l;
*Display CO2IEn_Cement.l, CO2e_Veg.l, CO2e_Kvaeg.l, CO2e_Svin.l,CO2e_Fjerkraemv.l, CO2_Other.l, CH4_Other.l, N2O_Other.l, Flour.l;
*Display CO2eDK.l;

*Energirelateret CO2 - bemærk at værdierne for 2016 ikke stemmer overens med modellens kalibrering. Derfor fremskrives alene væksten.
*			2016	2030	2050
*El og varme		11.670	1.699	1.749
*Olieraffinaderier	868	838	838
*Indvinding		1.329	1.058	676
*Forarbejdning		3.210	2.838	3.642
*Luftfart		757	737	577
*Vejtransport, hh	6.578	7.072	2.994
*Vejtransport, virk	5.257	5.418	4.069
*Jernbane		253	66	66
*Søfart			622	596	546
*Service og offentlig	830	587	527
*Husholdninger		2.131	1.168	1.022
*Landbrug mv.		1.580	1.309	1.207

*Ikke-energirelateret CO2		
*			2016	2030	2050
*Cementindustri		1.231	1.474	1.650

*Ikke-energirelateret CH4, N2O og flour

*			2016	2030	2050
*Vegetabilsk		4.232	4.047	4.026
*Kvæg			4.576	4.803	5.024
*Svin			1.666	1.364	1.503
*Fjerkræ, pelsdyr mv.	400	387	387

*Øvrig CO2		673	516	524
*Øvrig CH4		1.298	895	641
*Øvrig N2O		583	532	467
*Flour mm		623	110	110

*Indirekte		298	155	108

*CO2e fra dansk territorie i alt, ekskl. LULUCF
*			2016	2030	2050
*I alt			50.664	37.671	32.354


* * * * - - - - Endogen kalibrering - - - - * * * *

* * * * * *
display GDPf0.l, gdp.l;


$ontext
*Vi sætter el-kraft andelen til nul for brancher, hvor el-kraft andelen ellers bliver negativ
d1kraftandel0('350010b') = 1;
el_kraftandel.fx(j) $ (d1kraftandel0(j) EQ 1) = 0;

FV_kraftandel.fx(j) = FV_kraftandel.l(j);
J_FV_kraftandel.lo(j) = -inf;
J_FV_kraftandel.up(j) =  inf;
FV_renoandel.fx(j) = FV_renoandel.l(j);
J_FV_renoandel.lo(j) = -inf;
J_FV_renoandel.up(j) =  inf;


$include vis_andele.gms

solve static_fremskriv using cns;


display GDPf0.l;

$ontext
set loopstep9 /1*10/;

loop(loopstep9 $ (GDPf0.l lt 3700),
TFPtot.fx = TFPtot.l * 1.005;
*thetaL.fx(j) = thetaL.l(j) * 1.001;
solve static_fremskriv using cns;
$include vis_andele.gms
);

set loopstep10 /1*10/;

loop(loopstep10 $ (GDPf0.l gt 3700),
TFPtot.fx = TFPtot.l * 0.995;
*thetaL.fx(j) = thetaL.l(j) * 1.001;
solve static_fremskriv using cns;
$include vis_andele.gms
);

display GDPf0.l;
$offtext
*$exit

*$ontext
* Udbygning af vind og sol, biogas og elbaseret fjernvarme, nedskalering af kraftvarme og fastholdelse af affald
* Udvikling baseret på Balmoral-kørsler fra Ea Energianalyse

*Elproduktion
Display elproduktion_vind.l, elproduktion_kraft.l, elproduktion_affald.l, elnettoeksport.l;

Display m_elvind.l, m_elkraft.l, s_Y.l;


set loopstepVind2 /1*5/;

loop(loopstepVind2,

m_elvind.fx  $ (Elproduktion_kraft.l GT Elproduktion_kraft0*0.4* 5.2/6.7) = m_elvind.l + 0.03;
m_elkraft.fx $ (Elproduktion_kraft.l GT Elproduktion_kraft0*0.4* 5.2/6.7) = m_elkraft.l - 0.01;
m_CH.fx('350010b') $ (CH.l('350010a') GT CH0('350010a')*0.4 * 5.2/6.7)   = m_CH.l('350010b') + 0.02;
solve static_fremskriv using cns;

*s_Y.fx('350010b') $ (Elproduktion_vind.l LT Elproduktion_vind0 * 3.6) = s_Y.l('350010b') + 0.01;
TFP.fx('350010b')   $ (Elproduktion_vind.l LT Elproduktion_vind0 * 3.6 *6.7/5.2) = TFP.l('350010b') * 1.01;
J_TFP.lo('350010b') $ (Elproduktion_vind.l LT Elproduktion_vind0 * 3.6 *6.7/5.2) = -inf;
J_TFP.up('350010b') $ (Elproduktion_vind.l LT Elproduktion_vind0 * 3.6 *6.7/5.2) =  inf;
solve static_fremskriv using cns;

*thetaL.fx(j) $ (GDPf0.l lt 2610) = thetaL.l(j) + 0.02; 
*solve static_fremskriv using cns;

$include vis_andele.gms
);


loop(loopstepPris $ (GDP.l LT GDPf0.l*0.9),
X0.fx(i) $ (GDP.l LT GDPf0.l*0.9) = X0.l(i)*1.01;
solve static_fremskriv using cns;
Display GDPf0.l, GDP.l;
);

loop(loopstepPris $ (GDP.l GT GDPf0.l*1.2),
X0.fx(i) $ (GDP.l GT GDPf0.l*1.2) = X0.l(i)*0.98;
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



display gdp.l, gdpf0.l;





