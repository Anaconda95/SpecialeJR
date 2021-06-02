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

* * * * * * * *

*GDPf0.lo = -inf;
*GDPf0.up =  inf;
*GDP.lo = -inf;
*GDP.up =  inf;

parameter 
m_elvindpre
m_elkraftpre
m_CHpre
TFPpre
m_ISB_energipre
m_H_energipre
m_T_energipre
m_KEelpre
m_TTE_totpre
m_KEel_servicepre
m_KEel_forarbpre
m_KEel_landbrugmvpre
thetaTKFpre
markuppre
NudledperKBprepre
adjX0pre
adjThetaLpre

m_elvindpost
m_elkraftpost
m_CHpost
TFPpost
m_ISB_energipost
m_H_energipost
m_T_energipost
m_KEelpost
m_TTE_totpost
m_KEel_servicepost
m_KEel_forarbpost
m_KEel_landbrugmvpost
thetaTKFpost
markuppost
NudledperKBprepost
adjX0post
adjThetaLpost
;

m_elvindpre = m_elvind.l;
m_elkraftpre = m_elkraft.l;
m_CHpre(dc) = m_CH.l(dc);
TFPpre(j) = TFP.l(j);
m_ISB_energipre(j) = m_ISB_energi.l(j);
m_H_energipre(j) = m_H_energi.l(j);
m_T_energipre(j) = m_T_energi.l(j);
m_KEelpre(j) = m_KEel.l(j);
m_TTE_totpre = m_TTE_tot.l;
m_KEel_servicepre = m_KEel_service.l;
m_KEel_forarbpre = m_KEel_forarb.l;
m_KEel_landbrugmvpre = m_KEel_landbrugmv.l;
thetaTKFpre(j) = thetaTKF.l(j);
markuppre(j) = markup.l(j);
NudledperKBprepre = NudledperKBpre.l;
adjX0pre = adjX0.l;
adjThetaLpre = adjThetaL.l;


parameter pre_share;
pre_share = 1;

Execute_loadpoint "2030endo.gdx";

m_elvindpost = m_elvind.l;
m_elkraftpost = m_elkraft.l;
m_CHpost(dc) = m_CH.l(dc);
TFPpost(j) = TFP.l(j);
m_ISB_energipost(j) = m_ISB_energi.l(j);
m_H_energipost(j) = m_H_energi.l(j);
m_T_energipost(j) = m_T_energi.l(j);
m_KEelpost(j) = m_KEel.l(j);
m_TTE_totpost = m_TTE_tot.l;
m_KEel_servicepost = m_KEel_service.l;
m_KEel_forarbpost = m_KEel_forarb.l;
m_KEel_landbrugmvpost = m_KEel_landbrugmv.l;
thetaTKFpost(j) = thetaTKF.l(j);
markuppost(j) = markup.l(j);
NudledperKBprepost = NudledperKBpre.l;
adjX0post = adjX0.l;
adjThetaLpost = adjThetaL.l;


set loopstepShare /1*50/;

