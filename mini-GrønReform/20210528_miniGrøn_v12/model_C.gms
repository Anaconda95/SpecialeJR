Equations
E_HHEnergiGJOlie
E_HHEnergiGJBogD
E_HHEnergiGJBioOlie
E_HHEnergiGJNatGas
E_HHEnergiGJBiogas
E_HHEnergiGJVEVarm
E_HHEnergiGJFjVarm
E_HHEnergiGJEl


E_PCH_i190000a
E_PCH_i350020a

E_EudledHH(kilder,udled_type)
E_TR_EudledHH(kilder,udled_type)
E_EVAir_HH(kilder,udled_type)

E_PSaldonynyNY

E_CO2EnergiHH
E_CO2BogDHH
E_CO2eMLFHH
E_CO2eHH
E_CO2eInt_vej
E_CO2eInt_soe
E_CO2eInt_luft
E_CO2eDK

E_CO2En_exBoD(j)
E_CO2En_EloV
E_CO2En_Olier
E_CO2En_Indv
E_CO2En_Fora
E_CO2En_Luft
E_CO2En_Vej_hh
E_CO2En_Vej_virk
E_CO2En_Jernb
E_CO2En_Soe
E_CO2En_SeOff
E_CO2En_hh
E_CO2En_Lmv
E_CO2IEn_Cement
E_CO2En_Nordsoe
E_Co2En_Raf
E_CO2e_Veg
E_CO2e_Kvaeg
E_CO2e_Svin
E_CO2e_Fjerkraemv
E_CO2_Other
E_CH4_Other
E_N2O_Other
E_Flour_J(j)
E_Flour_Other

E_EVAirTot

E_NG_GJ_inklC
E_BG_GJ_inklC
E_OP_GJ_inklC
E_BO_GJ_inklC
E_BogD_GJ_inklC
E_BogDvej_GJ_inklC

E_EltotinklC
E_ElvindinklC
E_ElfossilinklC
E_ElkraftinklC
E_ElaffaldinklC
E_FVinklC
E_FVkraftinklC
E_FVaffaldinklC
E_FVxinklC
E_FVfossilinklC
E_FVVEinklC

E_Elproduktion_vind
E_Elproduktion_kraft
E_Elproduktion_affald
E_Elnettoeksport

E_Import(j)
E_Eksport(j)
;

GROUP ENDO_NEW4
HHEnergiGJ(kilder)           'Antal mia. GJ energi anvendt af husholdningerne (dog ikke GJ for el og FV)'
EudledHH(kilder,udled_type)
TR_EudledHH(kilder,udled_type)
EVAir_HH(kilder,udled_type)

CO2EnergiHH
CO2BogDHH
CO2eMLFHH
CO2eHH   
CO2eInt_vej
CO2eInt_soe
CO2eInt_luft
CO2eDK

CO2En_exBoD(j)
CO2En_EloV
CO2En_Olier
CO2En_Indv
CO2En_Fora
CO2En_Luft
CO2En_Vej_hh
CO2En_Vej_virk
CO2En_Jernb
CO2En_Soe
CO2En_SeOff
CO2En_hh
CO2En_Lmv
CO2IEn_Cement
CO2En_Nordsoe
Co2En_Raf
CO2e_Veg
CO2e_Kvaeg
CO2e_Svin
CO2e_Fjerkraemv
CO2_Other
CH4_Other
N2O_Other
Flour_J(j)
Flour_Other

EVAirTot

NG_GJ_inklC
BG_GJ_inklC
OP_GJ_inklC
BO_GJ_inklC
BogD_GJ_inklC
BogDvej_GJ_inklC

EltotinklC
ElvindinklC
ElfossilinklC
ElkraftinklC
ElaffaldinklC
FVinklC
FVkraftinklC
FVaffaldinklC
FVxinklC
FVfossilinklC
FVVEinklC

Elproduktion_vind
Elproduktion_kraft
Elproduktion_affald
Elnettoeksport

Import(j)
Eksport(j)
;

GROUP EKSO_NEW4
test2
c_HH_GJ(kilder)
c_HH_GJ_190000a
c_Olieandel
;

GROUP J_LED_NEW4
J_test    
J_HHEnergiGJ(kilder)
J_EudledHH(kilder,udled_type)
J_TR_EudledHH(kilder,udled_type)
J_EVAir_HH(kilder,udled_type)
J_PCH_i190000a
J_PCH_i350020a

J_CO2EnergiHH
J_CO2BogDHH
J_CO2eMLFHH
J_CO2eHH
J_CO2eInt_vej
J_CO2eInt_soe
J_CO2eInt_luft
J_CO2eDK

J_CO2En_exBoD(j)
J_CO2En_EloV
J_CO2En_Olier
J_CO2En_Indv
J_CO2En_Fora
J_CO2En_Luft
J_CO2En_Vej_hh
J_CO2En_Vej_virk
J_CO2En_Jernb
J_CO2En_Soe
J_CO2En_SeOff
J_CO2En_hh
J_CO2En_Lmv
J_CO2IEn_Cement
J_CO2En_Nordsoe
J_Co2En_Raf
J_CO2e_Veg
J_CO2e_Kvaeg
J_CO2e_Svin
J_CO2e_Fjerkraemv
J_CO2_Other
J_CH4_Other
J_N2O_Other
J_Flour_J(j)
J_Flour_other

J_EVAirTot

J_NG_GJ_inklC
J_BG_GJ_inklC
J_OP_GJ_inklC
J_BO_GJ_inklC
J_BogD_GJ_inklC
J_BogDvej_GJ_inklC

J_EltotinklC
J_ElvindinklC
J_ElfossilinklC
J_ElkraftinklC
J_ElaffaldinklC
J_FVinklC
J_FVkraftinklC
J_FVaffaldinklC
J_FVxinklC
J_FVfossilinklC
J_FVVEinklC

J_Elproduktion_vind
J_Elproduktion_kraft
J_Elproduktion_affald
J_Elnettoeksport

J_Import(j)
J_Eksport(j)
;

Parameter
test3
AnvGJ_hh(hh_c,kilder)
Emiss_E_hh(hh_c,kilder,udled_type)
EkoeffHH(kilder,udled_type)
Enhedsp_E_hh(hh_c,kilder,udled_type)
Enhedsp_E_hh_Avg(kilder,udled_type)
d1kildertaxHH(kilder)
d1EudledHH(kilder,udled_type)
d1HHEnergiGJ(kilder)
J_vaegtHH(kilder)
vaegtHH(dci,kilder)
vaegtUPSHH(dci)
HHEnergiGJ0(kilder)
CH0(dc)

Elproduktion_vind0
Elproduktion_kraft0
Elproduktion_affald0
Elnettoeksport0

CO2EDK0

CO2En_EloV0
CO2En_Olier0
CO2En_Indv0
CO2En_Fora0
CO2En_Luft0
CO2En_Vej_hh0
CO2En_Vej_virk0
CO2En_Jernb0
CO2En_Soe0
CO2En_SeOff0
CO2En_hh0
CO2En_Lmv0
CO2IEn_Cement0
CO2En_Nordsoe0
Co2En_Raf0
CO2e_Veg0
CO2e_Kvaeg0
CO2e_Svin0
CO2e_Fjerkraemv0
CO2_Other0
CH4_Other0
N2O_Other0
*Flour0

NG_GJ_inklC0
BG_GJ_inklC0
OP_GJ_inklC0
BO_GJ_inklC0
BogD_GJ_inklC0
BogDvej_GJ_inklC0

FVVEinklC0
FVfossilinklC0

Import0(j)
Eksport0(j)
;

*------------------------------------------------------------
*Modelligninger
*------------------------------------------------------------

