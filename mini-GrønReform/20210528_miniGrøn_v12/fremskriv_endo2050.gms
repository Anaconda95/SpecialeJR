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
display GDPf0.l;

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

GDPf0.fx = 3700;
TFPtot.lo = -inf;
TFPtot.up = inf;

Elproduktion_vind.l = Elproduktion_vind0 * 3.6 *6.7/5.2;
TFP.lo('350010b') = -inf;
TFP.up('350010b') =  inf;

Elproduktion_kraft.fx = Elproduktion_kraft0 * 0.4 * 5.2/6.7;
m_elvind.up = inf;
m_elvind.lo = -inf;

CH.fx('350010a') = CH0('350010a') * 0.4 * 5.2/6.7;
m_CH.lo('350010b') = -inf;
m_CH.up('350010b') = inf;

solve static_fremskriv using cns;

$exit

*Elproduktion_affald.fx = Elproduktion_affald0*0.4/1.4;
*m_elkraft.up = inf;
*m_elkraft.lo = -inf;

*CH.fx('383900') = CH0('383900')*0.4/1.4;
*m_CH.lo('neELEL') = -inf;
*m_CH.up('neELEL') = inf;

*Elproduktion_vind.fx = Elproduktion_vind0 * 3.6 * 63.5/32.8;
*s_Y.up('350010b') = inf;
*s_Y.lo('350010b') = -inf;

*Brændselssammensætning hos fjernvarmeværker

* Øget biomasseforbrug - mindsket gasforbrug
*Display m_KEel.l;

CO2En_EloV.fx = CO2En_EloV0 * 1749/11670;
m_KEel.lo('350030a') = -inf;
m_KEel.up('350030a') = inf;

*virker
* Bygningskapitalproduktiviteten tilpasses i cementindustrien, så de ikke-energirelaterede emissioner rammer 2030-pejlemærket
Display thetaB.l;

CO2IEn_Cement.fx = 1650;
thetaB.lo('230020') = -inf;
thetaB.up('230020') = inf;

* Bygningskapitalproduktiviteten tilpasses i landbruget, så de ikke-energirelaterede emissioner rammer 2030-pejlemærket

CO2e_Veg.fx = CO2e_Veg0*4026/4232;
thetaB.lo('01000a') = -inf;
thetaB.up('01000a') = inf;

CO2e_Kvaeg.fx = CO2e_Kvaeg0*5024/4576;
thetaB.lo('01000b') = -inf;
thetaB.up('01000b') = inf;

CO2e_Svin.fx = CO2e_Svin0*1503/1666;
thetaB.lo('01000c') = -inf;
thetaB.up('01000c') = inf;

*virker ikke her
CO2e_Fjerkraemv.fx = CO2e_Fjerkraemv0*387/400;
thetaB.lo('01000d') = -inf;
thetaB.up('01000d') = inf;

* Udbredelse af ellastbiler hos virksomhederne
Display m_TTE_tot.l;
CO2En_Vej_virk.fx = CO2En_Vej_virk0 * 4069/5257;
m_TTE_tot.lo = -inf;
m_TTE_tot.up = inf;

* Udbredelse af elbiler, varmepumper og bionaturgas hos husholdningerne
Display m_CH.l, c_HH_GJ.l;

CO2En_Vej_hh.fx = CO2En_Vej_hh0 * 2994/6578;
m_CH.lo('ng') = -inf;
m_CH.up('ng') = inf;

CO2En_hh.fx = CO2En_hh0 * 1022/2131;
m_CH.lo('neEL') = -inf;
m_CH.up('neEL') = inf;


* Elektrificering i serviceerhverv, industri og primære erhverv sænker emissionerne
Display m_KEel_service.l, m_KEel_forarb.l, m_KEel_landbrugmv.l;

CO2En_SeOff.fx = CO2En_SeOff0 * 527/830;
m_KEel_service.lo = -inf;
m_KEel_service.up = inf;

CO2En_Fora.fx = CO2En_Fora0 * 3642/3210;
m_KEel_forarb.lo = -inf;
m_KEel_forarb.up = inf;

