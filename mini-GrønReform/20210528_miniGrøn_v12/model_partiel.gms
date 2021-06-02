
*$goto Y_modellen

*------------------------------------------------------------
* Delmodel til udregning af partiel MAC-kurve for KE-aggregattet 
*------------------------------------------------------------

MODEL ke_partiel /

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


E_KEel
E_KEfo

E_PKE2

E_El
E_KMel
E_PKEel
E_fossil
E_KMfo
E_PKEfo

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

E_Eudled
E_TR_Eudled
E_CO2Energi

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
/;

GROUP KE_ENDO

PBG_energi   
PNG_energi  
PRG_energi  
PNoG_energi  
POP_energi   
PK_energi    
PA_energi    
PH_energi    
PT_energi    
PB_energi

KEel
KEfo
PKE2

El
KMel
PKEel

fossil
KMfo
PKEfo

ISB_energi 
SB_energi  
Pfossil    
G_energi   
O_energi   
PISB_energi

BG_energi
NG_energi 
RG_energi 
NoG_energi 
PG_energi  
OP_energi  
PO_energi  
K_energi   
A_energi   
HT_energi  
PSB_energi 
H_energi   
T_energi   
B_energi   
PHT_energi

energiGJ

Eudled
TR_Eudled
CO2Energi

CO2taxrate_BG 
CO2taxrate_NG 
CO2taxrate_RG 
CO2taxrate_NoG 
CO2taxrate_OP 
CO2taxrate_K 
CO2taxrate_A 
CO2taxrate_H 
CO2taxrate_T 
CO2taxrate_B 
;

fix ALL;
unfix KE_ENDO;

include Nuller.gms
include Nuller2.gms

energiGJ.fx(j,'BogD') = energiGJ.l(j,'BogD');
energiGJ.fx(j,'BioOlie') = energiGJ.l(j,'BioOlie');

solve ke_partiel using cns;


*------------------------------------------------------------
* Delmodel til udregning af partiel MAC-kurve for transport-aggregattet 
*------------------------------------------------------------

MODEL T_partiel /
E_TTF    
E_TTE
E_TEl
E_Tkel
E_Tkf
E_Tf
E_pT
E_PTTE
E_PTTF
E_TFX
*E_TX
E_TX2
E_PTFX  
E_PTF

E_TFXB
E_TB
E_PTFXB

E_BD_energiGJ
E_TB_energiGJ

E_Eudled
E_TR_Eudled
E_CO2BogD
/;

GROUP T_ENDO
TTE(j)
TTF(j)
TEL(j)
TKel(j)
TFX(j)
TKf(j)
TF(j)
*TX(j)
TX2(j)
PT(j)
PTTE(j)
PTTF(j)
PTFX(j)
PTF(j)
TFXB(j)
TB(j)
PTFXB(j)

Eudled
TR_Eudled
CO2BogD
;

fix ALL;
unfix T_ENDO;
$ontext
J_energiGJ.lo(j,kilder) = -inf;
J_energiGJ.up(j,kilder) =  inf;
J_energiGJ.fx(j,'BogD')    = 0;
J_energiGJ.fx(j,'BioOlie') = 0;
$offtext
energiGJ.lo(j,'BogD') = -inf;
energiGJ.up(j,'BogD') =  inf;
energiGJ.lo(j,'BioOlie') = -inf;
energiGJ.up(j,'BioOlie') =  inf;

$ontext
J_Eudled.lo(j,kilder,udled_type) = -inf;
J_Eudled.up(j,kilder,udled_type) =  inf;
J_Eudled.fx(j,'BogD',udled_type) =  0;
J_Eudled.fx(j,'BioOlie',udled_type) =  0;
Eudled.lo(j,'BogD',udled_type) = -inf;
Eudled.up(j,'BogD',udled_type) =  inf;
Eudled.lo(j,'BioOlie',udled_type) = -inf;
Eudled.up(j,'BioOlie',udled_type) =  inf;

J_TR_Eudled.lo(j,kilder,udled_type) = -inf;
J_TR_Eudled.up(j,kilder,udled_type) =  inf;
J_TR_Eudled.fx(j,'BogD',udled_type) =  0;
J_TR_Eudled.fx(j,'BioOlie',udled_type) =  0;
TR_Eudled.lo(j,'BogD',udled_type) = -inf;
TR_Eudled.up(j,'BogD',udled_type) =  inf;
TR_Eudled.lo(j,'BioOlie',udled_type) = -inf;
TR_Eudled.up(j,'BioOlie',udled_type) =  inf;
$offtext

*d1energiGJ(j,kilder)

include Nuller.gms
include Nuller2.gms
include NullerT.gms


solve T_partiel using cns;

$ontext
CO2eTax.fx = CO2eTax.l + 16;


solve T_partiel using cns;


CO2eTax.fx = CO2eTax.l + 16;


solve T_partiel using cns;


CO2eTax.fx = CO2eTax.l + 16;


solve T_partiel using cns;

