* Denne fil indeholder en udvidelse af REFORM-modellen fra DREAM. Denne fil indeholder følgende udvidelser:
* En ændring af produktionsfunktionen mht. energi og maskinkapital
* Herunder power-to-X-energiprodukter
* Et CO2e-regnskab
* Indførsel af CO2e-skat
* Indførsel af variable til at måle nytte til EV-mål
* En opsplitning af de offentlige finanser
* Indførelsen af optag af CO2e via CCS-teknologi


OPTION
  SYSOUT=OFF
  SOLPRINT=OFF
  LIMROW=0
  LIMCOL=0
  DECIMALS=6
  PROFILE = 1
  PROFILETOL = 0.05
;


$include sets_energi.gms

sets i_e(i) /
350010a
350010b
383900
350020a
350020b
190000a
*190000b
*080090
420000
060000b
industri
01000a
160000
020000
350030a
350030b
/
;

sets 
j_service(j)    /410009,420000,43000,45000,460000,470000,52000,53000,550000,560000,Tjenester,Boliger,Offentlig,79000/
j_forarb(j)     /100010a,100010b,100010c,100020,100030,100040,100050,11200,Industri,160000,200010,200020,210000,220000,230010,230020,240000,250000,280010,280020,36700/
j_landbrugmv(j) /01000a,01000b,01000c,01000d,020000,030000/
;

Equations
*Ændret produktionsfunktion
E_KE2(j)
E_FV_energi(j)
E_PKEny(j)

E_KEel1(j)
E_KEel2(j)
E_KEel3(j)
E_KEel4(j)

E_KEfo1(j)
E_KEfo2(j)
E_KEfo3(j)
E_KEfo4(j)

E_PKE2(j)
E_KMel(j)
E_El(j)
E_PKEel(j)
E_KMfo(j)
E_fossil(j)
E_PKEfo(j)
E_Eny(j)
E_KMny(j)
E_PEl(j)

E_el_energi(j)

E_x_energi1(j)
E_x_energi2(j)
E_x_energi2B(j)
E_x_energi2C(j)
*E_x_energi3(j)
E_x_energi4(j)
E_x_energi5(j)
E_x_energi6(j)
E_x_energi7(j)
E_x_energi8(j)
E_x_energi9(j)
E_x_energi10(j)
E_x_energi11(j)
E_x_energi12(j)
E_x_energi13(j)
E_x_energi14(j)

E_pBG_e(j)
E_pNG_e(j)
E_pRG_e(j)
E_pNoG_e(j)
*E_pBO_e(j)
E_pOP_e(j)
E_pK_e(j)
E_pA_e(j)
E_pH_e(j)
E_pT_e(j)
E_pB_e(j)

E_PFV_energi(j)
E_px_energi(j,i)

E_ISB_energi(j) 
E_SB_energi(j)  
E_Pfossil(j)    
E_G_energi(j)   
E_O_energi(j)   
E_PISB_energi(j)
E_BG_energi(j)
E_BG_energiGJ(j)
E_NG_energi(j)
E_NG_energiGJ(j)  'Antal mia. GJ naturgas anvendt i sektor j'
E_RG_energi(j) 
E_RG_energiGJ(j)
E_NoG_energi(j)
E_NoG_energiGJ(j)
E_PG_energi(j)  
*E_BO_energi(j)  
*E_BO_energiGJ(j)  
E_OP_energi(j)  
E_OP_energiGJ(j)  
E_PO_energi(j)  
E_K_energi(j)   
E_K_energiGJ(j)   
E_A_energi(j)   
E_A_energiGJ(j)   
E_HT_energi(j)  
E_PSB_energi(j) 
E_H_energi(j)   
E_H_energiGJ(j)   
E_T_energi(j)
E_T_energiGJ(j)
E_B_energi(j)
E_B_energiGJ(j)
E_PHT_energi(j) 

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

E_FVx
*E_FVfossil
E_FVVE
E_PFVx
E_PFVfossil
E_PFVVE


E_elkraftEQ
E_el_kraftandel(j)
E_elVindEQ
E_el_Vindandel(j)
E_el_Renoandel1(j)
E_el_Renoandel2(j)
E_FV_kraftandel(j)
E_FV_Renoandel(j)
E_FV_FjernVEandel(j)
E_FV_Fjernandel(j)
E_FVfossilEQ

E_xny(j,i)

E_DIVny(j)

*CO2e-regnskab
E_Eudled(j,kilder,udled_type)
E_TR_Eudled(j,kilder,udled_type)
E_TR_Eudled_kalib(j,kilder,udled_type)
E_EVAir_E(j,kilder,udled_type)

*EV-variable
E_NettoIndkomst
E_Disnytte

*Offentlige finanser
E_TRAfgifter
E_TRw
E_TRcap
E_TRcor
E_TRprod
E_Overf
E_Gval
E_Lump
E_PSaldony

*CCS
E_PCCS
E_CCSExp
E_BoPny

E_CO2taxrate_BG(j)
E_CO2taxrate_NG(j)
E_CO2taxrate_RG(j)
E_CO2taxrate_NoG(j)
E_CO2taxrate_OP(j)
E_CO2taxrate_K(j)
E_CO2taxrate_A(j)
E_CO2taxrate_H(j)
E_CO2taxrate_T(j)
E_CO2taxrate_B(j)

;

GROUP ENDO_NEW
KE2(j)
FV_energi(j)
KEel(j)
KEfo(j)
PKE2(j)

KMel(j)
El(j)
PKEel(j)
Pel(j)

KMfo(j)
fossil(j)
PKEfo(j)
Pfossil(j)

x_energi(j,i)
px_energi(j,i)

fossilNY(j)
ISB_energi(j) 
SB_energi(j)  
Pfossil(j)    
G_energi(j)   
O_energi(j)   
PISB_energi(j)
BG_energi(j)  
NG_energi(j)  'Mængde anvendt naturgas i sektor j - normaliseret til mia. kr. i basispriser'
RG_energi(j)  'Mængde anvendt rafinaderigas i sektor j - normaliseret til mia. kr. i basispriser'
NoG_energi(j)  'Mængde anvendt Nordsøgas i sektor j - normaliseret til mia. kr. i basispriser'
PG_energi(j)  
*BO_energi(j)  
OP_energi(j)  
PO_energi(j)  
K_energi(j)   
A_energi(j)   
HT_energi(j)  
PSB_energi(j) 
H_energi(j)   
T_energi(j)   
B_energi(j)
PHT_energi(j)
El_energi(j)

PBG_energi(j)  
PNG_energi(j) 
PRG_energi(j) 
PNoG_energi(j) 
*PBO_energi(j)  
POP_energi(j)  
PK_energi(j)   
PA_energi(j)   
PH_energi(j)   
PT_energi(j)   
PB_energi(j)
PFV_energi(j)

Eltot
Elvind
Elfossil
Elkraft
Elaffald

Peltot
Pelvind
Pelfossil
Pelkraft
Pelaffald

FVx
FVfossil
FVVE
PFVx
PFVfossil
PFVVE

EnergiX(j,kilderF)
EnergiGJ(j,kilder)           'Antal mia. GJ energi anvendt i branche j'

Eudled(j,kilder,udled_type)  'Udledninger relateret til energiforbrug - CO2 opgjort i 1.000 tons - alle andre opgjort i tons (ikke omregnet til CO2-ækvivalenter)'
TR_Eudled(j,kilder,udled_type) 'Skatteprovenu fra beskatning af udledninger relateret til energiforbrug - mia. kr.'
TR_Eudled_kalib(j,kilder,udled_type)
EVAir_E(j,kilder,udled_type) 'Helbredsomkostninger fra luftforurening - mia. kr.'

Nettoindkomst
Disnytte

TRAfgifter
TRw
TRcap
TRcor
TRprod
Overf
Gval
Lump

PCCS  'Marginalprisen på optag af CO2e via CCS - kr. per ton CO2e'
CCSExp    'Samlede omkostninger til CCS - mia. kr.'


el_kraftandel(j)
el_Vindandel(j)
el_Renoandel(j)
FV_kraftandel(j)
FV_Renoandel(j)
FV_FjernVEandel(j)
FV_Fjernandel(j)

el_RenoandelX
el_VindandelX
*FV_fjernandelX

CO2taxrate_BG(j)
CO2taxrate_NG(j)
CO2taxrate_RG(j)
CO2taxrate_NoG(j)
CO2taxrate_OP(j)
CO2taxrate_K(j)
CO2taxrate_A(j)
CO2taxrate_H(j)
CO2taxrate_T(j)
CO2taxrate_B(j)

;


GROUP EKSO_NEW

EKEny(j)
EKEel(j)
EKEfo(j)
Efossil(j)

EISB_energi(j) 
ESB_energi(j)   
EG_energi(j) 
EO_energi(j)  
EHT_energi(j) 

Eel
Eelfossil
EFV

m_KE2(j)
m_FV_energi(j)
m_KEel(j)

m_KEel_landbrugmv
m_KEel_forarb
m_KEel_service

m_El(j)
m_KMel(j)
m_KMfo(j)
m_fossil(j)
Pfossilscalar(j)

m_ISB_energi(j) 
*m_SB_energi(j)  
m_G_energi(j)   
m_O_energi(j)   
m_BG_energi(j)
m_BG_energi_tot
*m_NG_energi(j)  
m_RG_energi(j)  
m_NoG_energi(j)  
*m_BO_energi(j)  
m_OP_energi(j)  
m_K_energi(j)   
m_A_energi(j)   
m_HT_energi(j)  
m_H_energi(j)   
m_T_energi(j)   
*m_B_energi(j)   

m_elvind
m_elkraft

m_FVfossil

thetaKMel(j)
thetaKMfo(j)

CO2eTax         'CO2e skat - kr. per ton CO2e'
CO2eTax_kalib
Kalibrering

CCS   'CO2e-optag (negativ CO2e-udledning) på dansk territorium - enhed 1000 ton CO2-ækvivalenter'

;

GROUP J_LED_NEW
J_KE2(j)
J_FV_energi(j)
J_PKEny(j)
J_KEel(j)
J_KEfo(j)
J_PKE2(j)
J_KMel(j)
J_El(j)
J_PKEel(j)
J_KMfo(j)
J_fossil(j)
J_PKEfo(j)
J_Pfossil(j)

J_x_energi(j,i)
J_px_energi(j,i)

J_pBG_e(j)
J_pNG_e(j)
J_pRG_e(j)
J_pNoG_e(j)
J_pRG_e(j)
J_pNoG_e(j)
*J_pBO_e(j)
J_pOP_e(j)
J_pK_e(j)
J_pA_e(j)
J_pH_e(j)
J_pT_e(j)
J_pB_e(j)

J_PFV_energi(j)

J_el_energi(j)

J_ISB_energi(j) 
J_SB_energi(j)  
J_Pfossil(j)    
J_G_energi(j)   
J_O_energi(j)   
J_PISB_energi(j)
J_BG_energi(j)
J_BG_energiGJ(j)
J_NG_energi(j)
J_NG_energiGJ(j)
J_RG_energi(j)
J_RG_energiGJ(j)
J_NoG_energi(j)
J_NoG_energiGJ(j)
J_PG_energi(j)  
*J_BO_energi(j)
*J_BO_energiGJ(j)
J_OP_energi(j) 
J_OP_energiGJ(j) 
J_PO_energi(j)  
J_K_energi(j)
J_K_energiGJ(j)
J_A_energi(j)
J_A_energiGJ(j)
J_HT_energi(j)  
J_PSB_energi(j) 
J_H_energi(j)
J_H_energiGJ(j)
J_T_energi(j)
J_T_energiGJ(j)
J_B_energi(j)
J_B_energiGJ(j)
J_PHT_energi(j) 

J_pel(j)

J_eltot
J_elvind
J_elfossil
J_Peltot
J_elkraft
J_elaffald
J_Pelfossil
J_PElvind
J_PElkraft
J_PElaffald

J_FVx
J_FVfossil
J_FVVE
J_PFVx
J_PFVfossil
J_PFVVE

J_elkraftEQ
J_el_kraftandel(j)
J_elVindEQ
J_el_Vindandel(j)
J_el_Renoandel(j)
J_FV_kraftandel(j)
J_FV_Renoandel(j)
J_FV_FjernVEandel(j)
J_FV_Fjernandel(j)
J_FVfossilEQ

J_Nettoindkomst
J_Disnytte

J_Eudled(j,kilder,udled_type)
J_TR_Eudled(j,kilder,udled_type)
J_TR_Eudled_kalib(j,kilder,udled_type)
J_EVAir_E(j,kilder,udled_type)

J_TRAfgifter
j_TRw
j_TRcap
j_TRcor
j_TRprod
j_Overf
j_Gval
j_Lump

J_PCCS
J_CCSExp

J_CO2taxrate_BG(j)
J_CO2taxrate_NG(j)
J_CO2taxrate_RG(j)
J_CO2taxrate_NoG(j)
J_CO2taxrate_OP(j)
J_CO2taxrate_K(j)
J_CO2taxrate_A(j)
J_CO2taxrate_H(j)
J_CO2taxrate_T(j)
J_CO2taxrate_B(j)
;

Parameter
anvBas(j,kilder)
anvBas_hh(hh_c,kilder)
anvKbin(j,kilder)
anvKbin_hh(hh_c,kilder)
anvGJ(j,kilder)
TilBas(j,kilder)
TilGJ(j,kilder)
TilBas_import(kilder)
TilGJ_import(kilder)
EKoeff(j,kilder,udled_type)
Enhedsp_E(j,kilder,udled_type)

CO2eVaegt(udled_type)
CO2eTax_dummyE(j,kilder,udled_type)
CO2eTax_dummyE_kalib(j,kilder,udled_type)
Kalibrering_dummyE(j,kilder,udled_type)

