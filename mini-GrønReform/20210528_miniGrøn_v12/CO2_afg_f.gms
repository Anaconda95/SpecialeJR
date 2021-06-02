*Vegetabilsk landbrug holdes fast via åben markup
Y.fx('01000a')      $ (%LAND% EQ 1) = Y.l('01000a'); 
markup.lo('01000a') $ (%LAND% EQ 1) = -inf;
markup.up('01000a') $ (%LAND% EQ 1) =  inf;

*Fiskeri holdes fast via åben markup
Y.fx('030000')      $ (%FISK% EQ 1) = Y.l('030000'); 
markup.lo('030000') $ (%FISK% EQ 1) = -inf;
markup.up('030000') $ (%FISK% EQ 1) =  inf;



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

konstantKraft('50000a') = konstantKraft('50000a')*0.4;
konstantReno('50000a')  = konstantReno('50000a')*0.4;

$ontext
parameter CO2e_regnskab;
CO2e_regnskab('pre',j,'CO2_energi') = sum(CO2e_udled $ mapj_2_CO2e_udled(j,CO2e_udled), CO2e.l(CO2e_udled,'CO2')-CO2e.l(CO2e_udled,'CO2rest'));
CO2e_regnskab('pre',j,'CO2_BogD') = sum(CO2e_udled $ mapj_2_CO2e_udled(j,CO2e_udled), CO2e.l(CO2e_udled,'BogD'));
CO2e_regnskab('pre',j,'CO2_rest') = sum(CO2e_udled $ mapj_2_CO2e_udled(j,CO2e_udled), CO2e.l(CO2e_udled,'CO2rest'));
CO2e_regnskab('pre',j,'CO2e_Other') = sum(CO2e_udled $ mapj_2_CO2e_udled(j,CO2e_udled), CO2e.l(CO2e_udled,'CO2e_Lattergas')+CO2e.l(CO2e_udled,'CO2e_methan')+CO2e.l(CO2e_udled,'CO2e_flour'));
CO2e_regnskab('pre',j,'CO2_tot') = sum(CO2e_udled $ mapj_2_CO2e_udled(j,CO2e_udled), CO2e.l(CO2e_udled,'tot')-CO2e.l(CO2e_udled,'LULUCF'));
$offtext

*Den eksisterende CO2-afgift fjernes

set loopstep3 /1*3/;

loop(loopstep3,

tDuty_xD.fx(j,i,'tax11')   = 0.8*tDuty_xD.l(j,i,'tax11')  ;
tDuty_xF.fx(j,i,'tax11')   = 0.8*tDuty_xF.l(j,i,'tax11')  ;
tDuty_IBD.fx(j,i,'tax11')  = 0.8*tDuty_IBD.l(j,i,'tax11') ; 
tDuty_IMD.fx(j,i,'tax11')  = 0.8*tDuty_IMD.l(j,i,'tax11') ; 
tDuty_IBF.fx(j,i,'tax11')  = 0.8*tDuty_IBF.l(j,i,'tax11') ; 
tDuty_IMF.fx(j,i,'tax11')  = 0.8*tDuty_IMF.l(j,i,'tax11') ; 
tDuty_cD.fx(i,'tax11')     = 0.8*tDuty_cD.l(i,'tax11')    ; 
tDuty_cF.fx(i,'tax11')     = 0.8*tDuty_cF.l(i,'tax11')    ; 
tDuty_ExD.fx(i,'tax11')    = 0.8*tDuty_ExD.l(i,'tax11')   ; 
tDuty_ExF.fx(i,'tax11')    = 0.8*tDuty_ExF.l(i,'tax11')   ; 
tDuty_ILD.fx(i,'tax11')    = 0.8*tDuty_ILD.l(i,'tax11')   ; 
tDuty_ILF.fx(i,'tax11')    = 0.8*tDuty_ILF.l(i,'tax11')   ; 
tDuty_GD.fx(i,'tax11')     = 0.8*tDuty_GD.l(i,'tax11')    ; 
tDuty_GF.fx(i,'tax11')     = 0.8*tDuty_GF.l(i,'tax11')    ; 

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

*Der indføres en ensartet CO2-afgift (afgiften er allerede større end nul pga. kvoteprisen - der ses på ændringen i forhold til denne)

*For alle øvrige drivhusgasser sættes beskatningen til nul
set udled_typexCO2(udled_type) /
*co2
so2
nox
co
NH3
N2O
CH4
NMVOC
PM10
PM2_5
TSP
BC
SF6
PFC
HFC
/
;

CO2eTax_dummyE(j,kilder,udled_typexCO2) = 0;
CO2eTax_dummyIE(j,udled_typexCO2)= 0;

*display CO2eTax_dummyIE;

*Først hæves afgiften i ikke-kvotesektoren til samme niveau som kvoteprisen
Parameter CO2_2030temp;

CO2_2030temp(j) =  sum(kilder,Eudled.l(j,kilder,'CO2')) + Ieudled.l(j,'CO2');

d1kildertaxHH('BogD') = 0.75;
d1kildertaxHH('Olie') = 0.75;
d1kildertaxHH('NatGas') = 0.75;
CO2eTax_dummyE(j,kilder,'CO2') = CO2eTax_dummyE(j,kilder,'CO2')+0.5*(1 - CO2eTax_dummyE(j,kilder,'CO2'));
CO2eTax_dummyIE(j,'CO2')= CO2eTax_dummyIE(j,'CO2')+0.5*(1 - CO2eTax_dummyIE(j,'CO2'));
CO2eTax_dummyE('490030b','BogD','CO2') = 0;
CO2eTax_dummyE('50000b','BogD','CO2') = 0;
CO2eTax_dummyE('51000b','BogD','CO2') = 0;

display CO2eTax_dummyE;


solve static_fremskriv using cns;

d1kildertaxHH('BogD') = 1.25;
d1kildertaxHH('Olie') = 1.25;
d1kildertaxHH('NatGas') = 1.25;
CO2eTax_dummyE(j,kilder,'CO2') = 1;
CO2eTax_dummyIE(j,'CO2')= 1;
CO2eTax_dummyE(j,kilder,'CO2') = 1 - kvotepris_2016*kvoteandel_2016(j)/CO2eTax.l;
CO2eTax_dummyIE(j,'CO2') = 1 - kvotepris_2016*kvoteandel_2016(j)/CO2eTax.l;
CO2eTax_dummyE('490030b','BogD','CO2') = 0;
CO2eTax_dummyE('50000b','BogD','CO2') = 0;
CO2eTax_dummyE('51000b','BogD','CO2') = 0;

solve static_fremskriv using cns;

*Opdatering af andel af CO2-udledninger i branche j, der er kvoteomfattet: Alle ændringer i udledninger antages at finde sted i ikke-kvotesektoren
Parameter kvoteandel_2030;

kvoteandel_2030(j)$(kvoteandel_2030basis(j)>0 and kvoteandel_2030basis(j)<1) = kvoteandel_2030basis(j)*CO2_2030temp(j) / (sum(kilder,Eudled.l(j,kilder,'CO2')) + Ieudled.l(j,'CO2'));
kvoteandel_2030(j)$(kvoteandel_2030basis(j)>0.999) = 1;
kvoteandel_2030(j)$(kvoteandel_2030(j)<0) = 0;
kvoteandel_2030(j)$(kvoteandel_2030(j)>1) = 1;

Display kvoteandel_2030basis, kvoteandel_2030;