E_HHEnergiGJOlie..    HHEnergiGJ('Olie')    =E= J_HHEnergiGJ('Olie') + c_Olieandel * c_HH_GJ_190000a * CH('190000a');
E_HHEnergiGJBogD..    HHEnergiGJ('BogD')    =E= J_HHEnergiGJ('BogD') + (1-c_Olieandel) * c_HH_GJ_190000a * CH('190000a');
E_HHEnergiGJBioOlie.. HHEnergiGJ('BioOlie') =E= J_HHEnergiGJ('BioOlie') + c_HH_GJ('BioOlie') * CH('190000b');
E_HHEnergiGJNatGas..  HHEnergiGJ('NatGas')  =E= J_HHEnergiGJ('NatGas') + c_HH_GJ('NatGas') * CH('350020a');
E_HHEnergiGJBiogas..  HHEnergiGJ('Biogas')  =E= J_HHEnergiGJ('Biogas') + c_HH_GJ('Biogas') * CH('350020b');
E_HHEnergiGJVEVarm..  HHEnergiGJ('VEVarm')  =E= J_HHEnergiGJ('VEVarm') + c_HH_GJ('VEVarm') * CH('350030b');

*E_HHEnergiGJFjVarm..  HHEnergiGJ('FjVarm')  =E= J_HHEnergiGJ('FjVarm') + c_HH_GJ('FjVarm') * ( IO_vaegt('350030a','FjVarm') * CH('350030a')
*                                                                                             + IO_vaegt('350010a','FjVarm') * CH('350010a')
*                                                                                             + IO_vaegt('383900','FjVarm') * CH('383900') );
*
*E_HHEnergiGJEl..          HHEnergiGJ('El')  =E= J_HHEnergiGJ('El') + c_HH_GJ('El') * ( IO_vaegt('350010a','el') * CH('350010a')
*                                                                                     + IO_vaegt('350010b','el') * CH('350010b')
*                                                                                     + IO_vaegt('383900','el') * CH('383900') );

E_HHEnergiGJFjVarm..  HHEnergiGJ('FjVarm')  =E= J_HHEnergiGJ('FjVarm') + sum(dci,vaegtHH(dci,'FjVarm') * CH(dci));
E_HHEnergiGJEl..      HHEnergiGJ('El')      =E= J_HHEnergiGJ('El')     + sum(dci,vaegtHH(dci,'El')     * CH(dci));

*E_Eltot..                             Eltot =E= J_Eltot + HHEnergiGJ('El') + sum(j,el_energi(j));

*E_PCH_iNY(dci) $ d1CH(dci)..        PCH(dci) =e= j_PCH_i(dci) + sum(i $ mapdc2i(i,dci), PC(i)) + CO2epermia(dci) * CO2eTax;

E_PCH_i190000a..        PCH('190000a') =e= j_PCH_i190000a + PC('190000a')+ sum(udled_type, TR_EudledHH('olie',udled_type)+TR_EudledHH('BogD',udled_type))/CH('190000a');

E_PCH_i350020a..        PCH('350020a') =e= j_PCH_i350020a + PC('350020a') + sum(udled_type, TR_EudledHH('NatGas',udled_type))/CH('350020a');


* For CO2: antal mia. GJ gange kg. per GJ gange 10**(3) = antal 1.000 tons CO2
* For øvrige: antal mia. GJ gange gram per GJ gange 10**(3) = antal tons af X
E_EudledHH(kilder,udled_type) $ d1EudledHH(kilder,udled_type)..   EudledHH(kilder,udled_type) =E= J_EudledHH(kilder,udled_type) + HHEnergiGJ(kilder) * EkoeffHH(kilder,udled_type) * 10**(3);

* afgift i kr. per ton CO2e gange antal ton CO2-ækvivalent gange 10**(-9) = provenu i mia. kr.
E_TR_EudledHH(kilder,udled_type) $ d1EudledHH(kilder,udled_type).. TR_EudledHH(kilder,udled_type) =E= J_TR_EudledHH(kilder,udled_type) + EudledHH(kilder,udled_type)*CO2eVaegt(udled_type) * CO2eTax * 10**(-9) * d1kildertaxHH(kilder); 

* Helbredsomkostninger fra luftforurening: Enhedsværdier i kr. per kg emission gange antal ton emission gange 10**(-6) = værdi i mia. kr.
E_EVAir_HH(kilder,udled_type) $ d1EudledHH(kilder,udled_type).. EVAir_HH(kilder,udled_type) =E= J_EVAir_HH(kilder,udled_type) + EudledHH(kilder,udled_type)*Enhedsp_E_hh_Avg(kilder,udled_type) * 10**(-6); 

*E_PSaldonynyNY..   PSaldo =e=  J_PSaldo + TRAfgifter + TRw + TRcap + TRcor + TRprod + sum((j,kilder,udled_type), TR_Eudled(j,kilder,udled_type)) + sum((kilder,udled_type), TR_EudledHH(kilder,udled_type)) + sum((j,udled_type), TR_Ieudled(j,udled_type)) - sum(j,NegaUdled(j)*CO2eTax*10**(-6)) - Overf - Gval - Lump - CCSExp;   
E_PSaldonynyNY..   PSaldo =e=  J_PSaldo + TRAfgifter + TRw + TRcap + TRcor + TRprod + sum((j,kilder,udled_type), TR_Eudled(j,kilder,udled_type)) + sum((kilder,udled_type), TR_EudledHH(kilder,udled_type)) + sum((j,udled_type), TR_Ieudled(j,udled_type)) - sum((part,j),NegaUdled(part,j)*s_CCS(part,j)*10**(-6)) - Overf - Gval - Lump - CCSExp;


E_CO2EnergiHH..       CO2EnergiHH =E= J_CO2EnergiHH + sum(kilder,EudledHH(kilder,'CO2'));
E_CO2BogDHH..           CO2BogDHH =E= J_CO2BogDHH   + EudledHH('BogD','CO2');
E_CO2eMLFHH..           CO2eMLFHH =E= J_CO2eMLFHH   + sum((kilder,udled_type), EudledHH(kilder,udled_type) * CO2eVaegt(udled_type)/1000) - sum(kilder, EudledHH(kilder,'CO2'));
E_CO2eHH..                 CO2eHH =E= J_CO2eHH + CO2EnergiHH + CO2eMLFHH;

E_CO2eInt_vej..       CO2eInt_vej =E= J_CO2eInt_vej + SUM(udled_type, Eudled.l('490030b','BogD',udled_type)* CO2eVaegt(udled_type))/1000;
E_CO2eInt_soe..       CO2eInt_soe =E= J_CO2eInt_soe + SUM(udled_type, Eudled.l('50000b','BogD',udled_type)* CO2eVaegt(udled_type))/1000;
E_CO2eInt_luft..     CO2eInt_luft =E= J_CO2eInt_luft + SUM(udled_type, Eudled.l('51000b','BogD',udled_type)* CO2eVaegt(udled_type))/1000;

E_CO2eDK..                 CO2eDK =E= J_CO2eDK + CO2eHH + SUM(j,CO2e(j)) - CO2eInt_vej - CO2eInt_soe - CO2eInt_luft;

E_EVAirTot..             EVAirTot =E= J_EVAirTot + SUM((j,kilder,udled_type), EVAir_E(j,kilder,udled_type)) + SUM((j,udled_type), EVAir_IE(j,udled_type)) + SUM((kilder,udled_type), EVAir_HH(kilder,udled_type));

