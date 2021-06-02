* Denne fil indeholder yderligere udvidelse af REFORM-modellen. Udvidelsen køres ovenpå model_energi. Denne fil indeholder følgende udvidelser:
* Transport i produktionsfunktionen

sets 
j_soe_og_luft(j)    /50000a,50000b,51000a,51000b/;

Equations
*Tilføjelse af transport i øverste produktions-nest
E_T(j)
E_POny(j)

E_TTF1(j)
E_TTE1(j)
E_TTF2(j)
E_TTE2(j)
E_TEl(j)
E_Tkel(j)
E_TKF1(j)
E_TKF2(j)
E_Tf(j)
E_pT(j)
E_PTTE(j)
E_PTTF(j)
E_TFXB(j)
E_TB(j)
E_TFX(j)
*E_TX(j)
E_TX2(j)
E_PTFXB(j)
E_PTFX(j)
E_PTB(j)

E_KMny2(j)

E_PTel(j)
E_PTf(j)
*E_PTX(j)
E_PTX2(j)

E_el_energiNY(j)
E_x_energi4ny(j)
E_BD_energiGJ(j)
E_x_energi3(j)
E_TB_energiGJ(j)

E_x_energi6ny(j)

E_Power2X(j)
;

GROUP ENDO_NEW2
*Tilføjelse af transport i øverste produktions-nest
T(j)
TTE(j)
TTF(j)
TEL(j)
TKel(j)
TFXB(j)
TB(j)
TFX(j)
TKf(j)
TF(j)
*TX(j)
TX2(j)
PT(j)
PTTE(j)
PTTF(j)
PTFXB(j)
PTB(j)
PTFX(j)
PTB(j)

PTel(j)
PTf(j)
*PTX(j)
PTX2(j)

Power2X(j)
;


GROUP EKSO_NEW2
*Tilføjelse af transport i øverste produktions-nest
m_T(j)

thetaTKF(j)
thetaTKFtot

m_TTE(j)
m_TTE_tot
m_TEl(j)
m_Tkel(j)
m_TFXB(j)
m_TB(j)
m_Tkf(j)
m_Tf(j)
*m_TX(j)

ET(j)
ETTF(j)
ETTE(j)
ETFXB(j)
ETFX(j)

scalarBogD(j)
scalarPTf(j)
*scalarPTX(j)
scalarPTX2(j)
;

GROUP J_LED_NEW2
*Tilføjelse af transport i øverste produktions-nest
J_T(j)

J_TTF(j)
J_TTE(j)
J_TEl(j)
J_Tkel(j)
J_Tkf(j)
J_Tf(j)
J_pT(j)
J_PTTE(j)
J_PTTF(j)
J_TFXB(j)
J_TB(j)
J_TFX(j)
*J_TX(j)
J_PTFXB(j)
J_PTFX(j)
J_BogD(j)
J_PTel(j)
J_PTf(j)
*J_PTX(j)
J_PTX2(j)
J_BD_energiGJ(j)
J_TB_energiGJ(j)
J_PTB(j)

J_Power2X(j)
;

Parameter
*Tilføjelse af transport i øverste produktions-nest
testT
d1TB(j)
testTKKM(j)
d1TX2(j)
c_BD_GJ(j)
c_TB_GJ(j)
Power2Xratio1
Power2Xratio2
Power2X_elandel
;

*------------------------------------------------------------
*Modelligninger
*------------------------------------------------------------
*Tilføjelse af transport i øverste produktions-nest

$ontext
                      T
                 /        \
               TTE         TTF
               / \         /  \
             Tel TKel    TFXB TKF
                         / \    
                       TFX TB                    
                      / / \
                   TX2 TF TX

TF er fossil brændsel (benzin og diesel). TB (bioethanol og biodiesel) er et eksisterende substitut til diesel. 
TX (Power2X - version 1) er et stærkt substitut til TF. TX2 (Power2X - version 2) er et perfekt substitut til TF.                    
$offtext

