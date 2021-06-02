* * * * EU ETS * * * *

* CO2-emissioner hos virksomheder gemmes
Parameter CO2_temp;

CO2_temp(j) =  sum(kilder,Eudled.l(j,kilder,'CO2')) + Ieudled.l(j,'CO2');

* ETS-kvotepris i kr. per ton

*Fra IEA:

*			2018	2030	2050
*Current Policies	126	171	310
*Stated Policies	126	208	335
*Sustainable Development126	632	1137

Parameter kvotepris_2016, kvotepris_2030, kvotepris_2050;

kvotepris_2016 = 36.4;
kvotepris_2030 = 208;
kvotepris_2050 = 335;

*Andel af CO2-udledninger i branche j, der er kvoteomfattet
Parameter kvoteandel_2016, kvoteandel_2030basis;

kvoteandel_2016(j) = 0;

kvoteandel_2016('01000a') = 0.05;
kvoteandel_2016('060000a') = 1.00;
kvoteandel_2016('060000b') = 1.00;
kvoteandel_2016('080090') = 0.38;
kvoteandel_2016('100010a') = 0.43;
kvoteandel_2016('100010b') = 0.43;
kvoteandel_2016('100010c') = 0.43;
kvoteandel_2016('100020') = 0.95;
kvoteandel_2016('100030') = 0.68;
kvoteandel_2016('100040') = 0.16;
kvoteandel_2016('100050') = 0.61;
kvoteandel_2016('11200') = 0.52;
kvoteandel_2016('Industri') = 0.19;
kvoteandel_2016('160000') = 0.24;
kvoteandel_2016('190000a') = 1.00;
kvoteandel_2016('200010') = 0.55;
kvoteandel_2016('200020') = 0.71;
kvoteandel_2016('210000') = 0.02;
kvoteandel_2016('230010') = 0.77;
kvoteandel_2016('230020') = 0.94;
kvoteandel_2016('240000') = 0.80;
kvoteandel_2016('280010') = 0.22;
kvoteandel_2016('350010a') = 0.92;
kvoteandel_2016('350030a') = 1.00;
kvoteandel_2016('383900') = 0.53;
kvoteandel_2016('51000a') = 1.00;
kvoteandel_2016('Tjenester') = 0.01;
kvoteandel_2016('Offentlig') = 0.03;

*Antal gratiskvoter i 1.000 ton

Parameter Gratiskvoter_2016, Gratiskvoter_2030, Gratiskvoter_2050;

Gratiskvoter_2016(j) = 0;

Gratiskvoter_2016('01000a') = 23;
Gratiskvoter_2016('060000a') = 1040;
Gratiskvoter_2016('060000b') = 258;
Gratiskvoter_2016('080090') = 42;
Gratiskvoter_2016('100010a') = 7;
Gratiskvoter_2016('100010b') = 37;
Gratiskvoter_2016('100010c') = 6;
Gratiskvoter_2016('100020') = 91;
Gratiskvoter_2016('100030') = 111;
Gratiskvoter_2016('100050') = 173;
Gratiskvoter_2016('11200') = 42;
Gratiskvoter_2016('Industri') = 39;
Gratiskvoter_2016('160000') = 6;
Gratiskvoter_2016('190000a') = 710;
Gratiskvoter_2016('200010') = 46;
Gratiskvoter_2016('200020') = 113;
Gratiskvoter_2016('210000') = 1;
Gratiskvoter_2016('230010') = 56;
Gratiskvoter_2016('230020') = 2386;
Gratiskvoter_2016('240000') = 80;
Gratiskvoter_2016('280010') = 13;
Gratiskvoter_2016('350010a') = 2873;
Gratiskvoter_2016('350030a') = 466;
Gratiskvoter_2016('383900') = 632;
Gratiskvoter_2016('51000a') = 406;
Gratiskvoter_2016('Offentlig') = 5;

