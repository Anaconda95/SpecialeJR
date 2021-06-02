
sets 
part /part1*part100/
j_land(j)                     /01000a,01000b,01000c,01000d, 230020, 350010a, 383900/
j_anim(j)                     /       01000b,01000c,01000d                         /
j_CCS(j)                      /                             230020, 350010a, 383900/
j_landxCCS(j)                 /01000a,01000b,01000c,01000d                         /

alias(part,part_a)
;

sets
part1_50(part)  /part1*part50/
part51_100(part)  /part51*part100/
part51_99(part)  /part51*part99/
part1_15(part)  /part1*part15/
part1_30(part)  /part1*part30/
part1_35(part)  /part1*part35/
part1_40(part)  /part1*part40/
part1_70(part)  /part1*part70/
part86_100(part)  /part86*part100/

;


Equations
E_KBtot(j)
*E_KBtot1(j)
*E_KBtot2(j)
E_KBpart(part,j)
E_KBpartX(part,j)
E_PKBtot(j)
E_PKBpart1(part,j)
E_PKBpart2(part,j)

E_KBny1(j)
E_KBny2(j)
E_CO2eny(CO2e_udled,CO2e_type)

E_PHny1(j)
E_PHny2(j)

E_CO2eTaxRev_j1(j)
E_CO2eTaxRev_j2(j)

E_Ieudled1(j,udled_type)
E_Ieudled2(j,udled_type)
E_Ieudled3(j,udled_type)
E_Nudled
E_TR_Ieudled(j,udled_type)
*E_TR_Ieudled_kalib(j,udled_type)
E_EVAir_IE(j,udled_type)
E_EVNudled

E_PKBpartX(part,j)
E_CCSprKBx(j)
E_NegaUdled(part,j)
E_BECCSshare(j)

E_DIVnyny(j)

*E_DIVnyny1(j)
*E_DIVnyny2(j)
E_TRcorny
E_PSaldonyny
E_POnyny(j)

E_CO2Energi(j)
E_CO2BogD(j)  
E_CO2Ie(j)    
E_CO2eMLF(j)  
E_CO2e(j)

;

GROUP ENDO_NEW3
KBtot(j)
KBpart(part,j)
KBpartX(part,j)
PKBtot(j)
PKBpart(part,j)

Ieudled(j,udled_type) 'Udledninger relateret til andet end energiforbrug - CO2 opgjort i 1.000 tons - alle andre opgjort i tons - SF6, PFC og HFC opgjort i tons CO2-ækvivalenter'
Nudled
TR_Ieudled(j,udled_type)
TR_Ieudled_kalib(j,udled_type)
EVAir_IE(j,udled_type)
EVNudled

NegaUdled(part,j)   'CCS på energiforbrug - kan både være CCS på biomasse (BECCS) og CCS på fossil energi'
CCSprKBx(j)         'CCS per KBx på energiforbrug - kan både være CCS på biomasse (BECCS) og CCS på fossil energi, men ikke CCS på ikke-energirelaterede CO2-udledninger'
BECCSshare(j) 'Andelen af NegaUdled der kommer via BECCS'

CO2Energi(j)
CO2BogD(j)  
CO2Ie(j)    
CO2eMLF(j)  
CO2e(j)
;

GROUP EKSO_NEW3
EKB(j)

m_KBtot(j)
m_KBpart(j)
PKBpartX(part,j)

thetaB_anim

s_CCS(part,j)

NudledperKBpre
;

GROUP J_LED_NEW3
J_KBtot(j)
J_KBpart(part,j)
J_PKBtot(j)
J_PKBpart(part,j)
J_Ieudled(j,udled_type)
J_Nudled
J_TR_Ieudled(j,udled_type)
*J_TR_Ieudled_kalib(j,udled_type)
J_EVAir_IE(j,udled_type)
J_EVNudled

J_NegaUdled(part,j)
J_PKBpartX(part,j)
J_CCSprKBx(j)
J_BECCSshare(j)

J_CO2Energi(j)
J_CO2BogD(j)  
J_CO2Ie(j)    
J_CO2eMLF(j)  
J_CO2e(j)

;

Parameter
CO2eAndel(part,j)
NH3Andel(part,j)
NAndel(part)
CO2eAndelDiv(j)
NH3AndelDiv(j)
NAndelDiv
IeudledperKBpre(j,udled_type)   'ikke-energi-relaterede udledninger per KB før reduktionstiltag'
d1KBpartX(part,j)
CCStek(part)
scalar_PKBx(part,j)
CO2koeff(kilder)
CCSandel(j,kilder)