E_NG_GJ_inklC..   NG_GJ_inklC =E= J_NG_GJ_inklC + SUM(j, energiGJ(j,'natgas')) + HHEnergiGJ('NatGas');
E_BG_GJ_inklC..   BG_GJ_inklC =E= J_BG_GJ_inklC + SUM(j, energiGJ(j,'biogas')) + HHEnergiGJ('Biogas');
E_OP_GJ_inklC..   OP_GJ_inklC =E= J_OP_GJ_inklC + SUM(j, energiGJ(j,'olie')) + HHEnergiGJ('Olie');
E_BO_GJ_inklC..   BO_GJ_inklC =E= J_BO_GJ_inklC + SUM(j, energiGJ(j,'BioOlie')) + HHEnergiGJ('BioOlie');
E_BogD_GJ_inklC.. BogD_GJ_inklC =E= J_BogD_GJ_inklC + SUM(j, energiGJ(j,'BogD')) + HHEnergiGJ('BogD');
E_BogDvej_GJ_inklC.. BogDvej_GJ_inklC =E= J_BogDvej_GJ_inklC + SUM(j $ (not j_soe_og_luft(j)), energiGJ(j,'BogD')) + HHEnergiGJ('BogD');

*E_K_GJ_inklC..    K_GJ_inklC =E= SUM(j, energiGJ(j,'kul'));
*E_A_GJ_inklC..    A_GJ_inklC =E= SUM(j, energiGJ(j,'Affald'));
*E_H_GJ_inklC..    H_GJ_inklC =E= SUM(j, energiGJ(j,'Halm'));
*E_T_GJ_inklC..    T_GJ_inklC =E= SUM(j, energiGJ(j,'Tpiller'));
*E_B_GJ_inklC..    B_GJ_inklC =E= SUM(j, energiGJ(j,'Tbra'));

E_EltotinklC..    EltotinklC    =E= J_EltotinklC    + ElvindinklC + ElfossilinklC;
E_ElvindinklC..   ElvindinklC   =E= J_ElvindinklC   + Elvind   + vaegtHH('350010b','El') * CH('350010b');
E_ElfossilinklC.. ElfossilinklC =E= J_ElfossilinklC + ElkraftinklC + ElaffaldinklC;
E_ElkraftinklC..  ElkraftinklC  =E= J_ElkraftinklC  + Elkraft  + vaegtHH('350010a','El') * CH('350010a');
E_ElaffaldinklC.. ElaffaldinklC =E= J_ElaffaldinklC + Elaffald + vaegtHH('383900','El')  * CH('383900');
E_FVinklC..       FVinklC       =E= J_FVinklC       + FVkraftinklC + FVaffaldinklC + FVxinklC;
E_FVkraftinklC..  FVkraftinklC  =E= J_FVkraftinklC  + sum(j, FV_kraftandel(j)*FV_energi(j))  + vaegtHH('350010a','FjVarm') * CH('350010a');
E_FVaffaldinklC.. FVaffaldinklC =E= J_FVaffaldinklC + sum(j, FV_Renoandel(j) *FV_energi(j))  + vaegtHH('383900','FjVarm')  * CH('383900');
E_FVxinklC..      FVxinklC      =E= J_FVxinklC      + FVfossilinklC + FVVEinklC;
E_FVfossilinklC.. FVfossilinklC =E= J_FVfossilinklC + FVfossil + vaegtHH('350030a','FjVarm') * CH('350030a');
E_FVVEinklC..     FVVEinklC     =E= J_FVVEinklC     + FVVE     + vaegtHH('350030b','FjVarm') * CH('350030b');

E_Import(j)..      Import(j)  =E= J_Import(j)  + sum(i, xF(i,j)) + ExF(j) + cF(j) + sum(i, IBIF(i,j) + IMIF(i,j)) + ILF(j) + gF(j);
E_Eksport(j)..     Eksport(j) =E= J_Eksport(j) + ExD(j) + ExF(j);

E_Elproduktion_vind..    Elproduktion_vind   =E= J_Elproduktion_vind   + ElvindinklC   + Ex('350010b') - Import('350010b');
E_Elproduktion_kraft..   Elproduktion_kraft  =E= J_Elproduktion_kraft  + ElkraftinklC  + Ex('350010a') - Import('350010a');
E_Elproduktion_affald..  Elproduktion_affald =E= J_Elproduktion_affald + ElaffaldinklC + Ex('383900')  - Import('383900');
E_Elnettoeksport..       Elnettoeksport      =E= J_Elnettoeksport + Eksport('350010b') - Import('350010b') + Eksport('350010a') - Import('350010a') + Eksport('383900')  - Import('383900');

* * * * * * Pejlemærker for energirelaterede CO2-emissioner * * * * * *

E_CO2En_exBoD(j)..   CO2En_exBoD(j) =E= J_CO2En_exBoD(j) + CO2Energi(j) - CO2BogD(j);

*El og varme
E_CO2En_EloV..           CO2En_EloV =E= J_CO2En_EloV + CO2En_exBoD('350010a') + CO2En_exBoD('350010b') + CO2En_exBoD('350020a') + CO2En_exBoD('350020b') + CO2En_exBoD('350030a') + CO2En_exBoD('350030b') + CO2En_exBoD('383900');

*Olieraffinaderier
E_CO2En_Olier..         CO2En_Olier =E= J_CO2En_Olier + CO2En_exBoD('190000a') + CO2En_exBoD('190000b');

*Indvinding
E_CO2En_Indv..           CO2En_Indv =E= J_CO2En_Indv + CO2En_exBoD('060000a') + CO2En_exBoD('060000b') + CO2En_exBoD('080090');

*Forarbejdning
E_CO2En_Fora..           CO2En_Fora =E= J_CO2En_Fora + CO2En_exBoD('100010a') + CO2En_exBoD('100010b') + CO2En_exBoD('100010c') + CO2En_exBoD('100020') + CO2En_exBoD('100030') + CO2En_exBoD('100040') + CO2En_exBoD('100050') + CO2En_exBoD('11200') + CO2En_exBoD('Industri') + CO2En_exBoD('160000') + CO2En_exBoD('200010') + CO2En_exBoD('200020') + CO2En_exBoD('210000') + CO2En_exBoD('220000') + CO2En_exBoD('230010') + CO2En_exBoD('230020') + CO2En_exBoD('240000') + CO2En_exBoD('250000') + CO2En_exBoD('280010') + CO2En_exBoD('280020') + CO2En_exBoD('36700');

*Luftfart
E_CO2En_Luft..           CO2En_Luft =E= J_CO2En_Luft + CO2En_exBoD('51000a')  + CO2En_exBoD('51000b')  + CO2BogD('51000a');

*Vejtransport
E_CO2En_Vej_hh..       CO2En_Vej_hh =E= J_CO2En_Vej_hh + CO2BogDHH;

E_CO2En_Vej_virk..     CO2En_Vej_virk =E= J_CO2En_Vej_virk + CO2En_exBoD('490030a') + CO2En_exBoD('490030b') + SUM(j, CO2BogD(j)) - CO2BogD('490030b') - CO2BogD('50000a') - CO2BogD('50000b') - CO2BogD('51000a') - CO2BogD('51000b');

*Jernbane
E_CO2En_Jernb..         CO2En_Jernb =E= J_CO2En_Jernb + CO2En_exBoD('490012');
 
*Søfart
E_CO2En_Soe..             CO2En_Soe =E= J_CO2En_Soe + CO2En_exBoD('50000a') + CO2En_exBoD('50000b') + CO2BogD('50000a');

*Service og offentlig
E_CO2En_SeOff..         CO2En_SeOff =E= J_CO2En_SeOff + CO2En_exBoD('410009') + CO2En_exBoD('420000') + CO2En_exBoD('43000') + CO2En_exBoD('45000') + CO2En_exBoD('460000') + CO2En_exBoD('470000') + CO2En_exBoD('52000') + CO2En_exBoD('53000') + CO2En_exBoD('550000') + CO2En_exBoD('560000') + CO2En_exBoD('Tjenester') + CO2En_exBoD('Boliger') + CO2En_exBoD('Offentlig') + CO2En_exBoD('79000');

