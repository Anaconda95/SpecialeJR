LUMPSUM.fx $ (%LUK% EQ 1) = LUMPSUM.l;
t_w.lo $ (%LUK% EQ 1) = -inf;
t_w.up $ (%LUK% EQ 1) =  inf;
t_w.fx $ (%LUK% EQ 0) = t_w.l;
LUMPSUM.lo $ (%LUK% EQ 0) = -inf;
LUMPSUM.up $ (%LUK% EQ 0) =  inf;

*Afgift på al indenlandsk anvendelse svarende til fradraget per outputenhed (den "gamle" CO2-afgift tax11 benyttes)
$ontext
*Teststød for kvægbrancehn
tDuty_xD.fx(j,'01000b','tax11') $ (%anvafgift% EQ 1) = 0.1;
tDuty_xF.fx(j,'01000b','tax11') $ (%anvafgift% EQ 1) = 0.1;
tDuty_IBD.fx(j,'01000b','tax11')$ (%anvafgift% EQ 1) = 0.1;
tDuty_IMD.fx(j,'01000b','tax11')$ (%anvafgift% EQ 1) = 0.1;
tDuty_IBF.fx(j,'01000b','tax11')$ (%anvafgift% EQ 1) = 0.1;
tDuty_IMF.fx(j,'01000b','tax11')$ (%anvafgift% EQ 1) = 0.1;
tDuty_cD.fx('01000b','tax11')   $ (%anvafgift% EQ 1) = 0.1;
tDuty_cF.fx('01000b','tax11')   $ (%anvafgift% EQ 1) = 0.1;
*tDuty_ExD.fx('01000b','tax11') $ (%anvafgift% EQ 1) = 0.1;
*tDuty_ExF.fx('01000b','tax11') $ (%anvafgift% EQ 1) = 0.1;
tDuty_ILD.fx('01000b','tax11')  $ (%anvafgift% EQ 1) = 0.1;
tDuty_ILF.fx('01000b','tax11')  $ (%anvafgift% EQ 1) = 0.1;
tDuty_GD.fx('01000b','tax11')   $ (%anvafgift% EQ 1) = 0.1;
tDuty_GF.fx('01000b','tax11')   $ (%anvafgift% EQ 1) = 0.1;
$offtext

