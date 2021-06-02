*parameter justering(j);
*justering('230020') = -0.992;
*justering('383900') = -0.62;
*justering('350010a') = 0.06;

parameter justering(j);
justering('230020') = -0.992;
justering('383900') = -0.47;
justering('350010a') = 0.06;


scalar_PKBx(part,j) $ j_CCS(j) = 1 + (scalar_PKBx(part,j)-1)*(1+justering(j));


Parameter s_gratiskvoter;
s_gratiskvoter(j) = s_Y.l(j);


variables KE_udled(j), KE_udled_rela(j), T_udled(j), T_udled_rela(j), KB_udled(j), KB_udled_rela(j), C_udled, C_udled_rela; 
set loopstep4(loopstep) /100*339/;
Variables KE_udled_EA(loopstep4,j), KE_udled_rela_EA(loopstep4,j), T_udled_EA(loopstep4,j), T_udled_rela_EA(loopstep4,j), KB_udled_EA(loopstep4,j), KB_udled_rela_EA(loopstep4,j), C_udled_EA(loopstep4), C_udled_rela_EA(loopstep4);

set kilderKE(kilder) /natgas,rafgas,Nordgas,biogas,olie,kul,affald/;


KE_udled.l(j) = 1;
KE_udled_rela.l(j) = 1;
T_udled.l(j) = 1;
T_udled_rela.l(j) = 1;
KB_udled.l(j) = 1;
KB_udled_rela.l(j) = 1;
C_udled.l = 1;
C_udled_rela.l = 1;

KE_udled_EA.l(loopstep4,j) = 1; 
KE_udled_rela_EA.l(loopstep4,j) = 1; 
T_udled_EA.l(loopstep4,j) = 1; 
T_udled_rela_EA.l(loopstep4,j) = 1; 
KB_udled_EA.l(loopstep4,j) = 1; 
KB_udled_rela_EA.l(loopstep4,j) = 1;
C_udled_EA.l(loopstep4) = 1; 
C_udled_rela_EA.l(loopstep4) = 1;


Execute_loadpoint "tilskudssti.gdx";


*display KE_udled_EA.l;
*goto end;

*Initialværdier for CCS-tilskud
s_CCS.fx(part,j) = 700;
*s_CCS.fx(part,'383900') = 1000;
s_KBX.fx(part,'230020') = 0.35;



parameter tilskuddata, d1tilskud, tilskud_rela, tilskud_abso, Eudled70, EudledNu, d1tilskudNU, d1tilskudSUM, PKBtotpre, PKE2pre, PCHngepre;
d1tilskudNU = 1; 

PKBtotpre(j_landxCCS) = PKBtot.l(j_landxCCS);
PKE2pre(j) = PKE2.l(j);
PCHngepre = PCH.l('nge');

set loopstep7(loopstep) /500*699/;
*set loopstep7(loopstep) /500*501/;

d1tilskudSUM(loopstep7) = 0.5;

