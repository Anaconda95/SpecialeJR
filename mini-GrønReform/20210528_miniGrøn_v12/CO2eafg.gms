LUMPSUM.fx $ (%LUK% EQ 1) = LUMPSUM.l;
t_w.lo $ (%LUK% EQ 1) = -inf;
t_w.up $ (%LUK% EQ 1) =  inf;
t_w.fx $ (%LUK% EQ 0) = t_w.l;
LUMPSUM.lo $ (%LUK% EQ 0) = -inf;
LUMPSUM.up $ (%LUK% EQ 0) =  inf;



parameter MACdata,MACdata2,MACdata3;

MACdata('basis2030','CO2eTax') = CO2eTax.l;
MACdata('basis2030','CO2e') = CO2eDK.l;
MACdata('basis2030','Negaudled') = SUM((part,j_CCS), Negaudled.l(part,j_CCS)) + 0.000001;
MACdata('basis2030','NetInd') = Nettoindkomst.l;
MACdata('basis2030','DisN') = DisNytte.l;
MACdata('basis2030','PCH') = PCH.l('c');
MACdata('basis2030','EVAir') = EVAirtot.l;
MACdata('basis2030','EVNudled') = EVNudled.l;


parameter CO2emaal2030, CO2e_inklLULUCF_1990, LULUCF2016, LULUCF2030, LULUCF2050;
CO2e_inklLULUCF_1990 = 77236;

LULUCF2016 = 6166;
LULUCF2030 = 5287;
LULUCF2050 = 4492;

CO2emaal2030 = (1-0.7)*CO2e_inklLULUCF_1990 - LULUCF2030;

$ontext
parameter CO2e_regnskab;
CO2e_regnskab('pre',j,'CO2_energi') = sum(CO2e_udled $ mapj_2_CO2e_udled(j,CO2e_udled), CO2e.l(CO2e_udled,'CO2')-CO2e.l(CO2e_udled,'CO2rest'));
CO2e_regnskab('pre',j,'CO2_BogD') = sum(CO2e_udled $ mapj_2_CO2e_udled(j,CO2e_udled), CO2e.l(CO2e_udled,'BogD'));
CO2e_regnskab('pre',j,'CO2_rest') = sum(CO2e_udled $ mapj_2_CO2e_udled(j,CO2e_udled), CO2e.l(CO2e_udled,'CO2rest'));
CO2e_regnskab('pre',j,'CO2e_Other') = sum(CO2e_udled $ mapj_2_CO2e_udled(j,CO2e_udled), CO2e.l(CO2e_udled,'CO2e_Lattergas')+CO2e.l(CO2e_udled,'CO2e_methan')+CO2e.l(CO2e_udled,'CO2e_flour'));
CO2e_regnskab('pre',j,'CO2_tot') = sum(CO2e_udled $ mapj_2_CO2e_udled(j,CO2e_udled), CO2e.l(CO2e_udled,'tot')-CO2e.l(CO2e_udled,'LULUCF'));
$offtext

*Den eksisterende CO2-afgift fjernes

set loopstep3 /1*6/;
loop(loopstep3,

tDuty_xD.fx(j,i,'tax11')   = 0.9*tDuty_xD.l(j,i,'tax11')  ;
tDuty_xF.fx(j,i,'tax11')   = 0.9*tDuty_xF.l(j,i,'tax11')  ;
tDuty_IBD.fx(j,i,'tax11')  = 0.9*tDuty_IBD.l(j,i,'tax11') ; 
tDuty_IMD.fx(j,i,'tax11')  = 0.9*tDuty_IMD.l(j,i,'tax11') ; 
tDuty_IBF.fx(j,i,'tax11')  = 0.9*tDuty_IBF.l(j,i,'tax11') ; 
tDuty_IMF.fx(j,i,'tax11')  = 0.9*tDuty_IMF.l(j,i,'tax11') ; 
tDuty_cD.fx(i,'tax11')     = 0.9*tDuty_cD.l(i,'tax11')    ; 
tDuty_cF.fx(i,'tax11')     = 0.9*tDuty_cF.l(i,'tax11')    ; 
tDuty_ExD.fx(i,'tax11')    = 0.9*tDuty_ExD.l(i,'tax11')   ; 
tDuty_ExF.fx(i,'tax11')    = 0.9*tDuty_ExF.l(i,'tax11')   ; 
tDuty_ILD.fx(i,'tax11')    = 0.9*tDuty_ILD.l(i,'tax11')   ; 
tDuty_ILF.fx(i,'tax11')    = 0.9*tDuty_ILF.l(i,'tax11')   ; 
tDuty_GD.fx(i,'tax11')     = 0.9*tDuty_GD.l(i,'tax11')    ; 
tDuty_GF.fx(i,'tax11')     = 0.9*tDuty_GF.l(i,'tax11')    ; 

solve static_fremskriv using cns;


);

tDuty_xD.fx(j,i,'tax11')   = 0;
tDuty_xF.fx(j,i,'tax11')   = 0;
tDuty_IBD.fx(j,i,'tax11')  = 0; 
tDuty_IMD.fx(j,i,'tax11')  = 0; 
tDuty_IBF.fx(j,i,'tax11')  = 0; 
tDuty_IMF.fx(j,i,'tax11')  = 0; 
tDuty_cD.fx(i,'tax11')     = 0; 
tDuty_cF.fx(i,'tax11')     = 0; 
tDuty_ExD.fx(i,'tax11')    = 0; 
tDuty_ExF.fx(i,'tax11')    = 0; 
tDuty_ILD.fx(i,'tax11')    = 0; 
tDuty_ILF.fx(i,'tax11')    = 0; 
tDuty_GD.fx(i,'tax11')     = 0; 
tDuty_GF.fx(i,'tax11')     = 0; 