E_T(j)..     T(j) =E= J_T(j) + m_T(j) * (PT(j)/PO(j))**(-EY(j))*Y(j);
E_POny(j)..     PO(j)*Y(j) =e= J_PO(j) + PM(j)*M(j) + PH(j)*H(j) + PT(j)*T(j);

E_TTF1(j)$(j_soe_og_luft(j))..     TTF(j) =E= J_TTF(j) + (1-m_TTE(j)) * (PTTF(j)/PT(j))**(-ET(j))*T(j);
E_TTE1(j)$(j_soe_og_luft(j))..     TTE(j) =E= J_TTE(j) + m_TTE(j) * (PTTE(j)/PT(j))**(-ET(j))*T(j);
E_TTF2(j)$(not j_soe_og_luft(j)).. TTF(j) =E= J_TTF(j) + (1-m_TTE(j)*m_TTE_tot) * (PTTF(j)/PT(j))**(-ET(j))*T(j);
E_TTE2(j)$(not j_soe_og_luft(j)).. TTE(j) =E= J_TTE(j) + (m_TTE(j)*m_TTE_tot) * (PTTE(j)/PT(j))**(-ET(j))*T(j);
E_PT(j)..                    PT(j)*T(j)       =E= J_PT(j) + PTTE(j)*TTE(j) + PTTF(j)*TTF(j);

E_TEl(j)..                   TEl(j)           =E= J_TEl(j) + m_TEL(j) * (PTEL(j)/PTTE(j))**(-ETTE(j))*TTE(j);
E_Tkel(j)..           TFP(j)*TKel(j)/(1+grow) =E= J_TKel(j) + m_TKel(j) * ((1+tFak_M(j))*ucM(j)*PInvM(j)/(TFP(j)*PTTE(j)))**(-ETTE(j))*TTE(j);
E_PTTE(j)..                  PTTE(j)*TTE(j)   =E= J_PTTE(j) + PTEl(j)*TEL(j) + (1+tFak_M(j))*ucM(j)*PInvM(j)*TKel(j)/(1+grow);

E_TFXB(j)..                   TFXB(j)         =E= J_TFXB(j)+ m_TFXB(j) * (PTFXB(j)/PTTF(j))**(-ETTF(j))*TTF(j);
E_TKf1(j)$(j_soe_og_luft(j))..     TFP(j)*thetaTKF(j)*TKF(j)/(1+grow)  =E= J_TKF(j) + m_TKF(j) * ((1+tFak_M(j))*ucM(j)*PInvM(j)/(TFP(j)*thetaTKF(j)*PTTF(j)))**(-ETTF(j))*TTF(j);
E_TKf2(j)$(not j_soe_og_luft(j)).. TFP(j)*thetaTKF(j)*thetaTKFtot*TKF(j)/(1+grow)  =E= J_TKF(j) + m_TKF(j) * ((1+tFak_M(j))*ucM(j)*PInvM(j)/(TFP(j)*thetaTKF(j)*thetaTKFtot*PTTF(j)))**(-ETTF(j))*TTF(j);
E_PTTF(j)..                  PTTF(j)*TTF(j)   =E= J_PTTF(j) + PTFXB(j)*TFXB(j) + (1+tFak_M(j))*ucM(j)*PInvM(j)*TKf(j)/(1+grow);

