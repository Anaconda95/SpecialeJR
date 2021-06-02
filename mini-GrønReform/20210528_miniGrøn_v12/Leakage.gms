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

CO2eTax_dummyE('01000a',kilder,udled_type) = CO2eTax_dummyE('01000a',kilder,udled_type) + 100/CO2eTax.l;
CO2eTax_dummyIE('01000a',udled_type)= CO2eTax_dummyIE('01000a',udled_type) + 100/CO2eTax.l;

solve static_fremskriv using cns;

Leakagedata('Vegetabilsk','CO2eDK') = CO2eDK.l;
Leakagedata('Vegetabilsk','Kvoter') = SUM(j, kvoteandel_2030basis(j)*(sum(kilder,Eudled.l(j,kilder,'CO2')) + Ieudled.l(j,'CO2')));
Leakagedata2('Vegetabilsk','Eksport',j) = Eksport.l(j);
Leakagedata2('Vegetabilsk','Import',j) = Import.l(j);

CO2eTax_dummyE('01000a',kilder,udled_type) = CO2eTax_dummyE('01000a',kilder,udled_type) - 100/CO2eTax.l;
CO2eTax_dummyIE('01000a',udled_type)= CO2eTax_dummyIE('01000a',udled_type) - 100/CO2eTax.l;

solve static_fremskriv using cns;

*Oksekød og råmælk

CO2eTax_dummyE('01000b',kilder,udled_type) = CO2eTax_dummyE('01000b',kilder,udled_type) + 100/CO2eTax.l;
CO2eTax_dummyIE('01000b',udled_type)= CO2eTax_dummyIE('01000b',udled_type) + 100/CO2eTax.l;

solve static_fremskriv using cns;

Leakagedata('Kvaeg','CO2eDK') = CO2eDK.l;
Leakagedata('Kvaeg','Kvoter') = SUM(j, kvoteandel_2030basis(j)*(sum(kilder,Eudled.l(j,kilder,'CO2')) + Ieudled.l(j,'CO2')));
Leakagedata2('Kvaeg','Eksport',j) = Eksport.l(j);
Leakagedata2('Kvaeg','Import',j) = Import.l(j);

CO2eTax_dummyE('01000b',kilder,udled_type) = CO2eTax_dummyE('01000b',kilder,udled_type) - 100/CO2eTax.l;
CO2eTax_dummyIE('01000b',udled_type)= CO2eTax_dummyIE('01000b',udled_type) - 100/CO2eTax.l;

solve static_fremskriv using cns;

*Svin

CO2eTax_dummyE('01000c',kilder,udled_type) = CO2eTax_dummyE('01000c',kilder,udled_type) + 100/CO2eTax.l;
CO2eTax_dummyIE('01000c',udled_type)= CO2eTax_dummyIE('01000c',udled_type) + 100/CO2eTax.l;

solve static_fremskriv using cns;

Leakagedata('Svin','CO2eDK') = CO2eDK.l;
Leakagedata('Svin','Kvoter') = SUM(j, kvoteandel_2030basis(j)*(sum(kilder,Eudled.l(j,kilder,'CO2')) + Ieudled.l(j,'CO2')));
Leakagedata2('Svin','Eksport',j) = Eksport.l(j);
Leakagedata2('Svin','Import',j) = Import.l(j);

CO2eTax_dummyE('01000c',kilder,udled_type) = CO2eTax_dummyE('01000c',kilder,udled_type) - 100/CO2eTax.l;
CO2eTax_dummyIE('01000c',udled_type)= CO2eTax_dummyIE('01000c',udled_type) - 100/CO2eTax.l;

solve static_fremskriv using cns;

*Fjerkræ mm

CO2eTax_dummyE('01000d',kilder,udled_type) = CO2eTax_dummyE('01000d',kilder,udled_type) + 100/CO2eTax.l;
CO2eTax_dummyIE('01000d',udled_type)= CO2eTax_dummyIE('01000d',udled_type) + 100/CO2eTax.l;

solve static_fremskriv using cns;

Leakagedata('Fjerkrae','CO2eDK') = CO2eDK.l;
Leakagedata('Fjerkrae','Kvoter') = SUM(j, kvoteandel_2030basis(j)*(sum(kilder,Eudled.l(j,kilder,'CO2')) + Ieudled.l(j,'CO2')));
Leakagedata2('Fjerkrae','Eksport',j) = Eksport.l(j);
Leakagedata2('Fjerkrae','Import',j) = Import.l(j);

CO2eTax_dummyE('01000d',kilder,udled_type) = CO2eTax_dummyE('01000d',kilder,udled_type) - 100/CO2eTax.l;
CO2eTax_dummyIE('01000d',udled_type)= CO2eTax_dummyIE('01000d',udled_type) - 100/CO2eTax.l;

solve static_fremskriv using cns;


*Raffineret olie

CO2eTax_dummyE('190000a',kilder,udled_type) = CO2eTax_dummyE('190000a',kilder,udled_type) + 100/CO2eTax.l;
CO2eTax_dummyIE('190000a',udled_type)= CO2eTax_dummyIE('190000a',udled_type) + 100/CO2eTax.l;