KE_andel_rela  'angiver den relative forskel i K/E-forholdet i KEel-aggregattet ift. KEfor-aggregattet'
anvEnergiV(j,kilder)
anvEnergiQ(j,kilder)
CCSstartP                           'Startprisen på optag af CO2e via CCS-teknologi - kr. per ton CO2e'  
CCSalfa                              'Prisstigning på CCS ved øget mængde - prisstigning i kr. per 1000 tons'
d1fossil(j)
d1KM(j)

d1energiGJ(j,kilder)

d1ISB_e(j) 
d1SB_e(j)  
d1Pfossil(j)    
d1G_e(j)   
d1O_e(j)   
d1PISB_e(j)
d1BG_e(j)  
d1NG_e(j)
d1RG_e(j)
d1NoG_e(j)
*d1BO_e(j)  
d1OP_e(j)  
d1PO_e(j)  
d1K_e(j)   
d1A_e(j)   
d1HT_e(j)  
d1PSB_e(j) 
d1H_e(j)   
d1T_e(j)   
d1B_e(j)   
d1PHT_e(j) 

d1el_e(j)
d1FV_e(j)

d1el(j)
d1elfossil(j)
d1elvind(j)
d1elkraft(j)
d1elaffald(j)

Mpre(j)

*para_elkraftEQ
*para_elVindEQ
*para_FVfossilEQ
preRenoandelX(j)
preVindandelX(j)
*preFjernandelX(j)
konstantKraft(j)
konstantReno(j)

Eltest

c_NG_GJ(j)
c_RG_GJ(j)
c_NoG_GJ(j)
c_BG_GJ(j) 
c_OP_GJ(j) 
*c_BO_GJ(j) 
c_K_GJ(j)  
c_A_GJ(j)  
c_H_GJ(j)  
c_T_GJ(j)  
c_B_GJ(j)

GJvalueRatio_BG(j)
GJvalueRatio_NG(j)
GJvalueRatio_RG(j)
GJvalueRatio_NoG(j)
GJvalueRatio_OP(j)
GJvalueRatio_K(j)
GJvalueRatio_A(j)
GJvalueRatio_H(j)
GJvalueRatio_T(j)
GJvalueRatio_B(j)

El0(j)

d1kraftandel0(j)
FV_FjernandelKonstant(j)
;



*Ændret produktionsfunktion
$ontext
             KE
  /     /             \
E   FV_energi         KE2
                   /         \
                 KEel        KEfo
              /     \       /     \
            KMel    El     KMfo   fossil

$offtext
E_KE2(j) $ d1KE(j)..  KE2(j) =E= J_KE2(j) + m_KE2(j) * (PKE2(j)/PKE(j))**(-EKE(j))*KE(j);
E_FV_energi(j) $ d1FV_e(j).. FV_energi(j) =E= J_FV_energi(j) + m_FV_energi(j) * (PFV_energi(j)/PKE(j))**(-EKE(j))*KE(j);
E_PKEny(j) $ d1KE(j)..  PKE(j)*KE(j) =E= J_PKEny(j) + PKE2(j)*KE2(j)+ PE(j)*E(j) + PFV_energi(j)*FV_energi(j);

E_KEel1(j) $ (d1KE(j) and not j_landbrugmv(j) and not j_forarb(j) and not j_service(j))..  KEel(j) =e= J_KEel(j) + m_KEel(j) * (PKEel(j)/PKE2(j))**(-EKEny(j))*KE2(j);
E_KEel2(j) $ (d1KE(j) and j_landbrugmv(j))..                       KEel(j) =e= J_KEel(j) + (m_KEel(j) + (1-m_KEel(j))*m_KEel_landbrugmv)  * (PKEel(j)/PKE2(j))**(-EKEny(j))*KE2(j);
E_KEel3(j) $ (d1KE(j) and j_forarb(j))..                           KEel(j) =e= J_KEel(j) + (m_KEel(j) + (1-m_KEel(j))*m_KEel_forarb)  * (PKEel(j)/PKE2(j))**(-EKEny(j))*KE2(j);
E_KEel4(j) $ (d1KE(j) and j_service(j))..                          KEel(j) =e= J_KEel(j) + (m_KEel(j) + (1-m_KEel(j))*m_KEel_service) * (PKEel(j)/PKE2(j))**(-EKEny(j))*KE2(j);

E_KEfo1(j) $ (d1KE(j) and not j_landbrugmv(j) and not j_forarb(j) and not j_service(j))..  KEfo(j) =e= J_KEfo(j) + (1-m_KEel(j)) * (PKEfo(j)/PKE2(j))**(-EKEny(j))*KE2(j);
E_KEfo2(j) $ (d1KE(j) and j_landbrugmv(j))..                       KEfo(j) =e= J_KEfo(j) + (1-m_KEel(j))*(1-m_KEel_landbrugmv)  * (PKEfo(j)/PKE2(j))**(-EKEny(j))*KE2(j);
E_KEfo3(j) $ (d1KE(j) and j_forarb(j))..                           KEfo(j) =e= J_KEfo(j) + (1-m_KEel(j))*(1-m_KEel_forarb)  * (PKEfo(j)/PKE2(j))**(-EKEny(j))*KE2(j);
E_KEfo4(j) $ (d1KE(j) and j_service(j))..                          KEfo(j) =e= J_KEfo(j) + (1-m_KEel(j))*(1-m_KEel_service) * (PKEfo(j)/PKE2(j))**(-EKEny(j))*KE2(j);

E_PKE2(j) $ d1KE(j)..    PKE2(j)*KE2(j) =e= J_PKE2(j) + PKEel(j)*KEel(j) + PKEfo(j)*KEfo(j);


E_El(j) $ d1el_e(j)..      El(j) =e= J_El(j) + m_El(j) * (PEl(j)/PKEel(j))**(-EKEel(j))*KEel(j);
E_KMel(j) $ d1KE(j)..      tfp(j)*thetaKMel(j)*KMel(j)/(1+grow) =e= J_KMel(j) + m_KMel(j) * ((1+tFak_M(j))*ucM(j)*PInvM(j)/(tfp(j)*thetaKMel(j)*PKEel(j)))**(-EKEel(j))*KEel(j);
E_PKEel(j) $ d1KE(j)..    PKEel(j)*KEel(j) =e= J_PKEel(j) + PEl(j)*El(j) + (1+tFak_M(j))*ucM(j)*PInvM(j)*KMel(j)/(1+grow);

E_fossil(j)  $ d1fossil(j)..                   fossil(j) =e= J_fossil(j) + m_fossil(j) * (Pfossil(j)/PKEfo(j))**(-EKEfo(j))*KEfo(j);
E_KMfo(j)    $ d1fossil(j)..            tfp(j)*thetaKMfo(j)*KMfo(j)/(1+grow) =e= J_KMfo(j)   + m_KMfo(j) * ((1+tFak_M(j))*ucM(j)*PInvM(j)/(tfp(j)*thetaKMfo(j)*PKEfo(j)))**(-EKEfo(j))*KEfo(j);
E_PKEfo(j)   $ d1fossil(j)..            PKEfo(j)*KEfo(j) =e= J_PKEfo(j)  + Pfossil(j)*fossil(j) + (1+tFak_M(j))*ucM(j)*PInvM(j)*KMfo(j)/(1+grow);


$ontext
           fossil
       /             \
      ISB             SB         ISB:ikke-solide brændsler  SB:solide brændsler
    /      \        /  \  \
   G        O      K   A   HT      G:gas O:olie K:kul og koks A:affald HT:Halm og træ
 // \\       \            / \ \
BNRNo_G      OP           H T B     BG:biogas NG:natur- og bygas RG:rafinaderigas NoG:Nordsøgas BO:bioolie OP:olieprodukter H:halm T:træpiller B:brænde og skovflis

$offtext


E_ISB_energi(j)  $ d1ISB_e(j).. ISB_energi(j) =E= J_ISB_energi(j) + m_ISB_energi(j) * (PISB_energi(j)/Pfossil(j))**(-Efossil(j))*fossil(j);
E_SB_energi(j)   $ d1SB_e(j).. SB_energi(j)  =E= J_SB_energi(j)  + (1-m_ISB_energi(j)) * (PSB_energi(j) /Pfossil(j))**(-Efossil(j))*fossil(j);
E_Pfossil(j)     $ d1fossil(j).. Pfossil(j) * fossil(j) =E= J_Pfossil(j) + PISB_energi(j)*ISB_energi(j) + PSB_energi(j)*SB_energi(j);

E_G_energi(j)    $ d1G_e(j).. G_energi(j) =E= J_G_energi(j) + m_G_energi(j) * (PG_energi(j)/PISB_energi(j))**(-EISB_energi(j))*ISB_energi(j);
E_O_energi(j)    $ d1O_e(j).. O_energi(j)  =E= J_O_energi(j)  + m_O_energi(j) * (PO_energi(j) /PISB_energi(j))**(-EISB_energi(j))*ISB_energi(j);
E_PISB_energi(j) $ d1ISB_e(j).. PISB_energi(j) * ISB_energi(j) =e= J_PISB_energi(j) + PG_energi(j)*G_energi(j) + PO_energi(j)*O_energi(j);

*E_BG_energi(j)   $ d1BG_e(j).. BG_energi(j) =E= J_BG_energi(j) + m_BG_energi(j)*m_BG_energi_tot * (PBG_energi(j)/PG_energi(j))**(-EG_energi(j))*G_energi(j);
E_BG_energi(j)   $ d1BG_e(j).. BG_energi(j) =E= J_BG_energi(j) + (m_BG_energi(j)+(1-m_BG_energi(j))*m_BG_energi_tot) * (PBG_energi(j)/PG_energi(j))**(-EG_energi(j))*G_energi(j);

*E_NG_energi(j)   $ d1NG_e(j).. NG_energi(j)  =E= J_NG_energi(j)  + (1-m_BG_energi(j)*m_BG_energi_tot-m_RG_energi(j)-m_NoG_energi(j)) * (PNG_energi(j) /PG_energi(j))**(-EG_energi(j))*G_energi(j);
E_NG_energi(j)   $ d1NG_e(j).. NG_energi(j)  =E= J_NG_energi(j)  + (1 - (m_BG_energi(j)+(1-m_BG_energi(j))*m_BG_energi_tot) - m_RG_energi(j) - m_NoG_energi(j)) * (PNG_energi(j) /PG_energi(j))**(-EG_energi(j))*G_energi(j);
E_RG_energi(j)   $ d1RG_e(j).. RG_energi(j)  =E= J_RG_energi(j)  + m_RG_energi(j) * (PRG_energi(j) /PG_energi(j))**(-EG_energi(j))*G_energi(j);
E_NoG_energi(j)   $ d1NoG_e(j).. NoG_energi(j)  =E= J_NoG_energi(j)  + m_NoG_energi(j) * (PNoG_energi(j) /PG_energi(j))**(-EG_energi(j))*G_energi(j);
E_PG_energi(j)   $ d1G_e(j).. PG_energi(j) * G_energi(j) =e= J_PG_energi(j) + PBG_energi(j)*BG_energi(j) + PNG_energi(j)*NG_energi(j) + PRG_energi(j)*RG_energi(j) + PNoG_energi(j)*NoG_energi(j);

*E_BO_energi(j)   $ d1BO_e(j).. BO_energi(j) =E= J_BO_energi(j) + m_BO_energi(j) * (PBO_energi(j)/PO_energi(j))**(-EO_energi(j))*O_energi(j);
E_OP_energi(j)   $ d1OP_e(j).. OP_energi(j)  =E= J_OP_energi(j)  + m_OP_energi(j) * (POP_energi(j) /PO_energi(j))**(-EO_energi(j))*O_energi(j);
*E_PO_energi(j)   $ d1O_e(j).. PO_energi(j) * O_energi(j) =e= J_PO_energi(j) + PBO_energi(j)*BO_energi(j) + POP_energi(j)*OP_energi(j);
E_PO_energi(j)   $ d1O_e(j).. PO_energi(j) * O_energi(j) =e= J_PO_energi(j)  + POP_energi(j)*OP_energi(j);

E_K_energi(j)    $ d1K_e(j).. K_energi(j) =E= J_K_energi(j) + m_K_energi(j) * (PK_energi(j)/PSB_energi(j))**(-ESB_energi(j))*SB_energi(j);
E_A_energi(j)    $ d1A_e(j).. A_energi(j)  =E= J_A_energi(j)  + m_A_energi(j) * (PA_energi(j) /PSB_energi(j))**(-ESB_energi(j))*SB_energi(j);
E_HT_energi(j)   $ d1HT_e(j).. HT_energi(j)  =E= J_HT_energi(j)  + m_HT_energi(j) * (PHT_energi(j) /PSB_energi(j))**(-ESB_energi(j))*SB_energi(j);
E_PSB_energi(j)  $ d1SB_e(j).. PSB_energi(j) * SB_energi(j) =e= J_PSB_energi(j) + PK_energi(j)*K_energi(j) + PA_energi(j)*A_energi(j) + PHT_energi(j)*HT_energi(j);

E_H_energi(j)    $ d1H_e(j).. H_energi(j) =E= J_H_energi(j) + m_H_energi(j) * (PH_energi(j)/PHT_energi(j))**(-EHT_energi(j))*HT_energi(j);
E_T_energi(j)    $ d1T_e(j).. T_energi(j)  =E= J_T_energi(j)  + m_T_energi(j) * (PT_energi(j) /PHT_energi(j))**(-EHT_energi(j))*HT_energi(j);
E_B_energi(j)    $ d1B_e(j).. B_energi(j)  =E= J_B_energi(j)  + (1-m_H_energi(j)-m_T_energi(j)) * (PB_energi(j) /PHT_energi(j))**(-EHT_energi(j))*HT_energi(j);
E_PHT_energi(j)  $ d1HT_e(j).. PHT_energi(j) * HT_energi(j) =e= J_PHT_energi(j) + PH_energi(j)*H_energi(j) + PT_energi(j)*T_energi(j) + PB_energi(j)*B_energi(j);

