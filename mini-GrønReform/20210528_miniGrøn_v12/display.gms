display share_D.l, EY.l;
$exit

solve static_fremskriv using cns;

display CCSpris, d1KBpartX, lump.l;
$exit

display gdp.l, gdpf0.l;
$exit

display p.l, tfptot.l, s_y.l;
$exit

*s_CCS.l(part,j) = s_CCS.l(part,j) + 0.5;
display s_CCS.l, CO2etax.l,KM.l, KB.l, Y.l, CCSpris;

display ucB.l, dummy_ucB.l, deltaKB.l, deltaKB.lo, CO2emaal2030;
$exit

*display pKBpartX.l, PKBtot.l, KB.l, KBpart.l, KBpartX.l ;

*$exit
parameter el_kraftmax, el_kraftmin;

el_kraftmax = smax(j, el_kraftandel.l(j));
el_kraftmin = smin(j, el_kraftandel.l(j));

*display el_kraftandel.l, el_kraftmax, el_kraftmin, d1kraftandel0;

*display PF.l, p.l;


*E_PKBpartX(part,j) $ j_CCS(j).. PKBpartX(part,j) =E= J_PKBpartX(part,j) + scalar_PKBx(part,j) * (1+tFak_B(j))*ucB(j)*PInvB(j) - CCSprKBx(j)*1000 * s_CCS(part,j) * 10**(-9);
 

parameter pkbpartX350010a;
pkbpartX350010a('P') = PKBpartX.l('a','350010a');
pkbpartX350010a('J') = J_PKBpartX.l('a','350010a');
pkbpartX350010a('sca') = scalar_PKBx('a','350010a');
pkbpartX350010a('nomp') = (1+tFak_B.l('350010a'))*ucB.l('350010a')*PInvB.l('350010a');
pkbpartX350010a('xP') = -CCSprKBx.l('350010a')*1000 * s_CCS.l('a','350010a') * 10**(-9);
display pkbpartX350010a;

*PKBpartX(part,j) =E= J_PKBpartX(part,j) + scalar_PKBx(part,j) * (1+tFak_B(j))*ucB(j)*PInvB(j) - CCSprKBx(j)*1000 * s_CCS(part,j) * 10**(-9);
