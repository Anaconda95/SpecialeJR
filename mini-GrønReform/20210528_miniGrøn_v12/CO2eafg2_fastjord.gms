parameter Tilskudssti;

*Vegetabilsk landbrug holdes fast via åben markup
Y.fx('01000a')      $ (%LAND% EQ 1) = Y.l('01000a'); 
markup.lo('01000a') $ (%LAND% EQ 1) = -inf;
markup.up('01000a') $ (%LAND% EQ 1) =  inf;

*Fiskeri holdes fast via åben markup
Y.fx('030000')      $ (%FISK% EQ 1) = Y.l('030000'); 
markup.lo('030000') $ (%FISK% EQ 1) = -inf;
markup.up('030000') $ (%FISK% EQ 1) =  inf;


LUMPSUM.fx $ (%LUK% EQ 1) = LUMPSUM.l;
t_w.lo $ (%LUK% EQ 1) = -inf;
t_w.up $ (%LUK% EQ 1) =  inf;
t_w.fx $ (%LUK% EQ 0) = t_w.l;
LUMPSUM.lo $ (%LUK% EQ 0) = -inf;
LUMPSUM.up $ (%LUK% EQ 0) =  inf;

display scalar_PKBx;
parameter justering(j);
justering('230020') = -0.992;
justering('383900') = -0.47;
justering('350010a') = 0.06;

scalar_PKBx(part,j) $ j_CCS(j) = 1 + (scalar_PKBx(part,j)-1)*(1+justering(j));

*display scalar_PKBx;
*$exit

*Den generelle CO2e-afgift hæves først til 300 kr. per ton

CO2eTax.fx                          = 200;

*CO2e-skatten nedskaleres for brancher, der også betaler for CO2-kvoter
CO2eTax_dummyE(j,kilder,'CO2') = 1 - kvotepris_2016*kvoteandel_2016(j)/CO2eTax.l;
CO2eTax_dummyIE(j,'CO2') = 1 - kvotepris_2016*kvoteandel_2016(j)/CO2eTax.l;
*CO2e-skatten rammer ikke brandstofforbrug i international transport (fly,skib og vej)
CO2eTax_dummyE('490030b','BogD',udled_type) = 0;
CO2eTax_dummyE('50000b',kilder,udled_type) = 0;
CO2eTax_dummyE('51000b','BogD',udled_type) = 0;

solve static_fremskriv using cns;

CO2eSti('1','CO2IEn_Cement') = CO2IEn_Cement.l;
CO2eSti('1','CO2e_Veg') = CO2e_Veg.l;
CO2eSti('1','CO2e_Kvaeg') = CO2e_Kvaeg.l;
CO2eSti('1','CO2e_Svin') = CO2e_Svin.l;
CO2eSti('1','CO2e_Fjerkraemv') = CO2e_Fjerkraemv.l;
CO2eSti('1','CO2En_Vej_virk') = CO2En_Vej_virk.l;
CO2eSti('1','CO2En_Vej_hh') = CO2En_Vej_hh.l;
CO2eSti('1','CO2En_hh') = CO2En_hh.l;
CO2eSti('1','CO2En_SeOff') = CO2En_SeOff.l;
CO2eSti('1','CO2En_Fora') = CO2En_Fora.l;
CO2eSti('1','CO2En_Lmv') = CO2En_Lmv.l;
CO2eSti('1','CO2En_Luft') = CO2En_Luft.l;
CO2eSti('1','CO2En_Jernb') = CO2En_Jernb.l;
CO2eSti('1','CO2En_Soe') = CO2En_Soe.l;
CO2eSti('1','CO2_Other') = CO2_Other.l;
CO2eSti('1','N2O_Other') = N2O_Other.l;
CO2eSti('1','CH4_Other') = CH4_Other.l;
CO2eSti('1','Flour') = sum(j,Flour_J.l(j));
CO2eSti('1','CO2eDK') = CO2eDK.l;

MACdata('1','CO2eTax') = CO2eTax.l;
MACdata('1','CO2e') = CO2eDK.l;
MACdata('1','CO2eReduk') = 100-(CO2eDK.l+LULUCF2030)/CO2e_inklLULUCF_1990*100;
MACdata('1','Negaudled') = SUM((part,j_CCS), Negaudled.l(part,j_CCS));
MACdata('1','NetInd') = Nettoindkomst.l;
MACdata('1','DisN') = DisNytte.l;
MACdata('1','PCH') = PCH.l('c');
MACdata('1','EVAir') = EVAirtot.l;
MACdata('1','EVNudled') = EVNudled.l;

CO2eTax.fx                          = 300;

CO2eTax_dummyE(j,kilder,'CO2') = 1 - kvotepris_2016*kvoteandel_2016(j)/CO2eTax.l;
CO2eTax_dummyIE(j,'CO2') = 1 - kvotepris_2016*kvoteandel_2016(j)/CO2eTax.l;
CO2eTax_dummyE('490030b','BogD',udled_type) = 0;
CO2eTax_dummyE('50000b',kilder,udled_type) = 0;
CO2eTax_dummyE('51000b','BogD',udled_type) = 0;

solve static_fremskriv using cns;