scalar_Ieudled(j,udled_type)
d1IeudledType1(j,udled_type)
d1IeudledType2(j,udled_type)
d1IeudledType3(j,udled_type)
d1NegaUdled(j)
Emiss_IkkeE(j,udled_type)
Enhedsp_IkkeE(j,udled_type)
Enhedsp_N
CO2eTax_dummyIE(j,udled_type)
CO2eTax_dummyIE_kalib(j,udled_type)

Nudled0

;

*------------------------------------------------------------
*Modelligninger
*------------------------------------------------------------

$ontext
Forståelse af vækstkorrektion og udvidelse af KB: 
- Det er KB/(1+grow), der indgår i produktionsfunktionen for H på lige fod med LKE-aggregatet.
- (1+tFak_B)*ucB*PInvB er prisen på KB/(1+grow). 
- KBtot erstatter KB. 
- PKBtot er prisen på KBtot/(1+grow)
- summen af KBpart giver KBtot
- PKBpart er prisen på KBpart/(1+grow)
- Dermed har man PKBtot*KBtot/(1+grow) = sum(PKBpart*KBpart/(1+grow)) => PKBtot*KBtot = sum(PKBpart*KBpart)
- PKBpart er lig (1+tFak_B)*ucB*PInvB + tax
- Under tax skal det bemærkes, at PKBpart er prisen per KB/(1+grow), hvormed CO2eperKBpre skal divideres med (1+grow) for at man får CO2e per KB/(1+grow)
$offtext

E_KBtot(j)   $ j_land(j)..      tfp(j)*thetaB(j)*KBtot(j)/(1+grow) =e= J_KBtot(j) + m_KBtot(j) * (PKBtot(j)/(tfp(j)*thetaB(j)*PH(j)))**(-EH(j))*H(j);

E_KBpart(part,j)   $ (j_land(j) and d1KBpartX(part,j) EQ 0).. KBpart(part,j)  =E= J_KBpart(part,j) + m_KBpart(j) * (PKBpart(part,j) /PKBtot(j))**(-EKB(j))*KBtot(j);
E_KBpartX(part,j)  $ (j_land(j) and d1KBpartX(part,j) EQ 1).. KBpartX(part,j) =E= J_KBpart(part,j) + m_KBpart(j) * (PKBpartX(part,j)/PKBtot(j))**(-EKB(j))*KBtot(j);

E_PKBtot(j)        $ j_land(j)..                  PKBtot(j)*KBtot(j) =E= J_PKBtot(j) + sum(part, PKBpart(part,j)*KBpart(part,j)) + sum(part, PKBpartX(part,j)*KBpartX(part,j));

*E_PKBpart1(part,j)  $ j_land(j)..                     PKBpart(part,j) =E= J_PKBpart(part,j) + (1+tFak_B(j))*ucB(j)*PInvB(j) + sum(udled_type,TR_Ieudled(j,udled_type) + TR_Ieudled_kalib(j,udled_type))/sum(part_a,KBpart(part_a,j)) * CO2eAndel(part,j);
* Forklaring:                                                                                                                                 -             Udledningen af CO2e per KBpart                     -  gange  -          beskatningen af CO2e             -
E_PKBpart1(part,j)  $ j_land(j)..                     PKBpart(part,j) =E= J_PKBpart(part,j) + (1+tFak_B(j))*ucB(j)*PInvB(j) + sum(udled_type, IeudledperKBpre(j,udled_type)*CO2eAndel(part,j)*CO2eVaegt(udled_type) * CO2eTax_dummyIE(j,udled_type)) * CO2eTax * 10**(-9);



*E_KBny1(j)         $ j_land(j)..     KB(j) =e= J_KB(j) + sum(part, KBpart(part,j)+PKBpartX(part,j)/((1+tFak_B(j))*ucB(j)*PInvB(j))*KBpartX(part,j));
E_KBny1(j)         $ j_land(j)..     KB(j) =e= J_KB(j) + sum(part, KBpart(part,j)+scalar_PKBx(part,j)*KBpartX(part,j));

E_KBny2(j)   $ (NOT j_land(j))..     tfp(j)*thetaB(j)*KB(j)/(1+grow) =e= J_KB(j) + m_HB(j) * (((1+tFak_B(j))*ucB(j)*PInvB(j))/(tfp(j)*thetaB(j)*PH(j)))**(-EH(j))*H(j);