loop(loopstepShare,

pre_share = pre_share - 0.02;

*TFPtot.fx      = TFPtotpre * pre_share + TFPtotpost * (1-pre_share);
m_elvind.fx  = m_elvindpre * pre_share + m_elvindpost * (1-pre_share);
m_elkraft.fx  = m_elkraftpre * pre_share + m_elkraftpost * (1-pre_share);
m_CH.fx('neELEL')  = m_CHpre('neELEL') * pre_share + m_CHpost('neELEL') * (1-pre_share);
m_CH.fx('ng')  = m_CHpre('ng') * pre_share + m_CHpost('ng') * (1-pre_share);
m_CH.fx('neGAS')  = m_CHpre('neGAS') * pre_share + m_CHpost('neGAS') * (1-pre_share);
m_CH.fx('350010b')  = m_CHpre('350010b') * pre_share + m_CHpost('350010b') * (1-pre_share);
TFP.fx('350010b')  = TFPpre('350010b') * pre_share + TFPpost('350010b') * (1-pre_share);
m_ISB_energi.fx('350010a')  = m_ISB_energipre('350010a') * pre_share + m_ISB_energipost('350010a') * (1-pre_share);
m_ISB_energi.fx('350030a')  = m_ISB_energipre('350030a') * pre_share + m_ISB_energipost('350030a') * (1-pre_share);
m_H_energi.fx('350010a')  = m_H_energipre('350010a') * pre_share + m_H_energipost('350010a') * (1-pre_share);
m_H_energi.fx('350030a')  = m_H_energipre('350030a') * pre_share + m_H_energipost('350030a') * (1-pre_share);
m_T_energi.fx('350010a')  = m_T_energipre('350010a') * pre_share + m_T_energipost('350010a') * (1-pre_share);
m_T_energi.fx('350030a')  = m_T_energipre('350030a') * pre_share + m_T_energipost('350030a') * (1-pre_share);
m_KEel.fx('350030a')  = m_KEelpre('350030a') * pre_share + m_KEelpost('350030a') * (1-pre_share);
m_KEel.fx('490012')  = m_KEelpre('490012') * pre_share + m_KEelpost('490012') * (1-pre_share);
*m_KEel.fx('50000b')  = m_KEelpre('50000b') * pre_share + m_KEelpost('50000b') * (1-pre_share);
m_KEel.fx('190000a')  = m_KEelpre('190000a') * pre_share + m_KEelpost('190000a') * (1-pre_share);
m_TTE_tot.fx  = m_TTE_totpre * pre_share + m_TTE_totpost * (1-pre_share);
m_KEel_service.fx  = m_KEel_servicepre * pre_share + m_KEel_servicepost * (1-pre_share);
m_KEel_forarb.fx  = m_KEel_forarbpre * pre_share + m_KEel_forarbpost * (1-pre_share);
m_KEel_landbrugmv.fx  = m_KEel_landbrugmvpre * pre_share + m_KEel_landbrugmvpost * (1-pre_share);
*thetaTKF.fx('51000a')  = thetaTKFpre('51000a') * pre_share + thetaTKFpost('51000a') * (1-pre_share);
markup.fx('060000a')  = markuppre('060000a') * pre_share + markuppost('060000a') * (1-pre_share);
markup.fx('060000b')  = markuppre('060000b') * pre_share + markuppost('060000b') * (1-pre_share);
NudledperKBpre.fx = NudledperKBprepre * pre_share + NudledperKBprepost * (1-pre_share);
*adjX0.fx  = adjX0pre * pre_share + adjX0post * (1-pre_share);
*adjThetaL.fx  = adjThetaLpre * pre_share + adjThetaLpost * (1-pre_share);

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


solve static_fremskriv using cns;
);