Gratiskvoter_2030('01000a') = 9;
Gratiskvoter_2030('060000a') = 769;
Gratiskvoter_2030('060000b') = 191;
Gratiskvoter_2030('080090') = 31;
Gratiskvoter_2030('100010a') = 3;
Gratiskvoter_2030('100010b') = 14;
Gratiskvoter_2030('100010c') = 0;
Gratiskvoter_2030('100020') = 68;
Gratiskvoter_2030('100030') = 82;
Gratiskvoter_2030('100050') = 128;
Gratiskvoter_2030('11200') = 31;
Gratiskvoter_2030('Industri') = 15;
Gratiskvoter_2030('160000') = 4;
Gratiskvoter_2030('190000a') = 525;
Gratiskvoter_2030('200010') = 34;
Gratiskvoter_2030('200020') = 84;
Gratiskvoter_2030('210000') = 1;
Gratiskvoter_2030('230010') = 42;
Gratiskvoter_2030('230020') = 1764;
Gratiskvoter_2030('240000') = 59;
Gratiskvoter_2030('280010') = 10;
Gratiskvoter_2030('350010a') = 1092;
Gratiskvoter_2030('350030a') = 177;
Gratiskvoter_2030('383900') = 240;
Gratiskvoter_2030('51000a') = 325;
Gratiskvoter_2030('Offentlig') = 2;

Gratiskvoter_2050(j) = (1-0.022)**20 * Gratiskvoter_2030(j);

*Gratiskvoter modelleres som et output-baseret tilskud. Provenuet tilfalder den danske stat, da færre tildelte gratiskvoter medfører flere auktionerede kvoter.
*Bemærk at alene provenuet kan fortolkes - ikke tilskudssatsen

s_Y.fx(j) = (Gratiskvoter_2030(j) * kvotepris_2030 - Gratiskvoter_2016(j) * kvotepris_2016) * 10**(-6) / Y.l(j);

Display s_Y.l;

*Eksporten holdes konstant for at afspejle uændret konkurrenceevne overfor omverdenen, hvilket er en approksimation af virkeligheden
*Bemærk at importen påvirkes, når udlandsprisen tilpasses

Ex.fx(j) = Ex.l(j);

PF.up(j)$Ex.l(j) = inf;
PF.lo(j)$Ex.l(j) = -inf;

solve static_fremskriv using cns;

display p.l, gdp.l, gdpf0.l;

*Stigende kvotepris modelleres som en afgift på CO2-emissioner

CO2eTax_dummyE(j,kilder,'CO2') = kvoteandel_2016(j);
CO2eTax_dummyIE(j,'CO2') = kvoteandel_2016(j);
d1kildertaxHH(kilder) = 0;

CO2eTax.fx = 100;

solve static_fremskriv using cns;

CO2eTax.fx = kvotepris_2030 - kvotepris_2016;

solve static_fremskriv using cns;

Display PF.l;

PF.fx(j) = PF.l(j);

Ex.up(j)$Ex.l(j) = inf;
Ex.lo(j)$Ex.l(j) = -inf;

*Opdatering af andel af CO2-udledninger i branche j, der er kvoteomfattet: Alle ændringer i udledninger antages at finde sted i kvotesektoren

kvoteandel_2030basis(j)$kvoteandel_2016(j) = (kvoteandel_2016(j)*CO2_temp(j) + sum(kilder,Eudled.l(j,kilder,'CO2')) + Ieudled.l(j,'CO2') - CO2_temp(j)) / (sum(kilder,Eudled.l(j,kilder,'CO2')) + Ieudled.l(j,'CO2'));
kvoteandel_2030basis(j)$(kvoteandel_2030basis(j)<0) = 0;
kvoteandel_2030basis(j)$(kvoteandel_2030basis(j)>1) = 1;

Display kvoteandel_2016, kvoteandel_2030basis;

display BoP.l;
execute_unload "gekko\gdx_work\Basis2030_ETS.gdx";

display share_D.l;