E_NG_energiGJ(j) $ d1NG_e(j)..   energiGJ(j,'natgas')  =E= J_NG_energiGJ(j)  + c_NG_GJ(j)  * NG_energi(j);
E_RG_energiGJ(j) $ d1RG_e(j)..   energiGJ(j,'rafgas')  =E= J_RG_energiGJ(j)   + c_RG_GJ(j)  * RG_energi(j);
E_NoG_energiGJ(j) $ d1NoG_e(j).. energiGJ(j,'Nordgas') =E= J_NoG_energiGJ(j) + c_NoG_GJ(j) * NoG_energi(j);
E_BG_energiGJ(j) $ d1BG_e(j)..   energiGJ(j,'biogas')   =E= J_BG_energiGJ(j)  + c_BG_GJ(j)  * BG_energi(j);
E_OP_energiGJ(j) $ d1OP_e(j)..   energiGJ(j,'olie')     =E= J_OP_energiGJ(j)  + c_OP_GJ(j)  * OP_energi(j);
*E_BO_energiGJ(j) $ d1BO_e(j).. energiGJ(j,'BioOlie')  =E= J_BO_energiGJ(j)  + c_BO_GJ(j)  * BO_energi(j);
E_K_energiGJ(j)  $ d1K_e(j)..    energiGJ(j,'kul')      =E= J_K_energiGJ(j)   + c_K_GJ(j)   * K_energi(j);
E_A_energiGJ(j)  $ d1A_e(j)..    energiGJ(j,'Affald')   =E= J_A_energiGJ(j)   + c_A_GJ(j)   * A_energi(j);
E_H_energiGJ(j)  $ d1H_e(j)..    energiGJ(j,'Halm')     =E= J_H_energiGJ(j)   + c_H_GJ(j)   * H_energi(j);
E_T_energiGJ(j)  $ d1T_e(j)..    energiGJ(j,'Tpiller')  =E= J_T_energiGJ(j)   + c_T_GJ(j)   * T_energi(j);
E_B_energiGJ(j)  $ d1B_e(j)..    energiGJ(j,'Tbra')     =E= J_B_energiGJ(j)   + c_B_GJ(j)   * B_energi(j);


$ontext
      el                        fjernvarme
    /    \                              
vind     fossil              FVx          FVrest     
          /  \             /     \         /  \
      kraft affald    FVfossil   FVVE  kraft affald
$offtext

E_eltot..     Eltot    =E= J_eltot + sum(j,el_energi(j));
E_Elvind..    Elvind   =E= J_Elvind   + m_elvind   * (Pelvind/Peltot  )**(-Eel)*Eltot;
E_Elfossil..  Elfossil =E= J_Elfossil + (1-m_elvind) * (Pelfossil/Peltot)**(-Eel)*Eltot;
E_Peltot..    Peltot * Eltot =E= J_Peltot + Pelvind*elvind + Pelfossil*elfossil;
E_Elkraft..   Elkraft  =E= J_Elkraft  + m_elkraft  * (Pelkraft /Pelfossil)**(-Eelfossil)*Elfossil;
E_Elaffald..  Elaffald =E= J_Elaffald + (1-m_elkraft) * (Pelaffald/Pelfossil)**(-Eelfossil)*Elfossil;
E_Pelfossil.. Pelfossil * Elfossil =E= J_Pelfossil + Pelkraft*elkraft + Pelaffald*elaffald;
E_Pelvind..   Pelvind  *sum(j,x_energi(j,'350010b')) =E= J_Pelvind   + sum(j,px_energi(j,'350010b')*x_energi(j,'350010b'));
E_Pelkraft..  Pelkraft *sum(j,x_energi(j,'350010a')) =E= J_Pelkraft  + sum(j,px_energi(j,'350010a')*x_energi(j,'350010a'));
E_Pelaffald.. Pelaffald*sum(j,x_energi(j,'383900'))  =E= J_Pelaffald + sum(j,px_energi(j,'383900') *x_energi(j,'383900'));

E_FVx.. FVx =E= J_FVx + sum(j, (1-FV_kraftandel(j)-FV_Renoandel(j))*FV_energi(j));
*E_FVfossil.. FVfossil =E= J_FVfossil + m_FVfossil * (PFVfossil/PFVx)**(-EFV)*FVx;
E_FVVE..     FVVE     =E= J_FVVE     + (1-m_FVfossil) * (PFVVE    /PFVx)**(-EFV)*FVx;
E_PFVx.. PFVx*FVx =E= J_PFVx + PFVfossil*FVfossil + PFVVE*FVVE;
E_PFVfossil..  PFVfossil *sum(j,x_energi(j,'350030a')*FV_Fjernandel(j)) =E= J_PFVfossil  + sum(j,px_energi(j,'350030a')*x_energi(j,'350030a')*FV_Fjernandel(j));
E_PFVVE..      PFVVE   *sum(j,x_energi(j,'350030b')*FV_FjernVEandel(j)) =E= J_PFVVE      + sum(j,px_energi(j,'350030b')*x_energi(j,'350030b')*FV_FjernVEandel(j));


E_KMny(j) $ d1KM(j)..   KM(j) =e= j_KM(j) + KMel(j) + KMfo(j);

E_xny(j,i) $ d1x(j,i)..    x(j,i) =e= J_x(j,i) + sum(dmi $ mapdm2i(i,dmi), xm(j,dmi)) + sum(dmei $ mapdme2i(i,dmei), xe(j,dmei)) + x_energi(j,i);

E_el_energi(j).. el_energi(j) =E= J_el_energi(j) + El(j);

E_x_energi1(j) $ d1BG_e(j).. x_energi(j,'350020b') =E= J_x_energi(j,'350020b') + BG_energi(j);
E_x_energi2(j) $ d1NG_e(j).. x_energi(j,'350020a') =E= J_x_energi(j,'350020a') + NG_energi(j);
E_x_energi2C(j)$ d1NoG_e(j)..x_energi(j,'060000b') =E= J_x_energi(j,'060000b') + NoG_energi(j);
*E_x_energi3(j) $ d1BO_e(j).. x_energi(j,'190000b') =E= J_x_energi(j,'190000b') + BO_energi(j);
E_x_energi4(j) $ (d1OP_e(j) or d1RG_e(j)).. x_energi(j,'190000a') =E= J_x_energi(j,'190000a') + OP_energi(j) + RG_energi(j);
E_x_energi5(j) $ d1K_e(j)..  x_energi(j,'420000') =E= J_x_energi(j,'420000') + K_energi(j);
E_x_energi6(j) $ d1A_e(j)..  x_energi(j,'industri')=E= J_x_energi(j,'industri')+ A_energi(j);
E_x_energi7(j) $ d1H_e(j)..  x_energi(j,'01000a')  =E= J_x_energi(j,'01000a')  + H_energi(j);
E_x_energi8(j) $ d1T_e(j)..  x_energi(j,'160000')  =E= J_x_energi(j,'160000')  + T_energi(j);
E_x_energi9(j) $ d1B_e(j)..  x_energi(j,'020000')  =E= J_x_energi(j,'020000')  + B_energi(j);
E_x_energi10(j)..            x_energi(j,'350010a') =E= J_x_energi(j,'350010a') + el_energi(j)*el_kraftandel(j) + FV_energi(j)*FV_kraftandel(j);
E_x_energi11(j)..            x_energi(j,'350010b') =E= J_x_energi(j,'350010b') + el_energi(j)*el_Vindandel(j);
E_x_energi12(j)..            x_energi(j,'383900')  =E= J_x_energi(j,'383900')  + el_energi(j)*el_Renoandel(j) + FV_energi(j)*FV_Renoandel(j);
E_x_energi13(j) $ d1X(j,'350030a').. x_energi(j,'350030a') =E= J_x_energi(j,'350030a') + FV_energi(j)*FV_Fjernandel(j);
E_x_energi14(j) $ d1X(j,'350030b').. x_energi(j,'350030b') =E= J_x_energi(j,'350030b') + FV_energi(j)*FV_FjernVEandel(j);



E_pBG_e(j) $ d1BG_e(j).. PBG_energi(j)=E= J_pBG_e(j)+ px_energi(j,'350020b') + CO2taxrate_BG(j);
E_pNG_e(j) $ d1NG_e(j).. PNG_energi(j)=E= J_pNG_e(j)+ px_energi(j,'350020a') + CO2taxrate_NG(j);
E_pRG_e(j) $ d1RG_e(j).. PRG_energi(j)=E= J_pRG_e(j)+ px_energi(j,'190000a') + CO2taxrate_RG(j);
E_pNoG_e(j) $ d1NoG_e(j).. PNoG_energi(j)=E= J_pNoG_e(j)+ px_energi(j,'060000b') + CO2taxrate_NoG(j);
*E_pBO_e(j) $ d1BO_e(j).. PBO_energi(j)=E= J_pBO_e(j)+ px_energi(j,'190000b') + sum(udled_type,TR_Eudled(j,'BioOlie',udled_type))/BO_energi(j) ;
E_pOP_e(j) $ d1OP_e(j).. POP_energi(j)=E= J_pOP_e(j)+ px_energi(j,'190000a') + CO2taxrate_OP(j);
E_pK_e(j)  $ d1K_e(j)..  PK_energi(j) =E= J_pK_e(j) + px_energi(j,'420000')  + CO2taxrate_K(j);
E_pA_e(j)  $ d1A_e(j)..  PA_energi(j) =E= J_pA_e(j) + px_energi(j,'industri')+ CO2taxrate_A(j);
E_pH_e(j)  $ d1H_e(j)..  PH_energi(j) =E= J_pH_e(j) + px_energi(j,'01000a')  + CO2taxrate_H(j);
E_pT_e(j)  $ d1T_e(j)..  PT_energi(j) =E= J_pT_e(j) + px_energi(j,'160000')  + CO2taxrate_T(j);
E_pB_e(j)  $ d1B_e(j)..  PB_energi(j) =E= J_pB_e(j) + px_energi(j,'020000')  + CO2taxrate_B(j);


E_Pel(j)..          Pel(j)*el_energi(j) =E= J_Pel(j) +el_energi(j)*el_kraftandel(j)*px_energi(j,'350010a')
                                                     +el_energi(j)*el_Vindandel(j) *px_energi(j,'350010b')
                                                     +el_energi(j)*el_Renoandel(j) *px_energi(j,'383900');
E_PFV_energi(j) $d1FV_e(j).. PFV_energi(j)*FV_energi(j) =E= J_pFV_energi(j) + FV_energi(j)*FV_kraftandel(j)  *px_energi(j,'350010a')
                                                                            + FV_energi(j)*FV_Renoandel(j)   *px_energi(j,'383900')
                                                                            + FV_energi(j)*FV_Fjernandel(j)  *px_energi(j,'350030a')
                                                                            + FV_energi(j)*FV_FjernVEandel(j)*px_energi(j,'350030b');

E_px_energi(j,i)..                 px_energi(j,i) =E= J_px_energi(j,i) + Px(j,i);


*E_el_kraftandel(j).. el_kraftandel(j) =E= J_el_kraftandel(j) + el_kraftandelX**(prekraftandelX(j));
E_el_Vindandel(j)..   el_Vindandel(j) =E= J_el_Vindandel(j)  + el_VindandelX**(preVindandelX(j));
*E_el_Renoandel(j)..   el_Renoandel(j) =E= J_el_Renoandel(j) + 1 - el_kraftandel(j) - el_Vindandel(j);

E_el_Renoandel1(j) $ (d1kraftandel0(j) EQ 0)..  el_Renoandel(j) =E= J_el_Renoandel(j) + el_RenoandelX**(preRenoandelX(j));
E_el_Renoandel2(j) $ (d1kraftandel0(j) EQ 1)..  el_Renoandel(j) =E= J_el_Renoandel(j) + 1 - el_Vindandel(j);

E_el_kraftandel(j) $ (d1kraftandel0(j) EQ 0).. el_kraftandel(j) =E= J_el_kraftandel(j) + 1 - el_Renoandel(j) - el_Vindandel(j);


E_FV_kraftandel(j)   $ d1FV_e(j)..   FV_kraftandel(j) =E= J_FV_kraftandel(j) + el_energi(j)*el_kraftandel(j)/FV_energi(j) * konstantKraft(j);
*E_FV_kraftandel(j)   $ d1FV_e(j)..   FV_kraftandel(j) =E= J_FV_kraftandel(j) + el_kraftandel(j)**konstantKraft(j);
E_FV_Renoandel(j)    $ d1FV_e(j)..    FV_Renoandel(j) =E= J_FV_Renoandel(j)  + el_energi(j)*el_Renoandel(j) /FV_energi(j)  * konstantReno(j);
*E_FV_Renoandel(j)    $ d1FV_e(j)..    FV_Renoandel(j) =E= J_FV_Renoandel(j)  + el_Renoandel(j)**konstantReno(j);
*E_FV_Fjernandel(j)   $ d1FV_e(j)..   FV_Fjernandel(j) =E= J_FV_Fjernandel(j) + (@pos(FV_FjernandelX))**(preFjernandelX(j));
E_FV_Fjernandel(j)   $ d1FV_e(j)..   FV_Fjernandel(j) =E= J_FV_Fjernandel(j) + FV_FjernandelKonstant(j) * (1 - FV_kraftandel(j) - FV_Renoandel(j)); 
E_FV_FjernVEandel(j) $ d1FV_e(j).. FV_FjernVEandel(j) =E= J_FV_FjernVEandel(j) + 1 - FV_kraftandel(j) - FV_Renoandel(j) - FV_Fjernandel(j);


