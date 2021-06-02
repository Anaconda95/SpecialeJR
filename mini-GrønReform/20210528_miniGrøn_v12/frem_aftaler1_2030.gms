* * * * * Aftaler indgået efter seneste basisfremskrivning * * * * * *

*                                       Mio. ton CO2e i 2030
*1. Tilskud til sol og vind                0.02
*2. Øget brug af elbiler (virksomheder)    0.1
*3. Tilskud til CCS			   0.9
*4. Elektrificering hos husholdninger      0.7
*5. Tilskud til elbaseret fjernvarme       0.02
*6. Elektrificering i industri	           0.2
*7. Tilskud til biogas		           0.7
*8. Elektrificering af affaldsforbrænding  0.7
*9. Afgift i cementindustrien              0.5

* * * * *

Display CO2eDK.l;

*1. Tilskud til sol og vind

Display s_Y.l;

CO2eDK.fx = CO2eDK.l - 20;
m_elvind.up = inf;
m_elvind.lo = -inf;
*s_Y.lo('350010b') = -inf;
*s_Y.up('350010b') = inf;

solve static_fremskriv using cns;

s_Y.fx(j) = s_Y.l(j);
m_elvind.fx = m_elvind.l;

Display s_Y.l;

* * * * *

*2. Øget brug af elbiler (virksomheder)

Display m_TTE_tot.l;

CO2eDK.fx = CO2eDK.l - 100;

m_TTE_tot.lo = -inf;
m_TTE_tot.up = inf;

solve static_fremskriv using cns;

m_TTE_tot.fx = m_TTE_tot.l;

Display m_TTE_tot.l;

* * * * *

*4. Elektrificering hos husholdninger

Display m_CH.l;

CO2eDK.fx = CO2eDK.l - 700;

m_CH.lo('ng') = -inf;
m_CH.up('ng') = inf;

solve static_fremskriv using cns;

m_CH.fx('ng') = m_CH.l('ng');

Display m_CH.l;

* * * * *

*5. Elektrificering hos fjernvarmeværker

CO2eDK.fx = CO2eDK.l - 20;

m_KEel.lo('350030a') = -inf;
m_KEel.up('350030a') = inf;

solve static_fremskriv using cns;

m_KEel.fx('350030a') = m_KEel.l('350030a');

Display m_CH.l;

* * * * *

*6. Elektrificering i industri

Display m_KEel_forarb.l;

CO2eDK.fx = CO2eDK.l - 200;

m_KEel_forarb.lo = -inf;
m_KEel_forarb.up = inf;

solve static_fremskriv using cns;

m_KEel_forarb.fx = m_KEel_forarb.l;

Display s_Y.l;

* * * * *

*7. Tilskud til biogas

parameter CO2eDKpre, CO2eDKreduk;
*Øget anvendelse af biogas
*Indlægges ikke rigtigt - giver modsatrettede effekter


$ontext
m_BG_energi.fx('350010a') =  m_BG_energi.l('350010a')*1.1;
CO2eDKpre = CO2eDK.l;
CO2eDK.lo = -inf;
CO2eDK.up = inf;
solve static_fremskriv using cns;

CO2eDKreduk = CO2eDKpre-CO2eDK.l;
display CO2eDK.l, CO2eDKpre, CO2eDKreduk;
$exit


*CO2eDK.fx = CO2eDK.l - 700;
*m_BG_energi.lo('350010a') = -inf;
*m_BG_energi.up('350010a') =  inf;

*solve static_fremskriv using cns;

*m_BG_energi.fx('350010a') =  m_BG_energi.l('350010a');
$offtext

* * * * *

*8. Elektrificering af affaldsforbrænding
* tages ud, da det giver nogle mærkelige marginaleffekter, hvis affaldsforbrændingen kan elektrificeres
$ontext
Display m_KEel.l;

CO2eDK.fx = CO2eDK.l - 700;

m_KEel.lo('383900') = -inf;
m_KEel.up('383900') = inf;