CO2eSti('2','CO2IEn_Cement') = CO2IEn_Cement.l;
CO2eSti('2','CO2e_Veg') = CO2e_Veg.l;
CO2eSti('2','CO2e_Kvaeg') = CO2e_Kvaeg.l;
CO2eSti('2','CO2e_Svin') = CO2e_Svin.l;
CO2eSti('2','CO2e_Fjerkraemv') = CO2e_Fjerkraemv.l;
CO2eSti('2','CO2En_Vej_virk') = CO2En_Vej_virk.l;
CO2eSti('2','CO2En_Vej_hh') = CO2En_Vej_hh.l;
CO2eSti('2','CO2En_hh') = CO2En_hh.l;
CO2eSti('2','CO2En_SeOff') = CO2En_SeOff.l;
CO2eSti('2','CO2En_Fora') = CO2En_Fora.l;
CO2eSti('2','CO2En_Lmv') = CO2En_Lmv.l;
CO2eSti('2','CO2En_Luft') = CO2En_Luft.l;
CO2eSti('2','CO2En_Jernb') = CO2En_Jernb.l;
CO2eSti('2','CO2En_Soe') = CO2En_Soe.l;
CO2eSti('2','CO2_Other') = CO2_Other.l;
CO2eSti('2','N2O_Other') = N2O_Other.l;
CO2eSti('2','CH4_Other') = CH4_Other.l;
CO2eSti('2','Flour') = sum(j,Flour_J.l(j));
CO2eSti('2','CO2eDK') = CO2eDK.l;

MACdata('2','CO2eTax') = CO2eTax.l;
MACdata('2','CO2e') = CO2eDK.l;
MACdata('2','CO2eReduk') = 100-(CO2eDK.l+LULUCF2030)/CO2e_inklLULUCF_1990*100;
MACdata('2','Negaudled') = SUM((part,j_CCS), Negaudled.l(part,j_CCS));
MACdata('2','NetInd') = Nettoindkomst.l;
MACdata('2','DisN') = DisNytte.l;
MACdata('2','PCH') = PCH.l('c');
MACdata('2','EVAir') = EVAirtot.l;
MACdata('2','EVNudled') = EVNudled.l;

* * * * * Scenarier med intet fradrag eller dobbelt fradrag for kvoteprisen * * * * * 

CO2_temp(j) =  sum(kilder,Eudled.l(j,kilder,'CO2')) + Ieudled.l(j,'CO2');

CO2eTax_dummyE(j,kilder,'CO2') = 1 + (kvotepris_2030 $ (%kvotetax% EQ 1) - kvotepris_2030 $ (%kvote2xfradrag% EQ 1))*kvoteandel_2030(j)/CO2eTax.l - kvotepris_2016*kvoteandel_2016(j)/CO2eTax.l;
CO2eTax_dummyIE(j,'CO2') = 1 + (kvotepris_2030 $ (%kvotetax% EQ 1) - kvotepris_2030 $ (%kvote2xfradrag% EQ 1))*kvoteandel_2030(j)/CO2eTax.l - kvotepris_2016*kvoteandel_2016(j)/CO2eTax.l;
CO2eTax_dummyE('490030b','BogD',udled_type) = 0;
CO2eTax_dummyE('50000b',kilder,udled_type) = 0;
CO2eTax_dummyE('51000b','BogD',udled_type) = 0;

solve static_fremskriv using cns;

*Opdatering af andel af CO2-udledninger i branche j, der er kvoteomfattet: Alle ændringer i udledninger antages at finde sted i kvotesektoren

kvoteandel_2030(j)$(kvoteandel_2030(j)>0 and kvoteandel_2030(j)<1) = (kvoteandel_2030(j)*CO2_temp(j) + sum(kilder,Eudled.l(j,kilder,'CO2')) + Ieudled.l(j,'CO2') - CO2_temp(j)) / (sum(kilder,Eudled.l(j,kilder,'CO2')) + Ieudled.l(j,'CO2'));
kvoteandel_2030(j)$(kvoteandel_2030(j)<0) = 0;
kvoteandel_2030(j)$(kvoteandel_2030(j)>1) = 1;

Display kvoteandel_2030;

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

*Fradrag i CO2e-beskatningen
Parameter fradragsandel, leakagerate, s_gratiskvoter;
*parameter andel_kvaegSlagt, andel_kvaegMej, andel_svinSlagt;


s_gratiskvoter(j) = s_Y.l(j);

fradragsandel = 0.8;

leakagerate(j) = 0;
*kvæg
leakagerate('01000b') = 0.80;
*Svin
leakagerate('01000c') = 0.08;

*Kemikalier
leakagerate('200010') = 0.80;
leakagerate('200020') = 0.80;
*Elektricitet
leakagerate('350010a') = 0.08;
*metal
leakagerate('240000') = 0.71;



* * * * * * * * * * * * * * * *
*80 pct. lækagekorrektion for udvalgte brancher:
*leakagerate(j)$(leakagerate(j)>0) = 0.8;

fradragsandel = 1;
*80 pct. fradrag for alle brancher
leakagerate(j) $ (%leakage% EQ 0) = 1;
fradragsandel $ (%leakage% EQ 0) = 0.8;

* * * * * * * * * * * * * * * * *

