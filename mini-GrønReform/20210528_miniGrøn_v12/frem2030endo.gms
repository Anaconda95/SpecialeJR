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


Parameter vis_kalibreringMakro, vis_kalibreringCO2e;
Parameter korrektionCO2eTot;
* Hvis CO2eDK skal op, skal korrektionCO2eTot op
korrektionCO2eTot = 0.0050;


vis_kalibreringMakro('GDPf0','start') = GDPf0.l;
vis_kalibreringMakro('GDPf0','maal') = 2610;
vis_kalibreringMakro('elkraft','start') = Elproduktion_kraft.l;
vis_kalibreringMakro('elkraft','maal') = Elproduktion_kraft0 * 0.4;
vis_kalibreringMakro('elkraftHH','start') = CH.l('350010a');
vis_kalibreringMakro('elkraftHH','maal') = CH0('350010a')*0.4;
vis_kalibreringMakro('elaffald','start') = Elproduktion_affald.l;
vis_kalibreringMakro('elaffald','maal') = Elproduktion_affald0;
vis_kalibreringMakro('affaldHH','start') = CH.l('383900');
vis_kalibreringMakro('affaldHH','maal') = CH0('383900');
vis_kalibreringMakro('elvind','start') = Elproduktion_vind.l;
vis_kalibreringMakro('elvind','maal') = Elproduktion_vind0 * 3.6;
vis_kalibreringMakro('Tpillerel','start') = EnergiGJ.l('350010a','Tpiller');
vis_kalibreringMakro('Tpillerel','maal') = 0.0314;
vis_kalibreringMakro('Halmel','start') = EnergiGJ.l('350010a','Halm');
vis_kalibreringMakro('Halmel','maal') = 0.0066;
vis_kalibreringMakro('Tbrael','start') = EnergiGJ.l('350010a','Tbra');
vis_kalibreringMakro('Tbrael','maal') = 0.0334;
vis_kalibreringCO2e('CO2En_EloV','start') = CO2En_EloV.l;
vis_kalibreringCO2e('CO2En_EloV','maal') = CO2En_EloV0 * 1699/11670 * (1+korrektionCO2eTot);
vis_kalibreringMakro('TpillerReno','start') = EnergiGJ.l('350030a','Tpiller');
vis_kalibreringMakro('TpillerReno','maal') = 0.0012;
vis_kalibreringMakro('HalmReno','start') = EnergiGJ.l('350030a','Halm');
vis_kalibreringMakro('HalmReno','maal') = 0.0065;
vis_kalibreringMakro('TbraReno','start') = EnergiGJ.l('350030a','Tbra');
vis_kalibreringMakro('TbraReno','maal') = 0.0162;
vis_kalibreringMakro('BG_GJ_inklC','start') = BG_GJ_inklC.l;
vis_kalibreringMakro('BG_GJ_inklC','maal') = BG_GJ_inklC0 * 3.3;
vis_kalibreringCO2e('CO2IEn_Cement','start') = CO2IEn_Cement.l;
vis_kalibreringCO2e('CO2IEn_Cement','maal') = 1474;
vis_kalibreringCO2e('CO2e_Veg','start') = CO2e_Veg.l;
vis_kalibreringCO2e('CO2e_Veg','maal') = CO2e_Veg0*4047/4232 * (1+korrektionCO2eTot);
vis_kalibreringCO2e('CO2e_Kvaeg','start') = CO2e_Kvaeg.l;
vis_kalibreringCO2e('CO2e_Kvaeg','maal') = CO2e_Kvaeg0*4803/4576 * (1+korrektionCO2eTot);
vis_kalibreringCO2e('CO2e_Svin','start') = CO2e_Svin.l;
vis_kalibreringCO2e('CO2e_Svin','maal') = CO2e_Svin0*1364/1666 * (1+korrektionCO2eTot);
vis_kalibreringCO2e('CO2e_Fjerkraemv','start') = CO2e_Fjerkraemv.l;
vis_kalibreringCO2e('CO2e_Fjerkraemv','maal') = CO2e_Fjerkraemv0*387/400 * (1+korrektionCO2eTot);
vis_kalibreringCO2e('CO2En_Vej_virk','start') = CO2En_Vej_virk.l;
vis_kalibreringCO2e('CO2En_Vej_virk','maal') = CO2En_Vej_virk0 * 5418/5257 * (1+korrektionCO2eTot);
vis_kalibreringCO2e('CO2En_Vej_hh','start') = CO2En_Vej_hh.l;
vis_kalibreringCO2e('CO2En_Vej_hh','maal') = CO2En_Vej_hh0 * 7072/6578 * (1+korrektionCO2eTot);
vis_kalibreringMakro('olie','start') = HHEnergiGJ.l('Olie');
vis_kalibreringMakro('olie','maal') = HHEnergiGJ0('Olie')*0.34;
vis_kalibreringMakro('el','start') = HHEnergiGJ.l('el');
vis_kalibreringMakro('el','maal') = HHEnergiGJ0('el')*1.11;
vis_kalibreringCO2e('CO2En_hh','start') = CO2En_hh.l;
vis_kalibreringCO2e('CO2En_hh','maal') = CO2En_hh0 * 1168/2131 * (1+korrektionCO2eTot);
vis_kalibreringMakro('Biogas','start') = HHEnergiGJ.l('Biogas');
vis_kalibreringMakro('Biogas','maal') = HHEnergiGJ0('Biogas')*0.0071;
vis_kalibreringMakro('olie','start') = HHEnergiGJ.l('Olie');
vis_kalibreringMakro('olie','maal') = HHEnergiGJ0('Olie')*0.34;
vis_kalibreringMakro('olie','start') = HHEnergiGJ.l('Olie');
vis_kalibreringMakro('olie','maal') = HHEnergiGJ0('Olie')*0.34;
vis_kalibreringCO2e('CO2En_SeOff','start') = CO2En_SeOff.l;
vis_kalibreringCO2e('CO2En_SeOff','maal') = CO2En_SeOff0 * 587/830 * (1+korrektionCO2eTot);
vis_kalibreringCO2e('CO2En_Fora','start') = CO2En_Fora.l;
vis_kalibreringCO2e('CO2En_Fora','maal') = CO2En_Fora0 * 2838/3210 * (1+korrektionCO2eTot);
vis_kalibreringCO2e('CO2En_Lmv','start') = CO2En_Lmv.l;
vis_kalibreringCO2e('CO2En_Lmv','maal') = CO2En_Lmv0 * 1309/1580 * (1+korrektionCO2eTot);
vis_kalibreringCO2e('CO2En_Luft','start') = CO2En_Luft.l;
vis_kalibreringCO2e('CO2En_Luft','maal') = CO2En_Luft0 * 737/757 * (1+korrektionCO2eTot);
vis_kalibreringCO2e('CO2En_Jernb','start') = CO2En_Jernb.l;
vis_kalibreringCO2e('CO2En_Jernb','maal') = 66 * (1+korrektionCO2eTot);
vis_kalibreringCO2e('CO2En_Soe','start') = CO2En_Soe.l;
vis_kalibreringCO2e('CO2En_Soe','maal') = CO2En_Soe0 * 596/622 * (1+korrektionCO2eTot);
vis_kalibreringCO2e('CO2_Other','start') = CO2_Other.l;
vis_kalibreringCO2e('CO2_Other','maal') = 516;
vis_kalibreringCO2e('N2O_Other','start') = N2O_Other.l;
vis_kalibreringCO2e('N2O_Other','maal') = 532;
vis_kalibreringCO2e('CH4_Other','start') = CH4_Other.l;
vis_kalibreringCO2e('CH4_Other','maal') = 895;
vis_kalibreringCO2e('Flour','start') = sum(j,Flour_J.l(j));
vis_kalibreringCO2e('Flour','maal') = 110;
vis_kalibreringCO2e('CO2eDK','start') = CO2eDK.l;
vis_kalibreringCO2e('CO2eDK','maal') = 37671;