E_PHny1(j) $ (NOT j_land(j))..     PH(j)*H(j) =e= J_PH(j) + pLKE(j)*LKE(j) + (1+tFak_B(j))*ucB(j)*PInvB(j)*KB(j)/(1+grow);
E_PHny2(j)      $ j_land(j)..      PH(j)*H(j) =e= J_PH(j) + pLKE(j)*LKE(j) + PKBtot(j)*KBtot(j)/(1+grow);



* For CO2: antal mia. kr. gange 1.000 tons per mia. kr. = antal 1.000 tons CO2
* For øvrige: antal mia. kr. gange tons per mia. kr. = antal tons af X

*Ikke-energirelaterede udledninger knyttes til Y for ikke-j_land brancher
E_Ieudled1(j,udled_type) $ d1IeudledType1(j,udled_type).. Ieudled(j,udled_type) =E= J_Ieudled(j,udled_type) + Y(j) * scalar_Ieudled(j,udled_type); 

*Ikke-energirelaterede drivhusgasudledninger for j_land brancher knyttes til KB
E_Ieudled2(j,udled_type) $ d1IeudledType2(j,udled_type).. Ieudled(j,udled_type) =E= J_Ieudled(j,udled_type) + IeudledperKBpre(j,udled_type) * sum(part,KBpart(part,j)*CO2eAndel(part,j)) ;

*Ikke-energirelaterede ikke-drivhusgasudledninger for j_land brancher knyttes til KB
E_Ieudled3(j,udled_type) $ d1IeudledType3(j,udled_type).. Ieudled(j,udled_type) =E= J_Ieudled(j,udled_type) + IeudledperKBpre(j,udled_type) * sum(part,KBpart(part,j)*NH3Andel(part,j)); 



*Kvælstofudvaskning
E_Nudled.. Nudled =E= J_Nudled + NudledperKBpre * sum(part,KBpart(part,'01000a')*NAndel(part)); 

*CCS (i kg. pr GJ) gange antal mia. GJ divideret med antal KB i mia. kr. = kg. CCS per kr. KB  -  Dette ganges med 1.000, hvorefter vi har 1.000 tons CO2 per mia. kr. KB
E_CCSprKBx(j)      $ j_CCS(j)..      CCSprKBx(j) =E= J_CCSprKBx(j) + sum(kilder,CCSandel(j,kilder)*(CO2koeff(kilder)+Ekoeff(j,kilder,'CO2'))*energiGJ(j,kilder))/KBtot(j) * 1000;
*CCSprKBx(j)*1.000 = tons CCS per mia KB.    CO2eTax*10**(-9) = skat i mia. kr. per ton
E_PKBpartX(part,j) $ j_CCS(j).. PKBpartX(part,j) =E= J_PKBpartX(part,j) + scalar_PKBx(part,j) * (1+tFak_B(j))*ucB(j)*PInvB(j) - CCSprKBx(j)*1000 * BECCSshare(j) * s_CCS(part,j) * 10**(-9);

E_NegaUdled(part,j)     $ j_CCS(j)..     NegaUdled(part,j) =E= J_NegaUdled(part,j) + CCSprKBx(j) * KBpartX(part,j);

E_BECCSshare(j)              $ j_CCS(j)..     BECCSshare(j) =E= J_BECCSshare(j) + sum(kilder,CCSandel(j,kilder)*(CO2koeff(kilder))*energiGJ(j,kilder))/KBtot(j) * 1000 / CCSprKBx(j);

* Afgift i kr. per ton CO2e gange antal ton CO2-ækvivalent gange 10**(-9) = provenu i mia. kr.
E_TR_Ieudled(j,udled_type) $ (d1IeudledType1(j,udled_type) or d1IeudledType2(j,udled_type)  or d1IeudledType3(j,udled_type)).. TR_Ieudled(j,udled_type) =E= J_TR_Ieudled(j,udled_type) + Ieudled(j,udled_type)*CO2eVaegt(udled_type) * CO2eTax * CO2eTax_dummyIE(j,udled_type) * 10**(-9); 
*E_TR_Ieudled_kalib(j,udled_type) $ (d1IeudledType1(j,udled_type) or d1IeudledType2(j,udled_type)  or d1IeudledType3(j,udled_type)).. TR_Ieudled_kalib(j,udled_type) =E= J_TR_Ieudled_kalib(j,udled_type) + Ieudled(j,udled_type)*CO2eVaegt(udled_type) * CO2eTax_kalib * CO2eTax_dummyIE_kalib(j,udled_type) * 10**(-9); 