*Husholdninger
E_CO2En_hh..               CO2En_hh =E= J_CO2En_hh + CO2EnergiHH - CO2BogDHH;

*Landbrug mv.
E_CO2En_Lmv..             CO2En_Lmv =E= J_CO2En_Lmv + CO2En_exBoD('01000a') + CO2En_exBoD('01000b') + CO2En_exBoD('01000c') + CO2En_exBoD('01000d') + CO2En_exBoD('020000') + CO2En_exBoD('030000');

* Nordsø og raffinaderier
E_CO2En_Nordsoe..         CO2En_Nordsoe =E= J_CO2En_Nordsoe + CO2En_exBoD('060000a') + CO2En_exBoD('060000b');

E_CO2En_Raf..             CO2En_Raf =E= J_CO2En_Raf + CO2En_exBoD('190000a') + CO2En_exBoD('190000b');

* * * * * * Pejlemærker for ikke-energirelaterede emissioner af CO2, CH4 og N2O * * * * * *

*Cement
E_CO2IEn_Cement..     CO2IEn_Cement =E= J_CO2IEn_Cement + CO2Ie('230020');

*Landbrug
E_CO2e_Veg..          CO2e_Veg =E= J_CO2e_Veg + SUM(udled_type, Ieudled('01000a',udled_type) * CO2eVaegt(udled_type))/1000;

E_CO2e_Kvaeg..         CO2e_Kvaeg =E= J_CO2e_Kvaeg + SUM(udled_type, Ieudled('01000b',udled_type) * CO2eVaegt(udled_type))/1000;

E_CO2e_Svin..         CO2e_Svin =E= J_CO2e_Svin + SUM(udled_type, Ieudled('01000c',udled_type) * CO2eVaegt(udled_type))/1000;

E_CO2e_Fjerkraemv..         CO2e_Fjerkraemv =E= J_CO2e_Fjerkraemv + SUM(udled_type, Ieudled('01000d',udled_type) * CO2eVaegt(udled_type))/1000;



* * * * * * Øvrig CO2, CH4, N2O og flour, ekskl. international transport * * * * * *

E_CO2_Other..         CO2_Other =E= J_CO2_Other + SUM(j, Ieudled(j,'CO2')) - CO2IEn_Cement - Ieudled('01000a','CO2') - Ieudled('01000b','CO2') - Ieudled('01000c','CO2') - Ieudled('01000d','CO2');

E_CH4_Other..         CH4_Other =E= J_CH4_Other + (SUM((j,kilder), Eudled(j,kilder,'CH4')) - (Eudled('490030b','BogD','CH4') + Eudled('50000b','BogD','CH4') + Eudled('51000b','BogD','CH4')) + SUM(kilder, EudledHH(kilder,'CH4')) + SUM(j, Ieudled(j,'CH4')) - Ieudled('01000a','CH4') - Ieudled('01000b','CH4') - Ieudled('01000c','CH4') - Ieudled('01000d','CH4')) * CO2eVaegt('CH4')/1000;

E_N2O_Other..         N2O_Other =E= J_N2O_Other + (SUM((j,kilder), Eudled(j,kilder,'N2O')) - (Eudled('490030b','BogD','N2O') + Eudled('50000b','BogD','N2O') + Eudled('51000b','BogD','N2O')) + SUM(kilder, EudledHH(kilder,'N2O')) + SUM(j, Ieudled(j,'N2O')) - Ieudled('01000a','N2O') - Ieudled('01000b','N2O') - Ieudled('01000c','N2O') - Ieudled('01000d','N2O')) * CO2eVaegt('N2O')/1000;

E_Flour_J(j)..             Flour_J(j) =E= J_Flour_J(j) + Ieudled(j,'SF6') * CO2eVaegt('SF6')/1000 + Ieudled(j,'PFC') * CO2eVaegt('PFC')/1000 + Ieudled(j,'HFC') * CO2eVaegt('HFC')/1000;

E_Flour_Other..             Flour_Other =E= J_Flour_Other + SUM(j, Flour_J(j)) - sum(j $ j_land(j), Flour_J(j)); 
*------------------------------------------------------------
*Data
*------------------------------------------------------------

*Indlæs data 
$GDXIN data_16_E.gdx
$LOAD AnvGJ_hh, Emiss_E_hh, Enhedsp_E_hh
$GDXIN

*Sæt parametre
d1kildertaxHH(kilder) = 0;
d1kildertaxHH('BogD') = 1;
d1kildertaxHH('Olie') = 1;
d1kildertaxHH('NatGas') = 1;

*Elasticiteter
$ontext
         C
      / 0.3 \
  Bolig      ih
         /  0.5   \
      inge        nge
            /     0.4     \
     ng                      ne
   / 0.4 \               /   0.4    \
190000a 190000b      neEL               neV
                   / 0.2 \             / 0.1   \
               neELEL neReno       neGAS        neFV
              /  2 \    \          / 2 \     /  1.5  \  
          350010a ..b  383900  350020a ..b  350030a ..b
$offtext

*'Mellem reno og kraftværk eller vind'
ECH.l('neEL') = 0.2;  
*'Mellem varme fra gas eller fjernvarme'
ECH.l('neV') = 0.1; 
*'lige linje - elasticitet ligegyldig'
ECH.l('neReno') = 2; 
*'Mellem kraftværk og vind'
ECH.l('neELEL') = 2; 
*'Mellem naturgas og biogas' 
ECH.l('neGAS') = 2; 
*'mellem fossil FV og VE FV'
ECH.l('neFV') = 1.5; 

$ontext
      a                                      nf                                                                              
   / 0.1 \                                / 0.1 \                                                                               
020000   a1                            11200    nf1                                                                              
       / 0.85 \                               / 0.85 \                                                                              
    01000a    a2                           100050    nf2                                                                              
           / 0.85 \                               / 0.85 \                                                                              
        030000    a3                           100040    nf3                                                                              
               / 0.9 \                                / 0.59 \                                                                              
            01000d   a4                            100030   nf4                                                                              
                  /  1.5  \                              /  0.53 \                                    
              01000b     01000c                      100020      nf5
                                                               /  0.9  \ 
                                                          100010c      nf6
                                                                    /  1.5  \ 
                                                               100010a     100010b           
$offtext

*Mellem fødevarer og "Drikke- og tobaksvareindustri"
ECH.l('nf') = 0.1;
ECH.l('a') = 0.1;
*Mellem brød og animal og "Anden fødevareindustri"
ECH.l('nf1') = 0.85;
*Mellem animal og "Bagerier, brødfabrikker mv."
ECH.l('nf2') = 0.85;
ECH.l('a1') = 0.85;
*Mellem ikke-mejeri og "Mejerier"
ECH.l('nf3') = 0.59;
*Mellem kød og "Fiskeindustri"
ECH.l('nf4') = 0.53;
ECH.l('a2') = 0.53;
*Mellem rødt kød og "Slagterier (fjerkræ mv.)"
ECH.l('nf5') = 0.9;
ECH.l('a3') = 0.9;
*Mellem "Slagterier (kvæg)" og "Slagterier (svin)"
ECH.l('nf6') = 1.5;
ECH.l('a4') = 1.5;
*display ECH.l;
*$exit