$ontext
loop(loopstepShare,

pre_share = pre_share - 0.7/30;


*TFPtot.fx      = TFPtotpre * pre_share + TFPtotpost * (1-pre_share);
m_elvind.fx  = m_elvindpre * pre_share + m_elvindpost * (1-pre_share);
m_elkraft.fx  = m_elkraftpre * pre_share + m_elkraftpost * (1-pre_share);
m_CH.fx('neELEL')  = m_CHpre('neELEL') * pre_share + m_CHpost('neELEL') * (1-pre_share);
m_CH.fx('ng')  = m_CHpre('ng') * pre_share + m_CHpost('ng') * (1-pre_share);
m_CH.fx('neGAS')  = m_CHpre('neGAS') * pre_share + m_CHpost('neGAS') * (1-pre_share);
m_CH.fx('350010b')  = m_CHpre('350010b') * pre_share + m_CHpost('350010b') * (1-pre_share);
TFP.fx('350010b')  = TFPpre('350010b') * pre_share + TFPpost('350010b') * (1-pre_share);
m_ISB_energi.fx('350010a')  = m_ISB_energipre('350010a') * pre_share + m_ISB_energipost('350010a') * (1-pre_share);
m_ISB_energi.fx('350030a')  = m_ISB_energipre('350030a') * pre_share + m_ISB_energipost('350030a') * (1-pre_share);
m_H_energi.fx('350010a')  = m_H_energipre('350010a') * pre_share + m_H_energipost('350010a') * (1-pre_share);
m_H_energi.fx('350030a')  = m_H_energipre('350030a') * pre_share + m_H_energipost('350030a') * (1-pre_share);
m_T_energi.fx('350010a')  = m_T_energipre('350010a') * pre_share + m_T_energipost('350010a') * (1-pre_share);
m_T_energi.fx('350030a')  = m_T_energipre('350030a') * pre_share + m_T_energipost('350030a') * (1-pre_share);
m_KEel.fx('350030a')  = m_KEelpre('350030a') * pre_share + m_KEelpost('350030a') * (1-pre_share);
m_KEel.fx('490012')  = m_KEelpre('490012') * pre_share + m_KEelpost('490012') * (1-pre_share);
*m_KEel.fx('50000b')  = m_KEelpre('50000b') * pre_share + m_KEelpost('50000b') * (1-pre_share);
m_KEel.fx('190000a')  = m_KEelpre('190000a') * pre_share + m_KEelpost('190000a') * (1-pre_share);
m_TTE_tot.fx  = m_TTE_totpre * pre_share + m_TTE_totpost * (1-pre_share);
m_KEel_service.fx  = m_KEel_servicepre * pre_share + m_KEel_servicepost * (1-pre_share);
m_KEel_forarb.fx  = m_KEel_forarbpre * pre_share + m_KEel_forarbpost * (1-pre_share);
m_KEel_landbrugmv.fx  = m_KEel_landbrugmvpre * pre_share + m_KEel_landbrugmvpost * (1-pre_share);
*thetaTKF.fx('51000a')  = thetaTKFpre('51000a') * pre_share + thetaTKFpost('51000a') * (1-pre_share);
markup.fx('060000a')  = markuppre('060000a') * pre_share + markuppost('060000a') * (1-pre_share);
markup.fx('060000b')  = markuppre('060000b') * pre_share + markuppost('060000b') * (1-pre_share);
NudledperKBpre.fx = NudledperKBprepre * pre_share + NudledperKBprepost * (1-pre_share);
*adjX0.fx  = adjX0pre * pre_share + adjX0post * (1-pre_share);
*adjThetaL.fx  = adjThetaLpre * pre_share + adjThetaLpost * (1-pre_share);

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


solve static_fremskriv using cns;
);
$ontext

loop(loopstepShare,

pre_share = pre_share - 0.4;

Execute_loadpoint "2030endo_fast.gdx";

TFPtot.fx      = TFPtotpre * pre_share + TFPtot.l * (1-pre_share);
m_elvind.fx  = m_elvindpre * pre_share + m_elvind.l * (1-pre_share);
m_elkraft.fx  = m_elkraftpre * pre_share + m_elkraft.l * (1-pre_share);
m_CH.fx('neELEL')  = m_CHpre('neELEL') * pre_share + m_CH.l('neELEL') * (1-pre_share);
m_CH.fx('ng')  = m_CHpre('ng') * pre_share + m_CH.l('ng') * (1-pre_share);
m_CH.fx('neGAS')  = m_CHpre('neGAS') * pre_share + m_CH.l('neGAS') * (1-pre_share);
TFP.fx('350010b')  = TFPpre('350010b') * pre_share + TFP.l('350010b') * (1-pre_share);
m_ISB_energi.fx('350010a')  = m_ISB_energipre('350010a') * pre_share + m_ISB_energi.l('350010a') * (1-pre_share);
m_ISB_energi.fx('350030a')  = m_ISB_energipre('350030a') * pre_share + m_ISB_energi.l('350030a') * (1-pre_share);
m_H_energi.fx('350010a')  = m_H_energipre('350010a') * pre_share + m_H_energi.l('350010a') * (1-pre_share);
m_H_energi.fx('350030a')  = m_H_energipre('350030a') * pre_share + m_H_energi.l('350030a') * (1-pre_share);
m_T_energi.fx('350010a')  = m_T_energipre('350010a') * pre_share + m_T_energi.l('350010a') * (1-pre_share);
m_T_energi.fx('350030a')  = m_T_energipre('350030a') * pre_share + m_T_energi.l('350030a') * (1-pre_share);
m_KEel.fx('350030a')  = m_KEelpre('350030a') * pre_share + m_KEel.l('350030a') * (1-pre_share);
m_KEel.fx('490012')  = m_KEelpre('490012') * pre_share + m_KEel.l('490012') * (1-pre_share);
m_KEel.fx('50000b')  = m_KEelpre('50000b') * pre_share + m_KEel.l('50000b') * (1-pre_share);
m_KEel.fx('190000a')  = m_KEelpre('190000a') * pre_share + m_KEel.l('190000a') * (1-pre_share);
m_TTE_tot.fx  = m_TTE_totpre * pre_share + m_TTE_tot.l * (1-pre_share);
m_KEel_service.fx  = m_KEel_servicepre * pre_share + m_KEel_service.l * (1-pre_share);
m_KEel_forarb.fx  = m_KEel_forarbpre * pre_share + m_KEel_forarb.l * (1-pre_share);
m_KEel_landbrugmv.fx  = m_KEel_landbrugmvpre * pre_share + m_KEel_landbrugmv.l * (1-pre_share);
thetaTKF.fx('51000a')  = thetaTKFpre('51000a') * pre_share + thetaTKF.l('51000a') * (1-pre_share);
markup.fx('060000a')  = markuppre('060000a') * pre_share + markup.l('060000a') * (1-pre_share);
markup.fx('060000b')  = markuppre('060000b') * pre_share + markup.l('060000b') * (1-pre_share);

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


solve static_fremskriv using cns;
);