solve static_fremskriv using cns;

Leakagedata('Olie','CO2eDK') = CO2eDK.l;
Leakagedata('Olie','Kvoter') = SUM(j, kvoteandel_2030basis(j)*(sum(kilder,Eudled.l(j,kilder,'CO2')) + Ieudled.l(j,'CO2')));
Leakagedata2('Olie','Eksport',j) = Eksport.l(j);
Leakagedata2('Olie','Import',j) = Import.l(j);

CO2eTax_dummyE('190000a',kilder,udled_type) = CO2eTax_dummyE('190000a',kilder,udled_type) - 100/CO2eTax.l;
CO2eTax_dummyIE('190000a',udled_type)= CO2eTax_dummyIE('190000a',udled_type) - 100/CO2eTax.l;

solve static_fremskriv using cns;

*Kemikalier

CO2eTax_dummyE('200010',kilder,udled_type) = CO2eTax_dummyE('200010',kilder,udled_type) + 100/CO2eTax.l;
CO2eTax_dummyIE('200010',udled_type)= CO2eTax_dummyIE('200010',udled_type) + 100/CO2eTax.l;
CO2eTax_dummyE('200020',kilder,udled_type) = CO2eTax_dummyE('200020',kilder,udled_type) + 100/CO2eTax.l;
CO2eTax_dummyIE('200020',udled_type)= CO2eTax_dummyIE('200020',udled_type) + 100/CO2eTax.l;

solve static_fremskriv using cns;

Leakagedata('Kemikalier','CO2eDK') = CO2eDK.l;
Leakagedata('Kemikalier','Kvoter') = SUM(j, kvoteandel_2030basis(j)*(sum(kilder,Eudled.l(j,kilder,'CO2')) + Ieudled.l(j,'CO2')));
Leakagedata2('Kemikalier','Eksport',j) = Eksport.l(j);
Leakagedata2('Kemikalier','Import',j) = Import.l(j);

CO2eTax_dummyE('200010',kilder,udled_type) = CO2eTax_dummyE('200020',kilder,udled_type) - 100/CO2eTax.l;
CO2eTax_dummyIE('200010',udled_type)= CO2eTax_dummyIE('200020',udled_type) - 100/CO2eTax.l;
CO2eTax_dummyE('200020',kilder,udled_type) = CO2eTax_dummyE('200020',kilder,udled_type) - 100/CO2eTax.l;
CO2eTax_dummyIE('200020',udled_type)= CO2eTax_dummyIE('200020',udled_type) - 100/CO2eTax.l;

solve static_fremskriv using cns;

*Cement

CO2eTax_dummyE('230020',kilder,udled_type) = CO2eTax_dummyE('230020',kilder,udled_type) + 100/CO2eTax.l;
CO2eTax_dummyIE('230020',udled_type)= CO2eTax_dummyIE('230020',udled_type) + 100/CO2eTax.l;

solve static_fremskriv using cns;

Leakagedata('Cement','CO2eDK') = CO2eDK.l;
Leakagedata('Cement','Kvoter') = SUM(j, kvoteandel_2030basis(j)*(sum(kilder,Eudled.l(j,kilder,'CO2')) + Ieudled.l(j,'CO2')));
Leakagedata2('Cement','Eksport',j) = Eksport.l(j);
Leakagedata2('Cement','Import',j) = Import.l(j);

CO2eTax_dummyE('230020',kilder,udled_type) = CO2eTax_dummyE('230020',kilder,udled_type) - 100/CO2eTax.l;
CO2eTax_dummyIE('230020',udled_type)= CO2eTax_dummyIE('230020',udled_type) - 100/CO2eTax.l;

solve static_fremskriv using cns;

*Metal

CO2eTax_dummyE('240000',kilder,udled_type) = CO2eTax_dummyE('240000',kilder,udled_type) + 100/CO2eTax.l;
CO2eTax_dummyIE('240000',udled_type)= CO2eTax_dummyIE('240000',udled_type) + 100/CO2eTax.l;

solve static_fremskriv using cns;

Leakagedata('Metal','CO2eDK') = CO2eDK.l;
Leakagedata('Metal','Kvoter') = SUM(j, kvoteandel_2030basis(j)*(sum(kilder,Eudled.l(j,kilder,'CO2')) + Ieudled.l(j,'CO2')));
Leakagedata2('Metal','Eksport',j) = Eksport.l(j);
Leakagedata2('Metal','Import',j) = Import.l(j);

CO2eTax_dummyE('240000',kilder,udled_type) = CO2eTax_dummyE('240000',kilder,udled_type) - 100/CO2eTax.l;
CO2eTax_dummyIE('240000',udled_type)= CO2eTax_dummyIE('240000',udled_type) - 100/CO2eTax.l;

solve static_fremskriv using cns;

*Elektricitet

CO2eTax_dummyE('350010a',kilder,udled_type) = CO2eTax_dummyE('350010a',kilder,udled_type) + 100/CO2eTax.l;
CO2eTax_dummyIE('350010a',udled_type)= CO2eTax_dummyIE('350010a',udled_type) + 100/CO2eTax.l;

