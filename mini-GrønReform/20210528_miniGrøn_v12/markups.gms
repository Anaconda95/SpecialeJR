* * * * Korrektion af markups * * * *

* Markups stødes til 4.6% for alle private brancher pånær Nordsøen og 0% for den offentlige branche

Display markup.l, GDP.l, Y.l;

Parameter markup0, Y0, L0;
markup0(j) = markup.l(j);
Y0(j) = Y.l(j);
L0(j) = L.l(j);
$ontext
markup.fx(j) = 0.046;
*markup.fx('Offentlig') = 0;
markup.fx('Offentlig') = markup0('Offentlig');
markup.fx('030000') = markup0('030000');
markup.fx('060000a') = markup0('060000a');
markup.fx('060000b') = markup0('060000b');
$offtext
*Display markup.l, GDP.l, Y.l, ucB.l, ucM.l;

* Risikopræmie tilpasses i hver branche, så output er uændret i hver branche
sets
j_fiskeri(j) /030000/
;
*markup.fx(j)$ (NOT j_fiskeri(j)) = markup.l(j) - 0.01*(markup.l(j)-0.046);

markup.up('01000a') = inf;
markup.lo('01000a') = -inf;

P.fx('01000a') = 1;

m_YH.fx('01000a') = m_YH.l('01000a') * 1.01;
m_HLKE.fx('01000a') = m_HLKE.l('01000a') / 1.01;
m_HB.fx('01000a') = m_HB.l('01000a') * 1.01 / (1-LKE.l('01000a')/H.l('01000a'));

PInvB.fx('01000a') = 1;
dummy_ucB.up('01000a') = inf;
dummy_ucB.lo('01000a') = -inf;

*m_YH.fx(j)$ (NOT j_fiskeri(j)) = m_YH.l(j) + 0.1;

*markup.up(j)$ (NOT j_fiskeri(j)) = inf;
*markup.lo(j)$ (NOT j_fiskeri(j)) = -inf;

*dummy_ucB.fx(j)$ (NOT j_fiskeri(j)) = 0.02;

*dummy_ucB.up(j)$ (NOT j_fiskeri(j)) = inf;
*dummy_ucB.lo(j)$ (NOT j_fiskeri(j)) = -inf;

*PInvB.fx(j)$ (NOT j_fiskeri(j)) = 1;
*m_HB.up(j) $ (NOT j_fiskeri(j))= inf;
*m_HB.lo(j) $ (NOT j_fiskeri(j))= -inf;
*m_HB.up(j) $ (NOT j_land(j) AND NOT j_fiskeri(j))= inf;
*m_HB.lo(j) $ (NOT j_land(j) AND NOT j_fiskeri(j))= -inf;
*m_KBtot.up(j)$ (j_land(j) AND NOT j_fiskeri(j)) = inf;
*m_KBtot.lo(j)$ (j_land(j) AND NOT j_fiskeri(j)) = -inf;

*PH.fx(j)$ (NOT j_fiskeri(j)) = 1;

*m_YH.up(j)$ (NOT j_fiskeri(j)) = inf;
*m_YH.lo(j)$ (NOT j_fiskeri(j)) = -inf;

solve static_energi using cns;
$ontext
set loopstep4 /1*10/;

loop(loopstep4,

Y.fx(j) = Y.l(j) + 0.05*(Y0(j) - Y.l(j));

ucB.fx(j)$(ucB.l(j) lt 0.015) = ucB.l(j);
j_ucBny.up(j)$(ucB.l(j) lt 0.015) = inf;
j_ucBny.lo(j)$(ucB.l(j) lt 0.015) = -inf;

ucM.fx(j)$(ucM.l(j) lt 0.015) = ucM.l(j);
j_ucMny.up(j)$(ucM.l(j) lt 0.015) = inf;
j_ucMny.lo(j)$(ucM.l(j) lt 0.015) = -inf;

solve static_fremskriv using cns;

Display riskprem.l, GDP.l, Y.l, ucB.l, ucM.l;
);
$offtext
*Y.fx(j) = Y0(j);

*solve static_tilskud using cns;

*Display Y.l;

* TFP eksogeniseres og output endogeniseres

*tfp.fx(j) = tfp.l(j);

*Y.lo(j) = -inf;
*Y.up(j) = inf;

Display markup.l, GDP.l, Y.l;
display BoP.l;
execute_unload "gekko\gdx_work\base_m.gdx";