loop(loopstep7 $ (d1tilskudNU GT 0),

* genberegninger af udledninger
KE_udled.l(j) = sum(kilderKE, Eudled.l(j,kilderKE,'CO2'));
*             +Eudled.l(j,'rafgas','CO2')
*             +Eudled.l(j,'Nordgas','CO2')
*             +Eudled.l(j,'biogas','CO2')
*             +Eudled.l(j,'olie','CO2')
*             +Eudled.l(j,'kul','CO2')
*             +Eudled.l(j,'affald','CO2'); 
KE_udled_rela.l(j) = KE_udled.l(j)/KE2.l(j);
T_udled.l(j) = Eudled.l(j,'BogD','CO2')
             +Eudled.l(j,'BioOlie','CO2');
T_udled_rela.l(j) = T_udled.l(j)/T.l(j);
KB_udled.l(j) = CO2e.l(j) - KE_udled.l(j) - T_udled.l(j);
KB_udled_rela.l(j) $ j_land(j) = KB_udled.l(j) / KBtot.l(j);
C_udled.l = CO2EnergiHH.l;
C_udled_rela.l = CO2EnergiHH.l/CH.l('nge');


* Øget CCS-tilskud indtil fuld opnåelse
s_CCS.fx(part,j) $ (d1KBpartX(part,j) EQ 0) = s_CCS.l(part,j) + 5;
d1tilskud(loopstep7,'350010a','CCS') $ (d1KBpartX('part85','350010a') EQ 0) = 1;
d1tilskud(loopstep7,'383900','CCS')  $ (d1KBpartX('part50','383900')  EQ 0) = 1;


*Tilskud til CCS i cementindustrien
s_KBX.fx(part,'230020') $ (PKBpart.l(part,'230020') lt PKBpartX.l(part,'230020')) = s_KBX.l(part,'230020')  + (1-s_KBX.l(part,'230020'))*0.01;
d1tilskud(loopstep7,'230020','CCS') $ (d1KBpartX('part50','230020') EQ 0) = 1; 


*Tilskud til KEel
*s_KEel.fx(j)                  $ (KE_udled_rela.l(j) gt KE_udled_rela_EA.l('%antal%',j) and PKE2.l(j) GT PKE2pre(j)*0.99) = s_KEel.l(j) + (1-s_KEel.l(j))*0.003;
s_KEel.fx(j)                  $ (KE_udled_rela.l(j) gt KE_udled_rela_EA.l('%antal%',j) and PKE2.l(j) GT PKE2pre(j)*0.99) = s_KEel.l(j) + (1-s_KEel.l(j))*0.002;
s_KEel.fx('230020')           $ (KE_udled_rela.l('230020') gt KE_udled_rela_EA.l('%antal%','230020') and PKE2.l('230020') GT PKE2pre('230020')*0.99) = s_KEel.l('230020') + (1-s_KEel.l('230020'))*0.01;
d1tilskud(loopstep7,j,'keel') $ (KE_udled_rela.l(j) gt KE_udled_rela_EA.l('%antal%',j)) = 1;  
tilskud_rela(loopstep7,j,'keel') = KE_udled_rela.l(j) / KE_udled_rela_EA.l('%antal%',j);
tilskud_abso(loopstep7,j,'keel') = KE_udled.l(j) / KE_udled_EA.l('%antal%',j);

CO2eTax_dummyE(j,kilderKE,'CO2') $ (PKE2.l(j) LT PKE2pre(j)*0.97) = CO2eTax_dummyE(j,kilderKE,'CO2') + 0.2;
CO2eTax_dummyE(j,kilderKE,'CO2') $ (PKE2.l(j) LT PKE2pre(j)*0.998 and KE_udled_rela.l(j) gt KE_udled_rela_EA.l('%antal%',j)) = CO2eTax_dummyE(j,kilderKE,'CO2') + 0.2;

d1tilskud(loopstep7,j,'keCO2')$ (PKE2.l(j) LT PKE2pre(j)*0.97) = 1;
tilskud_rela(loopstep7,j,'keCO2') = PKE2.l(j) / PKE2pre(j);

s_KEel.fx('50000a') = 0;
s_KEel.fx('50000b') = 0;
d1tilskud(loopstep7,'50000a','keel') = 0;
d1tilskud(loopstep7,'50000b','keel') = 0;


*I Kraftvarmeværker gives der ikke tilskud til KE-teknologi, men der indføres en CO2-skat, så gas og kul m.m. udfases
s_KEel.fx('350010a') = 0;
*s_KEel.fx('230020')  = 0;
s_KEel.fx('383900')  = 0;
CO2eTax_dummyE('350010a',kilder,'CO2') $ (KE_udled_rela.l('350010a') gt KE_udled_rela_EA.l('%antal%','350010a')) = CO2eTax_dummyE('350010a',kilder,'CO2') + 0.1; 
*CO2eTax_dummyE('230020',kilder,'CO2')  $ (KE_udled_rela.l('230020')  gt KE_udled_rela_EA.l('%antal%','230020'))  = CO2eTax_dummyE('230020',kilder,'CO2') + 0.1; 
CO2eTax_dummyE('383900',kilder,'CO2')  $ (KE_udled_rela.l('383900')  gt KE_udled_rela_EA.l('%antal%','383900'))  = CO2eTax_dummyE('383900',kilder,'CO2') + 0.1; 
s_Y.fx('350010a') = s_gratiskvoter('350010a') + (sum((kilder,udled_type), TR_Eudled.l('350010a',kilder,udled_type)) + sum(udled_type, TR_Ieudled.l('350010a',udled_type))) / Y.l('350010a');
*s_Y.fx('230020')  = s_gratiskvoter('230020')  + (sum((kilder,udled_type), TR_Eudled.l('230020',kilder,udled_type))  + sum(udled_type, TR_Ieudled.l('230020',udled_type)))  / Y.l('230020');
s_Y.fx('383900')  = s_gratiskvoter('383900')  + (sum((kilder,udled_type), TR_Eudled.l('383900',kilder,udled_type))  + sum(udled_type, TR_Ieudled.l('383900',udled_type)))  / Y.l('383900');
d1tilskud(loopstep7,'350010a','keCO2') = 0;
d1tilskud(loopstep7,'383900','keCO2') = 0;
d1tilskud(loopstep7,'350010a','keel') = 0;
d1tilskud(loopstep7,'383900','keel') = 0;

*Tilskud til reduktionstiltag i landbruget
s_KB.fx(part,j) $ (j_landxCCS(j) and part1_50(part) and (KB_udled_rela.l(j) gt KB_udled_rela_EA.l('%antal%',j))) = s_KB.l(part,j) + (1-s_KB.l(part,j))*0.01;
d1tilskud(loopstep7,j,'kB')        $ (j_landxCCS(j) and (KB_udled_rela.l(j) gt KB_udled_rela_EA.l('%antal%',j))) = 1;  
tilskud_rela(loopstep7,j,'kB')     $ j_landxCCS(j) = KB_udled_rela.l(j) / KB_udled_rela_EA.l('%antal%',j);
tilskud_abso(loopstep7,j,'kB')                     = KB_udled.l(j) / KB_udled_EA.l('%antal%',j);
CO2eTax_dummyIE(j_landxCCS,udled_type) $ (PKBtot.l(j_landxCCS) LT PKBtotpre(j_landxCCS)*0.99) = CO2eTax_dummyIE(j_landxCCS,udled_type) + 0.1;
d1tilskud(loopstep7,j_landxCCS,'kbCO2e') $ (PKBtot.l(j_landxCCS) LT PKBtotpre(j_landxCCS)*0.99) = 1;
tilskud_rela(loopstep7,j,'kBCOe')     $ j_landxCCS(j) = PKBtot.l(j) / PKBtotpre(j);

s_KB.fx(part,'01000d') = 0;
d1tilskud(loopstep7,'01000d','kB') = 0;
CO2eTax_dummyIE('01000d',udled_type) = 0;




*Tilskud til grøn transport i industrien (dog ikke til fly, skib og udenlandsk vejtransport)
s_TTE.fx(j)                  $ (T_udled_rela.l(j) gt T_udled_rela_EA.l('%antal%',j)) = s_TTE.l(j) + (1-s_TTE.l(j))*0.01;
s_TTE.fx('50000a' ) = 0; 
s_TTE.fx('50000b' ) = 0; 
s_TTE.fx('51000a' ) = 0; 
s_TTE.fx('51000b' ) = 0; 
s_TTE.fx('490030b') = 0;
d1tilskud(loopstep7,j,'TTE') $ (T_udled_rela.l(j) gt T_udled_rela_EA.l('%antal%',j)) = 1;
d1tilskud(loopstep7,'50000a' ,'TTE') = 0;
d1tilskud(loopstep7,'50000b' ,'TTE') = 0;
d1tilskud(loopstep7,'51000a' ,'TTE') = 0;
d1tilskud(loopstep7,'51000b' ,'TTE') = 0;
d1tilskud(loopstep7,'490030b','TTE') = 0;
tilskud_rela(loopstep7,j,'TTE') = T_udled_rela.l(j) / T_udled_rela_EA.l('%antal%',j);
tilskud_abso(loopstep7,j,'TTE') = T_udled.l(j) / T_udled_EA.l('%antal%',j);


tilskud_abso(loopstep7,j,'TOT') = T_udled.l(j) + KB_udled.l(j) + KE_udled.l(j) - T_udled_EA.l('%antal%',j) - KB_udled_EA.l('%antal%',j) - KE_udled_EA.l('%antal%',j);

*prePKBtot(j) = PKBtot.l(j);
*prePT(j) = PT.l(j);


*Tilskud til husholdninger
tDuty_cD.fx('350010a','tax8') $ (C_udled_rela.l gt C_udled_rela_EA.l('%antal%') and PCH.l('nge') GT PCHngepre*0.99)    = tDuty_cD.l('350010a','tax8') - 0.01; 
tDuty_cF.fx('350010a','tax8') $ (C_udled_rela.l gt C_udled_rela_EA.l('%antal%') and PCH.l('nge') GT PCHngepre*0.99)    = tDuty_cF.l('350010a','tax8') - 0.01;
tDuty_cD.fx('350010b','tax8') $ (C_udled_rela.l gt C_udled_rela_EA.l('%antal%') and PCH.l('nge') GT PCHngepre*0.99)    = tDuty_cD.l('350010b','tax8') - 0.01; 
tDuty_cF.fx('350010b','tax8') $ (C_udled_rela.l gt C_udled_rela_EA.l('%antal%') and PCH.l('nge') GT PCHngepre*0.99)    = tDuty_cF.l('350010b','tax8') - 0.01;

d1kildertaxHH('BogD')   $ (PCH.l('nge') LT PCHngepre*0.998) = d1kildertaxHH('BogD') + 0.1;
d1kildertaxHH('Olie')   $ (PCH.l('nge') LT PCHngepre*0.998) = d1kildertaxHH('Olie') + 0.1;
d1kildertaxHH('NatGas') $ (PCH.l('nge') LT PCHngepre*0.998) = d1kildertaxHH('NatGas') + 0.1;
 
d1tilskud(loopstep7,'01000a','CH') $ (C_udled_rela.l gt C_udled_rela_EA.l('%antal%')) = 1; 
d1tilskud(loopstep7,'01000a','CHco2') $ (PCH.l('nge') LT PCHngepre*0.99) = 1; 

tilskud_rela(loopstep7,'01000a','CH') = C_udled_rela.l / C_udled_rela_EA.l('%antal%'); 
tilskud_rela(loopstep7,'01000a','CHco2') = PCH.l('nge') / PCHngepre; 
 
*Sammentælling 
 d1tilskudSUM(loopstep7) = sum(j, d1tilskud(loopstep7,j,'kB')+d1tilskud(loopstep7,j,'keel')+d1tilskud(loopstep7,j,'TTE')+d1tilskud(loopstep7,j,'CCS')+d1tilskud(loopstep7,j,'keCO2')+d1tilskud(loopstep7,j,'kbCO2e'))+d1tilskud(loopstep7,'01000a','CH')+d1tilskud(loopstep7,'01000a','CHco2');
 d1tilskudNU = d1tilskudSUM(loopstep7);


* ------ Standard initialisering mht. CCS/BECCS

* PKBpartX udregnes partielt inden modellen køres for at afgøre, om CCS skal slås til
PKBpartX.l(part,j) $ j_CCS(j) = scalar_PKBx(part,j) * (1+tFak_B.l(j))*ucB.l(j)*PInvB.l(j) - CCSprKBx.l(j)*1000 * BECCSshare.l(j) * s_CCS.l(part,j) * 10**(-9);


*Angivelse af, om backstop-teknologier skal anvendes. CCS slås til, hvis PKBpartX er lavere end PKBpart
d1KBpartX(part,j_land) $ (PKBpart.l(part,j_land) gt (1-s_KBx.l(part,j_land))*PKBpartX.l(part,j_land)) = 1;


*Ved CCS er KBpartX endogen, ellers er KBpart endogen
KBpartX.fx(part,j_land) $ (d1KBpartX(part,j_land) eq 0) = 0;
KBpart.fx(part,j_land)  $ (d1KBpartX(part,j_land) eq 1) = 0;
KBpartX.lo(part,j_land) $ (d1KBpartX(part,j_land) eq 1) = -inf;
KBpartX.up(part,j_land) $ (d1KBpartX(part,j_land) eq 1) =  inf;


*PKBpartX låses for at undgå negativ pris - tilskuddet tager tilpasningen
PKBpartX.fx(part,'350010a')  $ (d1KBpartX(part,'350010a') eq 1) = PKBpartX.l(part,'350010a');
s_CCS.lo(part,'350010a') $ (d1KBpartX(part,'350010a') eq 1) = -inf;
s_CCS.up(part,'350010a') $ (d1KBpartX(part,'350010a') eq 1) =  inf;


* --------- modellen løses

solve static_fremskriv using cns;

Tilskuddata(loopstep7,'CO2e') = CO2eDK.l;
Tilskuddata(loopstep7,'KEel') = sum(j,Subs_KEel.l(j));
Tilskuddata(loopstep7,'KB') = sum(j,Subs_KB.l(j));

);

execute_unload "gekko\gdx_work\%filnavn%.gdx";

$label end;
