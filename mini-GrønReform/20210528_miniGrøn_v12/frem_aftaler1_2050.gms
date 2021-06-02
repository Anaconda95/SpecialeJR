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

s_Y.lo('350010b') = -inf;
s_Y.up('350010b') = inf;

solve static_fremskriv using cns;

s_Y.fx(j) = s_Y.l(j);

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
Display m_CH.l;

*Øget anvendelse af biogas
m_BG_energi.fx(j) = m_BG_energi.l(j) + 0.05*(1 - m_BG_energi.l(j));

m_CH.up('350020b') = inf;
m_CH.lo('350020b') = -inf;

CO2eDK.fx = CO2eDK.l - 700;

solve static_fremskriv using cns;

m_CH.fx('350020b') = m_CH.l('350020b');

Display m_CH.l;
* * * * *

*8. Elektrificering af affaldsforbrænding

Display m_KEel.l;

CO2eDK.fx = CO2eDK.l - 700;

m_KEel.lo('383900') = -inf;
m_KEel.up('383900') = inf;

solve static_fremskriv using cns;

m_KEel.fx(j) = m_KEel.l(j);

Display m_KEel.l;

$include vis_andele.gms

* * * * *
$ontext
*9. Afgift i cementindustrien

CO2eTax_dummyE_kalib('230020',kilder,udled_type) = 1;
CO2eTax_dummyIE_kalib('230020',udled_type) = 1;

Parameter CO2eDK_temp, Y_230020_temp;
CO2eDK_temp = CO2eDK.l;
Y_230020_temp = Y.l('230020');

*Hjælp til startværdi
CO2eDK.lo = -inf;
CO2eDK.up = inf;
CO2eTax_kalib.fx = 1000;
solve static_fremskriv using cns;

CO2eDK.fx = CO2eDK_temp - 500;
CO2eTax_kalib.lo = -inf;
CO2eTax_kalib.up = inf;

Y.fx('230020') = Y_230020_temp;
s_Y.lo('230020') = -inf;
s_Y.up('230020') = inf;

solve static_fremskriv using cns;

Y.lo('230020') = -inf;
Y.up('230020') = inf;

CO2eTax_kalib.fx = CO2eTax_kalib.l;
s_Y.fx(j) = s_Y.l(j);

Display CO2eTax_kalib.l, s_Y.l;
$offtext
* * * * * *

CO2eDK.lo = -inf;
CO2eDK.up = inf;

solve static_fremskriv using cns;

execute_unload "gekko\gdx_work\Basis2050_aftaler.gdx";

$include vis_andele.gms