tDuty_xD.fx(j,i,'tax11') $ (%anvafgift% EQ 1) = fradragsandel * leakagerate(i) * (sum((kilder,udled_type), TR_Eudled.l(i,kilder,udled_type)) + sum(udled_type, TR_Ieudled.l(i,udled_type))) / Y.l(i);
tDuty_xF.fx(j,i,'tax11') $ (%anvafgift% EQ 1) = fradragsandel * leakagerate(i) * (sum((kilder,udled_type), TR_Eudled.l(i,kilder,udled_type)) + sum(udled_type, TR_Ieudled.l(i,udled_type))) / Y.l(i);
tDuty_IBD.fx(j,i,'tax11')$ (%anvafgift% EQ 1) = fradragsandel * leakagerate(i) * (sum((kilder,udled_type), TR_Eudled.l(i,kilder,udled_type)) + sum(udled_type, TR_Ieudled.l(i,udled_type))) / Y.l(i);
tDuty_IMD.fx(j,i,'tax11')$ (%anvafgift% EQ 1) = fradragsandel * leakagerate(i) * (sum((kilder,udled_type), TR_Eudled.l(i,kilder,udled_type)) + sum(udled_type, TR_Ieudled.l(i,udled_type))) / Y.l(i);
tDuty_IBF.fx(j,i,'tax11')$ (%anvafgift% EQ 1) = fradragsandel * leakagerate(i) * (sum((kilder,udled_type), TR_Eudled.l(i,kilder,udled_type)) + sum(udled_type, TR_Ieudled.l(i,udled_type))) / Y.l(i);
tDuty_IMF.fx(j,i,'tax11')$ (%anvafgift% EQ 1) = fradragsandel * leakagerate(i) * (sum((kilder,udled_type), TR_Eudled.l(i,kilder,udled_type)) + sum(udled_type, TR_Ieudled.l(i,udled_type))) / Y.l(i);
tDuty_cD.fx(j,'tax11')   $ (%anvafgift% EQ 1) = fradragsandel * leakagerate(j) * (sum((kilder,udled_type), TR_Eudled.l(j,kilder,udled_type)) + sum(udled_type, TR_Ieudled.l(j,udled_type))) / Y.l(j);
tDuty_cF.fx(j,'tax11')   $ (%anvafgift% EQ 1) = fradragsandel * leakagerate(j) * (sum((kilder,udled_type), TR_Eudled.l(j,kilder,udled_type)) + sum(udled_type, TR_Ieudled.l(j,udled_type))) / Y.l(j);
tDuty_ILD.fx(j,'tax11')  $ (%anvafgift% EQ 1) = fradragsandel * leakagerate(j) * (sum((kilder,udled_type), TR_Eudled.l(j,kilder,udled_type)) + sum(udled_type, TR_Ieudled.l(j,udled_type))) / Y.l(j);
tDuty_ILF.fx(j,'tax11')  $ (%anvafgift% EQ 1) = fradragsandel * leakagerate(j) * (sum((kilder,udled_type), TR_Eudled.l(j,kilder,udled_type)) + sum(udled_type, TR_Ieudled.l(j,udled_type))) / Y.l(j);
tDuty_GD.fx(j,'tax11')   $ (%anvafgift% EQ 1) = fradragsandel * leakagerate(j) * (sum((kilder,udled_type), TR_Eudled.l(j,kilder,udled_type)) + sum(udled_type, TR_Ieudled.l(j,udled_type))) / Y.l(j);
tDuty_GF.fx(j,'tax11')   $ (%anvafgift% EQ 1) = fradragsandel * leakagerate(j) * (sum((kilder,udled_type), TR_Eudled.l(j,kilder,udled_type)) + sum(udled_type, TR_Ieudled.l(j,udled_type))) / Y.l(j);


*International skibsfarts import fra olieraffinaderier (bunkering i udlandet) afgiftspålægges ikke
tDuty_xF.fx('50000b','190000a','tax11') $ (%anvafgift% EQ 1) = 0;

*$ontext
* * * * * * Korrektion hos slagterier og mejerier * * * * * * * *

*Slagterier og mejeriers køb fra dansk og udenlandsk landbrug afgiftspålægges ikke

*Slagteriers køb fra kvæg og køb fra sig selv
tDuty_xD.fx('100010a','01000b','tax11') $ (%anvafgift% EQ 1) = 0;
tDuty_xF.fx('100010a','01000b','tax11') $ (%anvafgift% EQ 1) = 0;

*Mejeriers køb fra kvæg og køb fra sig selv
tDuty_xD.fx('100030','01000b','tax11') $ (%anvafgift% EQ 1) = 0;
tDuty_xF.fx('100030','01000b','tax11') $ (%anvafgift% EQ 1) = 0;

*Slagteriers køb fra svin og køb fra sig selv
tDuty_xD.fx('100010b','01000c','tax11') $ (%anvafgift% EQ 1) = 0;
tDuty_xF.fx('100010b','01000c','tax11') $ (%anvafgift% EQ 1) = 0;


*Til gengæld afgiftspålægges indenlandsk anvendelse fra danske og udenlandske slagterier og mejerier med samme sats (hhv. kvæg og svin)
*parameter andel_kvaegSlagt, andel_kvaegMej, andel_svinSlagt;