display vis_kalibreringMakro, vis_kalibreringCO2e;


* CO2e-udledninger, som følger den samme relative ændring (men ikke de samme faktiske værdier) som statistikken skal korrigeres op med 2 pct. for at ramme det samlede faktiske tal.



*Startværdier for kalibreringen sker i frem2030endo1.gms


* * * * * Herfra sker den endogene kalibrering * * * * * 


* BNP i løbende og faste priser rammes igen

GDPf0.fx = sigteGDP;
adjThetaL.lo =  -inf;
adjThetaL.up =   inf;

GDP.fx = sigteGDP;
adjX0.lo =  -inf;
adjX0.up =   inf;

* Udbygning af vind og sol, biogas og elbaseret fjernvarme, nedskalering af kraftvarme og fastholdelse af affald

*Elproduktion

Elproduktion_kraft.fx = Elproduktion_kraft0 * 0.4;
m_elvind.up = inf;
m_elvind.lo = -inf;

Elproduktion_affald.fx = Elproduktion_affald0;
m_elkraft.up = inf;
m_elkraft.lo = -inf;

CH.fx('383900') = CH0('383900');
m_CH.lo('neELEL') = -inf;
m_CH.up('neELEL') = inf;

Elproduktion_vind.fx = Elproduktion_vind0 * 3.6;
TFP.lo('350010b') = -inf;
TFP.up('350010b') =  inf;