s_Y.fx(j) $ (%fradrag% EQ 1) = s_gratiskvoter(j) + leakagerate(j) * fradragsandel *(sum((kilder,udled_type), TR_Eudled.l(j,kilder,udled_type)) + sum(udled_type, TR_Ieudled.l(j,udled_type))) / Y.l(j);
s_Y.fx(j) $ (s_Y.l(j) LT 0) = 0; 

*Anvendelsesafgift
$include anvafgift.gms

solve static_fremskriv using cns;

s_CCS.fx(part,j) = 0;
d1KBpartX(part,j_land) = 0;

KBpartX.fx(part,j_land) $ (d1KBpartX(part,j_land) eq 0) = 0;
KBpart.fx(part,j_land)  $ (d1KBpartX(part,j_land) eq 1) = 0;
KBpart.lo(part,j_land) $ (d1KBpartX(part,j_land) eq 0) = -inf;
KBpart.up(part,j_land) $ (d1KBpartX(part,j_land) eq 0) =  inf;

*------------------------------------------------------------
* * * * * Den generelle CO2e-afgift hæves til 600 kr. per ton
*------------------------------------------------------------
set loopstep2(loopstep) /3*5/;

loop(loopstep2 $ (CO2eDK.l GT CO2emaal2030),


*Startværdier for backstop-teknologier
KBpartX.l(part,j_land) = KBpart.l(part,j_land);

*Selve CO2e-skatten
CO2eTax.fx                          = CO2eTax.l + 100;
*Tilskud til CCS følger CO2e-skatten indtil CCS tages i brug
s_CCS.fx(part,j) $ (d1KBpartX(part,j) EQ 0) = CO2eTax.l;

*Fradrag i CO2e-beskatningen
s_Y.fx(j) $ (%fradrag% EQ 1) = s_gratiskvoter(j) + leakagerate(j) * fradragsandel *(sum((kilder,udled_type), TR_Eudled.l(j,kilder,udled_type)) + sum(udled_type, TR_Ieudled.l(j,udled_type))) / Y.l(j);
s_Y.fx(j) $ (s_Y.l(j) LT 0) = 0; 
s_Y.fx('350010a') = 0;

*Anvendelsesafgift
$include anvafgift.gms

*CO2e-skatten nedskaleres for brancher, der også betaler for CO2-kvoter
CO2eTax_dummyE(j,kilder,'CO2') = 1 + (kvotepris_2030 $ (%kvotetax% EQ 1) - kvotepris_2030 $ (%kvote2xfradrag% EQ 1))*kvoteandel_2030(j)/CO2eTax.l - kvotepris_2016*kvoteandel_2016(j)/CO2eTax.l;
CO2eTax_dummyIE(j,'CO2') = 1 + (kvotepris_2030 $ (%kvotetax% EQ 1) - kvotepris_2030 $ (%kvote2xfradrag% EQ 1))*kvoteandel_2030(j)/CO2eTax.l - kvotepris_2016*kvoteandel_2016(j)/CO2eTax.l;
*CO2e-skatten rammer ikke brandstofforbrug i international transport (fly,skib og vej)
CO2eTax_dummyE('490030b','BogD',udled_type) = 0;
CO2eTax_dummyE('50000b',kilder,udled_type) = 0;
CO2eTax_dummyE('51000b','BogD',udled_type) = 0;


* PKBpartX udregnes partielt inden modellen køres for at afgøre, om CCS skal slås til
PKBpartX.l(part,j) $ j_CCS(j) = scalar_PKBx(part,j) * (1+tFak_B.l(j))*ucB.l(j)*PInvB.l(j) - CCSprKBx.l(j)*1000 * BECCSshare.l(j) * s_CCS.l(part,j) * 10**(-9);


*Angivelse af, om backstop-teknologier skal anvendes. CCS slås til, hvis PKBpartX er lavere end PKBpart
d1KBpartX(part,j_land) $ (PKBpart.l(part,j_land) gt PKBpartX.l(part,j_land)) = 1;


*Ved CCS er KBpartX endogen, ellers er KBpart endogen
KBpartX.fx(part,j_land) $ (d1KBpartX(part,j_land) eq 0) = 0;
KBpart.fx(part,j_land)  $ (d1KBpartX(part,j_land) eq 1) = 0;
KBpartX.lo(part,j_land) $ (d1KBpartX(part,j_land) eq 1) = -inf;
KBpartX.up(part,j_land) $ (d1KBpartX(part,j_land) eq 1) =  inf;



solve static_fremskriv using cns;

MACdata(loopstep2,'CO2eTax') = CO2eTax.l;
MACdata(loopstep2,'CO2e') = CO2eDK.l;
MACdata(loopstep2,'Negaudled') = SUM((part,j_CCS), Negaudled.l(part,j_CCS));
MACdata(loopstep2,'NetInd') = Nettoindkomst.l;
MACdata(loopstep2,'DisN') = DisNytte.l;
MACdata(loopstep2,'PCH') = PCH.l('c');
MACdata(loopstep2,'EVAir') = EVAirtot.l;
MACdata(loopstep2,'EVNudled') = EVNudled.l;

CO2eSti(loopstep2,'CO2IEn_Cement') = CO2IEn_Cement.l;
CO2eSti(loopstep2,'CO2e_Veg') = CO2e_Veg.l;
CO2eSti(loopstep2,'CO2e_Kvaeg') = CO2e_Kvaeg.l;
CO2eSti(loopstep2,'CO2e_Svin') = CO2e_Svin.l;
CO2eSti(loopstep2,'CO2e_Fjerkraemv') = CO2e_Fjerkraemv.l;
CO2eSti(loopstep2,'CO2En_Vej_virk') = CO2En_Vej_virk.l;
CO2eSti(loopstep2,'CO2En_Vej_hh') = CO2En_Vej_hh.l;
CO2eSti(loopstep2,'CO2En_hh') = CO2En_hh.l;
CO2eSti(loopstep2,'CO2En_SeOff') = CO2En_SeOff.l;
CO2eSti(loopstep2,'CO2En_Fora') = CO2En_Fora.l;
CO2eSti(loopstep2,'CO2En_Lmv') = CO2En_Lmv.l;
CO2eSti(loopstep2,'CO2En_Luft') = CO2En_Luft.l;
CO2eSti(loopstep2,'CO2En_Jernb') = CO2En_Jernb.l;
CO2eSti(loopstep2,'CO2En_Soe') = CO2En_Soe.l;
CO2eSti(loopstep2,'CO2_Other') = CO2_Other.l;
CO2eSti(loopstep2,'N2O_Other') = N2O_Other.l;
CO2eSti(loopstep2,'CH4_Other') = CH4_Other.l;
CO2eSti(loopstep2,'Flour') = sum(j,Flour_J.l(j));
CO2eSti(loopstep2,'CO2eDK') = CO2eDK.l;
);

