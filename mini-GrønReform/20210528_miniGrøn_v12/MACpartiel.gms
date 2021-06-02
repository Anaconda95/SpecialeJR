LUMPSUM.fx $ (%LUK% EQ 1) = LUMPSUM.l;
t_w.lo $ (%LUK% EQ 1) = -inf;
t_w.up $ (%LUK% EQ 1) =  inf;
t_w.fx $ (%LUK% EQ 0) = t_w.l;
LUMPSUM.lo $ (%LUK% EQ 0) = -inf;
LUMPSUM.up $ (%LUK% EQ 0) =  inf;

$include mac_set.gms

$include mac_pre.gms

*CO2e-afgiften ensartes til 200 kr. per ton

CO2eTax.fx = 200;

CO2eTax_dummyE(j,kilder,udled_type) = CO2eTax_dummyE(j,kilder,udled_type)+0.2*(1 - CO2eTax_dummyE(j,kilder,udled_type));
CO2eTax_dummyIE(j,udled_type)= CO2eTax_dummyIE(j,udled_type)+0.2*(1 - CO2eTax_dummyIE(j,udled_type));
CO2eTax_dummyE('490030b','BogD',udled_type) = 0;
CO2eTax_dummyE('50000b',kilder,udled_type) = 0;
CO2eTax_dummyE('51000b','BogD',udled_type) = 0;

solve static_fremskriv using cns;

CO2eTax_dummyE(j,kilder,udled_type) = CO2eTax_dummyE(j,kilder,udled_type)+0.5*(1 - CO2eTax_dummyE(j,kilder,udled_type));
CO2eTax_dummyIE(j,udled_type)= CO2eTax_dummyIE(j,udled_type)+0.5*(1 - CO2eTax_dummyIE(j,udled_type));
CO2eTax_dummyE('490030b','BogD',udled_type) = 0;
CO2eTax_dummyE('50000b',kilder,udled_type) = 0;
CO2eTax_dummyE('51000b','BogD',udled_type) = 0;

solve static_fremskriv using cns;

CO2eTax_dummyE(j,kilder,udled_type) = CO2eTax_dummyE(j,kilder,udled_type)+0.75*(1 - CO2eTax_dummyE(j,kilder,udled_type));
CO2eTax_dummyIE(j,udled_type)= CO2eTax_dummyIE(j,udled_type)+0.5*(1 - CO2eTax_dummyIE(j,udled_type));
CO2eTax_dummyE('490030b','BogD',udled_type) = 0;
CO2eTax_dummyE('50000b',kilder,udled_type) = 0;
CO2eTax_dummyE('51000b','BogD',udled_type) = 0;

solve static_fremskriv using cns;

CO2eTax_dummyE(j,kilder,udled_type) = 1;
CO2eTax_dummyIE(j,udled_type)= 1;
CO2eTax_dummyE(j,kilder,'CO2') = 1 - kvotepris_2016*kvoteandel_2016(j)/CO2eTax.l;
CO2eTax_dummyIE(j,'CO2') = 1 - kvotepris_2016*kvoteandel_2016(j)/CO2eTax.l;
CO2eTax_dummyE('490030b','BogD',udled_type) = 0;
CO2eTax_dummyE('50000b',kilder,udled_type) = 0;
CO2eTax_dummyE('51000b','BogD',udled_type) = 0;

solve static_fremskriv using cns;

*CO2e-afgiften hæves med 100 kr. ad gangen til 2000 kr. per ton

set loopstepMAC   /1*17/;

loop(loopstepMAC,

$include mac_pre.gms

CO2eTax.fx                          = CO2eTax.l + 100;
CO2eTax_dummyE(j,kilder,'CO2') = 1 - kvotepris_2016*kvoteandel_2016(j)/CO2eTax.l;
CO2eTax_dummyIE(j,'CO2') = 1 - kvotepris_2016*kvoteandel_2016(j)/CO2eTax.l;
CO2eTax_dummyE('490030b','BogD',udled_type) = 0;
CO2eTax_dummyE('50000b','BogD',udled_type) = 0;
CO2eTax_dummyE('51000b','BogD',udled_type) = 0;


solve static_fremskriv using cns;

$include mac_post.gms

CO2KE2redukAkku_serie(loopstepMAC,j) = CO2KE2redukAkku(j);
CO2KE2reduk_serie(loopstepMAC,j) = (CO2perKE2pre(j)-CO2perKE2post(j))*KE2base(j);
MAC_KE2_serie(loopstepMAC,j) = MAC_KE(j);

CO2TredukAkku_tot_serie(loopstepMAC) = CO2TredukAkku_tot;
CO2Treduk_tot_serie(loopstepMAC) = SUM(j, (CO2perTpre(j)-CO2perTpost(j))*Tbase(j));
MAC_T_serie(loopstepMAC,j) = MAC_T(j);
MAC_T_tot_serie(loopstepMAC) = MAC_T_tot;

MAC_Y_serie(loopstepMAC,j) = MAC_Y(j);
CO2eYredukAkku_serie(loopstepMAC,j) = CO2eYredukAkku(j);
CO2eYreduk_serie(loopstepMAC,j) = (CO2eperYpre(j)-CO2eperYpost(j))*Ybase(j);
NredukAkku_serie(loopstepMAC,j) = NredukAkku(j);
Nreduk_serie(loopstepMAC,j) = (NperYpre(j)-NperYpost(j))*Ybase(j);
NH3redukAkku_serie(loopstepMAC,j) = NH3redukAkku(j);
NH3reduk_serie(loopstepMAC,j) = (NH3perYpre(j)-NH3perYpost(j))*Ybase(j);
);

*display MAC_KE2_serie, CO2KE2reduk_serie, MAC_T_serie, CO2Treduk_serie;

execute_unload "MAC_partiel.gdx"
EKEny
CO2KE2redukAkku_serie
MAC_KE2_serie
CO2TredukAkku_tot_serie
MAC_T_serie
MAC_T_tot_serie
CO2eYredukAkku_serie
MAC_Y_serie
NredukAkku_serie
NH3redukAkku_serie
;