*Brændselssammensætning hos kraftvarmeværker

* Øget biomasseforbrug - mindsket gasforbrug
EnergiGJ.fx('350010a','Tpiller') = 0.0314;
m_ISB_energi.up('350010a') = inf;
m_ISB_energi.lo('350010a') = -inf;

EnergiGJ.fx('350010a','Halm') = 0.0066;
m_H_energi.up('350010a') = inf;
m_H_energi.lo('350010a') = -inf;

EnergiGJ.fx('350010a','Tbra') = 0.0334;
m_T_energi.up('350010a') = inf;
m_T_energi.lo('350010a') = -inf;


* Samlede udledninger fra el og varme er blevet presset for langt ned via elektrificering af fjernvarme og skift til biomasse i kraftvarmeværker
* Udledningerne presses lidt op igen via en smule tilbagerulning af elektrificeringen og mere gas i kraftvarmeværkerne


CO2En_EloV.fx = CO2En_EloV0 * 1699/11670 * (1+korrektionCO2eTot);
m_KEel.lo('350030a') = -inf;
m_KEel.up('350030a') = inf;


*Brændselssammensætning hos fjernvarmeværker

* Øget biomasseforbrug - mindsket gasforbrug - mindre elektrificering for at holde co2-niveauet


EnergiGJ.fx('350030a','Tpiller') = 0.0012;
m_ISB_energi.up('350030a') = inf;
m_ISB_energi.lo('350030a') = -inf;

EnergiGJ.fx('350030a','Halm') = 0.0065;
m_H_energi.up('350030a') = inf;
m_H_energi.lo('350030a') = -inf;

EnergiGJ.fx('350030a','Tbra') = 0.0162;
m_T_energi.up('350030a') = inf;
m_T_energi.lo('350030a') = -inf;

*Kvælstofudledninger
Nudled.fx = Nudled0;
NudledperKBpre.lo = -inf;
NudledperKBpre.up =  inf;

*Biogas



* Udbredelse af ellastbiler hos virksomhederne
CO2En_Vej_virk.fx = CO2En_Vej_virk0 * 5418/5257 * (1+korrektionCO2eTot);
m_TTE_tot.lo = -inf;
m_TTE_tot.up = inf;


* Udbredelse af elbiler, varmepumper og bionaturgas hos husholdningerne
* Andelsparametre i forbrugsfunktionen tilpasses til mængder fra basisfremskrivningen - mængden af fjernvarme bestemmes residualt. 

CO2En_Vej_hh.fx = CO2En_Vej_hh0 * 7072/6578 * (1+korrektionCO2eTot);
m_CH.lo('ng') = -inf;
m_CH.up('ng') = inf;