* Helbredsomkostninger fra luftforurening: Enhedsværdier i kr. per kg emission gange antal ton emission gange 10**(-6) = værdi i mia. kr.
E_EVAir_IE(j,udled_type).. EVAir_IE(j,udled_type) =E= J_EVAir_IE(j,udled_type) + Ieudled(j,udled_type)*Enhedsp_IkkeE(j,udled_type) * 10**(-6); 

* Værdi af vandmiljø: Enhedsværdi i kr. per kg udvaskning gange antal ton gange 10**(-6) = værdi i mia. kr.
E_EVNudled..               EVNudled =E= J_EVNudled + Nudled*Enhedsp_N * 10**(-6);

$ontext
E_DIVnyny1(j)  $ (NOT j_CCS(j))..    DIV(j) =e= J_DIV(j) + (1-t_cor(j))*(p(j)*Y(j) - PM(j)*M(j) - PE(j)*E(j) - sum(i,px_energi(j,i)*x_energi(j,i)) - (1+tFak_w(j))*w*L(j) - tFak_B(j)*ucB(j)*PInvB(j)*KB(j)/(1+grow) - tFak_M(j)*ucM(j)*PInvM(j)*KM(j)/(1+grow)
                                                                - sum((kilder,udled_type), TR_Eudled(j,kilder,udled_type)) - sum(udled_type, TR_Ieudled(j,udled_type)) - sum(udled_type, TR_Ieudled_kalib(j,udled_type)) + sum(part,NegaUdled(part,j)*s_CCS(part,j))*10**(-6)   - Fak_rest(j)
                                  - (r*(1+infl)+infl)*DP(j)/((1+infl)*(1+grow))) - PInvB(j)*InvB(j) - PInvM(j)*InvM(j) - PIL(j)*IL(j) 
                                  - SUBEU(j)
                                  + t_cor(j)*(deltaKBBook(j)*KBBook(j)+deltaKMBook(j)*KMBook(j))/((1+grow)*(1+infl)) + (1-1/((1+grow)*(1+infl)))*DP(j);

E_DIVnyny2(j)  $ j_CCS(j)..      DIV(j) =e= J_DIV(j) + (1-t_cor(j))*(p(j)*Y(j) - PM(j)*M(j) - PE(j)*E(j) - sum(i,px_energi(j,i)*x_energi(j,i)) - (1+tFak_w(j))*w*L(j) - tFak_B(j)*ucB(j)*PInvB(j)*KB(j)/(1+grow) - tFak_M(j)*ucM(j)*PInvM(j)*KM(j)/(1+grow)
                                                                - sum((kilder,udled_type), TR_Eudled(j,kilder,udled_type)) - sum(udled_type, TR_Ieudled(j,udled_type)) - sum(udled_type, TR_Ieudled_kalib(j,udled_type)) + sum(part,NegaUdled(part,j)*s_CCS(part,j))*10**(-6)   - Fak_rest(j)
                                  - (r*(1+infl)+infl)*DP(j)/((1+infl)*(1+grow))) - PInvB(j)*InvB(j) - PInvM(j)*InvM(j) - PIL(j)*IL(j) 
                                  - SUBEU(j)
                                  + t_cor(j)*(deltaKBBook(j)*KBBook(j)+deltaKMBook(j)*KMBook(j))/((1+grow)*(1+infl)) + (1-1/((1+grow)*(1+infl)))*DP(j);                                  
$offtext

E_DIVnyny(j)..      DIV(j) =e= J_DIV(j) + (1-t_cor(j))*(p(j)*Y(j) - PM(j)*M(j) - PE(j)*E(j) - sum(i,px_energi(j,i)*x_energi(j,i)) - (1+tFak_w(j))*w*L(j) - tFak_B(j)*ucB(j)*PInvB(j)*KB(j)/(1+grow) - tFak_M(j)*ucM(j)*PInvM(j)*KM(j)/(1+grow)
                                                                - sum((kilder,udled_type), TR_Eudled(j,kilder,udled_type)) - sum(udled_type, TR_Ieudled(j,udled_type)) - sum(udled_type, TR_Ieudled_kalib(j,udled_type)) + sum(part,NegaUdled(part,j)*BECCSshare(j)*s_CCS(part,j))*10**(-6)   - Fak_rest(j)
                                  - (r*(1+infl)+infl)*DP(j)/((1+infl)*(1+grow))) - PInvB(j)*InvB(j) - PInvM(j)*InvM(j) - PIL(j)*IL(j) 
                                  - SUBEU(j)
                                  + t_cor(j)*(deltaKBBook(j)*KBBook(j)+deltaKMBook(j)*KMBook(j))/((1+grow)*(1+infl)) + (1-1/((1+grow)*(1+infl)))*DP(j);                                  
                                  