E_elkraftEQ.. elkraft =E= J_elkraftEQ + sum(j, el_energi(j)*el_kraftandel(j)); 
E_elVindEQ..  elVind  =E= J_elVindEQ  + sum(j, el_energi(j)*el_Vindandel(j)); 
E_FVfossilEQ.. FVfossil =E= J_FVfossilEQ  + sum(j, FV_energi(j)*FV_Fjernandel(j)); 

  
E_DIVny(j)..    DIV(j) =e= J_DIV(j) + (1-t_cor(j))*(p(j)*Y(j) - PM(j)*M(j) - PE(j)*E(j) - sum(i,px_energi(j,i)*x_energi(j,i)) - (1+tFak_w(j))*w*L(j) - tFak_B(j)*ucB(j)*PInvB(j)*KB(j)/(1+grow) - tFak_M(j)*ucM(j)*PInvM(j)*KM(j)/(1+grow) - sum((kilder,udled_type), TR_Eudled(j,kilder,udled_type) + TR_Eudled_kalib(j,kilder,udled_type)) - Fak_rest(j)
                                  - (r*(1+infl)+infl)*DP(j)/((1+infl)*(1+grow))) - PInvB(j)*InvB(j) - PInvM(j)*InvM(j) - PIL(j)*IL(j) 
                                  - SUBEU(j)
                                  + t_cor(j)*(deltaKBBook(j)*KBBook(j)+deltaKMBook(j)*KMBook(j))/((1+grow)*(1+infl)) + (1-1/((1+grow)*(1+infl)))*DP(j);

*CO2e-regnskab

* For CO2: antal mia. GJ gange kg. per GJ gange 10**(3) = antal 1.000 tons CO2
* For øvrige: antal mia. GJ gange gram per GJ gange 10**(3) = antal tons af X
E_Eudled(j,kilder,udled_type) $ d1energiGJ(j,kilder).. Eudled(j,kilder,udled_type) =E= J_Eudled(j,kilder,udled_type) + energiGJ(j,kilder) * Ekoeff(j,kilder,udled_type) * 10**(3) * (1 + Kalibrering * Kalibrering_dummyE(j,kilder,udled_type));

* Afgift i kr. per ton CO2e gange antal ton CO2-ækvivalent gange 10**(-9) = provenu i mia. kr.
E_TR_Eudled(j,kilder,udled_type) $ d1energiGJ(j,kilder).. TR_Eudled(j,kilder,udled_type) =E= J_TR_Eudled(j,kilder,udled_type) + Eudled(j,kilder,udled_type)*CO2eVaegt(udled_type) * CO2eTax * CO2eTax_dummyE(j,kilder,udled_type) * 10**(-9); 
E_TR_Eudled_kalib(j,kilder,udled_type) $ d1energiGJ(j,kilder).. TR_Eudled_kalib(j,kilder,udled_type) =E= J_TR_Eudled_kalib(j,kilder,udled_type) + Eudled(j,kilder,udled_type)*CO2eVaegt(udled_type) * CO2eTax_kalib * CO2eTax_dummyE_kalib(j,kilder,udled_type) * 10**(-9); 

* Helbredsomkostninger fra luftforurening: Enhedsværdier i kr. per kg emission gange antal ton emission gange 10**(-6) = værdi i mia. kr.
E_EVAir_E(j,kilder,udled_type).. EVAir_E(j,kilder,udled_type) =E= J_EVAir_E(j,kilder,udled_type) + Eudled(j,kilder,udled_type)*Enhedsp_E(j,kilder,udled_type) * 10**(-6); 

E_CO2taxrate_BG(j)..  CO2taxrate_BG(j)  =E= J_CO2taxrate_BG(j)  + GJvalueRatio_BG(j)  * sum(udled_type, Ekoeff(j,'biogas',  udled_type) * CO2eVaegt(udled_type) * CO2eTax * CO2eTax_dummyE(j,'biogas',  udled_type)) * 10**(-6);   
E_CO2taxrate_NG(j)..  CO2taxrate_NG(j)  =E= J_CO2taxrate_NG(j)  + GJvalueRatio_NG(j)  * sum(udled_type, Ekoeff(j,'natgas',  udled_type) * CO2eVaegt(udled_type) * CO2eTax * CO2eTax_dummyE(j,'natgas',  udled_type)) * 10**(-6);   
E_CO2taxrate_RG(j)..  CO2taxrate_RG(j)  =E= J_CO2taxrate_RG(j)  + GJvalueRatio_RG(j)  * sum(udled_type, Ekoeff(j,'rafgas',  udled_type) * CO2eVaegt(udled_type) * CO2eTax * CO2eTax_dummyE(j,'rafgas',  udled_type)) * 10**(-6);   
E_CO2taxrate_NoG(j).. CO2taxrate_NoG(j) =E= J_CO2taxrate_NoG(j) + GJvalueRatio_NoG(j) * sum(udled_type, Ekoeff(j,'nordgas', udled_type) * CO2eVaegt(udled_type) * CO2eTax * CO2eTax_dummyE(j,'nordgas', udled_type)) * 10**(-6);   
E_CO2taxrate_OP(j)..  CO2taxrate_OP(j)  =E= J_CO2taxrate_OP(j)  + GJvalueRatio_OP(j)  * sum(udled_type, Ekoeff(j,'olie',    udled_type) * CO2eVaegt(udled_type) * CO2eTax * CO2eTax_dummyE(j,'olie',    udled_type)) * 10**(-6);   
E_CO2taxrate_K(j)..   CO2taxrate_K(j)   =E= J_CO2taxrate_K(j)   + GJvalueRatio_K(j)   * sum(udled_type, Ekoeff(j,'kul',     udled_type) * CO2eVaegt(udled_type) * CO2eTax * CO2eTax_dummyE(j,'kul',     udled_type)) * 10**(-6);   
E_CO2taxrate_A(j)..   CO2taxrate_A(j)   =E= J_CO2taxrate_A(j)   + GJvalueRatio_A(j)   * sum(udled_type, Ekoeff(j,'affald',  udled_type) * CO2eVaegt(udled_type) * CO2eTax * CO2eTax_dummyE(j,'affald',  udled_type)) * 10**(-6);   
E_CO2taxrate_H(j)..   CO2taxrate_H(j)   =E= J_CO2taxrate_H(j)   + GJvalueRatio_H(j)   * sum(udled_type, Ekoeff(j,'halm',    udled_type) * CO2eVaegt(udled_type) * CO2eTax * CO2eTax_dummyE(j,'halm',    udled_type)) * 10**(-6);   
E_CO2taxrate_T(j)..   CO2taxrate_T(j)   =E= J_CO2taxrate_T(j)   + GJvalueRatio_T(j)   * sum(udled_type, Ekoeff(j,'Tpiller', udled_type) * CO2eVaegt(udled_type) * CO2eTax * CO2eTax_dummyE(j,'Tpiller', udled_type)) * 10**(-6);   
E_CO2taxrate_B(j)..   CO2taxrate_B(j)   =E= J_CO2taxrate_B(j)   + GJvalueRatio_B(j)   * sum(udled_type, Ekoeff(j,'Tbra',    udled_type) * CO2eVaegt(udled_type) * CO2eTax * CO2eTax_dummyE(j,'Tbra',    udled_type)) * 10**(-6);   

 
*EV-variable
E_NettoIndkomst..  Nettoindkomst =E= J_Nettoindkomst
                                                               + (sum(j, w*L(j)) + (N_LabForce-N_Emp)*rateComp*w + Trans) * (1-t_w)
                                                               + (r-grow)*Wealth/(1+grow) * (1-t_r)
                                                               + lumpsum*N_Pop;

E_Disnytte.. Disnytte =E= J_Disnytte
                                        + (Elas_hour/(Elas_hour + 1))*(1-t_w)*(w)*hour*N_Emp;
 
  
* Offentlige finanser
E_TRAfgifter.. TRAfgifter =E= J_TRAfgifter
                          + sum(j, sum(i, ((1+tVAT_xD(j,i))*(p(i)+sum(taxd,tDuty_xD(j,i,taxd)))-p(i))*xD(j,i) + ((1+tVAT_xF(j,i))*(pF(i)+sum(taxd,tDuty_xF(j,i,taxd)))*(1+tCus_x(j,i))-pF(i))*xF(j,i)))
                          + sum(i, ((1+tVAT_CD(i))*(p(i)+sum(taxd,tDuty_CD(i,taxd)))-p(i))*cD(i) + ((1+tVAT_CF(i))*(pF(i)+sum(taxd,tDuty_CF(i,taxd)))*(1+tCus_C(i))-pF(i))*cF(i))
                          + sum(i, ((1+tVAT_GD(i))*(p(i)+sum(taxd,tDuty_GD(i,taxd)))-p(i))*gD(i) + ((1+tVAT_GF(i))*(pF(i)+sum(taxd,tDuty_GF(i,taxd)))*(1+tCus_G(i))-pF(i))*gF(i))
                          + sum(i, ((1+tVAT_ILD(i))*(p(i)+sum(taxd,tDuty_ILD(i,taxd)))-p(i))*ILD(i) + ((1+tVAT_ILF(i))*(pF(i)+sum(taxd,tDuty_ILF(i,taxd)))*(1+tCus_IL(i))-pF(i))*ILF(i))
                          + sum(i, ((p(i)+sum(taxd,tDuty_ExD(i,taxd)))-p(i))*ExD(i) + ((pF(i)+sum(taxd,tDuty_ExF(i,taxd)))*(1+tCus_Ex(i))-pF(i))*ExF(i))   
                          + sum(j, sum(i, ((1+tVAT_IMD(j,i))*(p(i)+sum(taxd,tDuty_IMD(j,i,taxd)))-p(i))*IMID(j,i) + ((1+tVAT_IMF(j,i))*(pF(i)+sum(taxd,tDuty_IMF(j,i,taxd)))*(1+tCus_IM(j,i))-pF(i))*IMIF(j,i)))
                          + sum(j, sum(i, ((1+tVAT_IBD(j,i))*(p(i)+sum(taxd,tDuty_IBD(j,i,taxd)))-p(i))*IBID(j,i) + ((1+tVAT_IBF(j,i))*(pF(i)+sum(taxd,tDuty_IBF(j,i,taxd)))*(1+tCus_IB(j,i))-pF(i))*IBIF(j,i)))
* Fratrækker told da dette går til EU og ikke staten
                         -(sum(i,sum(j,tCus_x(j,i)*PF(i)*xF(j,i))) 
                         + sum(i,sum(j,tCus_IM(j,i)*PF(i)*IMIF(j,i)+ tCus_IB(j,i)*PF(i)*IBIF(j,i)))
                         + sum(i,tCus_c(i)*PF(i)*cF(i)) 
                         + sum(i,tCus_Ex(i)*PF(i)*ExF(i)) 
                         + sum(i,tCus_g(i)*PF(i)*gF(i)) 
                         + sum(i,tCus_IL(i)*PF(i)*ILF(i)));                          
                          
E_TRw.. TRw =E= J_TRw + t_w * (w*hour*N_Emp + (N_LabForce-N_Emp)*rateComp*w + Trans);

E_TRcap.. TRcap =E= J_TRcap+ t_r * (r-grow) * Wealth/(1+grow);

E_TRcor.. TRcor =E= J_TRcor + sum(j, t_cor(j)*(p(j)*Y(j) - PM(j)*M(j)- PE(j)*E(j) - sum(i,px_energi(j,i)*x_energi(j,i)) - (1+tFak_w(j))*w*L(j) - tFak_B(j)*ucB(j)*PInvB(j)*KB(j)/(1+grow) - tFak_M(j)*ucM(j)*PInvM(j)*KM(j)/(1+grow) 
                                       - sum((kilder,udled_type), TR_Eudled(j,kilder,udled_type)) - sum((kilder,udled_type), TR_Eudled_kalib(j,kilder,udled_type))
                                       - Fak_rest(j) - (r*(1+infl)+infl)*DP(j)/((1+infl)*(1+grow)) - (deltaKBBook(j)*KBBook(j)+deltaKMBook(j)*KMBook(j))/((1+grow)*(1+infl)) )); 

E_TRprod.. TRprod =E= J_TRprod + sum(j, tFak_w(j)*w*L(j) + tFak_B(j)*ucB(j)*PInvB(j)*KB(j)/(1+grow) + tFak_M(j)*ucM(j)*PInvM(j)*KM(j)/(1+grow) + Fak_rest(j));  

E_Overf.. Overf =E= J_Overf + (N_LabForce-N_Emp)*rateComp*w + trans;

E_Gval.. Gval =E= J_Gval + sum(j, PG(j)*g(j));

E_Lump.. Lump =E= J_Lump + lumpsum*N_Pop;

E_PSaldony..   PSaldo =e=  J_PSaldo + TRAfgifter + TRw + TRcap + TRcor + TRprod + sum((j,kilder,udled_type), TR_Eudled(j,kilder,udled_type)) + sum((j,kilder,udled_type), TR_Eudled_kalib(j,kilder,udled_type)) - Overf - Gval - Lump - CCSExp;   

*CCS
E_PCCS..               PCCS =E= J_PCCS + CCSstartP + CCSalfa*CCS;
* Den samlede omkostning i mia. kr. = mængden i 1.000 tons * gennemsnitsprisen i kr. per ton *1000 * 10**(-9)
E_CCSExp..            CCSExp =E= J_CCSExp + CCS * (CCSstartP+PCCS)/2 * 1000 * 10**(-9);

E_BoPny..                   BoP =e= J_BoP + sum(i,P_Ex(i)*Ex(i) - PF(i)*(sum(j, xF(j,i)) + ExF(i) + cF(i) + sum(j, IBIF(j,i) + IMIF(j,i)) + ILF(i) + gF(i))) - CCSExp
                                 + (r-grow)*(Wealth_F - sum(j,(1-share_D(j)) * V(j)) - sum(j,DP(j)) - DG)/(1+grow) - TaxEU   ;