*Mængdevariable sættes
HHEnergiGJ.l(kilder) = sum(hh_c,AnvGJ_hh(hh_c,kilder)) * 10**(-9);
HHEnergiGJ.l('el')   = sum(hh_c,anvKbin_hh(hh_c,'el'))*10**(-6);
HHEnergiGJ.l('FjVarm')   = sum(hh_c,anvKbin_hh(hh_c,'FjVarm'))*10**(-6);

HHEnergiGJ0(kilder) = HHEnergiGJ.l(kilder);

d1HHEnergiGJ(kilder) = 1 $ ((HHEnergiGJ.l(kilder) gt 0) OR (HHEnergiGJ.l(kilder) gt 0));

EkoeffHH(kilder,udled_type) $ HHEnergiGJ.l(kilder) = sum(hh_c,Emiss_E_hh(hh_c,kilder,udled_type))/HHEnergiGJ.l(kilder)/1000;
EkoeffHH('BogD','CO2') =  (sum(hh_c,Emiss_E_hh(hh_c,'BogD','CO2'))-Emiss_E_hh('07220b','BogD','CO2'))/HHEnergiGJ.l('BogD')/1000;

EudledHH.l(kilder,udled_type) = HHEnergiGJ.l(kilder) * EkoeffHH(kilder,udled_type) * 10**(3);
d1EudledHH(kilder,udled_type) = 1 $ ((EudledHH.l(kilder,udled_type) gt 0) OR (EudledHH.l(kilder,udled_type) gt 0));

Enhedsp_E_hh_Avg(kilder,udled_type)$SUM(hh_c, Emiss_E_hh(hh_c,kilder,udled_type))  = SUM(hh_c, Enhedsp_E_hh(hh_c,kilder,udled_type) * Emiss_E_hh(hh_c,kilder,udled_type)) / SUM(hh_c, Emiss_E_hh(hh_c,kilder,udled_type));

EVAir_HH.l(kilder,udled_type) = EudledHH.l(kilder,udled_type)*Enhedsp_E_hh_Avg(kilder,udled_type) * 10**(-6); 

NG_GJ_inklC.l = SUM(j, energiGJ.l(j,'natgas')) + HHEnergiGJ.l('NatGas');
BG_GJ_inklC.l = SUM(j, energiGJ.l(j,'biogas')) + HHEnergiGJ.l('Biogas');
OP_GJ_inklC.l = SUM(j, energiGJ.l(j,'olie')) + HHEnergiGJ.l('Olie');
BO_GJ_inklC.l = SUM(j, energiGJ.l(j,'BioOlie')) + HHEnergiGJ.l('BioOlie');
BogD_GJ_inklC.l = SUM(j, energiGJ.l(j,'BogD')) + HHEnergiGJ.l('BogD');
BogDvej_GJ_inklC.l = SUM(j $ (not j_soe_og_luft(j)), energiGJ.l(j,'BogD')) + HHEnergiGJ.l('BogD');

NG_GJ_inklC0 = NG_GJ_inklC.l;
BG_GJ_inklC0 = BG_GJ_inklC.l;
OP_GJ_inklC0 = OP_GJ_inklC.l;
BO_GJ_inklC0 = BO_GJ_inklC.l;
BogD_GJ_inklC0 = BogD_GJ_inklC.l;
BogDvej_GJ_inklC0 = BogDvej_GJ_inklC.l;

CO2EnergiHH.l = sum(kilder,EudledHH.l(kilder,'CO2'));
CO2BogDHH.l = EudledHH.l('BogD','CO2');
CO2eMLFHH.l = sum((kilder,udled_type), EudledHH.l(kilder,udled_type) * CO2eVaegt(udled_type)/1000) - sum(kilder, EudledHH.l(kilder,'CO2'));
CO2eHH.l = CO2EnergiHH.l + CO2eMLFHH.l;
*CO2eDK.l = CO2eHH.l + sum(j,CO2e.l(j)) - CO2BogD.l('490030b') - CO2BogD.l('50000b') - CO2BogD.l('51000b') - CO2eMLF.l('490030b') - CO2eMLF.l('50000b') - CO2eMLF.l('51000b');
CO2eInt_vej.l = SUM(udled_type, Eudled.l('490030b','BogD',udled_type)* CO2eVaegt(udled_type))/1000;
CO2eInt_soe.l = SUM(udled_type, Eudled.l('50000b','BogD',udled_type)* CO2eVaegt(udled_type))/1000;
CO2eInt_luft.l = SUM(udled_type, Eudled.l('51000b','BogD',udled_type)* CO2eVaegt(udled_type))/1000;
CO2eDK.l = CO2eHH.l + SUM(j,CO2e.l(j)) - CO2eInt_vej.l - CO2eInt_soe.l - CO2eInt_luft.l;
CO2eDK0 = CO2eDK.l;

Parameter CO2virksE,CO2virksIE,MLFvirksMLF,VirksNegaUdled;

CO2virksE = SUM(j,CO2Energi.l(j));
CO2virksIE = SUM(j,CO2Ie.l(j));
MLFvirksMLF = SUM(j,CO2eMLF.l(j));
VirksNegaUdled = SUM((part,j),NegaUdled.l(part,j));  

Display CO2evaegt, CO2eHH.l, CO2virksE,CO2virksIE,MLFvirksMLF,VirksNegaUdled, CO2eDK0;

*Pejlemærker

