* * * * Kalibrering af pris på BCCS * * * * * *


PKBpartX.l('a',j) $ J_CCS(j) = PKBpart.l('a',j)*(9.85+0.0/0.5);
PKBpartX.l('b',j) $ J_CCS(j) = PKBpart.l('b',j)*(9.85+0.05/0.5);
PKBpartX.l('c',j) $ J_CCS(j) = PKBpart.l('c',j)*(9.85+0.1/0.5);
PKBpartX.l('d',j) $ J_CCS(j) = PKBpart.l('d',j)*(9.85+0.15/0.5);
PKBpartX.l('e',j) $ J_CCS(j) = PKBpart.l('e',j)*(9.85+0.2/0.5);
PKBpartX.l('f',j) $ J_CCS(j) = PKBpart.l('f',j)*(9.85+0.25/0.5);
PKBpartX.l('g',j) $ J_CCS(j) = PKBpart.l('g',j)*(9.85+0.3/0.5);
PKBpartX.l('h',j) $ J_CCS(j) = PKBpart.l('h',j)*(9.85+0.35/0.5);
PKBpartX.l('i',j) $ J_CCS(j) = PKBpart.l('i',j)*(9.85+0.4/0.5);
PKBpartX.l('j',j) $ J_CCS(j) = PKBpart.l('j',j)*(9.85+0.45/0.5);

scalar_PKBx(part,j) $ j_CCS(j) = PKBpartX.l(part,j)/PKBpart.l(part,j);

Parameter KBtotbase, PKBpartpre, NegaUdledperKBbase, NegaUdledperKBpre, NegaUdledperKBpost, PKBtotxCO2ebase, PKBtotxCO2epre, PKBtotxCO2epost, MAC_CCS, AAC_CCS, NegaUdledAkku, MAC_CCS_serie, AAC_CCS_serie, NegaUdledAkku_serie, d1KBpartX_serie;

NegaUdledAkku(j_CCS) = 0;
KBtotbase(j_CCS) = Kbtot.l(j_CCS);
PKBpartpre(part,j_CCS) = PKBpart.l(part,j_CCS);
PKBtotxCO2ebase(j_CCS) = sum(part, PKBpartpre(part,j_CCS) * KBpart.l(part,j_CCS))/KBtot.l(j_CCS) + sum(part, scalar_PKBx(part,j_CCS) * PKBpartpre(part,j_CCS) * KBpartX.l(part,j_CCS))/KBtot.l(j_CCS);
NegaUdledperKBbase(j_CCS) = NegaUdled.l(j_CCS)/Kbtot.l(j_CCS);

s_CCS.fx = 895;

set loopstep /1*10/;

loop(loopstep,

s_CCS.fx = s_CCS.l + 5;

*Angivelse af, om backstop-teknologier skal anvendes
d1KBpartX(part,j_land) $ (PKBpart.l(part,j_land) gt PKBpartX.l(part,j_land)) = 1;

Display PKBpartX.l;
PKBpartX.fx(part,j_CCS)   $ (PKBpartX.l(part,j_CCS) lt 0.01) = PKBpartX.l(part,j_CCS);
J_PKBpartX.lo(part,j_CCS) $ (PKBpartX.l(part,j_CCS) lt 0.01) = -inf;
J_PKBpartX.up(part,j_CCS) $ (PKBpartX.l(part,j_CCS) lt 0.01) =  inf;

KBpartX.fx(part,j_land) $ (d1KBpartX(part,j_land) eq 0) = 0;
KBpart.fx(part,j_land)  $ (d1KBpartX(part,j_land) eq 1) = 0;
KBpartX.lo(part,j_land) $ (d1KBpartX(part,j_land) eq 1) = -inf;
KBpartX.up(part,j_land) $ (d1KBpartX(part,j_land) eq 1) =  inf;

* * * * *

NegaUdledperKBpre(j_CCS) = NegaUdled.l(j_CCS)/Kbtot.l(j_CCS);
PKBtotxCO2epre(j_CCS) = sum(part, PKBpartpre(part,j_CCS) * KBpart.l(part,j_CCS))/KBtot.l(j_CCS) + sum(part, scalar_PKBx(part,j_CCS) * PKBpartpre(part,j_CCS) * KBpartX.l(part,j_CCS))/KBtot.l(j_CCS);

* * * * *

solve static_fremskriv using cns;

* * * * *

NegaUdledperKBpost(j_CCS) = NegaUdled.l(j_CCS)/Kbtot.l(j_CCS);
PKBtotxCO2epost(j_CCS) = sum(part, PKBpartpre(part,j_CCS) * KBpart.l(part,j_CCS))/KBtot.l(j_CCS) + sum(part, scalar_PKBx(part,j_CCS) * PKBpartpre(part,j_CCS) * KBpartX.l(part,j_CCS))/KBtot.l(j_CCS);

*Udregning af MAC (pris opgjort i mia. kr. og udledninger opgjort i 1.000 tons CO2 ganges med 10**6 for at få MAC i kr. per ton)
MAC_CCS(j_CCS) $ (NegaUdledperKBpost(j_CCS) ne NegaUdledperKBpre(j_CCS)) = (PKBtotxCO2epost(j_CCS) - PKBtotxCO2epre(j_CCS)) / (NegaUdledperKBpost(j_CCS) - NegaUdledperKBpre(j_CCS)) * 10**6;
AAC_CCS(j_CCS) $ (NegaUdledperKBpost(j_CCS) ne NegaUdledperKBpre(j_CCS)) = (PKBtotxCO2epost(j_CCS) - PKBtotxCO2ebase(j_CCS)) / (NegaUdledperKBpost(j_CCS) - NegaUdledperKBbase(j_CCS)) * 10**6;

NegaUdledAkku(j_CCS) = NegaUdledAkku(j_CCS) + (NegaUdledperKBpost(j_CCS) - NegaUdledperKBpre(j_CCS)) * KBtotbase(j_CCS);
MAC_CCS_serie(loopstep,j_CCS) = MAC_CCS(j_CCS);
AAC_CCS_serie(loopstep,j_CCS) = AAC_CCS(j_CCS);
NegaUdledAkku_serie(loopstep,j_CCS) = NegaUdledAkku(j_CCS);
d1KBpartX_serie(loopstep,part,j_CCS) = d1KBpartX(part,j_CCS);

);

execute_unload "MAC_CCS.gdx"
MAC_CCS_serie
AAC_CCS_serie
NegaUdledAkku_serie
d1KBpartX_serie
;