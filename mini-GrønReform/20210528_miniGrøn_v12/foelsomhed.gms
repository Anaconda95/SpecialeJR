*Test af modellen
solve static_fremskriv using cns;

display BoP.l;

*Ingen (dvs. meget begrænsede) reduktionsmuligheder i landbruget

Parameter PKBforhold_pre;
PKBforhold_pre(part,j) =  (PKBpart.l(part,j) /PKBtot.l(j))**(-EKB.l(j));

EKB.fx('01000a') = 0.01;
EKB.fx('01000b') = 0.01;
EKB.fx('01000c') = 0.01;
EKB.fx('01000d') = 0.01;

m_KBpart.fx(part,j) = m_KBpart.l(part,j) * PKBforhold_pre(part,j) / ((PKBpart.l(part,j) / PKBtot.l(j))**(-EKB.l(j)));

solve static_fremskriv using cns;

display BoP.l;

*Begrænset substitution mellem transport, materialer og øvrigt, øverst i neststrukturen

Parameter PYTforhold_pre,PYHforhold_pre,PYMforhold_pre;
PYTforhold_pre(j) = (PT.l(j)/PO.l(j))**(-EY.l(j));
PYHforhold_pre(j) = (PH.l(j)/PO.l(j))**(-EY.l(j));
PYMforhold_pre(j) = (PM.l(j)/PO.l(j))**(-EY.l(j));

EY.fx(j) = 0.01;

m_T.fx(j)  = m_T.l(j)  * PYTforhold_pre(j) / ((PT.l(j)/PO.l(j))**(-EY.l(j)));
m_YH.fx(j) = m_YH.l(j) * PYHforhold_pre(j) / ((PH.l(j)/PO.l(j))**(-EY.l(j)));
m_YM.fx(j) = m_YM.l(j) * PYMforhold_pre(j) / ((PM.l(j)/PO.l(j))**(-EY.l(j)));

solve static_fremskriv using cns;

display BoP.l;