E_TRcorny.. TRcor =E= J_TRcor + sum(j, t_cor(j)*(p(j)*Y(j) - PM(j)*M(j)- PE(j)*E(j) - sum(i,px_energi(j,i)*x_energi(j,i)) - (1+tFak_w(j))*w*L(j) - tFak_B(j)*ucB(j)*PInvB(j)*KB(j)/(1+grow) - tFak_M(j)*ucM(j)*PInvM(j)*KM(j)/(1+grow) 
                                       - sum((kilder,udled_type), TR_Eudled(j,kilder,udled_type))
                                       - sum(udled_type, TR_Ieudled(j,udled_type)) - sum(udled_type, TR_Ieudled_kalib(j,udled_type))
                                       + sum(part,NegaUdled(part,j)*BECCSshare(j)*s_CCS(part,j))*10**(-6)
                                       - Fak_rest(j) - (r*(1+infl)+infl)*DP(j)/((1+infl)*(1+grow)) - (deltaKBBook(j)*KBBook(j)+deltaKMBook(j)*KMBook(j))/((1+grow)*(1+infl)) )); 

E_PSaldonyny..   PSaldo =e=  J_PSaldo + TRAfgifter + TRw + TRcap + TRcor + TRprod + sum((j,kilder,udled_type), TR_Eudled(j,kilder,udled_type)) + sum((j,udled_type), TR_Ieudled(j,udled_type)) + sum((j,udled_type), TR_Ieudled_kalib(j,udled_type)) - sum((part,j),NegaUdled(part,j)*BECCSshare(j)*s_CCS(part,j)*10**(-6)) - Overf - Gval - Lump - CCSExp;   

E_POnyny(j)..     PO(j)*Y(j) =e= J_PO(j) + PM(j)*M(j) + PH(j)*H(j) + PT(j)*T(j) + sum(udled_type, TR_Ieudled(j,udled_type)*d1IeudledType1(j,udled_type)) + sum(udled_type, TR_Ieudled_kalib(j,udled_type)*d1IeudledType1(j,udled_type));



E_CO2Energi(j)..       CO2Energi(j) =E= J_CO2Energi(j) + sum(kilder,Eudled(j,kilder,'CO2'));
E_CO2BogD(j)..           CO2BogD(j) =E= J_CO2BogD(j)   + Eudled(j,'BogD','CO2');
E_CO2Ie(j)..               CO2Ie(j) =E= J_CO2Ie(j)     + Ieudled(j,'CO2');
E_CO2eMLF(j)..           CO2eMLF(j) =E= J_CO2eMLF(j)   + sum(udled_type,         Ieudled(j,udled_type) * CO2eVaegt(udled_type)/1000)
                                                       + sum((kilder,udled_type), Eudled(j,kilder,udled_type) * CO2eVaegt(udled_type)/1000) - CO2Energi(j) - CO2Ie(j);
E_CO2e(j)..                 CO2e(j) =E= J_CO2e(j) + CO2Energi(j) + CO2Ie(j) + CO2eMLF(j) - sum(part,NegaUdled(part,j));


*------------------------------------------------------------
*Data
*------------------------------------------------------------

*Indlæs data 
$GDXIN data_16_E.gdx
$LOAD Emiss_IkkeE, Enhedsp_IkkeE
$GDXIN


*Sæt parametre

CO2eTax_dummyIE(j,udled_type) = 0;
CO2eTax_dummyIE_kalib(j,udled_type) = 0;

d1KBpartX(part,j) = 0;


*Andel af biomasseforbrug hos kraftvarmeværker, der er på centrale kraftvarmeværker, og som derfor kan benyttes til BCCS
*Det generelle potentiale justeres med prisen
CCSandel('350010a','Halm')     = 0.43;
CCSandel('350010a','Tpiller')  = 0.81;
CCSandel('350010a','Tbra')     = 1;
CCSandel('350010a','Biogas')     = 0.25;
*Andel af CO2-udledninger fra energiforbrug, som kan fanges med CCS i cementindustrien
CCSandel('230020','olie')        = 1;
CCSandel('230020','kul')         = 1;
*CCSandel('230020','NatGas')      = 0.5*10/9;
CCSandel('230020','Biogas')      = 1;
*Under udarbejdelse
*Andel af CO2-udledninger (inkl. CO2-udledninger fra biomasse) fra affaldsforbrænding, som kan fanges med CCS (der ganges med 10/5 da de sidste 5/10 knyttes til ikke-energirelaterede udledninger og tages ud som mulig CCS)