*Slagterier, kvæg
tDuty_xD.fx(j,'100010a','tax11') $ (%anvafgift% EQ 1) = X.l('100010a','01000b')/Y.l('100010a') * fradragsandel * leakagerate('01000b') * (sum((kilder,udled_type), TR_Eudled.l('01000b',kilder,udled_type)) + sum(udled_type, TR_Ieudled.l('01000b',udled_type))) / Y.l('01000b');
tDuty_xF.fx(j,'100010a','tax11') $ (%anvafgift% EQ 1) = X.l('100010a','01000b')/Y.l('100010a') * fradragsandel * leakagerate('01000b') * (sum((kilder,udled_type), TR_Eudled.l('01000b',kilder,udled_type)) + sum(udled_type, TR_Ieudled.l('01000b',udled_type))) / Y.l('01000b');
tDuty_IBD.fx(j,'100010a','tax11')$ (%anvafgift% EQ 1) = X.l('100010a','01000b')/Y.l('100010a') * fradragsandel * leakagerate('01000b') * (sum((kilder,udled_type), TR_Eudled.l('01000b',kilder,udled_type)) + sum(udled_type, TR_Ieudled.l('01000b',udled_type))) / Y.l('01000b');
tDuty_IMD.fx(j,'100010a','tax11')$ (%anvafgift% EQ 1) = X.l('100010a','01000b')/Y.l('100010a') * fradragsandel * leakagerate('01000b') * (sum((kilder,udled_type), TR_Eudled.l('01000b',kilder,udled_type)) + sum(udled_type, TR_Ieudled.l('01000b',udled_type))) / Y.l('01000b'); 
tDuty_IBF.fx(j,'100010a','tax11')$ (%anvafgift% EQ 1) = X.l('100010a','01000b')/Y.l('100010a') * fradragsandel * leakagerate('01000b') * (sum((kilder,udled_type), TR_Eudled.l('01000b',kilder,udled_type)) + sum(udled_type, TR_Ieudled.l('01000b',udled_type))) / Y.l('01000b');
tDuty_IMF.fx(j,'100010a','tax11')$ (%anvafgift% EQ 1) = X.l('100010a','01000b')/Y.l('100010a') * fradragsandel * leakagerate('01000b') * (sum((kilder,udled_type), TR_Eudled.l('01000b',kilder,udled_type)) + sum(udled_type, TR_Ieudled.l('01000b',udled_type))) / Y.l('01000b');
tDuty_cD.fx('100010a','tax11')   $ (%anvafgift% EQ 1) = X.l('100010a','01000b')/Y.l('100010a') * fradragsandel * leakagerate('01000b') * (sum((kilder,udled_type), TR_Eudled.l('01000b',kilder,udled_type)) + sum(udled_type, TR_Ieudled.l('01000b',udled_type))) / Y.l('01000b'); 
tDuty_cF.fx('100010a','tax11')   $ (%anvafgift% EQ 1) = X.l('100010a','01000b')/Y.l('100010a') * fradragsandel * leakagerate('01000b') * (sum((kilder,udled_type), TR_Eudled.l('01000b',kilder,udled_type)) + sum(udled_type, TR_Ieudled.l('01000b',udled_type))) / Y.l('01000b');
tDuty_ILD.fx('100010a','tax11')  $ (%anvafgift% EQ 1) = X.l('100010a','01000b')/Y.l('100010a') * fradragsandel * leakagerate('01000b') * (sum((kilder,udled_type), TR_Eudled.l('01000b',kilder,udled_type)) + sum(udled_type, TR_Ieudled.l('01000b',udled_type))) / Y.l('01000b');
tDuty_ILF.fx('100010a','tax11')  $ (%anvafgift% EQ 1) = X.l('100010a','01000b')/Y.l('100010a') * fradragsandel * leakagerate('01000b') * (sum((kilder,udled_type), TR_Eudled.l('01000b',kilder,udled_type)) + sum(udled_type, TR_Ieudled.l('01000b',udled_type))) / Y.l('01000b');
tDuty_GD.fx('100010a','tax11')   $ (%anvafgift% EQ 1) = X.l('100010a','01000b')/Y.l('100010a') * fradragsandel * leakagerate('01000b') * (sum((kilder,udled_type), TR_Eudled.l('01000b',kilder,udled_type)) + sum(udled_type, TR_Ieudled.l('01000b',udled_type))) / Y.l('01000b'); 
tDuty_GF.fx('100010a','tax11')   $ (%anvafgift% EQ 1) = X.l('100010a','01000b')/Y.l('100010a') * fradragsandel * leakagerate('01000b') * (sum((kilder,udled_type), TR_Eudled.l('01000b',kilder,udled_type)) + sum(udled_type, TR_Ieudled.l('01000b',udled_type))) / Y.l('01000b');