display BoP.l;

$include vis_andele.gms


*------------------------------------------------------------
* * * * * Den generelle CO2e-afgift hæves med 10 kr. af gangen indtil CO2e er under 102 pct. af målet
*------------------------------------------------------------
set loopstep4(loopstep) /100*309/;
*set loopstep4(loopstep) /100*144/;

*Input til tilskudsberegningen
Variables KE_udled_EA(loopstep4,j), KE_udled_rela_EA(loopstep4,j), T_udled_EA(loopstep4,j), T_udled_rela_EA(loopstep4,j), KB_udled_EA(loopstep4,j), KB_udled_rela_EA(loopstep4,j), C_udled_EA(loopstep4), C_udled_rela_EA(loopstep4);

loop(loopstep4 $ (CO2eDK.l GT (CO2emaal2030)*1.01),
*loop(loopstep4 $ (CO2eDK.l GT (CO2emaal2030)*1.02),
*loop(loopstep4,

*Startværdier for backstop-teknologier
KBpartX.l(part,j_land) = KBpart.l(part,j_land);

*Selve CO2e-skatten
CO2eTax.fx                          = CO2eTax.l + 10;
*Tilskud til CCS følger CO2e-skatten indtil CCS tages i brug
s_CCS.fx(part,j) $ (d1KBpartX(part,j) EQ 0) = CO2eTax.l;

*Fradrag i CO2e-beskatningen
s_Y.fx(j) $ (%fradrag% EQ 1) = s_gratiskvoter(j) + leakagerate(j) * fradragsandel *(sum((kilder,udled_type), TR_Eudled.l(j,kilder,udled_type)) + sum(udled_type, TR_Ieudled.l(j,udled_type))) / Y.l(j);
s_Y.fx(j) $ (s_Y.l(j) LT 0) = 0; 
s_Y.fx('350010a') = 0;

*Anvendelsesafgift
$include anvafgift.gms

*CO2e-skatten nedskaleres for brancher, der også betaler for CO2-kvoter
CO2eTax_dummyE(j,kilder,'CO2') = 1 + (kvotepris_2030 $ (%kvotetax% EQ 1) - kvotepris_2030 $ (%kvote2xfradrag% EQ 1))*kvoteandel_2030(j)/CO2eTax.l - kvotepris_2016*kvoteandel_2016(j)/CO2eTax.l;
CO2eTax_dummyIE(j,'CO2') = 1 + (kvotepris_2030 $ (%kvotetax% EQ 1) - kvotepris_2030 $ (%kvote2xfradrag% EQ 1))*kvoteandel_2030(j)/CO2eTax.l - kvotepris_2016*kvoteandel_2016(j)/CO2eTax.l;
*CO2e-skatten rammer ikke brandstofforbrug i international transport (fly,skib og vej)
CO2eTax_dummyE('490030b','BogD',udled_type) = 0;
CO2eTax_dummyE('50000b',kilder,udled_type) = 0;
CO2eTax_dummyE('51000b','BogD',udled_type) = 0;


* PKBpartX udregnes partielt inden modellen køres for at afgøre, om CCS skal slås til
PKBpartX.l(part,j) $ j_CCS(j) = scalar_PKBx(part,j) * (1+tFak_B.l(j))*ucB.l(j)*PInvB.l(j) - CCSprKBx.l(j)*1000 * BECCSshare.l(j) * s_CCS.l(part,j) * 10**(-9);


*Angivelse af, om backstop-teknologier skal anvendes. CCS slås til, hvis PKBpartX er lavere end PKBpart
d1KBpartX(part,j_land) $ (PKBpart.l(part,j_land) gt PKBpartX.l(part,j_land)) = 1;


*Ved CCS er KBpartX endogen, ellers er KBpart endogen
KBpartX.fx(part,j_land) $ (d1KBpartX(part,j_land) eq 0) = 0;
KBpart.fx(part,j_land)  $ (d1KBpartX(part,j_land) eq 1) = 0;
KBpartX.lo(part,j_land) $ (d1KBpartX(part,j_land) eq 1) = -inf;
KBpartX.up(part,j_land) $ (d1KBpartX(part,j_land) eq 1) =  inf;


*PKBpartX låses for at undgå negativ pris - tilskuddet tager tilpasningen
PKBpartX.fx(part,'350010a')  $ (d1KBpartX(part,'350010a') eq 1) = PKBpartX.l(part,'350010a');
s_CCS.lo(part,'350010a') $ (d1KBpartX(part,'350010a') eq 1) = -inf;
s_CCS.up(part,'350010a') $ (d1KBpartX(part,'350010a') eq 1) =  inf;

solve static_fremskriv using cns;

MACdata(loopstep4,'CO2eTax') = CO2eTax.l;
MACdata(loopstep4,'CO2e') = CO2eDK.l;
MACdata(loopstep4,'CO2eReduk') = 100-(CO2eDK.l+LULUCF2030)/CO2e_inklLULUCF_1990*100;
MACdata(loopstep4,'Negaudled') = SUM((part,j_CCS), Negaudled.l(part,j_CCS));
MACdata(loopstep4,'NetInd') = Nettoindkomst.l;
MACdata(loopstep4,'DisN') = DisNytte.l;
MACdata(loopstep4,'PCH') = PCH.l('c');
MACdata(loopstep4,'EVAir') = EVAirtot.l;
MACdata(loopstep4,'EVNudled') = EVNudled.l;

CO2eSti(loopstep4,'CO2IEn_Cement') = CO2IEn_Cement.l;
CO2eSti(loopstep4,'CO2e_Veg') = CO2e_Veg.l;
CO2eSti(loopstep4,'CO2e_Kvaeg') = CO2e_Kvaeg.l;
CO2eSti(loopstep4,'CO2e_Svin') = CO2e_Svin.l;
CO2eSti(loopstep4,'CO2e_Fjerkraemv') = CO2e_Fjerkraemv.l;
CO2eSti(loopstep4,'CO2En_Vej_virk') = CO2En_Vej_virk.l;
CO2eSti(loopstep4,'CO2En_Vej_hh') = CO2En_Vej_hh.l;
CO2eSti(loopstep4,'CO2En_hh') = CO2En_hh.l;
CO2eSti(loopstep4,'CO2En_SeOff') = CO2En_SeOff.l;
CO2eSti(loopstep4,'CO2En_Fora') = CO2En_Fora.l;
CO2eSti(loopstep4,'CO2En_Lmv') = CO2En_Lmv.l;
CO2eSti(loopstep4,'CO2En_Luft') = CO2En_Luft.l;
CO2eSti(loopstep4,'CO2En_Jernb') = CO2En_Jernb.l;
CO2eSti(loopstep4,'CO2En_Soe') = CO2En_Soe.l;
CO2eSti(loopstep4,'CO2_Other') = CO2_Other.l;
CO2eSti(loopstep4,'N2O_Other') = N2O_Other.l;
CO2eSti(loopstep4,'CH4_Other') = CH4_Other.l;
CO2eSti(loopstep4,'Flour') = sum(j,Flour_J.l(j));
CO2eSti(loopstep4,'CO2eDK') = CO2eDK.l;
CO2eSti(loopstep4,'d1KB230020') = sum(part,d1KBpartX(part,'230020'));
CO2eSti(loopstep4,'d1KB350010a') = sum(part,d1KBpartX(part,'350010a'));
CO2eSti(loopstep4,'d1KB383900') = sum(part,d1KBpartX(part,'383900'));

KE_udled_EA.l(loopstep4,j) =  Eudled.l(j,'natgas','CO2')
             +Eudled.l(j,'rafgas','CO2')
             +Eudled.l(j,'Nordgas','CO2')
             +Eudled.l(j,'biogas','CO2')
             +Eudled.l(j,'olie','CO2')
             +Eudled.l(j,'kul','CO2')
             +Eudled.l(j,'affald','CO2'); 
KE_udled_rela_EA.l(loopstep4,j) =  KE_udled_EA.l(loopstep4,j)/KE2.l(j);
T_udled_EA.l(loopstep4,j) =  Eudled.l(j,'BogD','CO2')
             +Eudled.l(j,'BioOlie','CO2');
T_udled_rela_EA.l(loopstep4,j) =  T_udled_EA.l(loopstep4,j)/T.l(j);
KB_udled_EA.l(loopstep4,j) =  CO2e.l(j) - KE_udled_EA.l(loopstep4,j) - T_udled_EA.l(loopstep4,j);
KB_udled_rela_EA.l(loopstep4,j) $ j_land(j) = KB_udled_EA.l(loopstep4,j) / KBtot.l(j);
C_udled_EA.l(loopstep4) = CO2EnergiHH.l;
C_udled_rela_EA.l(loopstep4) = CO2EnergiHH.l/CH.l('nge');

);

execute_unload "tilskudssti.gdx"
KE_udled_EA.l 
KE_udled_rela_EA.l 
T_udled_EA.l 
T_udled_rela_EA.l 
KB_udled_EA.l 
KB_udled_rela_EA.l
C_udled_EA.l
C_udled_rela_EA.l
;
*------------------------------------------------------------
* * * * * Den generelle CO2e-afgift hæves med 5 kr. af gangen indtil CO2e er under 101 pct. af målet
*------------------------------------------------------------


set loopstep5(loopstep) /300*360/;
*set loopstep5(loopstep) /300*301/;

*loop(loopstep5 $ (CO2eDK.l GT CO2emaal2030*1.01),
loop(loopstep5 $ (CO2eDK.l GT CO2emaal2030*1.005),

*Startværdier for backstop-teknologier
KBpartX.l(part,j_land) = KBpart.l(part,j_land);

*Selve CO2e-skatten
CO2eTax.fx                          = CO2eTax.l + 5;
*Tilskud til CCS følger CO2e-skatten indtil CCS tages i brug
s_CCS.fx(part,j) $ (d1KBpartX(part,j) EQ 0) = CO2eTax.l;

*Fradrag i CO2e-beskatningen
s_Y.fx(j) $ (%fradrag% EQ 1) = s_gratiskvoter(j) + leakagerate(j) * fradragsandel *(sum((kilder,udled_type), TR_Eudled.l(j,kilder,udled_type)) + sum(udled_type, TR_Ieudled.l(j,udled_type))) / Y.l(j);
s_Y.fx(j) $ (s_Y.l(j) LT 0) = 0; 
s_Y.fx('350010a') = 0;

*Anvendelsesafgift
$include anvafgift.gms

*CO2e-skatten nedskaleres for brancher, der også betaler for CO2-kvoter
CO2eTax_dummyE(j,kilder,'CO2') = 1 + (kvotepris_2030 $ (%kvotetax% EQ 1) - kvotepris_2030 $ (%kvote2xfradrag% EQ 1))*kvoteandel_2030(j)/CO2eTax.l - kvotepris_2016*kvoteandel_2016(j)/CO2eTax.l;
CO2eTax_dummyIE(j,'CO2') = 1 + (kvotepris_2030 $ (%kvotetax% EQ 1) - kvotepris_2030 $ (%kvote2xfradrag% EQ 1))*kvoteandel_2030(j)/CO2eTax.l - kvotepris_2016*kvoteandel_2016(j)/CO2eTax.l;
*CO2e-skatten rammer ikke brandstofforbrug i international transport (fly,skib og vej)
CO2eTax_dummyE('490030b','BogD',udled_type) = 0;
CO2eTax_dummyE('50000b',kilder,udled_type) = 0;
CO2eTax_dummyE('51000b','BogD',udled_type) = 0;


* PKBpartX udregnes partielt inden modellen køres for at afgøre, om CCS skal slås til
PKBpartX.l(part,j) $ j_CCS(j) = scalar_PKBx(part,j) * (1+tFak_B.l(j))*ucB.l(j)*PInvB.l(j) - CCSprKBx.l(j)*1000 * BECCSshare.l(j) * s_CCS.l(part,j) * 10**(-9);


*Angivelse af, om backstop-teknologier skal anvendes. CCS slås til, hvis PKBpartX er lavere end PKBpart
d1KBpartX(part,j_land) $ (PKBpart.l(part,j_land) gt PKBpartX.l(part,j_land)) = 1;


*Ved CCS er KBpartX endogen, ellers er KBpart endogen
KBpartX.fx(part,j_land) $ (d1KBpartX(part,j_land) eq 0) = 0;
KBpart.fx(part,j_land)  $ (d1KBpartX(part,j_land) eq 1) = 0;
KBpartX.lo(part,j_land) $ (d1KBpartX(part,j_land) eq 1) = -inf;
KBpartX.up(part,j_land) $ (d1KBpartX(part,j_land) eq 1) =  inf;

PKBpartX.fx(part,'350010a')  $ (d1KBpartX(part,'350010a') eq 1) = PKBpartX.l(part,'350010a');
s_CCS.lo(part,'350010a') $ (d1KBpartX(part,'350010a') eq 1) = -inf;
s_CCS.up(part,'350010a') $ (d1KBpartX(part,'350010a') eq 1) =  inf;




solve static_fremskriv using cns;



MACdata(loopstep5,'CO2eTax') = CO2eTax.l;
MACdata(loopstep5,'CO2e') = CO2eDK.l;
MACdata(loopstep5,'CO2eReduk') = 100-(CO2eDK.l+LULUCF2030)/CO2e_inklLULUCF_1990*100;
MACdata(loopstep5,'Negaudled') = SUM((part,j_CCS), Negaudled.l(part,j_CCS));
MACdata(loopstep5,'NetInd') = Nettoindkomst.l;
MACdata(loopstep5,'DisN') = DisNytte.l;
MACdata(loopstep5,'PCH') = PCH.l('c');
MACdata(loopstep5,'EVAir') = EVAirtot.l;
MACdata(loopstep5,'EVNudled') = EVNudled.l;

CO2eSti(loopstep5,'CO2IEn_Cement') = CO2IEn_Cement.l;
CO2eSti(loopstep5,'CO2e_Veg') = CO2e_Veg.l;
CO2eSti(loopstep5,'CO2e_Kvaeg') = CO2e_Kvaeg.l;
CO2eSti(loopstep5,'CO2e_Svin') = CO2e_Svin.l;
CO2eSti(loopstep5,'CO2e_Fjerkraemv') = CO2e_Fjerkraemv.l;
CO2eSti(loopstep5,'CO2En_Vej_virk') = CO2En_Vej_virk.l;
CO2eSti(loopstep5,'CO2En_Vej_hh') = CO2En_Vej_hh.l;
CO2eSti(loopstep5,'CO2En_hh') = CO2En_hh.l;
CO2eSti(loopstep5,'CO2En_SeOff') = CO2En_SeOff.l;
CO2eSti(loopstep5,'CO2En_Fora') = CO2En_Fora.l;
CO2eSti(loopstep5,'CO2En_Lmv') = CO2En_Lmv.l;
CO2eSti(loopstep5,'CO2En_Luft') = CO2En_Luft.l;
CO2eSti(loopstep5,'CO2En_Jernb') = CO2En_Jernb.l;
CO2eSti(loopstep5,'CO2En_Soe') = CO2En_Soe.l;
CO2eSti(loopstep5,'CO2_Other') = CO2_Other.l;
CO2eSti(loopstep5,'N2O_Other') = N2O_Other.l;
CO2eSti(loopstep5,'CH4_Other') = CH4_Other.l;
CO2eSti(loopstep5,'Flour') = sum(j,Flour_J.l(j));
CO2eSti(loopstep5,'CO2eDK') = CO2eDK.l;
CO2eSti(loopstep5,'d1KB230020') = sum(part,d1KBpartX(part,'230020'));
CO2eSti(loopstep5,'d1KB350010a') = sum(part,d1KBpartX(part,'350010a'));
CO2eSti(loopstep5,'d1KB383900') = sum(part,d1KBpartX(part,'383900'));

);


*------------------------------------------------------------
* * * * * Den generelle CO2e-afgift hæves med 1 kr. af gangen indtil CO2e er under  målet
*------------------------------------------------------------


set loopstep6(loopstep) /400*460/;
*set loopstep6(loopstep) /400*401/;

loop(loopstep6 $ (CO2eDK.l GT CO2emaal2030),

*Startværdier for backstop-teknologier
KBpartX.l(part,j_land) = KBpart.l(part,j_land);

*Selve CO2e-skatten
CO2eTax.fx                          = CO2eTax.l + 1;
*Tilskud til CCS følger CO2e-skatten indtil CCS tages i brug
s_CCS.fx(part,j) $ (d1KBpartX(part,j) EQ 0) = CO2eTax.l;

*Fradrag i CO2e-beskatningen
s_Y.fx(j) $ (%fradrag% EQ 1) = s_gratiskvoter(j) + leakagerate(j) * fradragsandel *(sum((kilder,udled_type), TR_Eudled.l(j,kilder,udled_type)) + sum(udled_type, TR_Ieudled.l(j,udled_type))) / Y.l(j);
s_Y.fx(j) $ (s_Y.l(j) LT 0) = 0; 
s_Y.fx('350010a') = 0;

*Anvendelsesafgift
$include anvafgift.gms

*CO2e-skatten nedskaleres for brancher, der også betaler for CO2-kvoter
CO2eTax_dummyE(j,kilder,'CO2') = 1 + (kvotepris_2030 $ (%kvotetax% EQ 1) - kvotepris_2030 $ (%kvote2xfradrag% EQ 1))*kvoteandel_2030(j)/CO2eTax.l - kvotepris_2016*kvoteandel_2016(j)/CO2eTax.l;
CO2eTax_dummyIE(j,'CO2') = 1 + (kvotepris_2030 $ (%kvotetax% EQ 1) - kvotepris_2030 $ (%kvote2xfradrag% EQ 1))*kvoteandel_2030(j)/CO2eTax.l - kvotepris_2016*kvoteandel_2016(j)/CO2eTax.l;
*CO2e-skatten rammer ikke brandstofforbrug i international transport (fly,skib og vej)
CO2eTax_dummyE('490030b','BogD',udled_type) = 0;
CO2eTax_dummyE('50000b',kilder,udled_type) = 0;
CO2eTax_dummyE('51000b','BogD',udled_type) = 0;


* PKBpartX udregnes partielt inden modellen køres for at afgøre, om CCS skal slås til
PKBpartX.l(part,j) $ j_CCS(j) = scalar_PKBx(part,j) * (1+tFak_B.l(j))*ucB.l(j)*PInvB.l(j) - CCSprKBx.l(j)*1000 * BECCSshare.l(j) * s_CCS.l(part,j) * 10**(-9);


*Angivelse af, om backstop-teknologier skal anvendes. CCS slås til, hvis PKBpartX er lavere end PKBpart
d1KBpartX(part,j_land) $ (PKBpart.l(part,j_land) gt PKBpartX.l(part,j_land)) = 1;


*Ved CCS er KBpartX endogen, ellers er KBpart endogen
KBpartX.fx(part,j_land) $ (d1KBpartX(part,j_land) eq 0) = 0;
KBpart.fx(part,j_land)  $ (d1KBpartX(part,j_land) eq 1) = 0;
KBpartX.lo(part,j_land) $ (d1KBpartX(part,j_land) eq 1) = -inf;
KBpartX.up(part,j_land) $ (d1KBpartX(part,j_land) eq 1) =  inf;

PKBpartX.fx(part,'350010a')  $ (d1KBpartX(part,'350010a') eq 1) = PKBpartX.l(part,'350010a');
s_CCS.lo(part,'350010a') $ (d1KBpartX(part,'350010a') eq 1) = -inf;
s_CCS.up(part,'350010a') $ (d1KBpartX(part,'350010a') eq 1) =  inf;




solve static_fremskriv using cns;



MACdata(loopstep6,'CO2eTax') = CO2eTax.l;
MACdata(loopstep6,'CO2e') = CO2eDK.l;
MACdata(loopstep6,'CO2eReduk') = 100-(CO2eDK.l+LULUCF2030)/CO2e_inklLULUCF_1990*100;
MACdata(loopstep6,'Negaudled') = SUM((part,j_CCS), Negaudled.l(part,j_CCS));
MACdata(loopstep6,'NetInd') = Nettoindkomst.l;
MACdata(loopstep6,'DisN') = DisNytte.l;
MACdata(loopstep6,'PCH') = PCH.l('c');
MACdata(loopstep6,'EVAir') = EVAirtot.l;
MACdata(loopstep6,'EVNudled') = EVNudled.l;

CO2eSti(loopstep6,'CO2eTax') = CO2eTax.l;
CO2eSti(loopstep6,'CO2IEn_Cement') = CO2IEn_Cement.l;
CO2eSti(loopstep6,'CO2e_Veg') = CO2e_Veg.l;
CO2eSti(loopstep6,'CO2e_Kvaeg') = CO2e_Kvaeg.l;
CO2eSti(loopstep6,'CO2e_Svin') = CO2e_Svin.l;
CO2eSti(loopstep6,'CO2e_Fjerkraemv') = CO2e_Fjerkraemv.l;
CO2eSti(loopstep6,'CO2En_Vej_virk') = CO2En_Vej_virk.l;
CO2eSti(loopstep6,'CO2En_Vej_hh') = CO2En_Vej_hh.l;
CO2eSti(loopstep6,'CO2En_hh') = CO2En_hh.l;
CO2eSti(loopstep6,'CO2En_SeOff') = CO2En_SeOff.l;
CO2eSti(loopstep6,'CO2En_Fora') = CO2En_Fora.l;
CO2eSti(loopstep6,'CO2En_Lmv') = CO2En_Lmv.l;
CO2eSti(loopstep6,'CO2En_Luft') = CO2En_Luft.l;
CO2eSti(loopstep6,'CO2En_Jernb') = CO2En_Jernb.l;
CO2eSti(loopstep6,'CO2En_Soe') = CO2En_Soe.l;
CO2eSti(loopstep6,'CO2_Other') = CO2_Other.l;
CO2eSti(loopstep6,'N2O_Other') = N2O_Other.l;
CO2eSti(loopstep6,'CH4_Other') = CH4_Other.l;
CO2eSti(loopstep6,'Flour') = sum(j,Flour_J.l(j));
CO2eSti(loopstep6,'CO2eDK') = CO2eDK.l;
CO2eSti(loopstep6,'d1KB230020') = sum(part,d1KBpartX(part,'230020'));
CO2eSti(loopstep6,'d1KB350010a') = sum(part,d1KBpartX(part,'350010a'));
CO2eSti(loopstep6,'d1KB383900') = sum(part,d1KBpartX(part,'383900'));

);

Parameter CO2kvoter_2030, CO2eAfgift_Y(j);

CO2kvoter_2030(j) = kvoteandel_2030(j)*(sum(kilder,Eudled.l(j,kilder,'CO2')) + Ieudled.l(j,'CO2'));

CO2eAfgift_Y(j) = (sum((kilder,udled_type), TR_Eudled.l(j,kilder,udled_type)) + sum(udled_type, TR_Ieudled.l(j,udled_type))) / Y.l(j);

Parameter leakagerapport;

leakagerapport('kvoter') = sum(j, CO2kvoter_2030(j));
leakagerapport('CO2eTax') = CO2eTax.l;
leakagerapport('CO2eDK') = CO2eDK.l;
leakagerapport('CO2eInt') = CO2eInt_vej.l + CO2eInt_luft.l + CO2eInt_soe.l;
leakagerapport('lump') = lump.l;
leakagerapport('NetInd') = Nettoindkomst.l;
leakagerapport('DisN') = DisNytte.l;
leakagerapport('PCH') = PCH.l('c');
leakagerapport('EVAir') = EVAirtot.l;
leakagerapport('EVNudled') = EVNudled.l;
leakagerapport('w') = w.l;
leakagerapport('l_lf') = l.l('01000a')+l.l('01000b')+l.l('01000c')+l.l('01000d');
leakagerapport('l_cm') = l.l('190000a')+l.l('200010')+l.l('200020')+l.l('230020')+l.l('240000')+l.l('350010a');
leakagerapport('l_other') = sum(j, l.l(j)) - leakagerapport('l_lf') - leakagerapport('l_cm');


display BoP.l, CO2eTax.l;

execute_unload "gekko\gdx_work\%filnavn%.gdx";

$include vis_andele.gms