CCSandel('383900','affald')        = 1;



*CO2-emissionskoefficienter for biomasse
CO2koeff('Halm') = 100;
CO2koeff('Tpiller') = 112;
CO2koeff('Tbra') = 112;
*Nettoudledninger fra affald udgør 42½. Disse kommer fra den fossile del, som udgør 45 pct. og har en udledning på 94 kg. per GJ.
*Udledningerne fra biodelen tæller ikke med i de officielle udledninger, men udgør et potentiale for BECCS
*Udledningen per GJ bioaffald er 115. Dermed bliver de potentielle negative udledninger via BECCS på affald på 115*0.55
CO2koeff('affald') = 115*0.55;

*CO2 indholdet i biogas er sat til at vise effekten af at lave biogas om til bionaturgas
CO2koeff('biogas') = 30;



thetaB_anim.l = 1;

s_CCS.l(part,j) = 0;

*Elasticiteter kalibreret til MAC-kurver for CO2e-udledning

EKB.l(j) = 0;
EKB.l('01000a') = 0.5;
EKB.l('01000b') = 0.05;
EKB.l('01000c') = 0.9;


* Ikke-energirelaterede CO2e-udledninger knyttes for landbrug og 383900 til part 51-100. Disse kan dermed reduceres ved at substituerer over til part 1-50
CO2eAndel(part1_50,j) = 0;
CO2eAndel(part51_100,j) = 1;

*For cement er ikke-energi CO2e-udledninger knyttet til alle dele af KB og kan opfanges via CCS på samme måde som CO2 fra energi
*Dermed opfanges 50 pct., hvis halvdelen af KBpartX anvendes
CO2eAndel(part,'230020') = 1;

* For kraftvarmeværker er ikke-energirelateret co2e-udledninger (primært lidt flour) knyttet til part100, og kan dermed ikke fortrænges via CCS, som kun virker på energirelaterede udledninger
CO2eAndel(part,'350010a') = 0;
CO2eAndel('part100','350010a') = 1;



CO2eAndelDiv(j) = sum(part, CO2eAndel(part,j));
CO2eAndel(part,j) = CO2eAndel(part,j)/CO2eAndelDiv(j)*100; 

*For givne elasticiteter kalibreres andelen af KB, der udleder NH3 (og øvrig luftforurening) til MAC-kurver
NH3Andel(part,j) = 1;

NH3Andel(part1_35,'01000a') = 0;
NH3Andel(part1_50,'01000b') = 0;
NH3Andel(part1_40,'01000c') = 0;

NH3AndelDiv(j) = sum(part, NH3Andel(part,j));
NH3Andel(part,j) = NH3Andel(part,j)/NH3AndelDiv(j)*100; 

*For givne elasticiteter kalibreres andelen af KB, der udleder N til MAC-kurver
NAndel(part) = 1;
NAndel(part1_35) = 0;

NAndelDiv = sum(part, NAndel(part));
NAndel(part) = NAndel(part)/NAndelDiv*100; 


*display KB.l;
*$exit
*Mængdevariable sættes
KBtot.l(j) $ j_land(j) = KB.l(j);
KBpart.l(part,j) $ j_land(j) = KBtot.l(j)/100;

*Priser sættes
PKBtot.l(j) $ j_land(j) = (1+tFak_B.l(j))*ucB.l(j)*PInvB.l(j);
PKBpart.l(part,j) $ j_land(j) = (1+tFak_B.l(j))*ucB.l(j)*PInvB.l(j);


* Ikke-energirelaterede udledninger fra data
Ieudled.l(j,udled_type) = Emiss_IkkeE(j,udled_type);

* Kalibrering af ikke-energirelaterede udledninger per KB-enhed
IeudledperKBpre(j_land,udled_type) = Ieudled.l(j_land,udled_type) / KB.l(j_land);




*CCS pr KBx udregnes
CCSprKBx.l(j) $ j_CCS(j) = sum(kilder,CCSandel(j,kilder)*(CO2koeff(kilder)+Ekoeff(j,kilder,'CO2'))*energiGJ.l(j,kilder))/KBtot.l(j) * 1000;

parameter CCSprKBxinklCEMENT;
CCSprKBxinklCEMENT('230020') = sum(kilder,CCSandel('230020',kilder)*(CO2koeff(kilder)+Ekoeff('230020',kilder,'CO2'))*energiGJ.l('230020',kilder))/KBtot.l('230020') * 1000
                         + sum(udled_type, IeudledperKBpre('230020',udled_type)*CO2eVaegt(udled_type))/KBtot.l('230020');
