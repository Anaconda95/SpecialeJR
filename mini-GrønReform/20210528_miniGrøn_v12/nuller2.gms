KM.fx(j) $ (d1KM(j) EQ 0) = 0;

fossil.fx(j)  $ (d1fossil(j) eq 0) = 0;
Pfossil.fx(j) $ (d1fossil(j) eq 0) = 1;
el.fx(j)  $ (d1el_e(j) eq 0) = 0;

*x_energi.fx(j,i) = x_energi.l(j,i);
*x_energi.lo(j,i_e) = -inf;
*x_energi.up(j,i_e) =  inf;

x_energi.fx(j,i_e) $ (d1x(j,i_e) eq 0) = 0;

x_energi.fx(j,'350020b') $ (d1BG_e(j) eq 0) = 0;
x_energi.fx(j,'350020a') $ (d1NG_e(j) eq 0) = 0;
*x_energi.fx(j,'190000b') $ (d1BO_e(j) eq 0) = 0;
*x_energi.fx(j,'190000a') $ (d1OP_e(j) eq 0) = 0;
x_energi.fx(j,'420000') $ (d1K_e(j) eq 0) = 0;
x_energi.fx(j,'060000b') $ (d1NoG_e(j) eq 0) = 0;
*x_energi.fx(j,'industri')$ (d1A_e(j) eq 0) = 0;
x_energi.fx(j,'01000a')  $ (d1H_e(j) eq 0) = 0;
x_energi.fx(j,'160000')  $ (d1T_e(j) eq 0) = 0;
x_energi.fx(j,'020000')  $ (d1B_e(j) eq 0) = 0;
x_energi.fx(j,'350030b') $ (d1X(j,'350030b') eq 0) = 0;
x_energi.fx(j,'350030a') $ (d1X(j,'350030a') eq 0) = 0;

FV_energi.fx(j)  $ (d1FV_e(j) eq 0) = 0;
ISB_energi.fx(j) $ (d1ISB_e(j) eq 0) = 0;
SB_energi.fx(j)  $ (d1SB_e(j) eq 0) = 0;
G_energi.fx(j)   $ (d1G_e(j) eq 0) = 0;
O_energi.fx(j)   $ (d1O_e(j) eq 0) = 0;
BG_energi.fx(j)  $ (d1BG_e(j) eq 0) = 0;
energiGJ.fx(j,'biogas')  $ (d1BG_e(j) eq 0) = 0;
NG_energi.fx(j)  $ (d1NG_e(j) eq 0) = 0;
energiGJ.fx(j,'natgas')  $ (d1NG_e(j) eq 0) = 0;
RG_energi.fx(j)  $ (d1RG_e(j) eq 0) = 0;
energiGJ.fx(j,'Rafgas')  $ (d1RG_e(j) eq 0) = 0;
NoG_energi.fx(j)  $ (d1NoG_e(j) eq 0) = 0;
energiGJ.fx(j,'nordgas')  $ (d1NoG_e(j) eq 0) = 0;
*BO_energi.fx(j)  $ (d1BO_e(j) eq 0) = 0;
*energiGJ.fx(j,'bioolie')  $ (d1BO_e(j) eq 0) = 0;
OP_energi.fx(j)  $ (d1OP_e(j) eq 0) = 0;
energiGJ.fx(j,'olie')  $ (d1OP_e(j) eq 0) = 0;
K_energi.fx(j)   $ (d1K_e(j) eq 0) = 0;
energiGJ.fx(j,'kul')   $ (d1K_e(j) eq 0) = 0;
A_energi.fx(j)   $ (d1A_e(j) eq 0) = 0;
energiGJ.fx(j,'affald')   $ (d1A_e(j) eq 0) = 0;
HT_energi.fx(j)  $ (d1HT_e(j) eq 0) = 0;
H_energi.fx(j)   $ (d1H_e(j) eq 0) = 0;
energiGJ.fx(j,'halm')   $ (d1H_e(j) eq 0) = 0;
T_energi.fx(j)   $ (d1T_e(j) eq 0) = 0;
energiGJ.fx(j,'Tpiller')   $ (d1T_e(j) eq 0) = 0;
B_energi.fx(j)   $ (d1B_e(j) eq 0) = 0;
energiGJ.fx(j,'Tbra')   $ (d1B_e(j) eq 0) = 0;


PFV_energi.fx(j)  $ (d1FV_e(j) eq 0) = 0;
PISB_energi.fx(j) $ (d1ISB_e(j) eq 0) = 1;
PG_energi.fx(j)   $ (d1G_e(j) eq 0) = 1;
PO_energi.fx(j)   $ (d1O_e(j) eq 0) = 1;
PSB_energi.fx(j)  $ (d1SB_e(j) eq 0) = 1;
PHT_energi.fx(j)  $ (d1HT_e(j) eq 0) = 1;

PBG_energi.fx(j)  $ (d1BG_e(j) eq 0) = 0;
PNG_energi.fx(j)  $ (d1NG_e(j) eq 0) = 0;
PRG_energi.fx(j)  $ (d1RG_e(j) eq 0) = 0;
PNoG_energi.fx(j)  $ (d1NoG_e(j) eq 0) = 0;
*PBO_energi.fx(j)  $ (d1BO_e(j) eq 0) = 0;
POP_energi.fx(j)  $ (d1OP_e(j) eq 0) = 0;
PK_energi.fx(j)   $ (d1K_e(j) eq 0) = 0;
PA_energi.fx(j)   $ (d1A_e(j) eq 0) = 0;
PH_energi.fx(j)   $ (d1H_e(j) eq 0) = 0;
PT_energi.fx(j)   $ (d1T_e(j) eq 0) = 0;
PB_energi.fx(j)   $ (d1B_e(j) eq 0) = 0;

FV_kraftandel.fx(j) $ (d1FV_e(j) eq 0) = 0;
FV_Renoandel.fx(j) $ (d1FV_e(j) eq 0) = 0;
FV_Fjernandel.fx(j) $ (d1FV_e(j) eq 0) = 0;
FV_FjernVEandel.fx(j) $ (d1FV_e(j) eq 0) = 0;

Eudled.fx(j,kilder,udled_type) $ (d1energiGJ(j,kilder) eq 0) = 0;
TR_Eudled.fx(j,kilder,udled_type) $ (d1energiGJ(j,kilder) eq 0) = 0;
TR_Eudled_kalib.fx(j,kilder,udled_type) $ (d1energiGJ(j,kilder) eq 0) = 0;

fossil.fx(j) $ (d1fossil(j) eq 0) = 0;
KMfo.fx(j) $ (d1fossil(j) eq 0) = 0;  
PKEfo.fx(j) $ (d1fossil(j) eq 0) = 1; 