*$ontext
pre_share = 0.25;

Execute_loadpoint "2030endo_fast.gdx";

TFPtot.fx      = TFPtotpre * pre_share + TFPtot.l * (1-pre_share);
m_elvind.fx  = m_elvindpre * pre_share + m_elvind.l * (1-pre_share);
m_elkraft.fx  = m_elkraftpre * pre_share + m_elkraft.l * (1-pre_share);
m_CH.fx('neELEL')  = m_CHpre('neELEL') * pre_share + m_CH.l('neELEL') * (1-pre_share);
m_CH.fx('ng')  = m_CHpre('ng') * pre_share + m_CH.l('ng') * (1-pre_share);
m_CH.fx('neGAS')  = m_CHpre('neGAS') * pre_share + m_CH.l('neGAS') * (1-pre_share);
TFP.fx('350010b')  = TFPpre('350010b') * pre_share + TFP.l('350010b') * (1-pre_share);
m_ISB_energi.fx('350010a')  = m_ISB_energipre('350010a') * pre_share + m_ISB_energi.l('350010a') * (1-pre_share);
m_ISB_energi.fx('350030a')  = m_ISB_energipre('350030a') * pre_share + m_ISB_energi.l('350030a') * (1-pre_share);
m_H_energi.fx('350010a')  = m_H_energipre('350010a') * pre_share + m_H_energi.l('350010a') * (1-pre_share);
m_H_energi.fx('350030a')  = m_H_energipre('350030a') * pre_share + m_H_energi.l('350030a') * (1-pre_share);
m_T_energi.fx('350010a')  = m_T_energipre('350010a') * pre_share + m_T_energi.l('350010a') * (1-pre_share);
m_T_energi.fx('350030a')  = m_T_energipre('350030a') * pre_share + m_T_energi.l('350030a') * (1-pre_share);
m_KEel.fx('350030a')  = m_KEelpre('350030a') * pre_share + m_KEel.l('350030a') * (1-pre_share);
m_KEel.fx('490012')  = m_KEelpre('490012') * pre_share + m_KEel.l('490012') * (1-pre_share);
m_KEel.fx('50000b')  = m_KEelpre('50000b') * pre_share + m_KEel.l('50000b') * (1-pre_share);
m_KEel.fx('190000a')  = m_KEelpre('190000a') * pre_share + m_KEel.l('190000a') * (1-pre_share);
m_TTE_tot.fx  = m_TTE_totpre * pre_share + m_TTE_tot.l * (1-pre_share);
m_KEel_service.fx  = m_KEel_servicepre * pre_share + m_KEel_service.l * (1-pre_share);
m_KEel_forarb.fx  = m_KEel_forarbpre * pre_share + m_KEel_forarb.l * (1-pre_share);
m_KEel_landbrugmv.fx  = m_KEel_landbrugmvpre * pre_share + m_KEel_landbrugmv.l * (1-pre_share);
thetaTKF.fx('51000a')  = thetaTKFpre('51000a') * pre_share + thetaTKF.l('51000a') * (1-pre_share);
markup.fx('060000a')  = markuppre('060000a') * pre_share + markup.l('060000a') * (1-pre_share);
markup.fx('060000b')  = markuppre('060000b') * pre_share + markup.l('060000b') * (1-pre_share);

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