*display CCSprKBx.l, CCSprKBxinklCEMENT;

BECCSshare.l(j) $ j_CCS(j) = sum(kilder,CCSandel(j,kilder)*(CO2koeff(kilder))*energiGJ.l(j,kilder))/KBtot.l(j) * 1000 / CCSprKBx.l(j);

*KBpartX er taget ud af spillet for landbrug pt. via en høj pris (her sættes den uendeligt højt for alle, og senere sættes den rigtigt, hvor KBpartX er muligt)
PKBpartX.l(part,j) $ j_land(j) = PKBpart.l(part,j) * 10000;



*Kalibrering af priser på CCS

parameter CCSpris;
CCSpris(part,j_CCS) = 800+2*ord(part);
CCSpris(part,'350010a') = 800+2/0.85*ord(part);
CCSpris(part,'383900') = 800+2/0.5*ord(part);
CCSpris(part,'230020') = 800+2/0.5*ord(part);
*CCS er begrænset til 85 pct. i kraftvarmeværk
CCSpris(part86_100,'350010a') = CCSpris(part86_100,'350010a')*100;
*CCS er begrænset til 50 pct. i affaldsforbrænding. Øvrige udledninger fra spildevand m.m. er knyttet til de sidste 50 pct.
CCSpris(part51_100,'383900') = CCSpris(part51_100,'383900')*100;
CCSpris(part51_100,'230020') = CCSpris(part51_100,'230020')*100;

display CCSpris;



PKBpartX.l(part,j_CCS) = (1+tFak_B.l(j_CCS))*ucB.l(j_CCS)*PInvB.l(j_CCS) + CCSprKBx.l(j_CCS)*1000 * CCSpris(part,j_CCS) * 10**(-9);
PKBpartX.l(part,'230020') = (1+tFak_B.l('230020'))*ucB.l('230020')*PInvB.l('230020') + CCSprKBxinklCEMENT('230020')*1000 * CCSpris(part,'230020') * 10**(-9);
display PKBpartX.l, PKBpart.l;


*Kvælstofudvaskning i ton N, jf. Kvælstofudvaskning.xlsx
Nudled.l = 50604;
Nudled0 = 50604;

NudledperKBpre.l = Nudled.l / KB.l('01000a');

*Enhedsværdi i kr. per udvasket kg udvasket kvælstof, jf. boks I.8 i M18
Enhedsp_N = 60;

EVAir_IE.l(j,udled_type) = Ieudled.l(j,udled_type)*Enhedsp_IkkeE(j,udled_type) * 10**(-6);

EVNudled.l = Nudled.l*Enhedsp_N * 10**(-6);

CO2Energi.l(j) = sum(kilder,Eudled.l(j,kilder,'CO2'));
CO2BogD.l(j)   = Eudled.l(j,'BogD','CO2');
CO2Ie.l(j)     = Ieudled.l(j,'CO2');
CO2eMLF.l(j)   = sum(udled_type,Ieudled.l(j,udled_type) * CO2eVaegt(udled_type)/1000) + sum((kilder,udled_type), Eudled.l(j,kilder,udled_type) * CO2eVaegt(udled_type)/1000) - CO2Energi.l(j) - CO2Ie.l(j);
CO2e.l(j)      = CO2Energi.l(j) + CO2Ie.l(j) + CO2eMLF.l(j) - sum(part,NegaUdled.l(part,j));

*My'er kalibreres
m_KBtot.l(j) $ j_land(j) = tfp.l(j)*thetaB.l(j)*KBtot.l(j)/(1+grow.l) / H.l(j) * (PKBtot.l(j)/(tfp.l(j)*thetaB.l(j)*PH.l(j)))**(EH.l(j));
m_KBpart.l(j) $ j_land(j) = 1/100;

scalar_Ieudled(j,udled_type) = Ieudled.l(j,udled_type) / Y.l(j);

scalar_PKBx(part,j) $ j_CCS(j) = PKBpartX.l(part,j)/PKBpart.l(part,j);

d1IeudledType1(j,udled_type) = 1 $ (Ieudled.l(j,udled_type) gt 0);
d1IeudledType1(j_land,udled_type) = 0;
d1IeudledType2(j_land,udled_type)$drivhus(udled_type) = 1 $ (Ieudled.l(j_land,udled_type) gt 0);
d1IeudledType3(j_land,udled_type)$(not drivhus(udled_type)) = 1 $ (Ieudled.l(j_land,udled_type) gt 0);
*d1IeudledType1('350010a',udled_type) = 1 $ (Ieudled.l('350010a',udled_type) gt 0);
*d1IeudledType2('350010a',udled_type) = 0;
*d1IeudledType3('350010a',udled_type) = 0;