CO2En_Lmv.fx = CO2En_Lmv0 * 1207/1580;
m_KEel_landbrugmv.lo = -inf;
m_KEel_landbrugmv.up = inf;

* Tilbagegang i transportkapitalproduktiviteten i luftfart sænker emissionerne

CO2En_Luft.fx = CO2En_Luft0 * 577/757;
thetaTKF.lo('51000a') = -inf;
thetaTKF.up('51000a') = inf;

* Elektrificering af jernbanenettet sænker emissionerne
Display m_KEel.l;

CO2En_Jernb.fx = 66;
m_KEel.lo('490012') = -inf;
m_KEel.up('490012') = inf;

* Elektrificering i skibsfart (forbrug af olieprodukter i international skibsfart) sænker emissionerne

CO2En_Soe.fx = CO2En_Soe0 * 546/622;
m_KEel.lo('50000b') = -inf;
m_KEel.up('50000b') = inf;

* Emissionskoefficienter for øvrige ikke-energirelaterede emissioner af CO2, N2O og Flour skalereres, så de samlede øvrige emissioner (energi+ikke-energi) rammer målet for 2030 
CO2_Other.fx = 524;
K_IE_CO2.up = inf;
K_IE_CO2.lo = -inf;

*CH4_Other.fx = 641;
*K_IE_CH4.up = inf;
*K_IE_CH4.lo = -inf;

N2O_Other.fx = 467;
K_IE_N2O.up = inf;
K_IE_N2O.lo = -inf;

Flour.fx = 110;
K_IE_Flour.up = inf;
K_IE_Flour.lo = -inf;

* Emissionskoefficienten for øvrige CH4-emissioner nedskaleres proportionalt, så de samlede emissioner rammer målet for 2030

*Kalibrering_dummyIE(j,'CO2') = 1;
*Kalibrering_dummyIE('230020','CO2') = 0;

Kalibrering_dummyIE(j,'CH4') = 1;
Kalibrering_dummyIE('01000a','CH4') = 0;
Kalibrering_dummyIE('01000b','CH4') = 0;
Kalibrering_dummyIE('01000c','CH4') = 0;
Kalibrering_dummyIE('01000d','CH4') = 0;

*Kalibrering_dummyIE(j,'N2O') = 1;
*Kalibrering_dummyIE('01000a','N2O') = 0;
*Kalibrering_dummyIE('01000b','N2O') = 0;
*Kalibrering_dummyIE('01000c','N2O') = 0;
*Kalibrering_dummyIE('01000d','N2O') = 0;

*Kalibrering_dummyIE(j,'SF6') = 1;
*Kalibrering_dummyIE(j,'PFC') = 1;
*Kalibrering_dummyIE(j,'HFC') = 1;

Kalibrering_dummyE(j,kilder,'CH4') = 1;
Kalibrering_dummyE('490030b','BogD','CH4') = 0;
Kalibrering_dummyE('50000b','BogD','CH4') = 0;
Kalibrering_dummyE('51000b','BogD','CH4') = 0;

*Kalibrering_dummyE(j,kilder,'N2O') = 1;
*Kalibrering_dummyE('490030b','BogD','N2O') = 0;
*Kalibrering_dummyE('50000b','BogD','N2O') = 0;
*Kalibrering_dummyE('51000b','BogD','N2O') = 0;

CO2eDK.fx = 32354;
Kalibrering.up = inf;
Kalibrering.lo = -inf;

* * * * *

display PFV_energi.lo;

PFV_energi.lo(j) $d1FV_e(j) = 0;
*PKE.lo(j) $ d1KE(j) = 0;

display PFV_energi.lo;
*$offtext

solve static_fremskriv using cns;

$include vis_andele.gms

solve static_fremskriv using cns;

* * * * *

*Endogene variable låses op, og eksogene fixes igen

fix ALL;
unfix ENDO;
unfix ENDO_NEW;
unfix ENDO_NEW2;
unfix ENDO_NEW3;
unfix ENDO_NEW4;
unfix ENDO_NEW5;

el_kraftandel.fx(j) $ (d1kraftandel0(j) EQ 1) = 0;