solve static_fremskriv using cns;

m_KEel.fx(j) = m_KEel.l(j);

Display m_KEel.l;
$offtext
* * * * *

*9. aftale i cementindustrien
* - skift i energiforbrug fra kul og olie til naturgas
* - anden type cement med lavere ikke-energirelaterede udledninger
* Indføres via co2e-skatten fra co2-kvoterne


CCSprKBx.l(j) $ j_CCS(j) = sum(kilder,CCSandel(j,kilder)*(CO2koeff(kilder)+Ekoeff(j,kilder,'CO2'))*energiGJ.l(j,kilder))/KBtot.l(j) * 1000;
CCSprKBxinklCEMENT('230020') = sum(kilder,CCSandel('230020',kilder)*(CO2koeff(kilder)+Ekoeff('230020',kilder,'CO2'))*energiGJ.l('230020',kilder))/KBtot.l('230020') * 1000
                         + sum(udled_type, IeudledperKBpre('230020',udled_type)*CO2eVaegt(udled_type))/KBtot.l('230020');

scalar_PKBx(part,j_CCS) = (1+tFak_B.l(j_CCS))*ucB.l(j_CCS)*PInvB.l(j_CCS) + CCSprKBx.l(j_CCS)*1000 * CCSpris(part,j_CCS) * 10**(-9);
scalar_PKBx(part,'230020') = (1+tFak_B.l('230020'))*ucB.l('230020')*PInvB.l('230020') + CCSprKBxinklCEMENT('230020')*1000 * CCSpris(part,'230020') * 10**(-9);
scalar_PKBx(part,j) $ j_CCS(j) = scalar_PKBx(part,j)/PKBpart.l(part,j);



CO2eDKpre = CO2eDK.l;
CO2eDK.lo = -inf;
CO2eDK.up = inf;

display PKBpart.l;

set loopstepCement /1*20/;

*Først øges dummyerne der bestemmes i hvor høj grad co2-afgiften gælder indtil reduktionen kommer over 500
loop(loopstepCement $ (CO2eDK.l GT CO2eDKpre-500),  

CO2eTax_dummyE('230020',kilder,'CO2') = CO2eTax_dummyE('230020',kilder,'CO2') + 0.2;
CO2eTax_dummyIE('230020','CO2') = CO2eTax_dummyIE('230020','CO2') + 0.2;



*startværdi
KBpartX.l(part,j_land) = KBpart.l(part,j_land);


*startværdi for PKBpart med nye værdier for CO2eTax_dummyIE
PKBpart.l(part,j) $ j_land(j) = (1+tFak_B.l(j))*ucB.l(j)*PInvB.l(j) + sum(udled_type, IeudledperKBpre(j,udled_type)*CO2eAndel(part,j)*CO2eVaegt(udled_type) * CO2eTax_dummyIE(j,udled_type)) * CO2eTax.l * 10**(-9);

d1KBpartX(part,j_land) $ (PKBpart.l(part,j_land) gt PKBpartX.l(part,j_land)) = 1;

KBpartX.fx(part,j_land) $ (d1KBpartX(part,j_land) eq 0) = 0;
KBpart.fx(part,j_land)  $ (d1KBpartX(part,j_land) eq 1) = 0;
KBpartX.lo(part,j_land) $ (d1KBpartX(part,j_land) eq 1) = -inf;
KBpartX.up(part,j_land) $ (d1KBpartX(part,j_land) eq 1) =  inf;


solve static_fremskriv using cns;

CO2eDKreduk = CO2eDKpre-CO2eDK.l;

display CO2eDK.l, CO2eDKpre, CO2eDKreduk;
);

display PKBpart.l, d1KBpartX;


