* * * * - - - - Pejlemærker - - - - * * * *

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

parameter vis_kalibrering50;
vis_kalibrering50('CO2En_EloV','start') = CO2En_EloV.l;
vis_kalibrering50('CO2En_EloV','maal') = CO2En_EloV0 * 1749/11670;
vis_kalibrering50('CO2En_Vej_virk','start') = CO2En_Vej_virk.l;
vis_kalibrering50('CO2En_Vej_virk','maal') = CO2En_Vej_virk0 * 4069/5257;
vis_kalibrering50('CO2En_Vej_hh','start') = CO2En_Vej_hh.l;
vis_kalibrering50('CO2En_Vej_hh','maal') = CO2En_Vej_hh0 * 2994/6578;
vis_kalibrering50('CO2En_hh','start') = CO2En_hh.l;
vis_kalibrering50('CO2En_hh','maal') = CO2En_hh0 * 1022/2131;
vis_kalibrering50('CO2En_SeOff','start') = CO2En_SeOff.l;
vis_kalibrering50('CO2En_SeOff','maal') = CO2En_SeOff0 * 527/830;
vis_kalibrering50('CO2En_Fora','start') = CO2En_Fora.l;
vis_kalibrering50('CO2En_Fora','maal') = CO2En_Fora0 * 3642/3210;
vis_kalibrering50('CO2En_Lmv','start') = CO2En_Lmv.l;
vis_kalibrering50('CO2En_Lmv','maal') = CO2En_Lmv0 * 1207/1580;
vis_kalibrering50('CO2En_Luft','start') = CO2En_Luft.l;
vis_kalibrering50('CO2En_Luft','maal') = CO2En_Luft0 * 577/757;
vis_kalibrering50('CO2En_Jernb','start') = CO2En_Jernb.l;
vis_kalibrering50('CO2En_Jernb','maal') = 66;
vis_kalibrering50('CO2En_Soe','start') = CO2En_Soe.l;
vis_kalibrering50('CO2En_Soe','maal') = CO2En_Soe0 * 546/622;
vis_kalibrering50('CO2IEn_Cement','start') = CO2IEn_Cement.l;
vis_kalibrering50('CO2IEn_Cement','maal') = 1650;
vis_kalibrering50('CO2e_Veg','start') = CO2e_Veg.l;
vis_kalibrering50('CO2e_Veg','maal') = CO2e_Veg0*4026/4232;
vis_kalibrering50('CO2e_Kvaeg','start') = CO2e_Kvaeg.l;
vis_kalibrering50('CO2e_Kvaeg','maal') = CO2e_Kvaeg0*5024/4576;
vis_kalibrering50('CO2e_Svin','start') = CO2e_Svin.l;
vis_kalibrering50('CO2e_Svin','maal') = CO2e_Svin0*1503/1666;
vis_kalibrering50('CO2e_Fjerkraemv','start') = CO2e_Fjerkraemv.l;
vis_kalibrering50('CO2e_Fjerkraemv','maal') = CO2e_Fjerkraemv0*387/400;
vis_kalibrering50('CO2_Other','start') = CO2_Other.l;
vis_kalibrering50('CO2_Other','maal') = 524;
vis_kalibrering50('N2O_Other','start') = N2O_Other.l;
vis_kalibrering50('N2O_Other','maal') = 467;
vis_kalibrering50('Flour','start') = sum(j,Flour_J.l(j));
vis_kalibrering50('Flour','maal') = 110;
vis_kalibrering50('CO2eDK','start') = CO2eDK.l;
vis_kalibrering50('CO2eDK','maal') = 32354;


* * * * - - - - Endogen kalibrering - - - - * * * *

display gdp.l, gdpf0.l, tfptot.l;

GDPf0.fx = 3700;
TFPtot.lo = -inf;
TFPtot.up = inf;


Elproduktion_vind.fx = Elproduktion_vind0 * 3.6 *6.7/5.2;
TFP.lo('350010b') = -inf;
TFP.up('350010b') =  inf;
J_TFP.lo('350010b') = -inf;
J_TFP.up('350010b') =  inf;

Elproduktion_kraft.fx = Elproduktion_kraft0 * 0.4 * 5.2/6.7;
m_elvind.up = inf;
m_elvind.lo = -inf;

CH.fx('350010a') = CH0('350010a') * 0.4 * 5.2/6.7;
m_CH.lo('350010b') = -inf;
m_CH.up('350010b') = inf;

solve static_fremskriv using cns;

*display gdp.l, gdpf0.l, tfptot.l;