d1NegaUdled(j_land) = 1;
d1NegaUdled(j_landxCCS) = 0;

*------------------------------------------------------------
* Modeller
*------------------------------------------------------------
model static_KB
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
*E_DIVnyny1
*E_DIVnyny2

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
*E_PSaldony
E_PSaldonyny
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

*$ontext
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
*$offtext

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

save;

solve static_KB using cns;

* gamX-kommando (udskriver %-vis afvigelse i.f.t. sidste 'save' for alle variable i gruppen ENDO)
disp J_LED_NEW3;
dispdif |J_LED| > 0.0001;
dispdif |J_LED_NEW| > 0.0001;
dispdif |J_LED_NEW2| > 0.0001;
dispdif |J_LED_NEW3| > 0.0001;

*$exit

*------------------------------------------------------------
* Kørsel
*------------------------------------------------------------
fix ALL;
unfix ENDO;
unfix ENDO_NEW;
unfix ENDO_NEW2;
unfix ENDO_NEW3;
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

J_DIV.fx(j) = 0;

solve static_KB using cns;


disp J_LED_NEW;
disp J_LED_NEW2;
disp J_LED_NEW3;
dispdif |J_LED| > 0.0001;
dispdif |J_LED_NEW| > 0.0001;
dispdif |J_LED_NEW2| > 0.0001;
dispdif |J_LED_NEW3| > 0.0001;
display BoP.l;


*test af om CCS virker
$ontext
s_CCS.fx('part1','350010a') = 700;

solve static_KB using cns;

*Startværdier for backstop-teknologier
KBpartX.l(part,j_land) = KBpart.l(part,j_land);

s_CCS.fx('part1','350010a') = 790;

* PKBpartX udregnes partielt inden modellen køres for at afgøre, om CCS skal slås til
PKBpartX.l(part,j) $ j_CCS(j) = scalar_PKBx(part,j) * (1+tFak_B.l(j))*ucB.l(j)*PInvB.l(j) - CCSprKBx.l(j)*1000 * BECCSshare.l(j) * s_CCS.l(part,j) * 10**(-9);

*Angivelse af, om backstop-teknologier skal anvendes
*CCS slås til, hvis PKBpartX er lavere end PKBpart
d1KBpartX(part,j_land) $ (PKBpart.l(part,j_land) gt PKBpartX.l(part,j_land)) = 1;

*Ved CCS er KBpartX endogen, ellers er KBpart endogen
KBpartX.fx(part,j_land) $ (d1KBpartX(part,j_land) eq 0) = 0;
KBpart.fx(part,j_land)  $ (d1KBpartX(part,j_land) eq 1) = 0;
KBpartX.lo(part,j_land) $ (d1KBpartX(part,j_land) eq 1) = -inf;
KBpartX.up(part,j_land) $ (d1KBpartX(part,j_land) eq 1) =  inf;

solve static_KB using cns;


*Startværdier for backstop-teknologier
KBpartX.l(part,j_land) = KBpart.l(part,j_land);

s_CCS.fx('part1','350010a') = 820;

* PKBpartX udregnes partielt inden modellen køres for at afgøre, om CCS skal slås til
PKBpartX.l(part,j) $ j_CCS(j) = scalar_PKBx(part,j) * (1+tFak_B.l(j))*ucB.l(j)*PInvB.l(j) - CCSprKBx.l(j)*1000 *BECCSshare.l(j) * s_CCS.l(part,j) * 10**(-9);

*Angivelse af, om backstop-teknologier skal anvendes
*CCS slås til, hvis PKBpartX er lavere end PKBpart
d1KBpartX(part,j_land) $ (PKBpart.l(part,j_land) gt PKBpartX.l(part,j_land)) = 1;

*Ved CCS er KBpartX endogen, ellers er KBpart endogen
KBpartX.fx(part,j_land) $ (d1KBpartX(part,j_land) eq 0) = 0;
KBpart.fx(part,j_land)  $ (d1KBpartX(part,j_land) eq 1) = 0;
KBpartX.lo(part,j_land) $ (d1KBpartX(part,j_land) eq 1) = -inf;
KBpartX.up(part,j_land) $ (d1KBpartX(part,j_land) eq 1) =  inf;

solve static_KB using cns;

display BoP.l, KBpartX.l, d1KBpartX;
$ontext
$offtext