*HHEnergiGJ.fx('Olie') = HHEnergiGJ0('Olie')*0.34;
*c_Olieandel.lo = -inf;
*c_Olieandel.up = inf;

*HHEnergiGJ.fx('El') = HHEnergiGJ0('El')*1.11;
*m_CH.lo('neEL') = -inf;
*m_CH.up('neEL') = inf;

CO2En_hh.fx = CO2En_hh0 * 1168/2131 * (1+korrektionCO2eTot);
m_CH.lo('neGAS') = -inf;
m_CH.up('neGAS') = inf;

*CH.fx('350010a') = CH0('350010a')*0.48;
CH.fx('350010a') = CH0('350010a')*0.4;
m_CH.lo('350010b') = -inf;
m_CH.up('350010b') = inf;


* Elektrificering i serviceerhverv, industri og primære erhverv sænker emissionerne

CO2En_SeOff.fx = CO2En_SeOff0 * 587/830 * (1+korrektionCO2eTot);
m_KEel_service.lo = -inf;
m_KEel_service.up = inf;

CO2En_Fora.fx = CO2En_Fora0 * 2838/3210 * (1+korrektionCO2eTot);
m_KEel_forarb.lo = -inf;
m_KEel_forarb.up = inf;

CO2En_Lmv.fx = CO2En_Lmv0 * 1309/1580 * (1+korrektionCO2eTot);
m_KEel_landbrugmv.lo = -inf;
m_KEel_landbrugmv.up = inf;


* Tilbagegang i transportkapitalproduktiviteten i luftfart sænker emissionerne
*display thetaTKF.l;

*CO2En_Luft.fx = CO2En_Luft0 * 737/757 * (1+korrektionCO2eTot);
*thetaTKF.lo('51000a') = -inf;
*thetaTKF.up('51000a') = inf;
*thetaKMfo.fx('51000a') = 1.05;

* Elektrificering af jernbanenettet sænker emissionerne

CO2En_Jernb.fx = CO2En_Jernb0 * 66/253 * (1+korrektionCO2eTot);
m_KEel.lo('490012') = -inf;
m_KEel.up('490012') = inf;

* Elektrificering i skibsfart (forbrug af olieprodukter i international skibsfart) sænker emissionerne

*CO2En_Soe.fx = CO2En_Soe0 * 596/622 * (1+korrektionCO2eTot);
*m_KEel.lo('50000b') = -inf;
*m_KEel.up('50000b') = inf;
*thetaKMfo.fx('50000b') = 1.05;

solve static_fremskriv using cns;
* Udledninger fra Nordsøen rammes (energiudledninger fra "kilde" og MLF fra modellen) ved at lade markup'en være fri (I ekso rammes Y via markup'erne. Her skifter vi rundt, så udledningerne rammes i stedet for. I fremskrivningen er det igen Y, der holdes fast)
CO2En_exBoD.fx('060000a') = CO2En_Nordsoe0 * 1058/1329 * (1+korrektionCO2eTot) * CO2e.l('060000a')/(CO2e.l('060000a')+CO2e.l('060000b'));
CO2En_exBoD.fx('060000b') = CO2En_Nordsoe0 * 1058/1329 * (1+korrektionCO2eTot) * CO2e.l('060000b')/(CO2e.l('060000a')+CO2e.l('060000b'));
markup.lo('060000a') = -inf;
markup.up('060000a') =  inf;
markup.lo('060000b') = -inf;
markup.up('060000b') =  inf;


*Udledninger fra raffinaderier 
CO2En_Raf.fx  = CO2En_Raf0 * 838/868 * (1+korrektionCO2eTot);
m_KEel.lo('190000a') = -inf;
m_KEel.up('190000a') = inf;


solve static_fremskriv using cns;

*thetaKMfo.fx('50000b') = 1.1;
*thetaKMfo.fx('51000a') = 1.1;


*solve static_fremskriv using cns;

*Tilpasning af prisniveau via udlandets eftersrpøgsel
*GDP.fx = GDPf0.l;




