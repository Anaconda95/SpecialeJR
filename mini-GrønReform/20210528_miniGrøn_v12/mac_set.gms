parameter 
*KE
px_energipre, PInvMpre, PKEelpre, PHT_energixCO2, PG_energixCO2, PSB_energixCO2, PISB_energixCO2, PfossilxCO2, PKEfoxCO2, 
PKE2xCO2pre, PKE2inputpre, CO2perKE2pre, CO2perKE2post, MAC_KE, CO2KE2redukAkku_serie, CO2KE2redukAkku, KE2base, CO2KE2reduk_serie, MAC_KE2_serie,

*T
PTTEpre,PTBpre,PTX2pre,PTFXxCO2,PTFXBxCO2,PTTFxCO2,
PTxCO2pre, PTinputpre, CO2perTpre, CO2perTpost, Tbase,
MAC_T, MAC_T_tot, CO2TredukAkku_tot, MAC_T_serie, MAC_T_tot_serie, CO2Treduk_tot_serie, CO2TredukAkku_tot_serie,

*Landbrug
PInvBpre,PKBpartpre,PKBpartXpre,PLKEpre,PMpre,PTpre,
PKBpartxCO2e,PKBtotxCO2e,PHxCO2e,POxCO2epre,POxCO2epost,
CO2eperYpre,CO2eperYpost,Ybase,CO2eYredukAkku,CO2eYredukAkku_serie,CO2eYreduk_serie,MAC_Y,MAC_Y_serie,
NperYpre,NperYpost,NredukAkku,NredukAkku_serie,Nreduk_serie,
NH3perYpre,NH3perYpost,NH3redukAkku,NH3redukAkku_serie,NH3reduk_serie;

*KE
KE2base(j) = KE2.l(j);
CO2KE2reduk_serie('0',j) = 0;
CO2KE2redukAkku_serie('0',j) = 0;
MAC_KE2_serie('0',j) = 0;
CO2KE2redukAkku(j) = 0;

*T
Tbase(j) = T.l(j);
CO2Treduk_tot_serie('0') = 0;
CO2TredukAkku_tot_serie('0') = 0;
MAC_T_tot_serie('0') = 0;
CO2TredukAkku_tot = 0;

*Landbrug
Ybase(j) = Y.l(j);
MAC_Y_serie('0',j) $ j_land(j) = 0;

CO2eYredukAkku(j) $ j_land(j) = 0;
CO2eYredukAkku_serie('0',j) $ j_land(j) = 0;
CO2eYreduk_serie('0',j) $ j_land(j) = 0;

NredukAkku(j) $ j_land(j) = 0;
NredukAkku_serie('0',j) $ j_land(j) = 0;
Nreduk_serie('0',j) $ j_land(j) = 0;

NH3redukAkku(j) $ j_land(j) = 0;
NH3redukAkku_serie('0',j) $ j_land(j) = 0;
NH3reduk_serie('0',j) $ j_land(j) = 0;

*Definition af brancher uden vejtransport
*De primære erhverv, søfart og luftfart ekskluderes. Bemærk at international vejgodstransport ikke ekskluderes.
*Brancherne 190000b, 350010a og 52000 ekskluderes fordi MAC_T antager meget store værdier for høje CO2e-afgiften
sets
ikkevejtransport(j) /01000a,01000b,01000c,01000d,020000,030000,190000b,350010a,52000,50000a,50000b,51000a,51000b/
;

*Baseline ikke-energirelateret CO2e

Parameter IeCO2e;

IeCO2e(j) $ j_land(j) = sum(udled_type, Ieudled.l(j,udled_type) * CO2eVaegt(udled_type)/1000);

Display IeCO2e;