*------------------------------------------------------------
*Data
*------------------------------------------------------------

$GDXIN data_16_E.gdx
$LOAD anvKbin, anvKbin_hh, anvBas, anvBas_hh, anvGJ, TilBas, TilGJ, TilBas_import, TilGJ_import, EKoeff, Enhedsp_E
$GDXIN

* El fra kraftværker er i udgangspunktet større end 0 for alle brancher.
d1kraftandel0(j) = 0;

* Manipulation skal slettes når data er bedre:
anvKbin('190000b','Olie') = anvKbin('190000b','Olie') /100;
anvKbin('190000b','RafGas') = anvKbin('190000b','RafGas')/100;
anvKbin('190000b','BogD') = anvKbin('190000b','BogD')/100;
anvGJ('190000b','Olie') = anvGJ('190000b','Olie') /100;
anvGJ('190000b','RafGas') = anvGJ('190000b','RafGas')/100;
anvGJ('190000b','BogD') = anvGJ('190000b','BogD')/100;

* test af implicitte energipriser *
parameter relaPris;
relaPris(j,kilder) $ anvGJ(j,kilder) = (anvKbin(j,kilder)/anvGJ(j,kilder)) / (sum(jj,anvKbin(jj,kilder))/sum(jj,anvGJ(jj,kilder)));
*display relaPris;
*$exit

CO2eVaegt('N2O') = 298;
CO2eVaegt('CH4') = 25;
CO2eVaegt('CO2') = 1000;
CO2eVaegt('SF6') = 1;
CO2eVaegt('PFC') = 1;
CO2eVaegt('HFC') = 1;

CO2eTax_dummyE(j,kilder,udled_type) = 0;
CO2eTax_dummyE_kalib(j,kilder,udled_type) = 0;
Kalibrering_dummyE(j,kilder,udled_type) = 0;

* - - Elasticiteter - - *

$ontext
                                 KE
              /                           \            \
           KE2                             E          FV_energi
     /   (EKEny)     \
 KEel                 KEfo
 /  \            /           \
El KMel	    fossil            KMfo
          /        \
      ISB             SB         ISB:ikke-solide brændsler  SB:solide brændsler
    /      \        /  \  \
   G        O      K   A   HT      G:gas O:olie K:kul og koks A:affald HT:Halm og træ
 // \\       \            / \ \
BNRNo_G      OP           H T B     BG:biogas NG:natur- og bygas RG:rafinaderigas NoG:Nordsøgas BO:bioolie OP:olieprodukter H:halm T:træpiller B:brænde og skovflis

$offtext

EKE.l(j) = 0.0001;

* Kalibrering fra MAC-kurver
EKEny.l('01000a') = 2.5;
EKEny.l('01000b') = 2.5;
EKEny.l('01000c') = 2.5;
EKEny.l('01000d') = 2.5;
EKEny.l('020000') = 2;
EKEny.l('030000') = 0.1;
EKEny.l('060000a') = 0.5;
EKEny.l('060000b') = 0.5;
EKEny.l('080090') = 20;
EKEny.l('100010a') = 6;
EKEny.l('100010b') = 6;
EKEny.l('100010c') = 6;
EKEny.l('100020') = 2;
EKEny.l('100030') = 8;
EKEny.l('100040') = 5;
EKEny.l('100050') = 2;
EKEny.l('11200') = 10;
EKEny.l('Industri') = 20;
EKEny.l('160000') = 5;
EKEny.l('190000a') = 3;
EKEny.l('190000b') = 3;
EKEny.l('200010') = 14;
EKEny.l('200020') = 10;
EKEny.l('210000') = 20;
EKEny.l('220000') = 15;
EKEny.l('230010') = 4;
EKEny.l('230020') = 0.9;
EKEny.l('240000') = 2;
EKEny.l('250000') = 8;
EKEny.l('280010') = 20;
EKEny.l('280020') = 20;
EKEny.l('350010a') = 3;
EKEny.l('350010b') = 3;
EKEny.l('350020a') = 3;
EKEny.l('350020b') = 3;
EKEny.l('350030a') = 3;
EKEny.l('350030b') = 3;
EKEny.l('36700') = 3;
EKEny.l('383900') = 0.01;
EKEny.l('410009') = 15;
EKEny.l('420000') = 15;
EKEny.l('43000') = 15;
EKEny.l('45000') = 15;
EKEny.l('460000') = 15;
EKEny.l('470000') = 15;
EKEny.l('490012') = 15;
EKEny.l('490030a') = 15;
EKEny.l('490030b') = 15;
EKEny.l('50000a') = 15;
EKEny.l('50000b') = 15;
EKEny.l('51000a') = 15;
EKEny.l('51000b') = 15;
EKEny.l('52000') = 15;
EKEny.l('53000') = 15;
EKEny.l('550000') = 15;
EKEny.l('560000') = 15;
EKEny.l('Tjenester') = 15;
EKEny.l('Boliger') = 15;
EKEny.l('Offentlig') = 15;
EKEny.l('79000') = 15;




EKEfo.l(j) = 0.001;
EKEel.l(j) = 0.001;


* Virksomhedernes substitution mellem ikke-solide og solide brændsler - baseret på EMEC 


*Indvinding, industri, tjenester og boliger
Efossil.fx(j) = 1.2; 

*Primære erhverv
Efossil.fx('01000a') = 0.7; 
Efossil.fx('01000b') = 0.7; 
Efossil.fx('01000c') = 0.7; 
Efossil.fx('01000d') = 0.7; 
Efossil.fx('020000') = 0.7; 
Efossil.fx('030000') = 0.7; 

*Raffinaderier og byggeri
Efossil.fx('190000a') = 0.8; 
Efossil.fx('190000b') = 0.8; 
Efossil.fx('410009') = 0.8; 
Efossil.fx('420000') = 0.8; 
Efossil.fx('43000') = 0.8; 

*El og fjernvarme
Efossil.fx('350010a') = 1.1; 
Efossil.fx('350010b') = 1.1; 
Efossil.fx('350030a') = 1.1; 
Efossil.fx('350030b') = 1.1; 
*Efossil.fx('383900') = 1.1; 
Efossil.fx('383900') = 0; 


*Gas og transport
Efossil.fx('350020a') = 0.2; 
Efossil.fx('350020b') = 0.2; 
Efossil.fx('490012') = 0.2; 
Efossil.fx('490030a') = 0.2; 
Efossil.fx('490030b') = 0.2; 
Efossil.fx('50000a') = 0.2; 
Efossil.fx('50000b') = 0.2; 
Efossil.fx('51000a') = 0.2; 
Efossil.fx('51000b') = 0.2; 

* Virksomhedernes substitution mellem gas og olie - baseret på EMEC 

*Indvinding, industri og tjenester
EISB_energi.l(j) = 1.3; 

*Primære erhverv
EISB_energi.l('01000a') = 0.8; 
EISB_energi.l('01000b') = 0.8; 
EISB_energi.l('01000c') = 0.8; 
EISB_energi.l('01000d') = 0.8; 
EISB_energi.l('020000') = 0.8; 
EISB_energi.l('030000') = 0.8; 

*Raffinaderier
EISB_energi.l('190000a') = 0.9; 
EISB_energi.l('190000b') = 0.9; 

*El, fjernvarme og boliger
EISB_energi.l('350010a') = 1.5; 
EISB_energi.l('350010b') = 1.5; 
EISB_energi.l('350030a') = 1.5; 
EISB_energi.l('350030b') = 1.5; 
EISB_energi.l('383900') = 1.5; 
EISB_energi.l('Boliger') = 1.5; 

*Gas og transport
EISB_energi.l('350020a') = 0.2; 
EISB_energi.l('350020b') = 0.2; 
EISB_energi.l('490012') = 0.2; 
EISB_energi.l('490030a') = 0.2; 
EISB_energi.l('490030b') = 0.2; 
EISB_energi.l('50000a') = 0.2; 
EISB_energi.l('50000b') = 0.2; 
EISB_energi.l('51000a') = 0.2; 
EISB_energi.l('51000b') = 0.2; 

*Byggeri
EISB_energi.l('410009') = 0.9; 
EISB_energi.l('420000') = 0.9; 
EISB_energi.l('43000') = 0.9; 

* Virksomhedernes substitution mellem affald og biomasse

ESB_energi.l(j) = EISB_energi.l(j);

* Virksomhedernes substitution mellem biogas og naturgas

EG_energi.l(j) = 2;

* Virksomhedernes substitution mellem halm, træpiller og skovflis

EHT_energi.l(j) = 2;



Eel.l = 0.5;
Eelfossil.l = 0.5;
EFV.l = 0.5;


*---- energigoder

BG_energi.l(j) $ d1x(j,'350020b') = anvKbin(j,'Biogas')*10**(-6);
BG_energi.l(j) $ (xe.l(j,'350020b') LT BG_energi.l(j))  = xe.l(j,'350020b');
energiGJ.l(j,'Biogas')  $ d1x(j,'350020b') = anvGJ(j,'BioGas')*10**(-9);
GJvalueRatio_BG(j) $ BG_energi.l(j)= energiGJ.l(j,'biogas')/BG_energi.l(j);

NG_energi.l(j) $ d1x(j,'350020a') = anvKbin(j,'NatGas')*10**(-6);
NG_energi.l(j) $ (xe.l(j,'350020a') LT NG_energi.l(j))  = xe.l(j,'350020a');
energiGJ.l(j,'natgas')  $ d1x(j,'350020a') = anvGJ(j,'NatGas')*10**(-9);
GJvalueRatio_NG(j) $ NG_energi.l(j)= energiGJ.l(j,'natgas')/NG_energi.l(j);

NoG_energi.l(j) $ d1x(j,'060000b') = anvGJ(j,'NordGas')*10**(-9);
NoG_energi.l(j) $ (xm.l(j,'060000b') LT NoG_energi.l(j))  = xm.l(j,'060000b');
energiGJ.l(j,'NordGas') $ d1x(j,'060000b') = anvGJ(j,'NordGas')*10**(-9);
GJvalueRatio_NoG(j) $ NoG_energi.l(j)= energiGJ.l(j,'Nordgas')/NoG_energi.l(j);

*BO_energi.l(j) $ d1x(j,'190000b') = anvKbin(j,'BioOlie')*10**(-6);
*BO_energi.l(j) $ (xe.l(j,'190000b') LT BO_energi.l(j))  = xe.l(j,'190000b');
*energiGJ.l(j,'BioGas') $ d1x(j,'190000b') = anvGJ(j,'BioGas')*10**(-9);
parameter scalar190000a(j), taeller, naevner;
scalar190000a(j) =xe.l(j,'190000a')/((anvKbin(j,'Olie')+anvKbin(j,'RafGas')+anvKbin(j,'BogD'))*10**(-6));
scalar190000a(j) $ (scalar190000a(j) GT 1) = 1;
*taeller(j) =xe.l(j,'190000a');
*naevner(j) = ((anvKbin(j,'Olie')+anvKbin(j,'RafGas')+anvKbin(j,'BogD'))*10**(-6));
*display scalar190000a, taeller, naevner;
*$exit
OP_energi.l(j) $ d1x(j,'190000a') = anvKbin(j,'Olie')*10**(-6)*scalar190000a(j);
OP_energi.l(j) $ (xe.l(j,'190000a') LT OP_energi.l(j))  = xe.l(j,'190000a')*0.99;
energiGJ.l(j,'olie') $ d1x(j,'190000a') = anvGJ(j,'Olie')*10**(-9);
GJvalueRatio_OP(j) $ OP_energi.l(j)= energiGJ.l(j,'olie')/OP_energi.l(j);

RG_energi.l(j) $ d1x(j,'190000a') = anvKbin(j,'RafGas')*10**(-6)*scalar190000a(j);
RG_energi.l(j) $ (xe.l(j,'190000a') LT (OP_energi.l(j)+RG_energi.l(j)))  = xe.l(j,'190000a')-OP_energi.l(j);
energiGJ.l(j,'RafGas')  $ d1x(j,'190000a') = anvGJ(j,'RafGas')*10**(-9);
GJvalueRatio_RG(j) $ RG_energi.l(j)= energiGJ.l(j,'rafgas')/RG_energi.l(j);

G_energi.l(j) = BG_energi.l(j)+NG_energi.l(j)+RG_energi.l(j)+NoG_energi.l(j);
*O_energi.l(j) = BO_energi.l(j)+OP_energi.l(j);
O_energi.l(j) = OP_energi.l(j);
ISB_energi.l(j) = G_energi.l(j)+O_energi.l(j); 

K_energi.l(j) $ d1x(j,'420000') = anvKbin(j,'Kul')*10**(-6);
K_energi.l(j) $ (xm.l(j,'420000') LT K_energi.l(j))  = xm.l(j,'420000');
energiGJ.l(j,'kul') $ d1x(j,'420000') = anvGJ(j,'Kul')*10**(-9);
GJvalueRatio_K(j) $ K_energi.l(j)= energiGJ.l(j,'kul')/K_energi.l(j);

A_energi.l(j) $ d1x(j,'industri') = anvGJ(j,'Affald')*10**(-9);
A_energi.l(j) $ (xm.l(j,'industri') LT A_energi.l(j))  = xm.l(j,'industri')*0.99;
energiGJ.l(j,'Affald') $ d1x(j,'industri') = anvGJ(j,'Affald')*10**(-9);
GJvalueRatio_A(j) $ A_energi.l(j)= energiGJ.l(j,'Affald')/A_energi.l(j);

H_energi.l(j) $ d1x(j,'01000a') = anvKbin(j,'Halm')*10**(-6);
H_energi.l(j) $ (xm.l(j,'01000a') LT H_energi.l(j))  = xm.l(j,'01000a');
energiGJ.l(j,'Halm') $ d1x(j,'01000a') = anvGJ(j,'Halm')*10**(-9);
GJvalueRatio_H(j) $ H_energi.l(j)= energiGJ.l(j,'Halm')/H_energi.l(j);

