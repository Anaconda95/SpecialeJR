

* * * *  * 

* Eksogenisering og fremskrivning af output fra Nordsøen

*Fra DREAM:
*	2030	2050
*Olie 	0.5948	0.0065
*Gas	0.7380	0.0002

*Nordsøproduktionen sænkes så meget som muligt...

display y.l, p.l;

*set loopstep6 /1*2/;

*loop(loopstep6,

*markup.fx('060000a') = markup.l('060000a')*1.05;
*markup.fx('060000b') = markup.l('060000b')*1.05;

*thetaL.fx('060000a') = thetaL.l('060000a')*0.95;
*thetaL.fx('060000b') = thetaL.l('060000b')*0.95;

$ontext
Y.fx('060000a') = Y.l('060000a')*0.95;
Y.fx('060000b') = Y.l('060000b')*0.95;
TFP.fx(j) = TFP.l(j);
J_TFP.lo(j) = -inf;
J_TFP.up(j) =  inf;
TFP.lo('060000a') = -inf;
TFP.up('060000a') = inf;
TFP.lo('060000b') = -inf;
TFP.up('060000b') = inf;

P.fx('060000a') = P.l('060000a');
P.fx('060000b') = P.l('060000b');
markup.lo('060000a') = -inf;
markup.up('060000a') = inf;
markup.lo('060000b') = -inf;
markup.up('060000b') = inf;
$offtext

*solve static_fremskriv using cns;

*Display markup.l, y.l, p.l;
*$include vis_andele.gms

*);



* Markups låses op og output eksogeniseres i Nordsøen
$ontext
markup.lo('060000a') = -inf;
markup.up('060000a') = inf;

markup.lo('060000b') = -inf;
markup.up('060000b') = inf;

Y.fx('060000a') = Y.l('060000a');
Y.fx('060000b') = Y.l('060000b');
$offtext
*Y.fx('060000a') = Y.l('060000a')*0.0065/0.5948;
*Y.fx('060000b') = Y.l('060000b')*0.0002/0.7380;

*solve static_fremskriv using cns;

* * * * * Verdensmarkedspriser på fossile brændsler * * * * * 

*Fra IEA:

*			2018	2030	2050
*			Råolie DKK2018/tønde
*Current Policies	430	701	992
*Stated Policies	430	556	745
*Sustainable Development430	392	354
*			Naturgas DKK2018/Mbtu
*Current Policies	48	56	69
*Stated Policies	48	51	62
*Sustainable Development48	47	47

*Eksporten holdes konstant for at afspejle uændret konkurrenceevne overfor omverdenen, hvilket er en approksimation af virkeligheden
*Bemærk at importen påvirkes, når udlandsprisen tilpasses

*Alternativ forklaring: Verdensmarkedspriser for fossile brændsler tilpasses. Det antages nettoeksporten fra alle andre brancher ikke påvirkes, 
*da en højere energipris påvirker udenlandske virksomheder lige så negativt som danske. 
*Nettoeksporten af dansk produceret energi kan dog godt stige, hvis udenlandske energipriser stiger som følge af en grønnere energipolitik i udlandet.

*NYTNYT Eksogen prisstigning og eksogen generel efterspørgselstilpasning ift. generelt prisniveau

$ontext

Ex.fx(j) = Ex.l(j);

Ex.up('060000a') = inf;
Ex.lo('060000a') = -inf;

Ex.up('190000a') = inf;
Ex.lo('190000a') = -inf;

*PF.up(j)$Ex.l(j) = inf;
*PF.lo(j)$Ex.l(j) = -inf;
X0.up(j)$Ex.l(j) = inf;
X0.lo(j)$Ex.l(j) = -inf;
X0.fx('060000a') = X0.l('060000a');
X0.fx('190000a') = X0.l('190000a');

$offtext

display gdp.l, gdpf0.l;
* Verdensmarkedspris på olie
Parameter PF_060000a_temp, PF_190000a_temp;
PF_060000a_temp = PF.l('060000a');
PF_190000a_temp = PF.l('190000a');

set loopstepPF /1*3/;

loop(loopstepPF,

PF.fx('060000a') = PF.l('060000a') + (PF_060000a_temp*(745/430)/(556/430)-PF.l('060000a')) * 0.3;
PF.fx('190000a') = PF.l('190000a') + (PF_190000a_temp*(745/430)/(556/430)-PF.l('190000a')) * 0.3;


solve static_fremskriv using cns;
display gdp.l, gdpf0.l, p.l;
);

$ontext
loop(loopstepPF,

PF.fx('060000a') = PF.l('060000a') + (PF_060000a_temp*(745/430)/(556/430)-PF.l('060000a')) * 0.4;
PF.fx('190000a') = PF.l('190000a') + (PF_190000a_temp*(745/430)/(556/430)-PF.l('190000a')) * 0.4;

solve static_fremskriv using cns;
display gdp.l, gdpf0.l, p.l;
);

PF.fx('060000a') = PF_060000a_temp*(745/430)/(556/430);
PF.fx('190000a') = PF_060000a_temp*(745/430)/(556/430);

solve static_fremskriv using cns;

display gdp.l, gdpf0.l;
$offtext

* Verdensmarkedspris på naturgas
$ontext
Ex.up('350020a') = inf;
Ex.lo('350020a') = -inf;
$offtext

PF.fx('060000b') = PF.l('060000b')*(62/48)/(51/48);
PF.fx('350020a') = PF.l('350020a')*(62/48)/(51/48);

*X0.fx('060000b') = X0.l('060000b');
*X0.fx('350020a') = X0.l('350020a');

solve static_fremskriv using cns;

display gdp.l, gdpf0.l;

*PF.fx(j) = PF.l(j);

*Ex.up(j)$Ex.l(j) = inf;
*Ex.lo(j)$Ex.l(j) = -inf;

* * * *  * 
solve static_fremskriv using cns;

display BoP.l;

$include vis_andele.gms

display X0.l, PF.l, gdp.l, gdpf0.l;