*$ontext
*Herefter mindskes dummyerne en smule igen indtil reduktionen kommer lige under 500
loop(loopstepCement $ (CO2eDK.l LT CO2eDKpre-500),  

CO2eTax_dummyE('230020',kilder,'CO2') = CO2eTax_dummyE('230020',kilder,'CO2') - 0.01;
CO2eTax_dummyIE('230020','CO2') = CO2eTax_dummyIE('230020','CO2') - 0.01;


*startværdi
KBpart.l(part,j_land) $ (d1KBpartX(part,j_land) eq 1) = KBpartX.l(part,j_land);

*startværdi for PKBpart med nye værdier for CO2eTax_dummyIE
PKBpart.l(part,j) = (1+tFak_B.l(j))*ucB.l(j)*PInvB.l(j) + sum(udled_type, IeudledperKBpre(j,udled_type)*CO2eAndel(part,j)*CO2eVaegt(udled_type) * CO2eTax_dummyIE(j,udled_type)) * CO2eTax.l * 10**(-9);

d1KBpartX(part,j_land) $ (PKBpart.l(part,j_land) gt PKBpartX.l(part,j_land)) = 1;
d1KBpartX(part,j_land) $ (PKBpart.l(part,j_land) lt PKBpartX.l(part,j_land)) = 0;

KBpartX.fx(part,j_land) $ (d1KBpartX(part,j_land) eq 0) = 0;
KBpart.lo(part,j_land)  $ (d1KBpartX(part,j_land) eq 0) = -inf;
KBpart.up(part,j_land)  $ (d1KBpartX(part,j_land) eq 0) =  inf;
KBpart.fx(part,j_land)  $ (d1KBpartX(part,j_land) eq 1) = 0;
KBpartX.lo(part,j_land) $ (d1KBpartX(part,j_land) eq 1) = -inf;
KBpartX.up(part,j_land) $ (d1KBpartX(part,j_land) eq 1) =  inf;


solve static_fremskriv using cns;

CO2eDKreduk = CO2eDKpre-CO2eDK.l;

display CO2eDK.l, CO2eDKpre, CO2eDKreduk;
);
$ontext
$offtext
*display CO2eDK.l, CO2eDKpre, CO2eTax_dummyE, CO2eTax_dummyIE, CO2eDKreduk;


* * * * * *
* 10 Tilskud til CCS - samlet effekt 900.000 tons co2e
CO2eDKpre = CO2eDK.l;


s_CCS.fx(part,'350010a') = 800;


set loopstepCCS /1*50/;

loop(loopstepCCS $ (CO2eDK.l GT CO2eDKpre-900),

s_CCS.fx(part,'350010a') $ (d1KBpartX(part,'350010a') EQ 0) = s_CCS.l(part,'350010a') + 1;

*startværdi
KBpartX.l(part,j_land) = KBpart.l(part,j_land);

PKBpartX.l(part,j) $ j_CCS(j) = scalar_PKBx(part,j) * (1+tFak_B.l(j))*ucB.l(j)*PInvB.l(j) - CCSprKBx.l(j)*1000 * BECCSshare.l(j) * s_CCS.l(part,j) * 10**(-9);

d1KBpartX(part,j_land) $ (PKBpart.l(part,j_land) gt PKBpartX.l(part,j_land)) = 1;

*display d1KBpartX, PKBpartX.l, PKBpart.l;

KBpartX.fx(part,j_land) $ (d1KBpartX(part,j_land) eq 0) = 0;
KBpart.fx(part,j_land)  $ (d1KBpartX(part,j_land) eq 1) = 0;
KBpartX.lo(part,j_land) $ (d1KBpartX(part,j_land) eq 1) = -inf;
KBpartX.up(part,j_land) $ (d1KBpartX(part,j_land) eq 1) =  inf;

*PKBpartX låses for at undgå negativ pris - tilskuddet tager tilpasningen
*PKBpartX.fx(part,'350010a')  $ (d1KBpartX(part,'350010a') eq 1) = PKBpartX.l(part,'350010a');
*s_CCS.lo(part,'350010a') $ (d1KBpartX(part,'350010a') eq 1) = -inf;
*s_CCS.up(part,'350010a') $ (d1KBpartX(part,'350010a') eq 1) =  inf;

solve static_fremskriv using cns;

);