E_TFX(j)..                   TFX(j)           =E= J_TFX(j) + (1-m_TB(j)) * (PTFX(j)/PTFXB(j))**(-ETFXB(j))*TFXB(j);
E_TB(j) $ d1TB(j)..          TB(j)            =E= J_TB(j) + m_TB(j)   * (PTB(j) /PTFXB(j))**(-ETFXB(j))*TFXB(j);
E_PTFXB(j)..                 PTFXB(j)*TFXB(j) =E= J_PTFXB(j) + PTFX(j)*TFX(j) + PTB(j)*TB(j);
E_TF(j)  $ (d1TX2(j) EQ 0)..     TF(j)      =E= J_TF(j) + m_TF(j) * (PTF(j) /PTFX(j))**(-ETFX(j))*TFX(j);
E_TX2(j) $ (d1TX2(j) EQ 1)..     TX2(j)     =E= J_TF(j) + m_TF(j) * (PTX2(j)/PTFX(j))**(-ETFX(j))*TFX(j);
*E_TX(j)..     TX(j)          =E= J_TX(j) + m_TX(j) * (PTX(j)/PTFX(j))**(-ETFX(j))*TFX(j);
E_PTFX(j)..   PTFX(j)*TFX(j) =E= J_PTFX(j) + PTF(j)*TF(j)
*+ PTX(j)*TX(j)
+ PTX2(j)*TX2(j);



E_PTel(j) ..                 PTel(j) =E= J_PTel(j) + PEl(j);
E_el_energiNY(j).. el_energi(j) =E= J_el_energi(j) + El(j) + TEl(j) + Power2X_elandel*Power2X(j);


E_PTf(j)  $ (d1TX2(j) EQ 0)..    PTf(j)  =E= J_PTf(j)  + px_energi(j,'190000a') + sum(udled_type,TR_Eudled(j,'BogD',udled_type))/TF(j);
E_x_energi4ny(j).. x_energi(j,'190000a') =E= J_x_energi(j,'190000a') + OP_energi(j) + RG_energi(j) + TF(j);

E_BD_energiGJ(j)..  energiGJ(j,'BogD')     =E= J_BD_energiGJ(j)   + c_BD_GJ(j)   * TF(j);

E_KMny2(j) $ d1KM(j)..   KM(j) =e= j_KM(j) + KMel(j) + KMfo(j) + TKel(j) + TKf(j);


E_TB_energiGJ(j) $ d1TB(j).. energiGJ(j,'BioOlie')  =E= J_TB_energiGJ(j)  + c_TB_GJ(j)  * TB(j);
E_x_energi3(j) $ d1TB(j).. x_energi(j,'190000b') =E= J_x_energi(j,'190000b') + TB(j);
E_pTB(j) $ d1TB(j).. PTB(j)=E= J_pTB(j)+ px_energi(j,'190000b') + sum(udled_type,TR_Eudled(j,'BioOlie',udled_type))/TB(j) ;

E_x_energi6ny(j)..  x_energi(j,'industri') =E= J_x_energi(j,'industri') + A_energi(j) + Power2X(j)*(1-Power2X_elandel);

E_Power2X(j).. Power2X(j) =E= J_Power2X(j)
*+ Power2Xratio1 * TX(j)
+ Power2Xratio2 * TX2(j);
*E_PTX(j)..         PTX(j) =E= J_PTX(j)     + Power2Xratio1 * (px_energi(j,'industri')*(1-Power2X_elandel) + PEl(j)*Power2X_elandel);
E_PTX2(j)..       PTX2(j) =E= J_PTX2(j)    + Power2Xratio2 * (px_energi(j,'industri')*(1-Power2X_elandel) + PEl(j)*Power2X_elandel);

*------------------------------------------------------------
*Data
*------------------------------------------------------------

d1TX2(j) = 0;

*Power2Xratio1 = 1.5;
Power2Xratio2 = 3;
Power2X_elandel = 0.4;

*Elasticiteter

*Baseret på kalibrering til MAC-kurve
ET.l(j) = 4;

ETTF.l(j) = 0.2;
ETTE.l(j) = 0.2;
ETFXB.l(j) = 4;
ETFX.l(j) = 10;
*$ontext
*Angiv værdier fra data (og antag at TX er 1 promille af Tf i udgangspunktet)
Tf.l(j) $ d1x(j,'190000a') = anvKbin(j,'BogD')*10**(-6)*scalar190000a(j)*0.99;
Tf.l(j) $ (xe.l(j,'190000a') LT Tf.l(j))  = xe.l(j,'190000a')*0.99;
energiGJ.l(j,'BogD')  $ d1x(j,'190000a') = anvGJ(j,'BogD')*10**(-9);
TB.l(j) $ d1x(j,'190000b') = anvKbin(j,'BioOlie')*10**(-6);
TB.l(j) $ (xe.l(j,'190000b') LT TB.l(j))  = xe.l(j,'190000b')*0.99;
energiGJ.l(j,'BioOlie') $ d1x(j,'190000b') = anvGJ(j,'BioOlie')*10**(-9);