T_energi.l(j) $ d1x(j,'160000') = anvKbin(j,'Tpiller')*10**(-6);
T_energi.l(j) $ (xm.l(j,'160000') LT T_energi.l(j))  = xm.l(j,'160000');
energiGJ.l(j,'Tpiller') $ d1x(j,'160000') = anvGJ(j,'Tpiller')*10**(-9);
GJvalueRatio_T(j) $ T_energi.l(j)= energiGJ.l(j,'Tpiller')/T_energi.l(j);

B_energi.l(j) $ d1x(j,'020000') = anvKbin(j,'Tbra')*10**(-6);
B_energi.l(j) $ (xm.l(j,'020000') LT B_energi.l(j))  = xm.l(j,'020000');
energiGJ.l(j,'TBra') $ d1x(j,'020000') = anvGJ(j,'Tbra')*10**(-9);
GJvalueRatio_B(j) $ B_energi.l(j)= energiGJ.l(j,'Tbra')/B_energi.l(j);

HT_energi.l(j) = H_energi.l(j)+T_energi.l(j)+B_energi.l(j);
SB_energi.l(j) = K_energi.l(j)+A_energi.l(j)+HT_energi.l(j);
fossil.l(j) = ISB_energi.l(j)+SB_energi.l(j);

el_energi.l(j)     = anvKbin(j,'el')*10**(-6);
FV_energi.l(j)     = anvKbin(j,'FjVarm')*10**(-6);



$ontext
parameter elpriser, eltest;
elpriser('a') = TilBas('350010a','el')/TilGJ('350010a','el');
elpriser('b') = TilBas('350010b','el')/TilGJ('350010b','el');
elpriser('3839') = TilBas('383900','el')/TilGJ('383900','el');
elpriser('im') = TilBas_import('el')/TilGJ_import('el');
*display elpriser;


Eltot.l = (sum(j,anvKbin(j,'el'))+sum(hh_c,anvKbin_hh(hh_c,'el')))*10**(-6); 
Elkraft.l = (TilBas('350010a','el')+TilBas('350010a','el')/(TilBas('350010a','el')+TilBas('350010b','el'))*TilBas_import('el'))/(sum(j,TilBas(j,'el'))+TilBas_import('el'))*Eltot.l; 
Elvind.l  = (TilBas('350010b','el')+TilBas('350010b','el')/(TilBas('350010a','el')+TilBas('350010b','el'))*TilBas_import('el'))/(sum(j,TilBas(j,'el'))+TilBas_import('el'))*Eltot.l; 
Elaffald.l = TilBas('383900','el')/(sum(j,TilBas(j,'el'))+TilBas_import('el'))*Eltot.l; 
Eltest = Elkraft.l+elvind.l+elaffald.l-eltot.l;
Elfossil.l = elkraft.l + elaffald.l;
PEltot.l = 1; 
PElvind.l = 1; 
PElfossil.l = 1; 
PElkraft.l = 1;
PElaffald.l = 1;

m_elvind.l = elvind.l/eltot.l;
m_elkraft.l = elkraft.l/elfossil.l;
$offtext

*$offtext
*Udregning af IO_vaegte:
parameter tilEL, tilElM, tilFV, anvBasTot, anvkBinTot, IOtot, IOindu, Datasum;
*Tilgang fra el og FV alt
tilEL('kraft') = TilBas('350010a','el')*10**(-6);
tilEL('vind') = TilBas('350010b','el')*10**(-6);
tilEL('reno') = TilBas('383900','el')*10**(-6);
tilEL('import') = TilBas_import('el')*10**(-6);
tilEL('tot') = tilEL('kraft')+tilEL('vind')+tilEL('reno')+tilEL('import');  
tilELM('kraft') = TilBas('350010a','el')*10**(-6) + tilEL('import')*tilEL('kraft')/(tilEL('kraft')+tilEL('vind'));
tilELM('vind') = TilBas('350010b','el')*10**(-6) + tilEL('import')*tilEL('vind')/(tilEL('kraft')+tilEL('vind'));
tilELM('reno') = TilBas('383900','el')*10**(-6);
tilFV('kraft') = TilBas('350010a','FjVarm')*10**(-6);
tilFV('reno') = TilBas('383900','FjVarm')*10**(-6);
tilFV('FV') = TilBas('350030a','FjVarm')*10**(-6);
tilFV('FVVE') = TilBas('350030b','FjVarm')*10**(-6);

anvBasTot('el') = (sum(j,anvBas(j,'el'))+ sum(hh_c,anvBas_hh(hh_c,'el')))*10**(-6)+3.548;
anvkBinTot('el') = (sum(j,anvkBin(j,'el'))+ sum(hh_c,anvkBin_hh(hh_c,'el')))*10**(-6)+3.548-1.593;
anvBasTot('FV') = (sum(j,anvBas(j,'FjVarm'))+ sum(hh_c,anvBas_hh(hh_c,'FjVarm')))*10**(-6);
anvkBinTot('FV') = (sum(j,anvkBin(j,'FjVarm'))+ sum(hh_c,anvkBin_hh(hh_c,'FjVarm')))*10**(-6);
Datasum(j,'el') = anvkBin(j,'el')*10**(-6);
Datasum(j,'FV') = anvkBin(j,'FjVarm')*10**(-6);
Datasum(j,'IO') = x.l(j,'350010a')+x.l(j,'350010b')+x.l(j,'350030a')+x.l(j,'350030b')+x.l(j,'383900');
Datasum(j,'andre') = Datasum(j,'IO') - Datasum(j,'FV') - Datasum(j,'el');

IOtot('kraft') = sum(j, x.l(j,'350010a')) + CH.l('350010a');
IOtot('vind')  = sum(j, x.l(j,'350010b')) + CH.l('350010b');
IOtot('reno')  = sum(j, x.l(j,'383900') ) + CH.l('383900');
IOtot('fjern') = sum(j, x.l(j,'350030a') ) + CH.l('350030a');
IOtot('VEFV')  = sum(j, x.l(j,'350030b') ) + CH.l('350030b');

IOindu('kraft') = x.l('industri','350010a');
IOindu('vind')  = x.l('industri','350010b');
IOindu('reno')  = x.l('industri','383900') ;
IOindu('fjern') = x.l('industri','350030a');
IOindu('VEFV')  = x.l('industri','350030b');
display tilEL, tilELM, tilFV, anvBasTot, anvkBinTot, IOtot, IOindu, Datasum;
*$exit


parameter IO_vaegt(i,kilder), J_vaegt(j,kilder), vaegt(j,i,kilder), vaegtUPS(j,i), vaegttest, el_andeltest, FV_andeltest, vaegtVis;
IO_vaegt('350010a','el') = 0.51;
IO_vaegt('350010b','el') = 0.45;
IO_vaegt('383900','el')  = 0.04;
IO_vaegt('350010a','FjVarm') = 0.14;
IO_vaegt('383900','FjVarm')  = 0.13;
IO_vaegt('350030a','FjVarm') = 0.63;
IO_vaegt('350030b','FjVarm') = 0.11;
J_vaegt(j,'el')     = el_energi.l(j)    /sum(i,IO_vaegt(i,'el')    *X.l(j,i));
J_vaegt(j,'FjVarm') = FV_energi.l(j)    /sum(i,IO_vaegt(i,'FjVarm')*X.l(j,i));

vaegt(j,i,kilder) = IO_vaegt(i,kilder)*J_vaegt(j,kilder);
vaegtUPS(j,i) $ (sum(kilder, vaegt(j,i,kilder)) GT 1) = sum(kilder,vaegt(j,i,kilder))-1;
vaegtVis('190000b',i,kilder)= vaegt('190000b',i,kilder);
vaegttest(j,'el') = 0;
vaegttest(j,'FV') = 0;
vaegttest(j,'el') = sum(i,vaegt(j,i,'el')*X.l(j,i))-el_energi.l(j);
vaegttest(j,'FV') = sum(i,vaegt(j,i,'FjVarm')*X.l(j,i))-el_energi.l(j);
display vaegtUPS, vaegttest, vaegt, vaegtvis;

*$exit
*$ontext
*Nedskalering hvis "andre leverancer" er negative
el_energi.l(j) = el_energi.l(j) / (sum(i,vaegtUPS(j,i))+1);
FV_energi.l(j) = FV_energi.l(j) / (sum(i,vaegtUPS(j,i))+1);

J_vaegt(j,'el')     = el_energi.l(j)    /sum(i,IO_vaegt(i,'el')    *X.l(j,i));
J_vaegt(j,'FjVarm') = FV_energi.l(j)    /sum(i,IO_vaegt(i,'FjVarm')*X.l(j,i));
vaegt(j,i,kilder) = IO_vaegt(i,kilder)*J_vaegt(j,kilder);
*$offtext

*Korrektioner
*parameter vaegtpre;
*vaegtpre(j,i,kilder) = vaegt(j,i,kilder);
*vaegt(j,i,'el')     $ (vaegt(j,i,'el') GT vaegt(j,i,'FjVarm')) = vaegt(j,i,'el')     - vaegtUPS(j,i);
*vaegt(j,i,'FjVarm') $ (vaegt(j,i,'el') LE vaegt(j,i,'FjVarm')) = vaegt(j,i,'FjVarm') - vaegtUPS(j,i);
*vaegt(j,'383900',kilder) = vaegt(j,'383900',kilder) + sum(i,(vaegtpre(j,i,kilder)-vaegt(j,i,kilder))*X.l(j,i))/X.l(j,'383900'); 


vaegtUPS(j,i) = 0;
vaegtUPS(j,i) $ (sum(kilder, vaegt(j,i,kilder)) GT 1) = sum(kilder,vaegt(j,i,kilder))-1;
vaegtVis('industri',i,kilder)= vaegt('industri',i,kilder);
vaegttest(j,'el') = 0;
vaegttest(j,'FV') = 0;
vaegttest(j,'el') = sum(i,vaegt(j,i,'el')*X.l(j,i))-el_energi.l(j);
vaegttest(j,'FV') = sum(i,vaegt(j,i,'FjVarm')*X.l(j,i))-FV_energi.l(j);
display vaegtUPS, vaegttest, vaegtVis;
*$exit



*
el_kraftandel.l(j) = vaegt(j,'350010a','el')*X.l(j,'350010a')/sum(i,vaegt(j,i,'el')*X.l(j,i));
el_Vindandel.l(j)    = vaegt(j,'350010b','el')*X.l(j,'350010b')/sum(i,vaegt(j,i,'el')*X.l(j,i));
display el_kraftandel.l, el_Vindandel.l, x.l;
*$exit
el_Renoandel.l(j)  = vaegt(j,'383900','el') *X.l(j,'383900') /sum(i,vaegt(j,i,'el')*X.l(j,i));
el_andeltest(j) = el_kraftandel.l(j)+el_Vindandel.l(j)+el_Renoandel.l(j)-1;

FV_kraftandel.l(j) $ FV_energi.l(j)   = vaegt(j,'350010a','FjVarm')*X.l(j,'350010a')/sum(i,vaegt(j,i,'FjVarm')*X.l(j,i));
FV_Renoandel.l(j) $ FV_energi.l(j)    = vaegt(j,'383900','FjVarm') *X.l(j,'383900') /sum(i,vaegt(j,i,'FjVarm')*X.l(j,i));
FV_Fjernandel.l(j) $ FV_energi.l(j)   = vaegt(j,'350030a','FjVarm')*X.l(j,'350030a')/sum(i,vaegt(j,i,'FjVarm')*X.l(j,i));
FV_FjernVEandel.l(j) $ FV_energi.l(j) = vaegt(j,'350030b','FjVarm')*X.l(j,'350030b')/sum(i,vaegt(j,i,'FjVarm')*X.l(j,i));
FV_andeltest(j) $ FV_energi.l(j) = FV_kraftandel.l(j)+FV_Fjernandel.l(j)+FV_FjernVEandel.l(j)+FV_Renoandel.l(j)-1;

FV_FjernandelKonstant(j) $ (FV_energi.l(j) gt 0) = FV_Fjernandel.l(j)/(1 - FV_kraftandel.l(j) - FV_Renoandel.l(j));

display el_kraftandel.l, FV_kraftandel.l;
*$exit
El.l(j) = el_energi.l(j);
El0(j) = El.l(j);

*EL_energi.l(j) = anvEnergiV(j,'el');
display px.l, pxe.l, e.l;
*$exit


*Eltot.l = sum(j,el_energi.l(j))+sum(hh_c,anvKbin_hh(hh_c,'el'))*10**(-6); 
Eltot.l = sum(j,el_energi.l(j)); 
*Elkraft.l = (TilBas('350010a','el')+TilBas('350010a','el')/(TilBas('350010a','el')+TilBas('350010b','el'))*TilBas_import('el'))/(sum(j,TilBas(j,'el'))+TilBas_import('el'))*Eltot.l; 
*Elvind.l  = (TilBas('350010b','el')+TilBas('350010b','el')/(TilBas('350010a','el')+TilBas('350010b','el'))*TilBas_import('el'))/(sum(j,TilBas(j,'el'))+TilBas_import('el'))*Eltot.l; 
*Elaffald.l = TilBas('383900','el')/(sum(j,TilBas(j,'el'))+TilBas_import('el'))*Eltot.l; 
Elkraft.l = sum(j, el_energi.l(j)*el_kraftandel.l(j)); 
Elvind.l  = sum(j, el_energi.l(j)*el_Vindandel.l(j)); 
Elaffald.l = sum(j, el_energi.l(j)*el_renoandel.l(j)); 

Eltest = Elkraft.l+elvind.l+elaffald.l-eltot.l;
Elfossil.l = elkraft.l + elaffald.l;
PEltot.l = 1; 
PElvind.l = 1; 
PElfossil.l = 1; 
PElkraft.l = 1;
PElaffald.l = 1;

