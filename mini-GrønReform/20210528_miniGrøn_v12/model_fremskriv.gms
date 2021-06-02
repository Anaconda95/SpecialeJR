Equations
E_m_CH_ne
E_m_CH_neV
E_m_CH_neFV
E_m_CH_neReno
E_m_CH_350010a
E_m_CH_350020a
E_m_CH_350030a
*E_TFP(j)
E_UdlEftersp(j)
E_PF(j)
E_ucBny(j)
E_ucMny(j)

E_thetaL(j)
E_X0(j)
E_DivY(j)
;

GROUP ENDO_NEW6
thetaL(j)
X0(j)
DivY(j)
;

GROUP EKSO_NEW6
TFPtot
UdlEftersp(j)
RiskPrem(j)
thetaLpre(j)
X0pre(j)
adjthetaL
adjX0
;

GROUP J_LED_NEW6
J_m_CH_ne
J_m_CH_neV
J_m_CH_neFV
J_m_CH_neReno
J_m_CH_350010a
J_m_CH_350020a
J_m_CH_350030a
J_TFP(j)
J_UdlEftersp(j)
J_PF(j)
J_ucBny(j)
J_ucMny(j)

J_thetaL(j)
J_X0(j)
J_DivY(j)
;

Parameter
d1UdlEftersp(j)
;

*------------------------------------------------------------
*Modelligninger
*------------------------------------------------------------

E_m_CH_ne.. m_CH('ne') =E= J_m_CH_ne + 1 - m_CH('ng');
E_m_CH_neV.. m_CH('neV') =E= J_m_CH_neV + 1 - m_CH('neEL');
E_m_CH_neFV.. m_CH('neFV') =E= J_m_CH_neFV + 1 - m_CH('neGAS');
E_m_CH_neReno.. m_CH('neReno') =E= J_m_CH_neReno + 1 - m_CH('neELEL');

E_m_CH_350010a.. m_CH('350010a') =E= J_m_CH_350010a + 1 - m_CH('350010b');
E_m_CH_350020a.. m_CH('350020a') =E= J_m_CH_350020a + 1 - m_CH('350020b');
E_m_CH_350030a.. m_CH('350030a') =E= J_m_CH_350030a + 1 - m_CH('350030b');

*E_TFP(j).. TFP(j) =E= J_TFP(j) + TFPtot;

*E_UdlEftersp(j)$(d1UdlEftersp(j) and d1Ex(j)).. UdlEftersp(j) =E= J_UdlEftersp(j) + ExD(j)/Y(j);

E_PF(j)$d1UdlEftersp(j).. PF(j) =E= J_PF(j) + P(j);

E_ucBny(j)..    ucB(j) =e= J_ucBny(j) + dummy_ucB(j) + 1/(1-t_cor(j))*(r+RiskPrem(j)+deltaKB(j)-t_cor(j)*kvote_DP(j)*(r+infl/(1+infl))-t_cor(j)*deltaKBBook(j)/(1+infl)*(r+deltaKB(j))/(r+infl/(1+infl)+deltaKBBook(j)/(1+infl)));

E_ucMny(j)..    ucM(j) =e= J_ucMny(j) + dummy_ucM(j) + 1/(1-t_cor(j))*(r+RiskPrem(j)+deltaKM(j)-t_cor(j)*kvote_DP(j)*(r+infl/(1+infl))-t_cor(j)*deltaKMBook(j)/(1+infl)*(r+deltaKM(j))/(r+infl/(1+infl)+deltaKMBook(j)/(1+infl)));


E_thetaL(j)..  thetaL(j) =E= J_thetaL(j) + thetaLpre(j) * (1+adjThetaL);

E_X0(j)..      X0(j) =E= J_X0(j) +  X0pre(j) * (1+adjX0);

E_DivY(j)..    DivY(j) =E= J_DivY(j) + Div(j) / (PO(j)*Y(j));

*------------------------------------------------------------
* Data
*------------------------------------------------------------

TFPtot.l = 1;

UdlEftersp.l(j) = ExD.l(j)/Y.l(j);

d1UdlEftersp(j) = 0;

RiskPrem.l(j) = 0;