*Power2X.l(j) = 0.001*Tf.l(j);
*Power2X.l('060000a') = 0.1*Tf.l('060000a');
*Power2X.l('060000b') = 0.1*Tf.l('060000b');
*Power2X.l('190000b') = 0.1*Tf.l('190000b');
*Power2X.l('50000a') = 0.0001*Tf.l('50000a');


*Træk BogD og BioOlie ud af E-aggregatet og over under T. 
xe.l(j,'190000a')       $ d1x(j,'190000a') = xe.l(j,'190000a')       - Tf.l(j);
x_energi.l(j,'190000a') $ d1x(j,'190000a') = x_energi.l(j,'190000a') + Tf.l(j);
xe.l(j,'190000b')       $ d1x(j,'190000b') = xe.l(j,'190000b')       - TB.l(j);
x_energi.l(j,'190000b') $ d1x(j,'190000b') =                           TB.l(j);


xe.l(j,dmeo) = sum(dme $ mapdme2dmeo(dmeo,dme), xe.l(j,dme));
xe.l(j,dmeo) = sum(dme $ mapdme2dmeo(dmeo,dme), xe.l(j,dme));
E.l(j)       = xe.l(j,'me');

*xm.l(j,'industri')      $ d1x(j,'industri')= xm.l(j,'industri') - Power2X.l(j)*(1-Power2X_elandel);
*x_energi.l(j,'industri')$ d1x(j,'industri')= A_energi.l(j) + Power2X.l(j)*(1-Power2X_elandel);
parameter vism;
vism(j,'m') = xm.l(j,'industri')+1;
vism(j,'x') = x_energi.l(j,'industri');
*display vism;
*$exit

xm.l(j,dmo) = sum(dm $ mapdm2dmo(dmo,dm), xm.l(j,dm));
xm.l(j,dmo) = sum(dm $ mapdm2dmo(dmo,dm), xm.l(j,dm));
M.l(j)      = xm.l(j,'m');

Eudled.l(j,'BogD',udled_type) = energiGJ.l(j,'BogD') * Ekoeff(j,'BogD',udled_type) * 10**(3);
Eudled.l(j,'BioOlie',udled_type) = energiGJ.l(j,'BioOlie') * Ekoeff(j,'BioOlie',udled_type) * 10**(3);

EVAir_E.l(j,'BogD',udled_type) = Eudled.l(j,'BogD',udled_type) * Enhedsp_E(j,'BogD',udled_type) * 10**(-6);
EVAir_E.l(j,'BioOlie',udled_type) = Eudled.l(j,'BioOlie',udled_type) * Enhedsp_E(j,'BioOlie',udled_type) * 10**(-6);

*Sæt dummies
d1TB(j) $ TB.l(j) = 1;
d1TX2(j) = 0;

d1energiGJ(j,kilder) = 1 $ ((energiGJ.l(j,kilder) gt 0) OR (energiGJ.l(j,kilder) gt 0));

*TX.l(j) = Power2X.l(j)/Power2Xratio1;
TX2.l(j)  = 0;
TFX.l(j)  = Tf.l(j);
*+TX.l(j)*Power2Xratio1;
TFXB.l(j) = TFX.l(j)+TB.l(j);
TKf.l(j)  = sum(ns73 $ mapns732j(j,ns73), Ktu73V(ns73)/Kmu73V(ns73)) * KM.l(j) * 0.95;
*TKf.l(j) $ (KMfo.l(j) LT TKf.l(j))  = KMfo.l(j)*0.9;
TTF.l(j)  = TFXB.l(j) + (1+tFak_M.l(j))*ucM.l(j)*PInvM.l(j)*TKf.l(j)/(1+grow.l);