*Mejerier, kvæg
tDuty_xD.fx(j,'100030','tax11')  $ (%anvafgift% EQ 1) = X.l('100030','01000b')/Y.l('100030') * fradragsandel * leakagerate('01000b') * (sum((kilder,udled_type), TR_Eudled.l('01000b',kilder,udled_type)) + sum(udled_type, TR_Ieudled.l('01000b',udled_type))) / Y.l('01000b');
tDuty_xF.fx(j,'100030','tax11')  $ (%anvafgift% EQ 1) = X.l('100030','01000b')/Y.l('100030') * fradragsandel * leakagerate('01000b') * (sum((kilder,udled_type), TR_Eudled.l('01000b',kilder,udled_type)) + sum(udled_type, TR_Ieudled.l('01000b',udled_type))) / Y.l('01000b');
tDuty_IBD.fx(j,'100030','tax11') $ (%anvafgift% EQ 1) = X.l('100030','01000b')/Y.l('100030') * fradragsandel * leakagerate('01000b') * (sum((kilder,udled_type), TR_Eudled.l('01000b',kilder,udled_type)) + sum(udled_type, TR_Ieudled.l('01000b',udled_type))) / Y.l('01000b'); 
tDuty_IMD.fx(j,'100030','tax11') $ (%anvafgift% EQ 1) = X.l('100030','01000b')/Y.l('100030') * fradragsandel * leakagerate('01000b') * (sum((kilder,udled_type), TR_Eudled.l('01000b',kilder,udled_type)) + sum(udled_type, TR_Ieudled.l('01000b',udled_type))) / Y.l('01000b'); 
tDuty_IBF.fx(j,'100030','tax11') $ (%anvafgift% EQ 1) = X.l('100030','01000b')/Y.l('100030') * fradragsandel * leakagerate('01000b') * (sum((kilder,udled_type), TR_Eudled.l('01000b',kilder,udled_type)) + sum(udled_type, TR_Ieudled.l('01000b',udled_type))) / Y.l('01000b'); 
tDuty_IMF.fx(j,'100030','tax11') $ (%anvafgift% EQ 1) = X.l('100030','01000b')/Y.l('100030') * fradragsandel * leakagerate('01000b') * (sum((kilder,udled_type), TR_Eudled.l('01000b',kilder,udled_type)) + sum(udled_type, TR_Ieudled.l('01000b',udled_type))) / Y.l('01000b'); 
tDuty_cD.fx('100030','tax11')    $ (%anvafgift% EQ 1) = X.l('100030','01000b')/Y.l('100030') * fradragsandel * leakagerate('01000b') * (sum((kilder,udled_type), TR_Eudled.l('01000b',kilder,udled_type)) + sum(udled_type, TR_Ieudled.l('01000b',udled_type))) / Y.l('01000b'); 
tDuty_cF.fx('100030','tax11')    $ (%anvafgift% EQ 1) = X.l('100030','01000b')/Y.l('100030') * fradragsandel * leakagerate('01000b') * (sum((kilder,udled_type), TR_Eudled.l('01000b',kilder,udled_type)) + sum(udled_type, TR_Ieudled.l('01000b',udled_type))) / Y.l('01000b'); 
tDuty_ILD.fx('100030','tax11')   $ (%anvafgift% EQ 1) = X.l('100030','01000b')/Y.l('100030') * fradragsandel * leakagerate('01000b') * (sum((kilder,udled_type), TR_Eudled.l('01000b',kilder,udled_type)) + sum(udled_type, TR_Ieudled.l('01000b',udled_type))) / Y.l('01000b'); 
tDuty_ILF.fx('100030','tax11')   $ (%anvafgift% EQ 1) = X.l('100030','01000b')/Y.l('100030') * fradragsandel * leakagerate('01000b') * (sum((kilder,udled_type), TR_Eudled.l('01000b',kilder,udled_type)) + sum(udled_type, TR_Ieudled.l('01000b',udled_type))) / Y.l('01000b'); 
tDuty_GD.fx('100030','tax11')    $ (%anvafgift% EQ 1) = X.l('100030','01000b')/Y.l('100030') * fradragsandel * leakagerate('01000b') * (sum((kilder,udled_type), TR_Eudled.l('01000b',kilder,udled_type)) + sum(udled_type, TR_Ieudled.l('01000b',udled_type))) / Y.l('01000b'); 
tDuty_GF.fx('100030','tax11')    $ (%anvafgift% EQ 1) = X.l('100030','01000b')/Y.l('100030') * fradragsandel * leakagerate('01000b') * (sum((kilder,udled_type), TR_Eudled.l('01000b',kilder,udled_type)) + sum(udled_type, TR_Ieudled.l('01000b',udled_type))) / Y.l('01000b'); 