* For at ramme ikke-energirelaterede emissioner for cement og landbrug korrigeres emissionsparametrene knyttet dertil.
IeudledperKBpre('230020',udled_type) = IeudledperKBpre('230020',udled_type) * 1474/CO2IEn_Cement.l;
IeudledperKBpre('01000a',udled_type) = IeudledperKBpre('01000a',udled_type) * CO2e_Veg0*4047/4232* (1+korrektionCO2eTot) /CO2e_Veg.l;
IeudledperKBpre('01000b',udled_type) = IeudledperKBpre('01000b',udled_type) * CO2e_Kvaeg0*4803/4576 * (1+korrektionCO2eTot) /CO2e_Kvaeg.l;
IeudledperKBpre('01000c',udled_type) = IeudledperKBpre('01000c',udled_type) * CO2e_Svin0*1364/1666 * (1+korrektionCO2eTot) /CO2e_Svin.l;
IeudledperKBpre('01000d',udled_type) = IeudledperKBpre('01000d',udled_type) * CO2e_Fjerkraemv0*387/400* (1+korrektionCO2eTot) /CO2e_Fjerkraemv.l;


* For at ramme ikke-energirelaterede emissioner fra øvrige brancher korrigeres emissionsparametrene knyttet dertil.
scalar_Ieudled(j,'CO2')   $ d1IeudledType1(j,'CO2')   = scalar_Ieudled(j,'CO2')         * 516/CO2_Other.l;
scalar_Ieudled('350010a','CO2')                       = scalar_Ieudled('350010a','CO2') * 516/CO2_Other.l;
scalar_Ieudled('383900','CO2')                        = scalar_Ieudled('383900','CO2')  * 516/CO2_Other.l;
scalar_Ieudled(j,'N2O')   $ d1IeudledType1(j,'N2O')   = scalar_Ieudled(j,'N2O')   * 532/N2O_Other.l;
Ekoeff(j,kilder,'N2O')                                = Ekoeff(j,kilder,'N2O')    * 532/N2O_Other.l;
scalar_Ieudled(j,'CH4')   $ (NOT j_landxCCS(j))       = scalar_Ieudled(j,'CH4')   * 895/CH4_Other.l;
Ekoeff(j,kilder,'CH4')                                = Ekoeff(j,kilder,'CH4')    * 895/CH4_Other.l;
EkoeffHH(kilder,'CH4')                                = EkoeffHH(kilder,'CH4')    * 895/CH4_Other.l;
IeudledperKBpre(j,'CH4') $ (j_CCS(j))                 = IeudledperKBpre(j,'CH4')  * 895/CH4_Other.l;

*Samlede flour rammes ved at korrigere flour-udledninger fra øvrige brancher
scalar_Ieudled(j,'SF6')   $ d1IeudledType1(j,'SF6')   = scalar_Ieudled(j,'SF6')   * (110-sum(jj $ j_land(jj), Flour_J.l(jj)))/Flour_other.l;
scalar_Ieudled(j,'PFC')   $ d1IeudledType1(j,'PFC')   = scalar_Ieudled(j,'PFC')   * (110-sum(jj $ j_land(jj), Flour_J.l(jj)))/Flour_other.l;
scalar_Ieudled(j,'HFC')   $ d1IeudledType1(j,'HFC')   = scalar_Ieudled(j,'HFC')   * (110-sum(jj $ j_land(jj), Flour_J.l(jj)))/Flour_other.l;

solve static_fremskriv using cns;

*Samlet co2e rammes til slut ved at korrigere methan fra øvrige brancher
*scalar_Ieudled(j,'CH4')   $ d1IeudledType1(j,'CH4')   = scalar_Ieudled(j,'CH4')   * (CH4_Other.l+37671-CO2eDK.l)/CH4_Other.l;

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
unfix ENDO_NEW6;

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



*CO2e.fx('060000a') = CO2e.l('060000a');
*CO2e.fx('060000b') = CO2e.l('060000b');
Y.fx('060000a') = Y.l('060000a');
Y.fx('060000b') = Y.l('060000b');
markup.lo('060000a') = -inf;
markup.up('060000a') =  inf;
markup.lo('060000b') = -inf;
markup.up('060000b') =  inf;