TEl.l(j)  = 0.025 * Tf.l(j);
TEl.l(j) $ (El.l(j) LT (TEl.l(j)+Power2X.l(j)*Power2X_elandel))  = El.l(j)*0.9-Power2X.l(j)*Power2X_elandel;
TKel.l(j)  = sum(ns73 $ mapns732j(j,ns73), Ktu73V(ns73)/Kmu73V(ns73)) * KM.l(j) * 0.05;
TTE.l(j)  = TEl.l(j) + (1+tFak_M.l(j))*ucM.l(j)*PInvM.l(j)*TKel.l(j)/(1+grow.l);
T.l(j)    = TTF.l(j) + TTE.l(j);

*display tkel.l, tkf.l;
*$exit

*Priser sættes
PT.l(j)    = 1;
PTTF.l(j)  = 1;
PTTE.l(j)  = 1;
PTEl.l(j)  = 1;
*PTKel.l(j) = 1;
PTF.l(j)   = 1;
*PTKf.l(j)  = 1;

PTFXB.l(j) = 1;
PTFX.l(j) = 1;
PTB.l(j) = 1;
*PTX.l(j)  = Power2Xratio1;
PTX2.l(j) = Power2Xratio2;

thetaTKF.l(j) = 1;
thetaTKFtot.l = 1;

*My'er kalibreres
m_T.l(j) = T.l(j)/Y.l(j) * (PT.l(j)/PO.l(j))**(EY.l(j));
m_TF.l(j) = TF.l(j)/TFX.l(j) * (PTF.l(j) /PTFX.l(j))**(ETFX.l(j));
*m_TX.l(j) = TX.l(j)/TFX.l(j) * (PTX.l(j) /PTFX.l(j))**(ETFX.l(j));

m_TFXB.l(j) = TFXB.l(j)            / TTF.l(j);
m_TB.l(j)   = TB.l(j)              / TFXB.l(j);
m_TTE.l(j)  = TTE.l(j)             / T.l(j);

m_TTE_tot.l = 1;

m_TEl.l(j)  = TEl.l(j)             / TTE.l(j);
m_TKEl.l(j) = TKel.l(j)/(1+grow.l) / TTE.l(j) * ((1+tFak_M.l(j))*ucM.l(j)*PInvM.l(j))**ETTE.l(j);
m_TKF.l(j)  = TKF.l(j)/(1+grow.l)  / TTF.l(j) * ((1+tFak_M.l(j))*ucM.l(j)*PInvM.l(j))**ETTF.l(j);

c_BD_GJ(j) = energiGJ.l(j,'BogD')/TF.l(j);
c_TB_GJ(j) $ d1TB(j) = energiGJ.l(j,'BioOlie')/TB.l(j);


*Genberegninger af værdier (alt T trækkes ud af KE-aggregatet, dog ikke Power2X-materialedelen, som kommer fra M)
H.l(j)                 = H.l(j)     - T.l(j) + Power2X.l(j)*(1-Power2X_elandel);
LKE.l(j)               = LKE.l(j)   - T.l(j) + Power2X.l(j)*(1-Power2X_elandel);
KE.l(j) $ d1KE(j)      = KE.l(j)    - T.l(j)/PKE.l(j) + Power2X.l(j)*(1-Power2X_elandel)/PKE.l(j);
KE2.l(j) $ d1KE(j) = KE.l(j) - PE.l(j)*E.l(j) - FV_energi.l(j);

El.l(j) = El.l(j) - TEl.l(j) - Power2X.l(j)*Power2X_elandel;
display el.l;
*$exit