solve static_fremskriv using cns;

Leakagedata('El','CO2eDK') = CO2eDK.l;
Leakagedata('El','Kvoter') = SUM(j, kvoteandel_2030basis(j)*(sum(kilder,Eudled.l(j,kilder,'CO2')) + Ieudled.l(j,'CO2')));
Leakagedata2('El','Eksport',j) = Eksport.l(j);
Leakagedata2('El','Import',j) = Import.l(j);

CO2eTax_dummyE('350010a',kilder,udled_type) = CO2eTax_dummyE('350010a',kilder,udled_type) - 100/CO2eTax.l;
CO2eTax_dummyIE('350010a',udled_type)= CO2eTax_dummyIE('350010a',udled_type) - 100/CO2eTax.l;

solve static_fremskriv using cns;

*Anden industri

CO2eTax_dummyE('Industri',kilder,udled_type) = CO2eTax_dummyE('Industri',kilder,udled_type) + 100/CO2eTax.l;
CO2eTax_dummyIE('Industri',udled_type)= CO2eTax_dummyIE('Industri',udled_type) + 100/CO2eTax.l;

solve static_fremskriv using cns;

Leakagedata('Industri','CO2eDK') = CO2eDK.l;
Leakagedata('Industri','Kvoter') = SUM(j, kvoteandel_2030basis(j)*(sum(kilder,Eudled.l(j,kilder,'CO2')) + Ieudled.l(j,'CO2')));
Leakagedata2('Industri','Eksport',j) = Eksport.l(j);
Leakagedata2('Industri','Import',j) = Import.l(j);

CO2eTax_dummyE('Industri',kilder,udled_type) = CO2eTax_dummyE('Industri',kilder,udled_type) - 100/CO2eTax.l;
CO2eTax_dummyIE('Industri',udled_type)= CO2eTax_dummyIE('Industri',udled_type) - 100/CO2eTax.l;

solve static_fremskriv using cns;

*Private tjenester

CO2eTax_dummyE('Tjenester',kilder,udled_type) = CO2eTax_dummyE('Tjenester',kilder,udled_type) + 100/CO2eTax.l;
CO2eTax_dummyIE('Tjenester',udled_type)= CO2eTax_dummyIE('Tjenester',udled_type) + 100/CO2eTax.l;

solve static_fremskriv using cns;

Leakagedata('Tjenester','CO2eDK') = CO2eDK.l;
Leakagedata('Tjenester','Kvoter') = SUM(j, kvoteandel_2030basis(j)*(sum(kilder,Eudled.l(j,kilder,'CO2')) + Ieudled.l(j,'CO2')));
Leakagedata2('Tjenester','Eksport',j) = Eksport.l(j);
Leakagedata2('Tjenester','Import',j) = Import.l(j);

CO2eTax_dummyE('Tjenester',kilder,udled_type) = CO2eTax_dummyE('Tjenester',kilder,udled_type) - 100/CO2eTax.l;
CO2eTax_dummyIE('Tjenester',udled_type)= CO2eTax_dummyIE('Tjenester',udled_type) - 100/CO2eTax.l;

solve static_fremskriv using cns;

*Landbrug

CO2eTax_dummyE('01000a',kilder,udled_type) = CO2eTax_dummyE('01000a',kilder,udled_type) + 100/CO2eTax.l;
CO2eTax_dummyIE('01000a',udled_type)= CO2eTax_dummyIE('01000a',udled_type) + 100/CO2eTax.l;
CO2eTax_dummyE(j_anim,kilder,udled_type) = CO2eTax_dummyE(j_anim,kilder,udled_type) + 100/CO2eTax.l;
CO2eTax_dummyIE(j_anim,udled_type)= CO2eTax_dummyIE(j_anim,udled_type) + 100/CO2eTax.l;

solve static_fremskriv using cns;

Leakagedata('Landbrug','CO2eDK') = CO2eDK.l;
Leakagedata('Landbrug','Kvoter') = SUM(j, kvoteandel_2030basis(j)*(sum(kilder,Eudled.l(j,kilder,'CO2')) + Ieudled.l(j,'CO2')));
Leakagedata2('Landbrug','Eksport',j) = Eksport.l(j);
Leakagedata2('Landbrug','Import',j) = Import.l(j);

CO2eTax_dummyE('01000a',kilder,udled_type) = CO2eTax_dummyE('01000a',kilder,udled_type) - 100/CO2eTax.l;
CO2eTax_dummyIE('01000a',udled_type)= CO2eTax_dummyIE('01000a',udled_type) - 100/CO2eTax.l;
CO2eTax_dummyE(j_anim,kilder,udled_type) = CO2eTax_dummyE(j_anim,kilder,udled_type) - 100/CO2eTax.l;
CO2eTax_dummyIE(j_anim,udled_type)= CO2eTax_dummyIE(j_anim,udled_type) - 100/CO2eTax.l;

solve static_fremskriv using cns;

execute_unload "gekko\gdx_work\%filnavn%.gdx";