CO2eDKreduk = CO2eDKpre-CO2eDK.l;

display CO2eDK.l, CO2eDKpre, CO2eDKreduk;




$include vis_andele.gms

display BoP.l, gdp.l, gdpf0.l, d1KBpartX;



parameter CO2ePerBVT, lump0;
CO2ePerBVT(j) = CO2e.l(j) / BVTf0.l(j);
LUMP0 = LUMP.l;

execute_unload "gekko\gdx_work\%filnavn%.gdx";

* korrektionCO2eTot sættes så udledninger inkl. aftaler bliver det officielle tal. CO2eDK skal være 33831. Derfor bør korrektionCO2eTot korrigeres, hvis der er forskel.
display korrektionCO2eTot, CO2eDK.l;


parameter CO2emaal2030, CO2e_inklLULUCF_1990, LULUCF2016, LULUCF2030, LULUCF2050;
CO2e_inklLULUCF_1990 = 77236;

LULUCF2016 = 6166;
LULUCF2030 = 5287;
LULUCF2050 = 4492;

CO2emaal2030 = (1-0.7)*CO2e_inklLULUCF_1990 - LULUCF2030;

set loopstep /0*1000/;

Parameter CO2eSti, MACdata;

CO2eSti('0','CO2IEn_Cement') = CO2IEn_Cement.l;
CO2eSti('0','CO2e_Veg') = CO2e_Veg.l;
CO2eSti('0','CO2e_Kvaeg') = CO2e_Kvaeg.l;
CO2eSti('0','CO2e_Svin') = CO2e_Svin.l;
CO2eSti('0','CO2e_Fjerkraemv') = CO2e_Fjerkraemv.l;
CO2eSti('0','CO2En_Vej_virk') = CO2En_Vej_virk.l;
CO2eSti('0','CO2En_Vej_hh') = CO2En_Vej_hh.l;
CO2eSti('0','CO2En_hh') = CO2En_hh.l;
CO2eSti('0','CO2En_SeOff') = CO2En_SeOff.l;
CO2eSti('0','CO2En_Fora') = CO2En_Fora.l;
CO2eSti('0','CO2En_Lmv') = CO2En_Lmv.l;
CO2eSti('0','CO2En_Luft') = CO2En_Luft.l;
CO2eSti('0','CO2En_Jernb') = CO2En_Jernb.l;
CO2eSti('0','CO2En_Soe') = CO2En_Soe.l;
CO2eSti('0','CO2_Other') = CO2_Other.l;
CO2eSti('0','N2O_Other') = N2O_Other.l;
CO2eSti('0','CH4_Other') = CH4_Other.l;
CO2eSti('0','Flour') = sum(j,Flour_J.l(j));
CO2eSti('0','CO2eDK') = CO2eDK.l;

MACdata('0','CO2eTax') = CO2eTax.l;
MACdata('0','CO2e') = CO2eDK.l;
MACdata('0','CO2eReduk') = 100-(CO2eDK.l+LULUCF2030)/CO2e_inklLULUCF_1990*100;
MACdata('0','Negaudled') = SUM((part,j_CCS), Negaudled.l(part,j_CCS));
MACdata('0','NetInd') = Nettoindkomst.l;
MACdata('0','DisN') = DisNytte.l;
MACdata('0','PCH') = PCH.l('c');
MACdata('0','EVAir') = EVAirtot.l;
MACdata('0','EVNudled') = EVNudled.l;


konstantKraft('50000a') = konstantKraft('50000a')*0.4;
konstantReno('50000a')  = konstantReno('50000a')*0.4;

preandelKEel(j) = KEel.l(j)/(KEel.l(j)+KEfo.l(j));
preandelKBpart(part,j) $ j_landxCCS(j) = sum(part1_50,KBpart.l(part1_50,j))/sum(part_a,KBpart.l(part_a,j));
preKBpart(part,j) = KBpart.l(part,j);