x_energi.fx(j,i) = x_energi.l(j,i);
x_energi.lo(j,i_e) = -inf;
x_energi.up(j,i_e) =  inf;
x_energi.lo(j,'190000a') = -inf;
x_energi.up(j,'190000a') =  inf;
x_energi.lo(j,'190000b') $ d1TB(j) = -inf;
x_energi.up(j,'190000b') $ d1TB(j) =  inf;
x_energi.lo(j,'industri') = -inf;
x_energi.up(j,'industri') =  inf;

m_CH.lo('ne') = -inf;
m_CH.up('ne') = inf;
m_CH.lo('neV') = -inf;
m_CH.up('neV') = inf;
m_CH.lo('neFV') = -inf;
m_CH.up('neFV') = inf;
m_CH.lo('neReno') = -inf;
m_CH.up('neReno') = inf;

m_CH.lo('350010a') = -inf;
m_CH.up('350010a') = inf;
m_CH.lo('350020a') = -inf;
m_CH.up('350020a') = inf;
m_CH.lo('350030a') = -inf;
m_CH.up('350030a') = inf;

TFP.lo(j) = -inf;
TFP.up(j) = inf;

include Nuller.gms
include Nuller2.gms
include NullerT.gms
include NullerL.gms
UdlEftersp.fx(i) $ (d1Ex(i) eq 0) = 0;
save;

j_PCH_i.lo('190000a') = -inf;
j_PCH_i.up('190000a') =  inf;
j_PCH_i.lo('350020a') = -inf;
j_PCH_i.up('350020a') =  inf;

EudledHH.fx(kilder,udled_type) $ (d1EudledHH(kilder,udled_type) EQ 0) = 0;
TR_EudledHH.fx(kilder,udled_type) $ (d1EudledHH(kilder,udled_type) EQ 0) = 0;

EVAir_HH.fx(kilder,udled_type) $ (d1EudledHH(kilder,udled_type) EQ 0) = 0;

HHEnergiGJ.fx(kilder) $ (d1HHEnergiGJ(kilder) EQ 0) = 0;
HHEnergiGJ.fx('kul') = HHEnergiGJ.l('kul');
HHEnergiGJ.fx('Halm') = HHEnergiGJ.l('Halm');
HHEnergiGJ.fx('Tpiller') = HHEnergiGJ.l('Tpiller');
HHEnergiGJ.fx('Tbra') = HHEnergiGJ.l('Tbra');

Parameter CO2kvoter_2050basis;

CO2kvoter_2050basis(j) = kvoteandel_2050basis(j)*(sum(kilder,Eudled.l(j,kilder,'CO2')) + Ieudled.l(j,'CO2'));

display BoP.l;
execute_unload "gekko\gdx_work\Basis2050_endo.gdx";

* * * * Rapportering * * * *

Display GDPf0.l, TFPtot.l;
Display m_elvind.l, m_elkraft.l;
Display m_CH.l, c_HH_GJ.l;
Display elproduktion_vind.l, elproduktion_kraft.l, elproduktion_affald.l, elnettoeksport.l;
Display m_BG_energi.l,m_ISB_energi.l;
Display FVXinklC.l, FVVEinklC.l, FVfossilinklC.l, HHEnergiGJ.l;
Display m_TTE.l,m_TTE_tot.l;
Display s_Y.l;
Display thetaL.l, thetaB.l, m_KEel.l;
Display m_KEel_service.l, m_KEel_forarb.l, m_KEel_landbrugmv.l;
Display Kalibrering.l;

Display CO2En_EloV.l, CO2En_Olier.l, CO2En_Indv.l, CO2En_Fora.l, CO2En_Luft.l, CO2En_Vej_hh.l,CO2En_Vej_virk.l, CO2En_Jernb.l, CO2En_Soe.l, CO2En_SeOff.l, CO2En_hh.l, CO2En_Lmv.l;
Display CO2IEn_Cement.l, CO2e_Veg.l, CO2e_Kvaeg.l, CO2e_Svin.l,CO2e_Fjerkraemv.l, CO2_Other.l, CH4_Other.l, N2O_Other.l, Flour.l;
Display CO2eDK.l;

$include vis_andele.gms