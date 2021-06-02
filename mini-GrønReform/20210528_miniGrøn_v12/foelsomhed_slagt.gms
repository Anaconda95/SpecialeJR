


*Begrænset substitution mellem transport, materialer og øvrigt, øverst i neststrukturen

Parameter PYTforhold_pre,PYHforhold_pre,PYMforhold_pre;
PYTforhold_pre(j) = (PT.l(j)/PO.l(j))**(-EY.l(j));
PYHforhold_pre(j) = (PH.l(j)/PO.l(j))**(-EY.l(j));
PYMforhold_pre(j) = (PM.l(j)/PO.l(j))**(-EY.l(j));

Set j_slagt(j) /
    100010a  "Slagterier (kvæg)"
    100010b  "Slagterier (svin)"
    100010c  "Slagterier (fjerkræ mv.)"
    100030  "Mejerier" /;






EY.fx(j_slagt) = 0.01;

m_T.fx(j_slagt)  = m_T.l(j_slagt)  * PYTforhold_pre(j_slagt) / ((PT.l(j_slagt)/PO.l(j_slagt))**(-EY.l(j_slagt)));
m_YH.fx(j_slagt) = m_YH.l(j_slagt) * PYHforhold_pre(j_slagt) / ((PH.l(j_slagt)/PO.l(j_slagt))**(-EY.l(j_slagt)));
m_YM.fx(j_slagt) = m_YM.l(j_slagt) * PYMforhold_pre(j_slagt) / ((PM.l(j_slagt)/PO.l(j_slagt))**(-EY.l(j_slagt)));

solve static_fremskriv using cns;

display BoP.l;

execute_unload "gekko\gdx_work\%filnavn%.gdx";