CO2eTax.fx = CO2eTax.l + 16;


solve T_partiel using cns;

CO2eTax.fx = CO2eTax.l + 16;


solve T_partiel using cns;

execute_unload "gekko\gdx_work\test.gdx";

CO2eTax.fx = CO2eTax.l + 16;


solve T_partiel using cns;

CO2eTax.fx = CO2eTax.l + 16;


solve T_partiel using cns;

execute_unload "gekko\gdx_work\test.gdx";

CO2eTax.fx = CO2eTax.l + 16;


solve T_partiel using cns;

$exit
$offtext
*------------------------------------------------------------
* Delmodel til udregning af partiel MAC-kurve for KB-aggregatet
*------------------------------------------------------------

MODEL KB_partiel /

*E_KBtot
E_KBpart
E_KBpartX
E_PKBtot
E_PKBpart1
E_PKBpart2
E_PKBpartX

E_CCSprKBx
E_NegaUdled
E_Ieudled1
E_Ieudled2
E_CO2Ie
E_CO2eMLF
/;

GROUP KB_ENDO

*KBtot(j)
KBpart(part,j)
KBpartX(part,j)
PKBtot(j)
PKBpart(part,j)

CCSprKBx(j)
NegaUdled(j)
Ieudled(j,udled_type)
CO2Ie
CO2eMLF
;

fix ALL;
unfix KB_ENDO;

include Nuller.gms
include Nuller2.gms
include NullerT.gms
include NullerL.gms


solve KB_partiel using cns;

*------------------------------------------------------------
* Delmodel til udregning af partiel MAC-kurve for hele produktionen på sektorniveau
*------------------------------------------------------------
$Label Y_modellen

MODEL Y_partiel /

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


E_KEel
E_KEfo

E_PKE2

E_El
E_KMel
E_PKEel
E_fossil
E_KMfo
E_PKEfo

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

E_Eudled
E_TR_Eudled

E_TTF    
E_TTE
E_TEl
E_Tkel
E_Tkf
E_Tf
E_pT
E_PTTE
E_PTTF
E_TFX
*E_TX
E_TX2
E_PTFX  
E_PTF

E_TFXB
E_TB
E_PTFXB

E_BD_energiGJ
E_TB_energiGJ

*E_KBtot
E_KBpart
E_KBpartX
E_PKBtot
E_PKBpart1
E_PKBpart2
E_PKBpartX

E_CCSprKBx
E_NegaUdled
E_Ieudled1
E_Ieudled2


E_M
E_H
E_T
E_LKE
*E_KB
E_KBny1
E_KBny2
E_KBtot
E_KE
E_E
E_L
E_KE2
E_FV_energi

E_POny
E_PHny1
E_PHny2
E_PLKE

E_PKEny

E_CO2Energi
E_CO2BogD  
E_CO2Ie    
E_CO2eMLF  
E_CO2e 

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

/;
$ontext

**
$offtext


GROUP Y_ENDO

PBG_energi   
PNG_energi  
PRG_energi  
PNoG_energi  
POP_energi   
PK_energi    
PA_energi    
PH_energi    
PT_energi    
PB_energi

KEel
KEfo
PKE2

El
KMel
PKEel

fossil
KMfo
PKEfo

ISB_energi 
SB_energi  
Pfossil    
G_energi   
O_energi   
PISB_energi

BG_energi
NG_energi 
RG_energi 
NoG_energi 
PG_energi  
OP_energi  
PO_energi  
K_energi   
A_energi   
HT_energi  
PSB_energi 
H_energi   
T_energi   
B_energi   
PHT_energi

energiGJ

Eudled
TR_Eudled

TTE(j)
TTF(j)
TEL(j)
TKel(j)
TFX(j)
TKf(j)
TF(j)
TX(j)
TX2(j)
PT(j)
PTTE(j)
PTTF(j)
PTFX(j)
PTF(j)
TFXB(j)
TB(j)
PTFXB(j)

*KBtot(j)
KBpart(part,j)
KBpartX(part,j)
KBtot
PKBtot(j)
PKBpart(part,j)

CCSprKBx(j)
NegaUdled(j)
Ieudled(j,udled_type)

M(j)
H(j)
T(j)
LKE(j)
KE(j)
E(j)
L(j)
KB(j)

KE2
FV_energi

PO(j)
PH(j)
PLKE(j)
PKE

CO2Energi
CO2BogD  
CO2Ie    
CO2eMLF  
CO2e 

CO2taxrate_BG 
CO2taxrate_NG 
CO2taxrate_RG 
CO2taxrate_NoG 
CO2taxrate_OP 
CO2taxrate_K 
CO2taxrate_A 
CO2taxrate_H 
CO2taxrate_T 
CO2taxrate_B 
;


$ontext

**

$offtext


fix ALL;
unfix Y_ENDO;

include Nuller.gms
include Nuller2.gms
include NullerT.gms
include NullerL.gms


solve Y_partiel using cns;