CO2En_exBoD.l(j) = CO2Energi.l(j) - CO2BogD.l(j);
CO2En_EloV.l = CO2En_exBoD.l('350010a') + CO2En_exBoD.l('350010b') + CO2En_exBoD.l('350020a') + CO2En_exBoD.l('350020b') + CO2En_exBoD.l('350030a') + CO2En_exBoD.l('350030b') + CO2En_exBoD.l('383900');
CO2En_Olier.l = CO2En_exBoD.l('190000a') + CO2En_exBoD.l('190000b');
CO2En_Indv.l = CO2En_exBoD.l('060000a') + CO2En_exBoD.l('060000b') + CO2En_exBoD.l('080090');
CO2En_Fora.l = CO2En_exBoD.l('100010a') + CO2En_exBoD.l('100010b') + CO2En_exBoD.l('100010c') + CO2En_exBoD.l('100020') + CO2En_exBoD.l('100030') + CO2En_exBoD.l('100040') + CO2En_exBoD.l('100050') + CO2En_exBoD.l('11200') + CO2En_exBoD.l('Industri') + CO2En_exBoD.l('160000') + CO2En_exBoD.l('200010') + CO2En_exBoD.l('200020') + CO2En_exBoD.l('210000') + CO2En_exBoD.l('220000') + CO2En_exBoD.l('230010') + CO2En_exBoD.l('230020') + CO2En_exBoD.l('240000') + CO2En_exBoD.l('250000') + CO2En_exBoD.l('280010') + CO2En_exBoD.l('280020') + CO2En_exBoD.l('36700');
CO2En_Luft.l = CO2En_exBoD.l('51000a')  + CO2En_exBoD.l('51000b')  + CO2BogD.l('51000a');
CO2En_Vej_hh.l = CO2BogDHH.l;
CO2En_Vej_virk.l = CO2En_exBoD.l('490030a') + CO2En_exBoD.l('490030b') + SUM(j, CO2BogD.l(j)) - CO2BogD.l('490030b') - CO2BogD.l('50000a') - CO2BogD.l('50000b') - CO2BogD.l('51000a') - CO2BogD.l('51000b');
CO2En_Jernb.l = CO2En_exBoD.l('490012');
CO2En_Soe.l = CO2En_exBoD.l('50000a') + CO2En_exBoD.l('50000b') + CO2BogD.l('50000a');
CO2En_SeOff.l = CO2En_exBoD.l('410009') + CO2En_exBoD.l('420000') + CO2En_exBoD.l('43000') + CO2En_exBoD.l('45000') + CO2En_exBoD.l('460000') + CO2En_exBoD.l('470000') + CO2En_exBoD.l('52000') + CO2En_exBoD.l('53000') + CO2En_exBoD.l('550000') + CO2En_exBoD.l('560000') + CO2En_exBoD.l('Tjenester') + CO2En_exBoD.l('Boliger') + CO2En_exBoD.l('Offentlig') + CO2En_exBoD.l('79000');
CO2En_hh.l = CO2EnergiHH.l - CO2BogDHH.l;
CO2En_Lmv.l = CO2En_exBoD.l('01000a') + CO2En_exBoD.l('01000b') + CO2En_exBoD.l('01000c') + CO2En_exBoD.l('01000d') + CO2En_exBoD.l('020000') + CO2En_exBoD.l('030000');
CO2En_Nordsoe.l = CO2En_exBoD.l('060000a') + CO2En_exBoD.l('060000b');
Co2En_Raf.l = CO2En_exBoD.l('190000a') + CO2En_exBoD.l('190000b');
CO2IEn_Cement.l = CO2Ie.l('230020');
CO2e_Veg.l = SUM(udled_type, Ieudled.l('01000a',udled_type) * CO2eVaegt(udled_type))/1000;
CO2e_Kvaeg.l = SUM(udled_type, Ieudled.l('01000b',udled_type) * CO2eVaegt(udled_type))/1000;
CO2e_Svin.l = SUM(udled_type, Ieudled.l('01000c',udled_type) * CO2eVaegt(udled_type))/1000;
CO2e_Fjerkraemv.l = SUM(udled_type, Ieudled.l('01000d',udled_type) * CO2eVaegt(udled_type))/1000;
CO2_Other.l = SUM(j, Ieudled.l(j,'CO2')) - CO2IEn_Cement.l - Ieudled.l('01000a','CO2') - Ieudled.l('01000b','CO2') - Ieudled.l('01000c','CO2') - Ieudled.l('01000d','CO2');
CH4_Other.l = (SUM((j,kilder), Eudled.l(j,kilder,'CH4')) - (Eudled.l('490030b','BogD','CH4') + Eudled.l('50000b','BogD','CH4') + Eudled.l('51000b','BogD','CH4')) + SUM(kilder, EudledHH.l(kilder,'CH4')) + SUM(j, Ieudled.l(j,'CH4')) - Ieudled.l('01000a','CH4') - Ieudled.l('01000b','CH4') - Ieudled.l('01000c','CH4') - Ieudled.l('01000d','CH4')) * CO2eVaegt('CH4')/1000;
N2O_Other.l = (SUM((j,kilder), Eudled.l(j,kilder,'N2O')) - (Eudled.l('490030b','BogD','N2O') + Eudled.l('50000b','BogD','N2O') + Eudled.l('51000b','BogD','N2O')) + SUM(kilder, EudledHH.l(kilder,'N2O')) + SUM(j, Ieudled.l(j,'N2O')) - Ieudled.l('01000a','N2O') - Ieudled.l('01000b','N2O') - Ieudled.l('01000c','N2O') - Ieudled.l('01000d','N2O')) * CO2eVaegt('N2O')/1000;
Flour_J.l(j) = Ieudled.l(j,'SF6') * CO2eVaegt('SF6')/1000 + Ieudled.l(j,'PFC') * CO2eVaegt('PFC')/1000 + Ieudled.l(j,'HFC') * CO2eVaegt('HFC')/1000;
Flour_Other.l = SUM(j, Flour_J.l(j)) - sum(j $ j_land(j), Flour_J.l(j));

CO2En_EloV0     = CO2En_EloV.l;
CO2En_Olier0    = CO2En_Olier.l;
CO2En_Indv0     = CO2En_Indv.l;
CO2En_Fora0     = CO2En_Fora.l;
CO2En_Luft0     = CO2En_Luft.l;
CO2En_Vej_hh0   = CO2En_Vej_hh.l;
CO2En_Vej_virk0 = CO2En_Vej_virk.l;
CO2En_Jernb0    = CO2En_Jernb.l;
CO2En_Soe0      = CO2En_Soe.l;
CO2En_SeOff0    = CO2En_SeOff.l;
CO2En_hh0       = CO2En_hh.l;
CO2En_Lmv0      = CO2En_Lmv.l;
CO2En_Nordsoe0  = CO2En_Nordsoe.l;
Co2En_Raf0      = Co2En_Raf.l;
CO2IEn_Cement0  = CO2IEn_Cement.l;
CO2e_Veg0       = CO2e_Veg.l;
CO2e_Kvaeg0     = CO2e_Kvaeg.l;
CO2e_Svin0      = CO2e_Svin.l;
CO2e_Fjerkraemv0= CO2e_Fjerkraemv.l;
CO2_Other0      = CO2_Other.l;
CH4_Other0      = CH4_Other.l;
N2O_Other0      = N2O_Other.l;
*Flour0          = Flour.l;

EVAirTot.l = SUM((j,kilder,udled_type), EVAir_E.l(j,kilder,udled_type)) + SUM((j,udled_type), EVAir_IE.l(j,udled_type)) + SUM((kilder,udled_type), EVAir_HH.l(kilder,udled_type));


* Kalibrering af parametre
c_HH_GJ_190000a.l = (HHEnergiGJ.l('Olie') + HHEnergiGJ.l('BogD'))/CH.l('190000a');
c_Olieandel.l = HHEnergiGJ.l('Olie')/(HHEnergiGJ.l('Olie') + HHEnergiGJ.l('BogD'));

c_HH_GJ.l('BioOlie') = HHEnergiGJ.l('BioOlie')/CH.l('190000b');
c_HH_GJ.l('NatGas') = HHEnergiGJ.l('NatGas')/CH.l('350020a');
c_HH_GJ.l('Biogas') = HHEnergiGJ.l('Biogas')/CH.l('350020b');
c_HH_GJ.l('VEVarm') = HHEnergiGJ.l('VEVarm')/CH.l('350030b');

CH0(dc) = CH.l(dc);

sets mapi2dci(i,dci) /
350010a.350010a
350010b.350010b
350030a.350030a
350030b.350030b
383900.383900
/;


J_vaegtHH('el')     = HHEnergiGJ.l('el')     /sum((i,dci) $ mapi2dci(i,dci),IO_vaegt(i,'el')    *CH.l(dci));
J_vaegtHH('FjVarm') = HHEnergiGJ.l('FjVarm') /sum((i,dci) $ mapi2dci(i,dci),IO_vaegt(i,'FjVarm')*CH.l(dci));

vaegtHH(dci,kilder) = sum(i $ mapi2dci(i,dci), IO_vaegt(i,kilder)*J_vaegtHH(kilder));
*display vaegtHH, HHEnergiGJ.l, CH.l;

vaegtUPSHH(dci) $ (sum(kilder, vaegtHH(dci,kilder)) GT 1) = sum(kilder,vaegtHH(dci,kilder))-1;

*Nedskalering
HHEnergiGJ.l('el') = HHEnergiGJ.l('el') / (sum(dci,vaegtUPSHH(dci))+1);
HHEnergiGJ.l('FjVarm') = HHEnergiGJ.l('FjVarm') / (sum(dci,vaegtUPSHH(dci))+1);

J_vaegtHH('el')     = HHEnergiGJ.l('el')     /sum((i,dci) $ mapi2dci(i,dci),IO_vaegt(i,'el')    *CH.l(dci));;
J_vaegtHH('FjVarm') = HHEnergiGJ.l('FjVarm') /sum((i,dci) $ mapi2dci(i,dci),IO_vaegt(i,'FjVarm')*CH.l(dci));
vaegtHH(dci,kilder) = sum(i $ mapi2dci(i,dci), IO_vaegt(i,kilder)*J_vaegtHH(kilder));

