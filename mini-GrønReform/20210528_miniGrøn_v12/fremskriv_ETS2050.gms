* * * * EU ETS * * * *

* CO2-emissioner hos virksomheder gemmes
CO2_temp(j) =  sum(kilder,Eudled.l(j,kilder,'CO2')) + Ieudled.l(j,'CO2');

*Eksporten holdes konstant for at afspejle uændret konkurrenceevne overfor omverdenen, hvilket er en approksimation af virkeligheden
*Bemærk at importen påvirkes, når udlandsprisen tilpasses

Ex.fx(j) = Ex.l(j);

PF.up(j)$Ex.l(j) = inf;
PF.lo(j)$Ex.l(j) = -inf;

*Gratiskvoter modelleres som et output-baseret tilskud. Provenuet tilfalder den danske stat, da færre tildelte gratiskvoter medfører flere auktionerede kvoter.
*Bemærk at alene provenuet kan fortolkes - ikke tilskudssatsen

Display s_Y.l;

s_Y.fx(j) = s_Y.l(j) + (Gratiskvoter_2050(j) * kvotepris_2050 - Gratiskvoter_2030(j) * kvotepris_2030) * 10**(-6) / Y.l(j);

*Stigende kvotepris modelleres som en afgift på CO2-emissioner

CO2eTax.fx = kvotepris_2050 - kvotepris_2016;

solve static_fremskriv using cns;

Display s_Y.l, CO2eTax.l, PF.l;


*Eksporten låses op igen
PF.fx(j) = PF.l(j);

Ex.up(j)$Ex.l(j) = inf;
Ex.lo(j)$Ex.l(j) = -inf;

*Opdatering af andel af CO2-udledninger i branche j, der er kvoteomfattet: Alle ændringer i udledninger antages at finde sted i kvotesektoren
Parameter kvoteandel_2050basis;

kvoteandel_2050basis(j)$kvoteandel_2030basis(j) = (kvoteandel_2030basis(j)*CO2_temp(j) + sum(kilder,Eudled.l(j,kilder,'CO2')) + Ieudled.l(j,'CO2') - CO2_temp(j)) / (sum(kilder,Eudled.l(j,kilder,'CO2')) + Ieudled.l(j,'CO2'));
kvoteandel_2050basis(j)$(kvoteandel_2050basis(j)<0) = 0;
kvoteandel_2050basis(j)$(kvoteandel_2050basis(j)>1) = 1;

Display kvoteandel_2016, kvoteandel_2030basis, kvoteandel_2050basis;

* * * * * 

display BoP.l;
execute_unload "gekko\gdx_work\Basis2050_ETS.gdx";

$include vis_andele.gms