parameter foelforhold(j);
foelforhold(j) = KMfo.l(j)/(KMfo.l(j)+KMel.l(j));
KMfo.l(j) = KMfo.l(j) - (TKf.l(j)+TKel.l(j))*foelforhold(j);  
KMel.l(j) = KMel.l(j) - (TKf.l(j)+TKel.l(j))*(1-foelforhold(j));
KEel.l(j) $ d1KE(j) = PEl.l(j)*El.l(j)/PKEel.l(j)         + (1+tFak_M.l(j))*ucM.l(j)*PInvM.l(j)*KMel.l(j)/(1+grow.l)/PKEel.l(j);
KEfo.l(j) $ d1KE(j) = Pfossil.l(j)*fossil.l(j)/PKEfo.l(j) + (1+tFak_M.l(j))*ucM.l(j)*PInvM.l(j)*KMfo.l(j)/(1+grow.l)/PKEfo.l(j);


*Genkalibreringer
m_xe.l(j,dme) $sum(dmeo $ mapdme2dmeo(dmeo,dme), xe.l(j,dmeo))  = xe.l(j,dme) /sum(dmeo $ mapdme2dmeo(dmeo,dme), xe.l(j,dmeo));
m_xm.l(j,dm)  $sum(dmo  $ mapdm2dmo(dmo,dm),     xm.l(j,dmo))   = xm.l(j,dm)  /sum(dmo $ mapdm2dmo(dmo,dm),      xm.l(j,dmo));

m_YM.l(j)     $ Y.l(j)       = PO.l(j)**(-EY.l(j))*M.l(j) / Y.l(j); 
m_YH.l(j)     $ Y.l(j)       = PO.l(j)**(-EY.l(j))*H.l(j) / Y.l(j); 
m_HB.l(j)     $ H.l(j)       = ((1+tFak_B.l(j))*ucB.l(j))**EH.l(j)*(KB.l(j)/(1+grow.l)) / H.l(j); 
m_HLKE.l(j)   $ H.l(j)       = LKE.l(j) / H.l(j); 
m_LKEL.l(j)   $ LKE.l(j)     = (1+tFak_w.l(j))**(ELKE.l(j))*L.l(j) / LKE.l(j); 
m_LKEKE.l(j)  $ LKE.l(j)     = KE.l(j) / LKE.l(j); 
m_KEE.l(j)    $ KE.l(j)      = E.l(j) / KE.l(j); 

m_KE2.l(j)  $ d1KE(j) = KE2.l(j) / KE.l(j);
m_KEel.l(j) $ d1KE(j) = KEel.l(j)/KE2.l(j);

m_El.l(j) $ d1el_e(j) = El.l(j)/KEel.l(j) / (PEl.l(j)/PKEel.l(j))**(-EKEel.l(j));
m_KMel.l(j) $ d1KE(j) = KMel.l(j)/(1+grow.l)/KEel.l(j) / ((1+tFak_M.l(j))*ucM.l(j)*PInvM.l(j)/PKEel.l(j))**(-EKEel.l(j));

m_fossil.l(j) $ d1fossil(j) = fossil.l(j)/KEfo.l(j) / (Pfossil.l(j)/PKEfo.l(j))**(-EKEfo.l(j));
m_KMfo.l(j) $ d1fossil(j)  = KMfo.l(j)/(1+grow.l)/KEfo.l(j) / ((1+tFak_M.l(j))*ucM.l(j)*PInvM.l(j)/PKEfo.l(j))**(-EKEfo.l(j));

m_FV_energi.l(j) $ d1FV_e(j) = FV_energi.l(j)/KE.l(j);



xe_nega(j,dme) $ (xe.l(j,dme) lt 0) = xe.l(j,dme);
xm_nega(j,dm) $ (xm.l(j,dm) lt 0) = xm.l(j,dm);
display xe_nega, xm_nega;
*$exit
*$offtext
*------------------------------------------------------------
* Modeller
*------------------------------------------------------------
model static_transport
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

E_P
E_L
E_KB

E_KBBook
E_KMBook
E_ucB
E_ucM
E_PH
*E_PHny
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
E_DIVny
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
E_Wealth
E_Ex
E_ExD
E_ExF
E_P_Ex
E_GD
E_GF
E_PG
*E_PSaldo
E_PSaldony
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

