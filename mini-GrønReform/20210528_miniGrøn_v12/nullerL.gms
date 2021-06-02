

KBtot.fx(j)        $ (NOT j_land(j)) = 0;
KBpart.fx(part,j)  $ (NOT j_land(j)) = 0;
PKBtot.fx(j)       $ (NOT j_land(j)) = 1;
PKBpart.fx(part,j) $ (NOT j_land(j)) = 1;
KBpartX.fx(part,j) $ (NOT j_land(j)) = 0;

NegaUdled.fx(part,j) $ (NOT j_CCS(j)) = 0;

BECCSshare.fx(j) $ (NOT j_CCS(j)) = 0;

KBpart.fx(part,j)  $ (d1KBpartX(part,j) EQ 1) = 0;
KBpartX.fx(part,j)  $ (d1KBpartX(part,j) EQ 0) = 0;

Ieudled.fx(j,udled_type)     $ (d1IeudledType1(j,udled_type)+d1IeudledType2(j,udled_type)+d1IeudledType3(j,udled_type) EQ 0) = 0;
TR_Ieudled.fx(j,udled_type)  $ (d1IeudledType1(j,udled_type)+d1IeudledType2(j,udled_type)+d1IeudledType3(j,udled_type) EQ 0) = 0;
*TR_Ieudled_kalib.fx(j,udled_type)  $ (d1IeudledType1(j,udled_type)+d1IeudledType2(j,udled_type)+d1IeudledType3(j,udled_type) EQ 0) = 0;
TR_Ieudled_kalib.fx(j,udled_type) = 0;

PKBpartX.lo(part,j_CCS) = -inf;
PKBpartX.up(part,j_CCS) =  inf;