*Slagterier, svin
tDuty_xD.fx(j,'100010b','tax11') $ (%anvafgift% EQ 1) = X.l('100010b','01000c')/Y.l('100010b') * fradragsandel * leakagerate('01000c') * (sum((kilder,udled_type), TR_Eudled.l('01000c',kilder,udled_type)) + sum(udled_type, TR_Ieudled.l('01000c',udled_type))) / Y.l('01000c');
tDuty_xF.fx(j,'100010b','tax11') $ (%anvafgift% EQ 1) = X.l('100010b','01000c')/Y.l('100010b') * fradragsandel * leakagerate('01000c') * (sum((kilder,udled_type), TR_Eudled.l('01000c',kilder,udled_type)) + sum(udled_type, TR_Ieudled.l('01000c',udled_type))) / Y.l('01000c');
tDuty_IBD.fx(j,'100010b','tax11')$ (%anvafgift% EQ 1) = X.l('100010b','01000c')/Y.l('100010b') * fradragsandel * leakagerate('01000c') * (sum((kilder,udled_type), TR_Eudled.l('01000c',kilder,udled_type)) + sum(udled_type, TR_Ieudled.l('01000c',udled_type))) / Y.l('01000c'); 
tDuty_IMD.fx(j,'100010b','tax11')$ (%anvafgift% EQ 1) = X.l('100010b','01000c')/Y.l('100010b') * fradragsandel * leakagerate('01000c') * (sum((kilder,udled_type), TR_Eudled.l('01000c',kilder,udled_type)) + sum(udled_type, TR_Ieudled.l('01000c',udled_type))) / Y.l('01000c'); 
tDuty_IBF.fx(j,'100010b','tax11')$ (%anvafgift% EQ 1) = X.l('100010b','01000c')/Y.l('100010b') * fradragsandel * leakagerate('01000c') * (sum((kilder,udled_type), TR_Eudled.l('01000c',kilder,udled_type)) + sum(udled_type, TR_Ieudled.l('01000c',udled_type))) / Y.l('01000c'); 
tDuty_IMF.fx(j,'100010b','tax11')$ (%anvafgift% EQ 1) = X.l('100010b','01000c')/Y.l('100010b') * fradragsandel * leakagerate('01000c') * (sum((kilder,udled_type), TR_Eudled.l('01000c',kilder,udled_type)) + sum(udled_type, TR_Ieudled.l('01000c',udled_type))) / Y.l('01000c'); 
tDuty_cD.fx('100010b','tax11')   $ (%anvafgift% EQ 1) = X.l('100010b','01000c')/Y.l('100010b') * fradragsandel * leakagerate('01000c') * (sum((kilder,udled_type), TR_Eudled.l('01000c',kilder,udled_type)) + sum(udled_type, TR_Ieudled.l('01000c',udled_type))) / Y.l('01000c'); 
tDuty_cF.fx('100010b','tax11')   $ (%anvafgift% EQ 1) = X.l('100010b','01000c')/Y.l('100010b') * fradragsandel * leakagerate('01000c') * (sum((kilder,udled_type), TR_Eudled.l('01000c',kilder,udled_type)) + sum(udled_type, TR_Ieudled.l('01000c',udled_type))) / Y.l('01000c'); 
tDuty_ILD.fx('100010b','tax11')  $ (%anvafgift% EQ 1) = X.l('100010b','01000c')/Y.l('100010b') * fradragsandel * leakagerate('01000c') * (sum((kilder,udled_type), TR_Eudled.l('01000c',kilder,udled_type)) + sum(udled_type, TR_Ieudled.l('01000c',udled_type))) / Y.l('01000c'); 
tDuty_ILF.fx('100010b','tax11')  $ (%anvafgift% EQ 1) = X.l('100010b','01000c')/Y.l('100010b') * fradragsandel * leakagerate('01000c') * (sum((kilder,udled_type), TR_Eudled.l('01000c',kilder,udled_type)) + sum(udled_type, TR_Ieudled.l('01000c',udled_type))) / Y.l('01000c'); 
tDuty_GD.fx('100010b','tax11')   $ (%anvafgift% EQ 1) = X.l('100010b','01000c')/Y.l('100010b') * fradragsandel * leakagerate('01000c') * (sum((kilder,udled_type), TR_Eudled.l('01000c',kilder,udled_type)) + sum(udled_type, TR_Ieudled.l('01000c',udled_type))) / Y.l('01000c'); 
tDuty_GF.fx('100010b','tax11')   $ (%anvafgift% EQ 1) = X.l('100010b','01000c')/Y.l('100010b') * fradragsandel * leakagerate('01000c') * (sum((kilder,udled_type), TR_Eudled.l('01000c',kilder,udled_type)) + sum(udled_type, TR_Ieudled.l('01000c',udled_type))) / Y.l('01000c'); 