m_elvind.l = elvind.l/eltot.l;
m_elkraft.l = elkraft.l/elfossil.l;

*prekraftandelX(j) = log(el_kraftandel.l(j))/log(elkraft.l/eltot.l);
preRenoandelX(j) = log(el_renoandel.l(j))/log(elaffald.l/eltot.l);
preVindandelX(j)  = log(el_vindandel.l(j)) /log(elvind.l /eltot.l);
*el_kraftandelX.l = elkraft.l/eltot.l;
el_RenoandelX.l = elaffald.l/eltot.l;
el_vindandelX.l  = elvind.l /eltot.l;
*para_elkraftEQ = elkraft.l / sum(j, el_energi.l(j)*el_kraftandel.l(j));
*para_elvindEQ  = elvind.l  / sum(j, el_energi.l(j)*el_vindandel.l(j));

konstantKraft(j) = FV_Kraftandel.l(j)*FV_energi.l(j)/el_Kraftandel.l(j)/el_energi.l(j);
*konstantKraft(j) $ (el_kraftandel.l(j)*FV_kraftandel.l(j) gt 0) = log(FV_kraftandel.l(j))/log(el_kraftandel.l(j));
konstantReno(j)  = FV_Renoandel.l(j)*FV_energi.l(j) /el_Renoandel.l(j) /el_energi.l(j);
*konstantReno(j) $ (el_renoandel.l(j)*FV_renoandel.l(j) gt 0) = log(FV_renoandel.l(j))/log(el_renoandel.l(j));


FVx.l = sum(j, (1-FV_kraftandel.l(j)-FV_Renoandel.l(j))*FV_energi.l(j));
FVfossil.l = sum(j, (1-FV_kraftandel.l(j)-FV_Renoandel.l(j)-FV_fjernVEandel.l(j))*FV_energi.l(j));
FVVE.l = FVx.l-FVfossil.l;
PFVx.l = 1;
PFVfossil.l = 1;
PFVVE.l = 1;

m_FVfossil.l = FVfossil.l/FVx.l;

*FV_fjernandelX.l = FVfossil.l/sum(j,FV_energi.l(j));
*prefjernandelX(j) $ FV_fjernandel.l(j) = log(FV_fjernandel.l(j))/log(FV_fjernandelX.l);
*para_FVfossilEQ = FVfossil.l/sum(j, FV_energi.l(j)*FV_fjernandel.l(j));

xe.l(j,'350020b')       $ d1x(j,'350020b') = xe.l(j,'350020b') - BG_energi.l(j);
x_energi.l(j,'350020b') $ d1x(j,'350020b') =                     BG_energi.l(j);
xe.l(j,'350020a')       $ d1x(j,'350020a') = xe.l(j,'350020a') - NG_energi.l(j);
x_energi.l(j,'350020a') $ d1x(j,'350020a') =                     NG_energi.l(j);
*xe.l(j,'190000b')       $ d1x(j,'190000b') = xe.l(j,'190000b') - BO_energi.l(j);
*x_energi.l(j,'190000b') $ d1x(j,'190000b') =                     BO_energi.l(j);
xe.l(j,'190000a')       $ d1x(j,'190000a') = xe.l(j,'190000a') - OP_energi.l(j) - RG_energi.l(j);
x_energi.l(j,'190000a') $ d1x(j,'190000a') =                     OP_energi.l(j) + RG_energi.l(j);

xm.l(j,'420000')       $ d1x(j,'420000') = xm.l(j,'420000') - K_energi.l(j);
x_energi.l(j,'420000') $ d1x(j,'420000') =                     K_energi.l(j);
xm.l(j,'060000b')       $ d1x(j,'060000b') = xm.l(j,'060000b') - NoG_energi.l(j);
x_energi.l(j,'060000b') $ d1x(j,'060000b') =                     NoG_energi.l(j);
xm.l(j,'industri')      $ d1x(j,'industri')= xm.l(j,'industri') - A_energi.l(j);
x_energi.l(j,'industri')$ d1x(j,'industri')=                      A_energi.l(j);
xm.l(j,'01000a')        $ d1x(j,'01000a')  = xm.l(j,'01000a') - H_energi.l(j);
x_energi.l(j,'01000a')  $ d1x(j,'01000a')  =                    H_energi.l(j);
xm.l(j,'160000')        $ d1x(j,'160000')  = xm.l(j,'160000') - T_energi.l(j);
x_energi.l(j,'160000')  $ d1x(j,'160000')  =                    T_energi.l(j);
xm.l(j,'020000')        $ d1x(j,'020000')  = xm.l(j,'020000') - B_energi.l(j);
x_energi.l(j,'020000')  $ d1x(j,'020000')  =                    B_energi.l(j);

xe.l(j,'350010a')       $ d1x(j,'350010a') = xe.l(j,'350010a') - El_energi.l(j)*el_kraftandel.l(j) - FV_energi.l(j)*FV_kraftandel.l(j);
x_energi.l(j,'350010a') $ d1x(j,'350010a') =                     El_energi.l(j)*el_kraftandel.l(j) + FV_energi.l(j)*FV_kraftandel.l(j);
xe.l(j,'350010b')       $ d1x(j,'350010b') = xe.l(j,'350010b') - El_energi.l(j)*el_Vindandel.l(j);
x_energi.l(j,'350010b') $ d1x(j,'350010b') =                     El_energi.l(j)*el_Vindandel.l(j);
xe.l(j,'383900')        $ d1x(j,'383900')  = xe.l(j,'383900')  - El_energi.l(j)*el_Renoandel.l(j) - FV_energi.l(j)*FV_Renoandel.l(j);
x_energi.l(j,'383900')  $ d1x(j,'383900')  =                     El_energi.l(j)*el_Renoandel.l(j) + FV_energi.l(j)*FV_Renoandel.l(j);
xe.l(j,'350030a')       $ d1x(j,'350030a') = xe.l(j,'350030a') - FV_energi.l(j)*FV_Fjernandel.l(j);
x_energi.l(j,'350030a') $ d1x(j,'350030a') =                     FV_energi.l(j)*FV_Fjernandel.l(j);
xe.l(j,'350030b')       $ d1x(j,'350030b') = xe.l(j,'350030b') - FV_energi.l(j)*FV_FjernVEandel.l(j);
x_energi.l(j,'350030b') $ d1x(j,'350030b') =                     FV_energi.l(j)*FV_FjernVEandel.l(j);


parameter xe_nega, xm_nega;
xe_nega(j,dme) $ (xe.l(j,dme) lt 0) = xe.l(j,dme);
xm_nega(j,dm) $ (xm.l(j,dm) lt 0) = xm.l(j,dm);
display xe_nega, xm_nega;


xe.l(j,dmeo) = sum(dme $ mapdme2dmeo(dmeo,dme), xe.l(j,dme));
xe.l(j,dmeo) = sum(dme $ mapdme2dmeo(dmeo,dme), xe.l(j,dme));
E.l(j)       = xe.l(j,'me');

*display xm.l;
xm.l(j,dmo) = sum(dm $ mapdm2dmo(dmo,dm), xm.l(j,dm));
xm.l(j,dmo) = sum(dm $ mapdm2dmo(dmo,dm), xm.l(j,dm));
Mpre(j) = M.l(j);
M.l(j)      = xm.l(j,'m');
*display xm.l, Mpre, M.l;

H.l(j)   = H.l(j)  +Mpre(j)-M.l(j);
LKE.l(j) = LKE.l(j)+Mpre(j)-M.l(j);
KE.l(j)  = KE.l(j) +Mpre(j)-M.l(j);

display e.l;
*px.l, pxe.l, e.l;
*$exit

m_xe.l(j,dme) $sum(dmeo $ mapdme2dmeo(dmeo,dme), xe.l(j,dmeo))  = xe.l(j,dme) /sum(dmeo $ mapdme2dmeo(dmeo,dme), xe.l(j,dmeo));
m_xm.l(j,dm)  $sum(dmo  $ mapdm2dmo(dmo,dm),     xm.l(j,dmo))   = xm.l(j,dm)  /sum(dmo $ mapdm2dmo(dmo,dm),      xm.l(j,dmo));



* Andelsparametre for materialekøb vs. aggregat af kapital og arbejdskraft
m_YM.l(j)$Y.l(j) = PO.l(j)**(-EY.l(j))*M.l(j) / Y.l(j); 
m_YH.l(j)$Y.l(j) = PO.l(j)**(-EY.l(j))*H.l(j) / Y.l(j); 

* Andelsparametre for bygninger vs. aggregat af maskinkapital og arbejdskraft
m_HB.l(j)$H.l(j)  = ((1+tFak_B.l(j))*ucB.l(j))**EH.l(j)*(KB.l(j)/(1+grow.l)) / H.l(j); 
m_HLKE.l(j)$H.l(j) = LKE.l(j) / H.l(j); 

* Andelsparametre for arbejdskraft vs. kapital
* NB: Andelsparametrene summerer ikke, da usercost ikke er normeret til 1 - det er ok
m_LKEL.l(j)$LKE.l(j) = (1+tFak_w.l(j))**(ELKE.l(j))*L.l(j) / LKE.l(j); 
m_LKEKE.l(j)$LKE.l(j) = KE.l(j) / LKE.l(j); 
m_KEE.l(j)$KE.l(j) = E.l(j) / KE.l(j); 
*m_KEK.l(j)$KE.l(j) = (1+tFak_M.l(j))*ucM.l(j)**EKE.l(j)*(KM.l(j)/(1+grow.l)) / KE.l(j); 

d1energiGJ(j,kilder) = 1 $ ((energiGJ.l(j,kilder) gt 0) OR (energiGJ.l(j,kilder) gt 0));

d1BG_e(j)   = 1 $ ((BG_energi.l(j) gt 0) OR (BG_energi.l(j) gt 0));
d1NG_e(j)   = 1 $ ((NG_energi.l(j) gt 0) OR (NG_energi.l(j) gt 0));
d1RG_e(j)   = 1 $ ((RG_energi.l(j) gt 0) OR (RG_energi.l(j) gt 0));
d1NoG_e(j)  = 1 $ ((NoG_energi.l(j) gt 0) OR (NoG_energi.l(j) gt 0));
d1G_e(j)    = 1 $ ((G_energi.l(j) gt 0) OR (G_energi.l(j) gt 0));
*d1BO_e(j)   = 1 $ ((BO_energi.l(j) gt 0) OR (BO_energi.l(j) gt 0));
d1OP_e(j)   = 1 $ ((OP_energi.l(j) gt 0) OR (OP_energi.l(j) gt 0));
d1O_e(j)    = 1 $ ((O_energi.l(j) gt 0) OR (O_energi.l(j) gt 0));
d1ISB_e(j)  = 1 $ ((ISB_energi.l(j) gt 0) OR (ISB_energi.l(j) gt 0));
d1K_e(j)    = 1 $ ((K_energi.l(j) gt 0) OR (K_energi.l(j) gt 0));
d1A_e(j)    = 1 $ ((A_energi.l(j) gt 0) OR (A_energi.l(j) gt 0));
d1H_e(j)    = 1 $ ((H_energi.l(j) gt 0) OR (H_energi.l(j) gt 0));
d1T_e(j)    = 1 $ ((T_energi.l(j) gt 0) OR (T_energi.l(j) gt 0));
d1B_e(j)    = 1 $ ((B_energi.l(j) gt 0) OR (B_energi.l(j) gt 0));
d1HT_e(j)   = 1 $ ((HT_energi.l(j) gt 0) OR (HT_energi.l(j) gt 0));
d1SB_e(j)   = 1 $ ((SB_energi.l(j) gt 0) OR (SB_energi.l(j) gt 0));
d1fossil(j) = 1 $ ((fossil.l(j) gt 0) OR (fossil.l(j) gt 0));

d1el_e(j)   = 1 $ ((El_energi.l(j) gt 0) OR (El_energi.l(j) gt 0));
d1FV_e(j)   = 1 $ ((FV_energi.l(j) gt 0) OR (FV_energi.l(j) gt 0));

m_BG_energi.l(j)  $ d1BG_e(j) = BG_energi.l(j)/G_energi.l(j);
m_BG_energi_tot.l = 0;
*m_NG_energi.l(j)  $ d1NG_e(j) = NG_energi.l(j)/G_energi.l(j);
m_RG_energi.l(j)  $ d1RG_e(j) = RG_energi.l(j)/G_energi.l(j);
m_NoG_energi.l(j)  $ d1NoG_e(j) = NoG_energi.l(j)/G_energi.l(j);
m_G_energi.l(j)   $ d1G_e(j) = G_energi.l(j)/ISB_energi.l(j);
*m_BO_energi.l(j)  $ d1BO_e(j) = BO_energi.l(j)/O_energi.l(j);
m_OP_energi.l(j)  $ d1OP_e(j) = OP_energi.l(j)/O_energi.l(j);
m_O_energi.l(j)   $ d1O_e(j) = O_energi.l(j)/ISB_energi.l(j);
m_ISB_energi.l(j) $ d1ISB_e(j) = ISB_energi.l(j)/fossil.l(j);
m_K_energi.l(j)   $ d1K_e(j) = K_energi.l(j)/SB_energi.l(j);
m_A_energi.l(j)   $ d1A_e(j) = A_energi.l(j)/SB_energi.l(j);
m_H_energi.l(j)   $ d1H_e(j) = H_energi.l(j)/HT_energi.l(j);
m_T_energi.l(j)   $ d1T_e(j) = T_energi.l(j)/HT_energi.l(j);
*m_B_energi.l(j)   $ d1B_e(j) = B_energi.l(j)/HT_energi.l(j);
m_HT_energi.l(j)  $ d1HT_e(j) = HT_energi.l(j)/SB_energi.l(j);
*m_SB_energi.l(j)  $ d1SB_e(j) = SB_energi.l(j)/fossil.l(j);