thetaLpre.l(j) = thetaL.l(j);
X0pre.l(j) = X0.l(j);
adjThetaL.l = 0;
adjX0.l = 0;
DivY.l(j) = Div.l(j) / (PO.l(j)*Y.l(j));

*------------------------------------------------------------
* Modeller
*------------------------------------------------------------
model static_fremskriv
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
*E_P
E_Pny
E_L
*E_KB
E_KBny1
E_KBny2
*E_KM
*E_KMny
E_KMny2
E_KBBook
E_KMBook
*E_ucB
*E_ucM
E_ucBny
E_ucMny
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
*E_DIVnyny
E_DIVnynyNY
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
*E_PSaldonynyNy
E_PSaldonynyNYNY
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
*E_KEel1
*E_KEel2
*E_KEel3
*E_KEel4
E_KEelny1
E_KEelny2
E_KEelny3
E_KEelny4

*E_KEfo
E_KEfo1
E_KEfo2
E_KEfo3
E_KEfo4

*E_PKE2
E_PKE2ny

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

*E_BG_energi
E_BG_energiny
E_BG_energiGJ
E_NG_energi 
E_NG_energiGJ
E_RG_energi 
E_RG_energiGJ
E_NoG_energi 
E_NoG_energiGJ
*E_PG_energi
E_PG_energiny
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
*E_TRcorny
E_TRcornyny
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
*E_TTE2
*E_pT
E_TTE2NY
E_pTNY

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

*$ontext
* Landbrug m.m.
E_KBtot
*E_KBtot1
*E_KBtot2
*E_KBpart
*E_KBpartX
*E_PKBtot
E_KBpartNY
E_KBpartXNY
*E_PKBtotNY
E_PKBtotNY2
E_PKBpart1
*E_PKBpart2

E_PKBpartX
E_CCSprKBx
E_NegaUdled
E_BECCSshare
*$offtext

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

*Tilskud

E_Subs_Y
E_Subs_KEel
E_Subs_BG
E_Subs_KB
E_Subs_TTE

*Fremskriv
E_m_CH_ne
E_m_CH_neV
E_m_CH_neFV
E_m_CH_neReno

E_m_CH_350010a
E_m_CH_350020a
E_m_CH_350030a

*E_TFP
*E_UdlEftersp
E_PF

E_thetaL
E_X0
E_DivY

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
unfix J_LED_NEW5;
unfix J_LED_NEW6;

save;

solve static_fremskriv using cns;

* gamX-kommando (udskriver %-vis afvigelse i.f.t. sidste 'save' for alle variable i gruppen ENDO)
dispdif |J_LED| > 0.0001;
dispdif |J_LED_NEW| > 0.0001;
dispdif |J_LED_NEW2| > 0.0001;
dispdif |J_LED_NEW3| > 0.0001;
dispdif |J_LED_NEW4| > 0.0001;
dispdif |J_LED_NEW5| > 0.0001;
dispdif |J_LED_NEW6| > 0.0001;

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


*TFP.lo(j) = -inf;
*TFP.up(j) = inf;


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

*Subs_KB.fx(j) $ (NOT j_landxCCS(j)) = 0;

solve static_fremskriv using cns;

disp J_LED_NEW;
disp J_LED_NEW2;
disp J_LED_NEW3;
disp J_LED_NEW4;
disp J_LED_NEW5;
disp J_LED_NEW6;

dispdif |J_LED| > 0.0001;
dispdif |J_LED_NEW| > 0.0001;
dispdif |J_LED_NEW2| > 0.0001;
dispdif |J_LED_NEW3| > 0.0001;
dispdif |J_LED_NEW4| > 0.0001;
dispdif |J_LED_NEW5| > 0.0001;
dispdif |J_LED_NEW6| > 0.0001;


display BoP.l;
execute_unload "gekko\gdx_work\base.gdx";

*s_Y.fx(j) = 0.01;

*solve static_fremskriv using cns;

*display BoP.l;


*s_Y.fx(j) = 0;
*CO2eTax.fx = 15;

*solve static_fremskriv using cns;

*display BoP.l;

parameter nega_andel;
$include vis_andele.gms