E_x_energi5

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

E_eltot
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
E_TRcor
E_TRprod
E_Overf
E_Gval
E_Lump

E_PCCS
E_CCSExp

*Transport
*E_PO
E_POny

*E_KM
*E_KMny
E_KMny2

*E_el_energi
E_el_energiNY

*

*E_x_energi4
E_x_energi4ny

*E_x_energi6
E_x_energi6ny


*Transport - NYE

E_pTB
E_TB  
E_TB_energiGJ
E_x_energi3

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
*$offtext

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


/
;


*------------------------------------------------------------
* Test baseret på J_LED (Husk J_Led i alle nye ligninger)
*------------------------------------------------------------
fix ALL;
unfix J_LED;
unfix J_LED_NEW;
unfix J_LED_NEW2;

save;

solve static_transport using cns;

* gamX-kommando (udskriver %-vis afvigelse i.f.t. sidste 'save' for alle variable i gruppen ENDO)
disp J_LED_NEW2;
dispdif |J_LED| > 0.00001;
dispdif |J_LED_NEW| > 0.00001;
dispdif |J_LED_NEW2| > 0.00001;

*$exit

*------------------------------------------------------------
* Kørsel
*------------------------------------------------------------
fix ALL;
unfix ENDO;
unfix ENDO_NEW;
unfix ENDO_NEW2;
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
save;

*eltot.fx = eltot.l;



$ontext
*KM.fx(j) = KM.l(j); 
*el_energi.fx(j) = el_energi.l(j); 

x_energi.fx(j,'190000b') = x_energi.l(j,'190000b');

TB.fx(j) = TB.l(j);
energiGJ.fx(j,'BioOlie') = energiGJ.l(j,'BioOlie');
pTB.fx(j) = pTB.l(j);

T.fx(j) = T.l(j);

TTF.fx(j) = TTF.l(j);
TTE.fx(j) = TTE.l(j);
pT.fx(j) = pT.l(j);

TEl.fx(j) = TEl.l(j);
Tkel.fx(j) = Tkel.l(j);
PTTE.fx(j) = PTTE.l(j);

TFX.fx(j) = TFX.l(j);
TFXB.fx(j) = TFXB.l(j);
Tf.fx(j) = Tf.l(j);
PTTF.fx(j) = PTTF.l(j);

Tkf.fx(j) = Tkf.l(j);
TX.fx(j) = TX.l(j);
TX2.fx(j) = TX2.l(j);
PTFX.fx(j) = PTFX.l(j);
PTFXB.fx(j) = PTFXB.l(j);

PTel.fx(j) = PTel.l(j);
PTf.fx(j) = PTf.l(j);
energiGJ.fx(j,'BogD') = energiGJ.l(j,'BogD');
Power2X.fx(j) = Power2X.l(j);
PTX.fx(j) = PTX.l(j);
PTX2.fx(j) = PTX2.l(j);
$ontext
$offtext

solve static_transport using cns;

*execute_unload "gekko\gdx_work\model_transport.gdx";





disp J_LED_NEW;
dispdif |J_LED| > 0.0001;
dispdif |J_LED_NEW| > 0.0001;
dispdif |J_LED_NEW2| > 0.0001;
display BoP.l;

$ontext
parameter sektordata, aggdata;
sektordata('Penergi',j,kilderF) $ d1Energi(j,kilderF) = PEnergi.l(j,kilderF);
sektordata('energi',j,kilderF) $ d1Energi(j,kilderF) = Energi.l(j,kilderF);
aggdata('Penergi',kilderF) = PEnergiavg.l(kilderF);

execute_unload "sektordata.gdx"
PEnergi.l
Energi.l
PEnergiavg.l
sektordata
aggdata
j
j_indu
;
$offtext

*display KMtest, testKMel;


*CO2eTax.fx = 30;

*solve static_transport using cns;

*display BoP.l;