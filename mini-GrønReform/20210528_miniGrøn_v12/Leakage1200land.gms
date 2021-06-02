LUMPSUM.fx $ (%LUK% EQ 1) = LUMPSUM.l;
t_w.lo $ (%LUK% EQ 1) = -inf;
t_w.up $ (%LUK% EQ 1) =  inf;
t_w.fx $ (%LUK% EQ 0) = t_w.l;
LUMPSUM.lo $ (%LUK% EQ 0) = -inf;
LUMPSUM.up $ (%LUK% EQ 0) =  inf;

parameter Leakagedata,Leakagedata2;

Leakagedata('basis2030','CO2eDK') = CO2eDK.l;
Leakagedata('basis2030','Kvoter') = SUM(j, kvoteandel_2030basis(j)*(sum(kilder,Eudled.l(j,kilder,'CO2')) + Ieudled.l(j,'CO2')));
Leakagedata2('basis2030','Eksport',j) = Eksport.l(j);
Leakagedata2('basis2030','Import',j) = Import.l(j);

*Drivhusgasafgift på 100 kr. per ton CO2e



*Vegetabilske produkter
CO2eTax_dummyE('01000a',kilder,udled_type) = CO2eTax_dummyE('01000a',kilder,udled_type) + 300/CO2eTax.l;
CO2eTax_dummyIE('01000a',udled_type)= CO2eTax_dummyIE('01000a',udled_type) + 300/CO2eTax.l;
*Oksekød og råmælk
CO2eTax_dummyE('01000b',kilder,udled_type) = CO2eTax_dummyE('01000b',kilder,udled_type) + 300/CO2eTax.l;
CO2eTax_dummyIE('01000b',udled_type)= CO2eTax_dummyIE('01000b',udled_type) + 300/CO2eTax.l;
*svin
CO2eTax_dummyE('01000c',kilder,udled_type) = CO2eTax_dummyE('01000c',kilder,udled_type) + 300/CO2eTax.l;
CO2eTax_dummyIE('01000c',udled_type)= CO2eTax_dummyIE('01000c',udled_type) + 300/CO2eTax.l;
*Fjerkræ mm
CO2eTax_dummyE('01000d',kilder,udled_type) = CO2eTax_dummyE('01000d',kilder,udled_type) + 300/CO2eTax.l;
CO2eTax_dummyIE('01000d',udled_type)= CO2eTax_dummyIE('01000d',udled_type) + 300/CO2eTax.l;

solve static_fremskriv using cns;

*Vegetabilske produkter
CO2eTax_dummyE('01000a',kilder,udled_type) = CO2eTax_dummyE('01000a',kilder,udled_type) + 300/CO2eTax.l;
CO2eTax_dummyIE('01000a',udled_type)= CO2eTax_dummyIE('01000a',udled_type) + 300/CO2eTax.l;
*Oksekød og råmælk
CO2eTax_dummyE('01000b',kilder,udled_type) = CO2eTax_dummyE('01000b',kilder,udled_type) + 300/CO2eTax.l;
CO2eTax_dummyIE('01000b',udled_type)= CO2eTax_dummyIE('01000b',udled_type) + 300/CO2eTax.l;
*svin
CO2eTax_dummyE('01000c',kilder,udled_type) = CO2eTax_dummyE('01000c',kilder,udled_type) + 300/CO2eTax.l;
CO2eTax_dummyIE('01000c',udled_type)= CO2eTax_dummyIE('01000c',udled_type) + 300/CO2eTax.l;
*Fjerkræ mm
CO2eTax_dummyE('01000d',kilder,udled_type) = CO2eTax_dummyE('01000d',kilder,udled_type) + 300/CO2eTax.l;
CO2eTax_dummyIE('01000d',udled_type)= CO2eTax_dummyIE('01000d',udled_type) + 300/CO2eTax.l;

solve static_fremskriv using cns;