* Nuller.gms fixer variable med leverancer som er nul, da de er fjernet i ligningerne
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

el_kraftandel.fx(j) $ (d1kraftandel0(j) EQ 1) = 0;

*Subs_KB.fx(j) $ (NOT j_landxCCS(j)) = 0;

solve static_fremskriv using cns;

* * * * * * 

Parameter CO2kvoter_2030basis;

CO2kvoter_2030basis(j) = kvoteandel_2030basis(j)*(sum(kilder,Eudled.l(j,kilder,'CO2')) + Ieudled.l(j,'CO2'));


* * * * Rapportering * * * *

$ontext
Display GDPf0.l, TFPtot.l;
Display m_elvind.l, m_elkraft.l;
Display m_FVfossil.l, m_CH.l, c_HH_GJ.l;
Display elproduktion_vind.l, elproduktion_kraft.l, elproduktion_affald.l, elnettoeksport.l;
Display m_BG_energi.l;
Display FVXinklC.l, FVVEinklC.l, FVfossilinklC.l, HHEnergiGJ.l;
Display s_Y.l;
Display m_TTE.l,m_TTE_tot.l;
Display thetaL.l, thetaB.l, m_KEel.l;
Display m_KEel_service.l, m_KEel_forarb.l, m_KEel_landbrugmv.l;
Display Kalibrering.l;

Display CO2En_EloV0, CO2En_Olier0, CO2En_Indv0, CO2En_Fora0, CO2En_Luft0, CO2En_Vej_hh0, CO2En_Vej_virk0, CO2En_Jernb0, CO2En_Soe0, CO2En_SeOff0, CO2En_hh0, CO2En_Lmv0;
Display CO2IEn_Cement0, CO2e_Veg0, CO2e_Kvaeg0, CO2e_Svin0,CO2e_Fjerkraemv0;
Display CO2_Other0, CH4_Other0, N2O_Other0, Flour0;
Display CO2eDK0;

Display CO2En_EloV.l, CO2En_Olier.l, CO2En_Indv.l, CO2En_Fora.l, CO2En_Luft.l, CO2En_Vej_hh.l, CO2En_Vej_virk.l, CO2En_Jernb.l, CO2En_Soe.l, CO2En_SeOff.l, CO2En_hh.l, CO2En_Lmv.l;
Display CO2IEn_Cement.l, CO2e_Veg.l, CO2e_Kvaeg.l, CO2e_Svin.l,CO2e_Fjerkraemv.l;
Display CO2_Other.l, CH4_Other.l, N2O_Other.l, Flour.l;
Display CO2eDK.l;

Display HHEnergiGJ.l;
$offtext

*Parameter vis_kalibreringMakro, vis_kalibreringCO2e;