*Brændselssammensætning hos fjernvarmeværker

* Øget biomasseforbrug - mindsket gasforbrug

CO2En_EloV.fx = CO2En_EloV0 * 1749/11670;
m_KEel.lo('350030a') = -inf;
m_KEel.up('350030a') = inf;

solve static_fremskriv using cns;



* Udbredelse af ellastbiler hos virksomhederne
Display m_TTE_tot.l;
CO2En_Vej_virk.fx = CO2En_Vej_virk0 * 4069/5257;
m_TTE_tot.lo = -inf;
m_TTE_tot.up = inf;

solve static_fremskriv using cns;

* Udbredelse af elbiler, varmepumper og bionaturgas hos husholdningerne
Display m_CH.l, c_HH_GJ.l, CO2En_Vej_hh.l, CO2En_Vej_hh0;
m_CH.fx('ng') = m_CH.l('ng')*0.7;
solve static_fremskriv using cns;
m_CH.fx('ng') = m_CH.l('ng')*0.7;
solve static_fremskriv using cns;
*display CO2En_Vej_hh.l, CO2En_Vej_hh0, p.l;


CO2En_Vej_hh.fx = CO2En_Vej_hh0 * 2994/6578;
m_CH.lo('ng') = -inf;
m_CH.up('ng') = inf;

solve static_fremskriv using cns;
*Display m_CH.l, c_HH_GJ.l;


CO2En_hh.fx = CO2En_hh0 * 1022/2131;
m_CH.lo('neEL') = -inf;
m_CH.up('neEL') = inf;

solve static_fremskriv using cns;


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

solve static_fremskriv using cns;

* Tilbagegang i transportkapitalproduktiviteten i luftfart sænker emissionerne

thetaTKF.fx('51000a') = 0.5;
solve static_fremskriv using cns;

CO2En_Luft.fx = CO2En_Luft0 * 577/757;
thetaTKF.lo('51000a') = -inf;
thetaTKF.up('51000a') = inf;

solve static_fremskriv using cns;

* Elektrificering af jernbanenettet sænker emissionerne
Display m_KEel.l;

CO2En_Jernb.fx = 66;
m_KEel.lo('490012') = -inf;
m_KEel.up('490012') = inf;

solve static_fremskriv using cns;

* Elektrificering i skibsfart (forbrug af olieprodukter i international skibsfart) sænker emissionerne

CO2En_Soe.fx = CO2En_Soe0 * 546/622;
m_KEel.lo('50000b') = -inf;
m_KEel.up('50000b') = inf;

solve static_fremskriv using cns;


* For at ramme ikke-energirelaterede emissioner for cement og landbrug korrigeres emissionsparametrene knyttet dertil.
IeudledperKBpre('230020',udled_type) = IeudledperKBpre('230020',udled_type) * 1650/CO2IEn_Cement.l;
IeudledperKBpre('01000a',udled_type) = IeudledperKBpre('01000a',udled_type) * CO2e_Veg0*4026/4232/CO2e_Veg.l;
IeudledperKBpre('01000b',udled_type) = IeudledperKBpre('01000b',udled_type) * CO2e_Kvaeg0*5024/4576/CO2e_Kvaeg.l;
IeudledperKBpre('01000c',udled_type) = IeudledperKBpre('01000c',udled_type) * CO2e_Svin0*1503/1666/CO2e_Svin.l;
IeudledperKBpre('01000d',udled_type) = IeudledperKBpre('01000d',udled_type) * CO2e_Fjerkraemv0*387/400/CO2e_Fjerkraemv.l;

* For at ramme ikke-energirelaterede emissioner fra øvrige brancher korrigeres emissionsparametrene knyttet dertil.
scalar_Ieudled(j,'CO2')   $ d1IeudledType1(j,'CO2')   = scalar_Ieudled(j,'CO2')   * 524/CO2_Other.l;
scalar_Ieudled(j,'N2O')   $ d1IeudledType1(j,'N2O')   = scalar_Ieudled(j,'N2O')   * 467/N2O_Other.l;
scalar_Ieudled(j,'CH4')   $ d1IeudledType1(j,'CH4')   = scalar_Ieudled(j,'CH4')   * 641/CH4_Other.l;