display vaegtHH;

*Eltot.l              = HHEnergiGJ.l('El') + sum(j,el_energi.l(j));
*Elkraft.l = (TilBas('350010a','el')+TilBas('350010a','el')/(TilBas('350010a','el')+TilBas('350010b','el'))*TilBas_import('el'))/(sum(j,TilBas(j,'el'))+TilBas_import('el'))*Eltot.l; 
*Elvind.l  = (TilBas('350010b','el')+TilBas('350010b','el')/(TilBas('350010a','el')+TilBas('350010b','el'))*TilBas_import('el'))/(sum(j,TilBas(j,'el'))+TilBas_import('el'))*Eltot.l; 
*Elaffald.l = TilBas('383900','el')/(sum(j,TilBas(j,'el'))+TilBas_import('el'))*Eltot.l; 
*Eltest = Elkraft.l+elvind.l+elaffald.l-eltot.l;
*Elfossil.l = elkraft.l + elaffald.l;

*$exit
*c_HH_GJ.l('FjVarm') = HHEnergiGJ.l('FjVarm') /  ( IO_vaegt('350030a','FjVarm') * CH.l('350030a')
*                                              + IO_vaegt('350010a','FjVarm') * CH.l('350010a')
*                                              + IO_vaegt('383900','FjVarm') * CH.l('383900') );
                                              
*c_HH_GJ.l('El')     = HHEnergiGJ.l('El')     /  ( IO_vaegt('350010a','el') * CH.l('350010a')
*                                              + IO_vaegt('350010b','el') * CH.l('350010b')
*                                              + IO_vaegt('383900','el') * CH.l('383900') );



ElvindinklC.l   = Elvind.l   + vaegtHH('350010b','El') * CH.l('350010b');
ElkraftinklC.l  = Elkraft.l  + vaegtHH('350010a','El') * CH.l('350010a');
ElaffaldinklC.l = Elaffald.l + vaegtHH('383900','El') * CH.l('383900');
ElfossilinklC.l = ElkraftinklC.l + ElaffaldinklC.l;
EltotinklC.l    = ElvindinklC.l + ElfossilinklC.l;

FVkraftinklC.l  = sum(j, FV_kraftandel.l(j)*FV_energi.l(j))  + vaegtHH('350010a','FjVarm') * CH.l('350010a');
FVaffaldinklC.l = sum(j, FV_Renoandel.l(j) *FV_energi.l(j))  + vaegtHH('383900','FjVarm')  * CH.l('383900');
FVfossilinklC.l = FVfossil.l + vaegtHH('350030a','FjVarm') * CH.l('350030a');
FVVEinklC.l     = FVVE.l     + vaegtHH('350030b','FjVarm') * CH.l('350030b');
FVxinklC.l      = FVfossilinklC.l + FVVEinklC.l;
FVinklC.l       = FVkraftinklC.l + FVaffaldinklC.l + FVxinklC.l;

FVVEinklC0 = FVVEinklC.l;
FVfossilinklC0 = FVfossilinklC.l;

Import.l(j) = sum(i, xF.l(i,j)) + ExF.l(j) + cF.l(j) + sum(i, IBIF.l(i,j) + IMIF.l(i,j)) + ILF.l(j) + gF.l(j);
Import0(j) = Import.l(j);

Eksport.l(j) = ExD.l(j) + ExF.l(j);
Eksport0(j) = Eksport.l(j);

Elproduktion_vind.l = ElvindinklC.l + Ex.l('350010b') - Import.l('350010b');
Elproduktion_kraft.l = ElkraftinklC.l + Ex.l('350010a') - Import.l('350010a');
Elproduktion_affald.l = ElaffaldinklC.l + Ex.l('383900') - Import.l('383900');
Elnettoeksport.l = Eksport.l('350010b') - Import.l('350010b') + Eksport.l('350010a') - Import.l('350010a') + Eksport.l('383900') - Import.l('383900');

Elproduktion_vind0 = Elproduktion_vind.l;
Elproduktion_kraft0 = Elproduktion_kraft.l;
Elproduktion_affald0 = Elproduktion_affald.l;
Elnettoeksport0 = Elnettoeksport.l;

Display Elnettoeksport0;

*------------------------------------------------------------
* Modeller
*------------------------------------------------------------
model static_C
/
*E_BoP
E_BoPny
E_Ktot
E_GDP
E_GDPf0
E_BVT
E_BVTtot
E_BVTf0
E_BVTf0tot
E_NVTf0
E_NVTf0tot
E_M
E_E
*E_Eny
E_H
E_LKE
E_KE
*E_PO
*E_POny
E_POnyny
E_P
E_L
*E_KB
E_KBny1
E_KBny2
*E_KM
*E_KMny
E_KMny2
E_KBBook
E_KMBook
E_ucB
E_ucM
*E_PH
*E_PHny
E_PHny1
E_PHny2
E_PLKE
*E_PKE
E_PKEny
E_xmm
E_xeme
E_xm
E_xe
*E_x
E_xny
E_PM
E_PE
E_Pxm
E_Pxe
E_Pxm_i
E_Pxe_i
E_xD
E_xF
E_Px
E_InvB
E_InvM
E_IBI
E_IBIB
E_IB
E_IMI
E_IMIM
E_IM
E_PInvB
E_PInvM
E_IBD
E_IMD
E_IBF
E_IMF
E_PIBI
E_PIB
E_PIB_I
E_PIMI
E_PIM
E_PIM_I
*E_DIV
*E_DIVny
E_DIVnyny
E_V
E_IL
E_ILD
E_ILF
E_PIL
E_YEmp
E_YNotEmp
E_N_Emp
E_C_Emp
E_C_NotEmp
E_CTot
E_cD 
E_cF 
E_PC
E_CHC
E_CH
E_C
E_PCH
E_PCH_i
E_PCH_i190000a
E_PCH_i350020a
E_Wealth
E_Ex
E_ExD
E_ExF
E_P_Ex
E_GD
E_GF
E_PG
*E_PSaldo
*E_PSaldony
*E_PSaldonyny
E_PSaldonynyNy
E_DG
E_DP
E_Trans
E_w
E_Y
E_P_udl
E_Ltot
E_G
E_UTILITY
E_TaxEU
E_tMarg_cD
E_tMarg_cF
$IF NOT %NYTADD% == 1  $GOTO SKIP
E_hour
$LABEL SKIP
$IF NOT %NYTMUL% == 1  $GOTO SKIPa
E_YZ
E_hourMUL
E_VV
E_PU
$LABEL SKIPa

E_KE2
E_FV_energi
*E_KEel
E_KEel1
E_KEel2
E_KEel3
E_KEel4

*E_KEfo
E_KEfo1
E_KEfo2
E_KEfo3
E_KEfo4

E_PKE2

E_El
E_KMel
E_PKEel
E_fossil
E_KMfo
E_PKEfo

E_x_energi1
E_x_energi2
E_x_energi2C
E_x_energi3
*E_x_energi4
E_x_energi4ny
E_x_energi5
*E_x_energi6
E_x_energi6ny
E_x_energi7
E_x_energi8
E_x_energi9
E_x_energi10
E_x_energi11
E_x_energi12
E_x_energi13
E_x_energi14
E_pBG_e
E_pNG_e
E_pRG_e
E_pNoG_e
E_pTB
E_pOP_e
E_pK_e
E_pA_e
E_pH_e
E_pT_e
E_pB_e
E_PFV_energi
E_px_energi

E_ISB_energi 
E_SB_energi  
E_Pfossil    
E_G_energi   
E_O_energi   
E_PISB_energi