vis_kalibreringMakro('GDPf0','start') = GDPf0.l;
vis_kalibreringMakro('GDPf0','maal') = 2610;
vis_kalibreringMakro('elkraft','start') = Elproduktion_kraft.l;
vis_kalibreringMakro('elkraft','maal') = Elproduktion_kraft0 * 0.4;
vis_kalibreringMakro('elkraftHH','start') = CH.l('350010a');
vis_kalibreringMakro('elkraftHH','maal') = CH0('350010a')*0.4;
vis_kalibreringMakro('elaffald','start') = Elproduktion_affald.l;
vis_kalibreringMakro('elaffald','maal') = Elproduktion_affald0;
vis_kalibreringMakro('affaldHH','start') = CH.l('383900');
vis_kalibreringMakro('affaldHH','maal') = CH0('383900');
vis_kalibreringMakro('elvind','start') = Elproduktion_vind.l;
vis_kalibreringMakro('elvind','maal') = Elproduktion_vind0 * 3.6;
vis_kalibreringMakro('Tpillerel','start') = EnergiGJ.l('350010a','Tpiller');
vis_kalibreringMakro('Tpillerel','maal') = 0.0314;
vis_kalibreringMakro('Halmel','start') = EnergiGJ.l('350010a','Halm');
vis_kalibreringMakro('Halmel','maal') = 0.0066;
vis_kalibreringMakro('Tbrael','start') = EnergiGJ.l('350010a','Tbra');
vis_kalibreringMakro('Tbrael','maal') = 0.0334;
vis_kalibreringCO2e('CO2En_EloV','start') = CO2En_EloV.l;
vis_kalibreringCO2e('CO2En_EloV','maal') = CO2En_EloV0 * 1699/11670 * (1+korrektionCO2eTot);
vis_kalibreringCO2e('CO2En_Nordsoe','start') = CO2En_Nordsoe.l;
vis_kalibreringCO2e('CO2En_Nordsoe','maal') = CO2En_Nordsoe0 * 1058/1329 * (1+korrektionCO2eTot);
vis_kalibreringCO2e('CO2En_Raf','start') = CO2En_Raf.l;
vis_kalibreringCO2e('CO2En_Raf','maal') = CO2En_Raf0 * 838/868 * (1+korrektionCO2eTot);
vis_kalibreringMakro('TpillerReno','start') = EnergiGJ.l('350030a','Tpiller');
vis_kalibreringMakro('TpillerReno','maal') = 0.0012;
vis_kalibreringMakro('HalmReno','start') = EnergiGJ.l('350030a','Halm');
vis_kalibreringMakro('HalmReno','maal') = 0.0065;
vis_kalibreringMakro('TbraReno','start') = EnergiGJ.l('350030a','Tbra');
vis_kalibreringMakro('TbraReno','maal') = 0.0162;
vis_kalibreringMakro('BG_GJ_inklC','start') = BG_GJ_inklC.l;
vis_kalibreringMakro('BG_GJ_inklC','maal') = BG_GJ_inklC0 * 3.3;
vis_kalibreringCO2e('CO2IEn_Cement','start') = CO2IEn_Cement.l;
vis_kalibreringCO2e('CO2IEn_Cement','maal') = 1474;
vis_kalibreringCO2e('CO2e_Veg','start') = CO2e_Veg.l;
vis_kalibreringCO2e('CO2e_Veg','maal') = CO2e_Veg0*4047/4232 * (1+korrektionCO2eTot);
vis_kalibreringCO2e('CO2e_Kvaeg','start') = CO2e_Kvaeg.l;
vis_kalibreringCO2e('CO2e_Kvaeg','maal') = CO2e_Kvaeg0*4803/4576 * (1+korrektionCO2eTot);
vis_kalibreringCO2e('CO2e_Svin','start') = CO2e_Svin.l;
vis_kalibreringCO2e('CO2e_Svin','maal') = CO2e_Svin0*1364/1666 * (1+korrektionCO2eTot);
vis_kalibreringCO2e('CO2e_Fjerkraemv','start') = CO2e_Fjerkraemv.l;
vis_kalibreringCO2e('CO2e_Fjerkraemv','maal') = CO2e_Fjerkraemv0*387/400 * (1+korrektionCO2eTot);
vis_kalibreringCO2e('CO2En_Vej_virk','start') = CO2En_Vej_virk.l;
vis_kalibreringCO2e('CO2En_Vej_virk','maal') = CO2En_Vej_virk0 * 5418/5257 * (1+korrektionCO2eTot);
vis_kalibreringCO2e('CO2En_Vej_hh','start') = CO2En_Vej_hh.l;
vis_kalibreringCO2e('CO2En_Vej_hh','maal') = CO2En_Vej_hh0 * 7072/6578 * (1+korrektionCO2eTot);
vis_kalibreringMakro('olie','start') = HHEnergiGJ.l('Olie');
vis_kalibreringMakro('olie','maal') = HHEnergiGJ0('Olie')*0.34;
vis_kalibreringMakro('el','start') = HHEnergiGJ.l('el');
vis_kalibreringMakro('el','maal') = HHEnergiGJ0('el')*1.11;
vis_kalibreringCO2e('CO2En_hh','start') = CO2En_hh.l;
vis_kalibreringCO2e('CO2En_hh','maal') = CO2En_hh0 * 1168/2131 * (1+korrektionCO2eTot);
vis_kalibreringMakro('Biogas','start') = HHEnergiGJ.l('Biogas');
vis_kalibreringMakro('Biogas','maal') = HHEnergiGJ0('Biogas')*0.0071;
vis_kalibreringMakro('olie','start') = HHEnergiGJ.l('Olie');
vis_kalibreringMakro('olie','maal') = HHEnergiGJ0('Olie')*0.34;
vis_kalibreringMakro('olie','start') = HHEnergiGJ.l('Olie');
vis_kalibreringMakro('olie','maal') = HHEnergiGJ0('Olie')*0.34;
vis_kalibreringCO2e('CO2En_SeOff','start') = CO2En_SeOff.l;
vis_kalibreringCO2e('CO2En_SeOff','maal') = CO2En_SeOff0 * 587/830 * (1+korrektionCO2eTot);
vis_kalibreringCO2e('CO2En_Fora','start') = CO2En_Fora.l;
vis_kalibreringCO2e('CO2En_Fora','maal') = CO2En_Fora0 * 2838/3210 * (1+korrektionCO2eTot);
vis_kalibreringCO2e('CO2En_Lmv','start') = CO2En_Lmv.l;
vis_kalibreringCO2e('CO2En_Lmv','maal') = CO2En_Lmv0 * 1309/1580 * (1+korrektionCO2eTot);
vis_kalibreringCO2e('CO2En_Luft','start') = CO2En_Luft.l;
vis_kalibreringCO2e('CO2En_Luft','maal') = CO2En_Luft0 * 737/757 * (1+korrektionCO2eTot);
vis_kalibreringCO2e('CO2En_Jernb','start') = CO2En_Jernb.l;
vis_kalibreringCO2e('CO2En_Jernb','maal') = CO2En_Jernb0 * 66/253 * (1+korrektionCO2eTot);
vis_kalibreringCO2e('CO2En_Soe','start') = CO2En_Soe.l;
vis_kalibreringCO2e('CO2En_Soe','maal') = CO2En_Soe0 * 596/622 * (1+korrektionCO2eTot);
vis_kalibreringCO2e('CO2_Other','start') = CO2_Other.l;
vis_kalibreringCO2e('CO2_Other','maal') = 516;
vis_kalibreringCO2e('N2O_Other','start') = N2O_Other.l;
vis_kalibreringCO2e('N2O_Other','maal') = 532;
vis_kalibreringCO2e('CH4_Other','start') = CH4_Other.l;
vis_kalibreringCO2e('CH4_Other','maal') = 895;
vis_kalibreringCO2e('Flour','start') = sum(j,Flour_J.l(j));
vis_kalibreringCO2e('Flour','maal') = 110;
vis_kalibreringCO2e('CO2eDK','start') = CO2eDK.l;
vis_kalibreringCO2e('CO2eDK','maal') = 37671;

display vis_kalibreringMakro, vis_kalibreringCO2e;


$include vis_andele.gms

display gdp.l, gdpf0.l, BoP.l;

execute_unload "gekko\gdx_work\Basis2030endo2.gdx";

$ontext
parameter NudledperKBprepost;
TFPtotpost = TFPtot.l;
m_elvindpost = m_elvind.l;
m_elkraftpost = m_elkraft.l;
m_CHpost(dc) = m_CH.l(dc);
J_TFPpost(j) = J_TFP.l(j);
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
$offtext

execute_unload "2030endo.gdx"
*TFPtot.l
m_elvind.l
m_elkraft.l
m_CH.l
TFP.l
m_ISB_energi.l
m_H_energi.l
m_T_energi.l
m_KEel.l
m_TTE_tot.l
m_KEel_service.l
m_KEel_forarb.l
m_KEel_landbrugmv.l
thetaTKF.l
markup.l
NudledperKBpre.l
thetaKMfo.l
adjX0.l
adjThetaL.l
;

*display markupstep;