solve static_fremskriv using cns;


*Der indføres en ensartet CO2e-afgift (afgiften er allerede større end nul pga. kvoteprisen - der ses på ændringen i forhold til denne)
* Dette gøres ved at CO2eTax_dummyE og CO2eTax_dummyIE gravist sættes til (eller tæt på) 1. Dermed bliver co2e-afgiften lig kvoteprisen. 
* For kvotebrancher bliver afgiften korrigeret lidt ned for at tage højde for co2-kvoterne der allerede betales i 2016.
* International transport (490030b, 50000b og 51000b), er ikke omfattet af en dansk co2e-afgift.

* Cementaftalen udfases implicit, når CO2eTax_dummyE og CO2eTax_dummyIE  sættes tæt på 1 i cementindustrien.

Parameter CO2_2030temp;

CO2_2030temp(j) =  sum(kilder,Eudled.l(j,kilder,'CO2')) + Ieudled.l(j,'CO2');

d1kildertaxHH('BogD') = 0.2;
d1kildertaxHH('Olie') = 0.2;
d1kildertaxHH('NatGas') = 0.2;
CO2eTax_dummyE(j,kilder,udled_type) = CO2eTax_dummyE(j,kilder,udled_type)+0.2*(1 - CO2eTax_dummyE(j,kilder,udled_type));
CO2eTax_dummyIE(j,udled_type)= CO2eTax_dummyIE(j,udled_type)+0.2*(1 - CO2eTax_dummyIE(j,udled_type));
CO2eTax_dummyE('490030b','BogD',udled_type) = 0;
CO2eTax_dummyE('50000b',kilder,udled_type) = 0;
CO2eTax_dummyE('51000b','BogD',udled_type) = 0;

solve static_fremskriv using cns;

d1kildertaxHH('BogD') = 0.5;
d1kildertaxHH('Olie') = 0.5;
d1kildertaxHH('NatGas') = 0.5;
CO2eTax_dummyE(j,kilder,udled_type) = CO2eTax_dummyE(j,kilder,udled_type)+0.5*(1 - CO2eTax_dummyE(j,kilder,udled_type));
CO2eTax_dummyIE(j,udled_type)= CO2eTax_dummyIE(j,udled_type)+0.5*(1 - CO2eTax_dummyIE(j,udled_type));
CO2eTax_dummyE('490030b','BogD',udled_type) = 0;
CO2eTax_dummyE('50000b',kilder,udled_type) = 0;
CO2eTax_dummyE('51000b','BogD',udled_type) = 0;

solve static_fremskriv using cns;

d1kildertaxHH('BogD') = 0.75;
d1kildertaxHH('Olie') = 0.75;
d1kildertaxHH('NatGas') = 0.75;
CO2eTax_dummyE(j,kilder,udled_type) = CO2eTax_dummyE(j,kilder,udled_type)+0.75*(1 - CO2eTax_dummyE(j,kilder,udled_type));
CO2eTax_dummyIE(j,udled_type)= CO2eTax_dummyIE(j,udled_type)+0.5*(1 - CO2eTax_dummyIE(j,udled_type));
CO2eTax_dummyE('490030b','BogD',udled_type) = 0;
CO2eTax_dummyE('50000b',kilder,udled_type) = 0;
CO2eTax_dummyE('51000b','BogD',udled_type) = 0;

solve static_fremskriv using cns;

d1kildertaxHH('BogD') = 1.25;
d1kildertaxHH('Olie') = 1.25;
d1kildertaxHH('NatGas') = 1.25;
CO2eTax_dummyE(j,kilder,udled_type) = 1;
CO2eTax_dummyIE(j,udled_type)= 1;
CO2eTax_dummyE(j,kilder,'CO2') = 1 - kvotepris_2016*kvoteandel_2016(j)/CO2eTax.l;
CO2eTax_dummyIE(j,'CO2') = 1 - kvotepris_2016*kvoteandel_2016(j)/CO2eTax.l;
CO2eTax_dummyE('490030b','BogD',udled_type) = 0;
CO2eTax_dummyE('50000b',kilder,udled_type) = 0;
CO2eTax_dummyE('51000b','BogD',udled_type) = 0;

solve static_fremskriv using cns;

*Opdatering af andel af CO2-udledninger i branche j, der er kvoteomfattet: Alle ændringer i udledninger antages at finde sted i ikke-kvotesektoren
Parameter kvoteandel_2030;

kvoteandel_2030(j)$(kvoteandel_2030basis(j)>0 and kvoteandel_2030basis(j)<1) = kvoteandel_2030basis(j)*CO2_2030temp(j) / (sum(kilder,Eudled.l(j,kilder,'CO2')) + Ieudled.l(j,'CO2'));
kvoteandel_2030(j)$(kvoteandel_2030basis(j)>0.999) = 1;
kvoteandel_2030(j)$(kvoteandel_2030(j)<0) = 0;
kvoteandel_2030(j)$(kvoteandel_2030(j)>1) = 1;

*Kvoteandelen i cementindustrien holdes konstant
kvoteandel_2030('230020') = kvoteandel_2030basis('230020'); 

Display kvoteandel_2030basis, kvoteandel_2030;