E_BG_energi
E_BG_energiGJ
E_NG_energi 
E_NG_energiGJ
E_RG_energi 
E_RG_energiGJ
E_NoG_energi 
E_NoG_energiGJ
E_PG_energi  
E_TB  
E_TB_energiGJ
E_OP_energi  
E_OP_energiGJ  
E_PO_energi  
E_K_energi   
E_K_energiGJ   
E_A_energi   
E_A_energiGJ   
E_HT_energi  
E_PSB_energi 
E_H_energi   
E_H_energiGJ   
E_T_energi   
E_T_energiGJ   
E_B_energi   
E_B_energiGJ   
E_PHT_energi

*E_el_energi
E_el_energiNY

E_elkraftEQ
E_el_kraftandel
E_elVindEQ
E_el_Vindandel
E_el_Renoandel1
E_el_Renoandel2
E_FV_kraftandel
E_FV_Renoandel
E_FV_Fjernandel
E_FV_FjernVEandel
E_FVfossilEQ

E_FVx
*E_FVfossil
E_FVVE
E_PFVx
E_PFVfossil
E_PFVVE

E_PEl

E_Eltot
E_Elvind
E_Elfossil
E_Peltot
E_Elkraft
E_Elaffald
E_Pelfossil
E_PElvind
E_PElkraft
E_PElaffald

E_Eudled
E_TR_Eudled
E_TR_Eudled_kalib
E_EVAir_E

E_Nettoindkomst
E_Disnytte

E_TRAfgifter
E_TRw
E_TRcap
*E_TRcor
E_TRcorny
E_TRprod
E_Overf
E_Gval
E_Lump

E_PCCS
E_CCSExp


*Transport
E_T

E_TTF1
E_TTE1
E_TTF2
E_TTE2
E_pT

E_TEl
E_Tkel
E_PTTE

E_TFX
E_TFXB
E_Tf
E_PTTF

*E_Tkf
E_TKF1
E_TKF2
*E_TX
E_TX2
E_PTFX
E_PTFXB

E_PTel
E_PTf

E_BD_energiGJ

E_Power2X
*E_PTX
E_PTX2

*KB
E_Ieudled1
E_Ieudled2
E_Ieudled3
E_Nudled
E_TR_Ieudled
*E_TR_Ieudled_kalib
E_EVAir_IE
E_EVNudled

* Landbrug m.m.
E_KBtot
*E_KBtot1
*E_KBtot2
E_KBpart
E_KBpartX
E_PKBtot
E_PKBpart1
*E_PKBpart2

E_PKBpartX
E_CCSprKBx
E_NegaUdled
E_BECCSshare

E_CO2Energi
E_CO2BogD  
E_CO2Ie    
E_CO2eMLF  
E_CO2e

E_HHEnergiGJOlie
E_HHEnergiGJBogD
E_HHEnergiGJBioOlie
E_HHEnergiGJNatGas
E_HHEnergiGJBiogas
E_HHEnergiGJVEVarm
E_HHEnergiGJFjVarm
E_HHEnergiGJEl

E_EudledHH
E_TR_EudledHH

E_EVAir_HH

E_CO2EnergiHH
E_CO2BogDHH
E_CO2eMLFHH
E_CO2eHH
E_CO2eInt_vej
E_CO2eInt_soe
E_CO2eInt_luft
E_CO2eDK 

E_CO2En_exBoD
E_CO2En_EloV
E_CO2En_Olier
E_CO2En_Indv
E_CO2En_Fora
E_CO2En_Luft
E_CO2En_Vej_hh
E_CO2En_Vej_virk
E_CO2En_Jernb
E_CO2En_Soe
E_CO2En_SeOff
E_CO2En_hh
E_CO2En_Lmv
E_CO2En_Nordsoe
E_CO2En_Raf
E_CO2IEn_Cement
E_CO2e_Veg
E_CO2e_Kvaeg
E_CO2e_Svin
E_CO2e_Fjerkraemv
E_CO2_Other
E_CH4_Other
E_N2O_Other
E_Flour_J
E_Flour_other

E_EVAirTot

E_NG_GJ_inklC
E_BG_GJ_inklC
E_OP_GJ_inklC
E_BO_GJ_inklC
E_BogD_GJ_inklC
E_BogDvej_GJ_inklC

E_EltotinklC
E_ElvindinklC
E_ElfossilinklC
E_ElkraftinklC
E_ElaffaldinklC
E_FVinklC
E_FVkraftinklC
E_FVaffaldinklC
E_FVxinklC
E_FVfossilinklC
E_FVVEinklC

E_Elproduktion_vind
E_Elproduktion_kraft
E_Elproduktion_affald
E_Elnettoeksport

E_CO2taxrate_BG 
E_CO2taxrate_NG 
E_CO2taxrate_RG 
E_CO2taxrate_NoG 
E_CO2taxrate_OP 
E_CO2taxrate_K 
E_CO2taxrate_A 
E_CO2taxrate_H 
E_CO2taxrate_T 
E_CO2taxrate_B 

E_Import
E_Eksport
/
;


*------------------------------------------------------------
* Test baseret på J_LED (Husk J_Led i alle nye ligninger)
*------------------------------------------------------------
fix ALL;
unfix J_LED;
unfix J_LED_NEW;
unfix J_LED_NEW2;
unfix J_LED_NEW3;
unfix J_LED_NEW4;

save;

solve static_C using cns;

* gamX-kommando (udskriver %-vis afvigelse i.f.t. sidste 'save' for alle variable i gruppen ENDO)
disp J_LED_NEW3;
dispdif |J_LED| > 0.0001;
dispdif |J_LED_NEW| > 0.0001;
dispdif |J_LED_NEW2| > 0.0001;
dispdif |J_LED_NEW3| > 0.0001;
dispdif |J_LED_NEW4| > 0.0001;

*$exit

*------------------------------------------------------------
* Kørsel
*------------------------------------------------------------
fix ALL;
unfix ENDO;
unfix ENDO_NEW;
unfix ENDO_NEW2;
unfix ENDO_NEW3;
unfix ENDO_NEW4;
x_energi.fx(j,i) = x_energi.l(j,i);
x_energi.lo(j,i_e) = -inf;
x_energi.up(j,i_e) =  inf;
x_energi.lo(j,'190000a') = -inf;
x_energi.up(j,'190000a') =  inf;
x_energi.lo(j,'190000b') $ d1TB(j) = -inf;
x_energi.up(j,'190000b') $ d1TB(j) =  inf;
x_energi.lo(j,'industri') = -inf;
x_energi.up(j,'industri') =  inf;

* Nuller.gms fixer variable med leverancer som er nul, da de er fjernet i ligningerne
include Nuller.gms
include Nuller2.gms
include NullerT.gms
include NullerL.gms
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


*eltot.fx = eltot.l;


solve static_C using cns;




disp J_LED_NEW;
disp J_LED_NEW2;
disp J_LED_NEW3;
disp J_LED_NEW4;
dispdif |J_LED| > 0.0001;
dispdif |J_LED_NEW| > 0.0001;
dispdif |J_LED_NEW2| > 0.0001;
dispdif |J_LED_NEW3| > 0.0001;
dispdif |J_LED_NEW4| > 0.0001;
display BoP.l;


*Display CH4_Other.l, N2O_Other.l, Flour.l;

*CO2eTax.fx = 15;

*solve static_C using cns;


display BoP.l;
*Display CH4_Other.l, N2O_Other.l, Flour.l;


*tfp.fx('350010b') = tfp.l('350010b')*1.1;

*solve static_C using cns;

*execute_unload "gekko\gdx_work\baseteststod.gdx";