*Samlede flour rammes ved at korrigere flour-udledninger fra øvrige brancher
scalar_Ieudled(j,'SF6')   $ d1IeudledType1(j,'SF6')   = scalar_Ieudled(j,'SF6')   * (110-sum(jj $ j_land(jj), Flour_J.l(jj)))/Flour_other.l;
scalar_Ieudled(j,'PFC')   $ d1IeudledType1(j,'PFC')   = scalar_Ieudled(j,'PFC')   * (110-sum(jj $ j_land(jj), Flour_J.l(jj)))/Flour_other.l;
scalar_Ieudled(j,'HFC')   $ d1IeudledType1(j,'HFC')   = scalar_Ieudled(j,'HFC')   * (110-sum(jj $ j_land(jj), Flour_J.l(jj)))/Flour_other.l;

solve static_fremskriv using cns;

*Samlet co2e rammes til slut ved at korrigere methan fra øvrige brancher


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

* * * * Rapportering * * * *


vis_kalibrering50('CO2En_EloV','start') = CO2En_EloV.l;
vis_kalibrering50('CO2En_EloV','maal') = CO2En_EloV0 * 1749/11670;
vis_kalibrering50('CO2En_Vej_virk','start') = CO2En_Vej_virk.l;
vis_kalibrering50('CO2En_Vej_virk','maal') = CO2En_Vej_virk0 * 4069/5257;
vis_kalibrering50('CO2En_Vej_hh','start') = CO2En_Vej_hh.l;
vis_kalibrering50('CO2En_Vej_hh','maal') = CO2En_Vej_hh0 * 2994/6578;
vis_kalibrering50('CO2En_hh','start') = CO2En_hh.l;
vis_kalibrering50('CO2En_hh','maal') = CO2En_hh0 * 1022/2131;
vis_kalibrering50('CO2En_SeOff','start') = CO2En_SeOff.l;
vis_kalibrering50('CO2En_SeOff','maal') = CO2En_SeOff0 * 527/830;
vis_kalibrering50('CO2En_Fora','start') = CO2En_Fora.l;
vis_kalibrering50('CO2En_Fora','maal') = CO2En_Fora0 * 3642/3210;
vis_kalibrering50('CO2En_Lmv','start') = CO2En_Lmv.l;
vis_kalibrering50('CO2En_Lmv','maal') = CO2En_Lmv0 * 1207/1580;
vis_kalibrering50('CO2En_Luft','start') = CO2En_Luft.l;
vis_kalibrering50('CO2En_Luft','maal') = CO2En_Luft0 * 577/757;
vis_kalibrering50('CO2En_Jernb','start') = CO2En_Jernb.l;
vis_kalibrering50('CO2En_Jernb','maal') = 66;
vis_kalibrering50('CO2En_Soe','start') = CO2En_Soe.l;
vis_kalibrering50('CO2En_Soe','maal') = CO2En_Soe0 * 546/622;
vis_kalibrering50('CO2IEn_Cement','start') = CO2IEn_Cement.l;
vis_kalibrering50('CO2IEn_Cement','maal') = 1650;
vis_kalibrering50('CO2e_Veg','start') = CO2e_Veg.l;
vis_kalibrering50('CO2e_Veg','maal') = CO2e_Veg0*4026/4232;
vis_kalibrering50('CO2e_Kvaeg','start') = CO2e_Kvaeg.l;
vis_kalibrering50('CO2e_Kvaeg','maal') = CO2e_Kvaeg0*5024/4576;
vis_kalibrering50('CO2e_Svin','start') = CO2e_Svin.l;
vis_kalibrering50('CO2e_Svin','maal') = CO2e_Svin0*1503/1666;
vis_kalibrering50('CO2e_Fjerkraemv','start') = CO2e_Fjerkraemv.l;
vis_kalibrering50('CO2e_Fjerkraemv','maal') = CO2e_Fjerkraemv0*387/400;
vis_kalibrering50('CO2_Other','start') = CO2_Other.l;
vis_kalibrering50('CO2_Other','maal') = 524;
vis_kalibrering50('N2O_Other','start') = N2O_Other.l;
vis_kalibrering50('N2O_Other','maal') = 467;
vis_kalibrering50('CH4_Other','start') = CH4_Other.l;
vis_kalibrering50('CH4_Other','maal') = 641;
vis_kalibrering50('Flour','start') = sum(j,Flour_J.l(j));
vis_kalibrering50('Flour','maal') = 110;
vis_kalibrering50('CO2eDK','start') = CO2eDK.l;
vis_kalibrering50('CO2eDK','maal') = 32354;
display vis_kalibrering50;

$include vis_andele.gms

display BoP.l, gdp.l, gdpf0.l;

execute_unload "gekko\gdx_work\Basis2050_endo.gdx";