tDuty_xD.fx(j,j,'tax11') = 0;
tDuty_xF.fx(j,j,'tax11') = 0;

$ontext
*Ingen anvendelsesafgift på cement
tDuty_xD.fx(j,'230020','tax11') $ (%anvafgift% EQ 1) = 0;
tDuty_xF.fx(j,'230020','tax11') $ (%anvafgift% EQ 1) = 0;
tDuty_IBD.fx(j,'230020','tax11')$ (%anvafgift% EQ 1) = 0;
tDuty_IMD.fx(j,'230020','tax11')$ (%anvafgift% EQ 1) = 0;
tDuty_IBF.fx(j,'230020','tax11')$ (%anvafgift% EQ 1) = 0;
tDuty_IMF.fx(j,'230020','tax11')$ (%anvafgift% EQ 1) = 0;
tDuty_cD.fx('230020','tax11')   $ (%anvafgift% EQ 1) = 0;
tDuty_cF.fx('230020','tax11')   $ (%anvafgift% EQ 1) = 0;
tDuty_ILD.fx('230020','tax11')  $ (%anvafgift% EQ 1) = 0;
tDuty_ILF.fx('230020','tax11')  $ (%anvafgift% EQ 1) = 0;
tDuty_GD.fx('230020','tax11')   $ (%anvafgift% EQ 1) = 0;
tDuty_GF.fx('230020','tax11')   $ (%anvafgift% EQ 1) = 0;


$ontext
$offtext