solve static_fremskriv using cns;
$offtext


pre_share = 0;


*TFPtot.fx      = TFPtotpre * pre_share + TFPtotpost * (1-pre_share);
m_elvind.fx  = m_elvindpre * pre_share + m_elvindpost * (1-pre_share);
m_elkraft.fx  = m_elkraftpre * pre_share + m_elkraftpost * (1-pre_share);
m_CH.fx('neELEL')  = m_CHpre('neELEL') * pre_share + m_CHpost('neELEL') * (1-pre_share);
m_CH.fx('ng')  = m_CHpre('ng') * pre_share + m_CHpost('ng') * (1-pre_share);
m_CH.fx('neGAS')  = m_CHpre('neGAS') * pre_share + m_CHpost('neGAS') * (1-pre_share);
m_CH.fx('350010b')  = m_CHpre('350010b') * pre_share + m_CHpost('350010b') * (1-pre_share);
TFP.fx('350010b')  = TFPpre('350010b') * pre_share + TFPpost('350010b') * (1-pre_share);
m_ISB_energi.fx('350010a')  = m_ISB_energipre('350010a') * pre_share + m_ISB_energipost('350010a') * (1-pre_share);
m_ISB_energi.fx('350030a')  = m_ISB_energipre('350030a') * pre_share + m_ISB_energipost('350030a') * (1-pre_share);
m_H_energi.fx('350010a')  = m_H_energipre('350010a') * pre_share + m_H_energipost('350010a') * (1-pre_share);
m_H_energi.fx('350030a')  = m_H_energipre('350030a') * pre_share + m_H_energipost('350030a') * (1-pre_share);
m_T_energi.fx('350010a')  = m_T_energipre('350010a') * pre_share + m_T_energipost('350010a') * (1-pre_share);
m_T_energi.fx('350030a')  = m_T_energipre('350030a') * pre_share + m_T_energipost('350030a') * (1-pre_share);
m_KEel.fx('350030a')  = m_KEelpre('350030a') * pre_share + m_KEelpost('350030a') * (1-pre_share);
m_KEel.fx('490012')  = m_KEelpre('490012') * pre_share + m_KEelpost('490012') * (1-pre_share);
*m_KEel.fx('50000b')  = m_KEelpre('50000b') * pre_share + m_KEelpost('50000b') * (1-pre_share);
m_KEel.fx('190000a')  = m_KEelpre('190000a') * pre_share + m_KEelpost('190000a') * (1-pre_share);
m_TTE_tot.fx  = m_TTE_totpre * pre_share + m_TTE_totpost * (1-pre_share);
m_KEel_service.fx  = m_KEel_servicepre * pre_share + m_KEel_servicepost * (1-pre_share);
m_KEel_forarb.fx  = m_KEel_forarbpre * pre_share + m_KEel_forarbpost * (1-pre_share);
m_KEel_landbrugmv.fx  = m_KEel_landbrugmvpre * pre_share + m_KEel_landbrugmvpost * (1-pre_share);
*thetaTKF.fx('51000a')  = thetaTKFpre('51000a') * pre_share + thetaTKFpost('51000a') * (1-pre_share);
markup.fx('060000a')  = markuppre('060000a') * pre_share + markuppost('060000a') * (1-pre_share);
markup.fx('060000b')  = markuppre('060000b') * pre_share + markuppost('060000b') * (1-pre_share);
NudledperKBpre.fx = NudledperKBprepre * pre_share + NudledperKBprepost * (1-pre_share);
*adjX0.fx  = adjX0pre * pre_share + adjX0post * (1-pre_share);
*adjThetaL.fx  = adjThetaLpre * pre_share + adjThetaLpost * (1-pre_share);

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


solve static_fremskriv using cns;