PBG_energi.l(j) = 1;
PNG_energi.l(j) = 1;
PRG_energi.l(j) = 1;
PNoG_energi.l(j) = 1;
PG_energi.l(j) = 1;
*PBO_energi.l(j) = 1;
POP_energi.l(j) = 1;
PO_energi.l(j) = 1;
PISB_energi.l(j) = 1;
PK_energi.l(j) = 1;
PA_energi.l(j) = 1;
PH_energi.l(j) = 1;
PT_energi.l(j) = 1;
PB_energi.l(j) = 1;
PHT_energi.l(j) = 1;
PSB_energi.l(j) = 1;
Pfossil.l(j) = 1;



* - - Bestemmelse af nederste niveau ud fra data og antagelser - - *
d1KM(j) $ (KM.l(j) gt 0) = 1;

Pel.l(j) = 1;
px_energi.l(j,i) = 1;
PFV_energi.l(j) = 1;

*Bestemmelser af KMel og KMfor udfra samlet KMforbrug - Prisen på KMel og KMfo er lig prisen på KM via samme user cost.
KMel.l(j) $ d1KE(j) = el_energi.l(j) / (el_energi.l(j)+fossil.l(j)) * KM.l(j);
KMfo.l(j) $ d1KE(j) = KM.l(j) - KMel.l(j);

* - - Bestemmelse af niveauet over ud fra ligninger og antagelser om P=1 - - *
PKE2.l(j)  = 1;
PKEel.l(j) = 1;
PKEfo.l(j) = 1;

KEel.l(j) $ d1KE(j) = PEl.l(j)*El.l(j)/PKEel.l(j)         + (1+tFak_M.l(j))*ucM.l(j)*PInvM.l(j)*KMel.l(j)/(1+grow.l)/PKEel.l(j);
KEfo.l(j) $ d1KE(j) = Pfossil.l(j)*fossil.l(j)/PKEfo.l(j) + (1+tFak_M.l(j))*ucM.l(j)*PInvM.l(j)*KMfo.l(j)/(1+grow.l)/PKEfo.l(j);

KE2.l(j) $ d1KE(j) = PKE.l(j)*KE.l(j)/PKE2.l(j) - PE.l(j)*E.l(j)/PKE2.l(j) - PFV_energi.l(j)*FV_energi.l(j);

* - - Kalirering af my'er - - *

m_KE2.l(j)  $ d1KE(j) = KE2.l(j) / KE.l(j);
m_KEel.l(j) $ d1KE(j) = KEel.l(j)/KE2.l(j);

m_KEel_landbrugmv.l = 0;
m_KEel_forarb.l = 0;
m_KEel_service.l = 0;

m_El.l(j) $ d1el_e(j) = El.l(j)/KEel.l(j) / (PEl.l(j)/PKEel.l(j))**(-EKEel.l(j));
m_KMel.l(j) $ d1KE(j) = KMel.l(j)/(1+grow.l)/KEel.l(j) / ((1+tFak_M.l(j))*ucM.l(j)*PInvM.l(j)/PKEel.l(j))**(-EKEel.l(j));

m_fossil.l(j) $ d1fossil(j) = fossil.l(j)/KEfo.l(j) / (Pfossil.l(j)/PKEfo.l(j))**(-EKEfo.l(j));
m_KMfo.l(j) $ d1fossil(j)  = KMfo.l(j)/(1+grow.l)/KEfo.l(j) / ((1+tFak_M.l(j))*ucM.l(j)*PInvM.l(j)/PKEfo.l(j))**(-EKEfo.l(j));

m_FV_energi.l(j) $ d1FV_e(j) = FV_energi.l(j)/KE.l(j);

* - - Øvrige startværdier - - *

thetaKMel.l(j) = 1;
thetaKMfo.l(j) = 1;

CO2eTax.l = 0;
CO2eTax_kalib.l = 0;
Kalibrering.l = 0;

Nettoindkomst.l =                                                (sum(j, w.l*L.l(j)) + (N_LabForce.l-N_Emp.l)*rateComp.l*w.l + Trans.l) * (1-t_w.l)
                                                               + (r.l-grow.l)*Wealth.l/(1+grow.l) * (1-t_r.l)
                                                               + lumpsum.l*N_Pop.l;

Disnytte.l =                                        + (Elas_hour.l/(Elas_hour.l + 1))*(1-t_w.l)*(w.l)*hour.l*N_Emp.l;

*Offentlige finanser
TRAfgifter.l =
                          + sum(j, sum(i, ((1+tVAT_xD.l(j,i))*(p.l(i)+sum(taxd,tDuty_xD.l(j,i,taxd)))-p.l(i))*xD.l(j,i) + ((1+tVAT_xF.l(j,i))*(pF.l(i)+sum(taxd,tDuty_xF.l(j,i,taxd)))*(1+tCus_x.l(j,i))-pF.l(i))*xF.l(j,i)))
                          + sum(i, ((1+tVAT_CD.l(i))*(p.l(i)+sum(taxd,tDuty_CD.l(i,taxd)))-p.l(i))*cD.l(i) + ((1+tVAT_CF.l(i))*(pF.l(i)+sum(taxd,tDuty_CF.l(i,taxd)))*(1+tCus_C.l(i))-pF.l(i))*cF.l(i))
                          + sum(i, ((1+tVAT_GD.l(i))*(p.l(i)+sum(taxd,tDuty_GD.l(i,taxd)))-p.l(i))*gD.l(i) + ((1+tVAT_GF.l(i))*(pF.l(i)+sum(taxd,tDuty_GF.l(i,taxd)))*(1+tCus_G.l(i))-pF.l(i))*gF.l(i))
                          + sum(i, ((1+tVAT_ILD.l(i))*(p.l(i)+sum(taxd,tDuty_ILD.l(i,taxd)))-p.l(i))*ILD.l(i) + ((1+tVAT_ILF.l(i))*(pF.l(i)+sum(taxd,tDuty_ILF.l(i,taxd)))*(1+tCus_IL.l(i))-pF.l(i))*ILF.l(i))
                          + sum(i, ((p.l(i)+sum(taxd,tDuty_ExD.l(i,taxd)))-p.l(i))*ExD.l(i) + ((pF.l(i)+sum(taxd,tDuty_ExF.l(i,taxd)))*(1+tCus_Ex.l(i))-pF.l(i))*ExF.l(i))   
                          + sum(j, sum(i, ((1+tVAT_IMD.l(j,i))*(p.l(i)+sum(taxd,tDuty_IMD.l(j,i,taxd)))-p.l(i))*IMID.l(j,i) + ((1+tVAT_IMF.l(j,i))*(pF.l(i)+sum(taxd,tDuty_IMF.l(j,i,taxd)))*(1+tCus_IM.l(j,i))-pF.l(i))*IMIF.l(j,i)))
                          + sum(j, sum(i, ((1+tVAT_IBD.l(j,i))*(p.l(i)+sum(taxd,tDuty_IBD.l(j,i,taxd)))-p.l(i))*IBID.l(j,i) + ((1+tVAT_IBF.l(j,i))*(pF.l(i)+sum(taxd,tDuty_IBF.l(j,i,taxd)))*(1+tCus_IB.l(j,i))-pF.l(i))*IBIF.l(j,i)))
* Fratrækker told da dette går til EU og ikke staten
                         -(sum(i,sum(j,tCus_x.l(j,i)*PF.l(i)*xF.l(j,i))) 
                         + sum(i,sum(j,tCus_IM.l(j,i)*PF.l(i)*IMIF.l(j,i)+ tCus_IB.l(j,i)*PF.l(i)*IBIF.l(j,i)))
                         + sum(i,tCus_c.l(i)*PF.l(i)*cF.l(i)) 
                         + sum(i,tCus_Ex.l(i)*PF.l(i)*ExF.l(i)) 
                         + sum(i,tCus_g.l(i)*PF.l(i)*gF.l(i)) 
                         + sum(i,tCus_IL.l(i)*PF.l(i)*ILF.l(i)));                          
                          
TRw.l = t_w.l * (w.l*hour.l*N_Emp.l + (N_LabForce.l-N_Emp.l)*rateComp.l*w.l + Trans.l);

TRcap.l = t_r.l * (r.l-grow.l) * Wealth.l/(1+grow.l);

TRcor.l = sum(j, t_cor.l(j)*(p.l(j)*Y.l(j) - PM.l(j)*M.l(j)- PE.l(j)*E.l(j) - sum(i,x_energi.l(j,i)) - (1+tFak_w.l(j))*w.l*L.l(j) - tFak_B.l(j)*ucB.l(j)*PInvB.l(j)*KB.l(j)/(1+grow.l) - tFak_M.l(j)*ucM.l(j)*PInvM.l(j)*KM.l(j)/(1+grow.l) 
                                       - Fak_rest.l(j) - (r.l*(1+infl.l)+infl.l)*DP.l(j)/((1+infl.l)*(1+grow.l)) - (deltaKBBook.l(j)*KBBook.l(j)+deltaKMBook.l(j)*KMBook.l(j))/((1+grow.l)*(1+infl.l)) )); 

TRprod.l = sum(j, tFak_w.l(j)*w.l*L.l(j) + tFak_B.l(j)*ucB.l(j)*PInvB.l(j)*KB.l(j)/(1+grow.l) + tFak_M.l(j)*ucM.l(j)*PInvM.l(j)*KM.l(j)/(1+grow.l) + Fak_rest.l(j));  

Overf.l = (N_LabForce.l-N_Emp.l)*rateComp.l*w.l + trans.l;

Gval.l = sum(j, PG.l(j)*g.l(j));

Lump.l = lumpsum.l*N_Pop.l;

*CCS
CCSstartP = 5000;
CCSalfa = 1;  
CCS.l = 0;
PCCS.l = CCSstartP;
CCSExp.l = 0;


c_BG_GJ(j)  $ d1BG_e(j) = energiGJ.l(j,'Biogas') /BG_energi.l(j);
c_NG_GJ(j)  $ d1NG_e(j) = energiGJ.l(j,'natgas') /NG_energi.l(j);
c_RG_GJ(j)  $ d1RG_e(j) = energiGJ.l(j,'RafGas') /RG_energi.l(j);
c_NoG_GJ(j) $ d1NoG_e(j) = energiGJ.l(j,'NordGas')/NoG_energi.l(j);
c_OP_GJ(j)  $ d1OP_e(j) = energiGJ.l(j,'olie')   /OP_energi.l(j);
*c_BO_GJ(j)  $ d1BO_e(j) = energiGJ.l(j,'Bioolie')/BO_energi.l(j);
c_K_GJ(j)   $ d1K_e(j)  = energiGJ.l(j,'kul')    /K_energi.l(j);
c_A_GJ(j)   $ d1A_e(j)  = energiGJ.l(j,'affald') /A_energi.l(j);
c_H_GJ(j)   $ d1H_e(j)  = energiGJ.l(j,'halm')   /H_energi.l(j);
c_T_GJ(j)   $ d1T_e(j)  = energiGJ.l(j,'Tpiller')/T_energi.l(j);
c_B_GJ(j)   $ d1B_e(j)  = energiGJ.l(j,'TBra')   /B_energi.l(j);

Eudled.l(j,kilder,udled_type) = energiGJ.l(j,kilder) * Ekoeff(j,kilder,udled_type) * 10**(3);

EVAir_E.l(j,kilder,udled_type) = Eudled.l(j,kilder,udled_type) * Enhedsp_E(j,kilder,udled_type) * 10**(-6);

*------------------------------------------------------------
* Modeller
*------------------------------------------------------------
model static_energi
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
E_PO
E_P
E_L
E_KB
*E_KM
E_KMny
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
*E_x_energi3
E_x_energi4
E_x_energi5
E_x_energi6
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
*E_pBO_e
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
*E_BO_energi  
*E_BO_energiGJ  
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

E_el_energi

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

save;

solve static_energi using cns;

* gamX-kommando (udskriver %-vis afvigelse i.f.t. sidste 'save' fo alle variable i gruppen ENDO)
disp J_LED_NEW;
dispdif |J_LED| > 0.0001;
dispdif |J_LED_NEW| > 0.0001;

*execute_unload "j_led.gdx"
*J_co2e
*;

*execute_unload "gekko\gdx_work\model_energi_pre.gdx";
*$exit
*------------------------------------------------------------
* Kørsel
*------------------------------------------------------------
fix ALL;
unfix ENDO;
unfix ENDO_NEW;
x_energi.fx(j,i) = x_energi.l(j,i);
x_energi.lo(j,i_e) = -inf;
x_energi.up(j,i_e) =  inf;

* Nuller.gms fixer variable med leverancer som er nul, da de er fjernet i ligningerne
include Nuller.gms
include Nuller2.gms
x_energi.fx(j,'industri')$ (d1A_e(j) eq 0) = 0;
x_energi.fx(j,'190000a') $ (d1OP_e(j) eq 0) = 0;


save;


*eltot.fx = eltot.l;


solve static_energi using cns;


execute_unload "gekko\gdx_work\model_energi.gdx";


disp J_LED_NEW;
dispdif |J_LED| > 0.0001;
dispdif |J_LED_NEW| > 0.0001;
display BoP.l, el_andeltest, vaegttest, FV_andeltest, Eltest;

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
$ontext
$offtext


*t_cor.fx(j) = t_cor.l(j) + 0.01;

$ontext

set loopstep /1*50/;

loop(loopstep,

CO2eTax.fx = 20 + CO2eTax.l;

solve static_energi using cns;

);
$ontext
$offtext

*CO2eTax_dummyE_kalib('230020',kilder,udled_type) = 1;
*CO2eTax_kalib.fx = 100;

*solve static_energi using cns;

*display BoP.l;