*Vegetabilske produkter
CO2eTax_dummyE('01000a',kilder,udled_type) = CO2eTax_dummyE('01000a',kilder,udled_type) + 200/CO2eTax.l;
CO2eTax_dummyIE('01000a',udled_type)= CO2eTax_dummyIE('01000a',udled_type) + 200/CO2eTax.l;
*Oksekød og råmælk
CO2eTax_dummyE('01000b',kilder,udled_type) = CO2eTax_dummyE('01000b',kilder,udled_type) + 200/CO2eTax.l;
CO2eTax_dummyIE('01000b',udled_type)= CO2eTax_dummyIE('01000b',udled_type) + 200/CO2eTax.l;
*svin
CO2eTax_dummyE('01000c',kilder,udled_type) = CO2eTax_dummyE('01000c',kilder,udled_type) + 200/CO2eTax.l;
CO2eTax_dummyIE('01000c',udled_type)= CO2eTax_dummyIE('01000c',udled_type) + 200/CO2eTax.l;
*Fjerkræ mm
CO2eTax_dummyE('01000d',kilder,udled_type) = CO2eTax_dummyE('01000d',kilder,udled_type) + 200/CO2eTax.l;
CO2eTax_dummyIE('01000d',udled_type)= CO2eTax_dummyIE('01000d',udled_type) + 200/CO2eTax.l;

solve static_fremskriv using cns;

*Vegetabilske produkter
CO2eTax_dummyE('01000a',kilder,udled_type) = CO2eTax_dummyE('01000a',kilder,udled_type) + 200/CO2eTax.l;
CO2eTax_dummyIE('01000a',udled_type)= CO2eTax_dummyIE('01000a',udled_type) + 200/CO2eTax.l;
*Oksekød og råmælk
CO2eTax_dummyE('01000b',kilder,udled_type) = CO2eTax_dummyE('01000b',kilder,udled_type) + 200/CO2eTax.l;
CO2eTax_dummyIE('01000b',udled_type)= CO2eTax_dummyIE('01000b',udled_type) + 200/CO2eTax.l;
*svin
CO2eTax_dummyE('01000c',kilder,udled_type) = CO2eTax_dummyE('01000c',kilder,udled_type) + 200/CO2eTax.l;
CO2eTax_dummyIE('01000c',udled_type)= CO2eTax_dummyIE('01000c',udled_type) + 200/CO2eTax.l;
*Fjerkræ mm
CO2eTax_dummyE('01000d',kilder,udled_type) = CO2eTax_dummyE('01000d',kilder,udled_type) + 200/CO2eTax.l;
CO2eTax_dummyIE('01000d',udled_type)= CO2eTax_dummyIE('01000d',udled_type) + 200/CO2eTax.l;

solve static_fremskriv using cns;

*Vegetabilske produkter
CO2eTax_dummyE('01000a',kilder,udled_type) = CO2eTax_dummyE('01000a',kilder,udled_type) + 200/CO2eTax.l;
CO2eTax_dummyIE('01000a',udled_type)= CO2eTax_dummyIE('01000a',udled_type) + 200/CO2eTax.l;
*Oksekød og råmælk
CO2eTax_dummyE('01000b',kilder,udled_type) = CO2eTax_dummyE('01000b',kilder,udled_type) + 200/CO2eTax.l;
CO2eTax_dummyIE('01000b',udled_type)= CO2eTax_dummyIE('01000b',udled_type) + 200/CO2eTax.l;
*svin
CO2eTax_dummyE('01000c',kilder,udled_type) = CO2eTax_dummyE('01000c',kilder,udled_type) + 200/CO2eTax.l;
CO2eTax_dummyIE('01000c',udled_type)= CO2eTax_dummyIE('01000c',udled_type) + 200/CO2eTax.l;
*Fjerkræ mm
CO2eTax_dummyE('01000d',kilder,udled_type) = CO2eTax_dummyE('01000d',kilder,udled_type) + 200/CO2eTax.l;
CO2eTax_dummyIE('01000d',udled_type)= CO2eTax_dummyIE('01000d',udled_type) + 200/CO2eTax.l;

solve static_fremskriv using cns;


Leakagedata('Landbrug','CO2eDK') = CO2eDK.l;
Leakagedata('Landbrug','Kvoter') = SUM(j, kvoteandel_2030basis(j)*(sum(kilder,Eudled.l(j,kilder,'CO2')) + Ieudled.l(j,'CO2')));
Leakagedata2('Landbrug','Eksport',j) = Eksport.l(j);
Leakagedata2('Landbrug','Import',j) = Import.l(j);




execute_unload "gekko\gdx_work\%filnavn%.gdx";