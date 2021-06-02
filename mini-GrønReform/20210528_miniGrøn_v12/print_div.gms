parameter vis_div, dekomp_div;

dekomp_div(j,'div') = div.l(j);

dekomp_div(j,'rev') = (1-t_cor.l(j))*p.l(j)*Y.l(j); 
dekomp_div(j,'M') = -(1-t_cor.l(j))*pM.l(j)*M.l(j); 
dekomp_div(j,'E') = -(1-t_cor.l(j))*(pE.l(j)*E.l(j)+sum(i,px_energi.l(j,i)*x_energi.l(j,i))); 
dekomp_div(j,'L') = -(1-t_cor.l(j))*(1+tFak_w.l(j))*w.l*L.l(j); 
dekomp_div(j,'K') = -(1-t_cor.l(j))*(tFak_B.l(j)*ucB.l(j)*PInvB.l(j)*KB.l(j)/(1+grow.l) + tFak_M.l(j)*ucM.l(j)*PInvM.l(j)*KM.l(j)/(1+grow.l)
                                     + (r.l*(1+infl.l)+infl.l)*DP.l(j)/((1+infl.l)*(1+grow.l)))
                    - PInvB.l(j)*InvB.l(j) - PInvM.l(j)*InvM.l(j)
                    + t_cor.l(j)*(deltaKBBook.l(j)*KBBook.l(j)+deltaKMBook.l(j)*KMBook.l(j))/((1+grow.l)*(1+infl.l)) + (1-1/((1+grow.l)*(1+infl.l)))*DP.l(j)
                     ;
                     
dekomp_div(j,'co2eskat') = (1-t_cor.l(j))*
(- sum((kilder,udled_type), TR_Eudled.l(j,kilder,udled_type)) - sum(udled_type, TR_Ieudled.l(j,udled_type)) 
+ sum(part,NegaUdled.l(part,j)*s_CCS.l(part,j))*10**(-6) + Subs_Y.l(j) + Subs_KEel.l(j) + Subs_KB.l(j) + Subs_TTE.l(j) + Subs_BG.l(j));

dekomp_div(j,'andenskat') = -(1-t_cor.l(j))*Fak_rest.l(j)- SUBEU.l(j); 
dekomp_div(j,'lager') = - PIL.l(j)*IL.l(j);

display dekomp_div;
*$exit






vis_div(j,'markup') = markup.l(j);
vis_div(j,'div') = div.l(j)/(PO.l(j)*y.l(j));
vis_div(j,'divL') = (div.l(j)+PIL.l(j)*IL.l(j))/(PO.l(j)*y.l(j));
vis_div(j,'divEU') = (div.l(j)+PIL.l(j)*IL.l(j)+SUBEU.l(j))/(PO.l(j)*y.l(j));
vis_div(j,'divrest') = (div.l(j)+PIL.l(j)*IL.l(j)+SUBEU.l(j)+ (1-t_cor.l(j))*Fak_rest.l(j))/(PO.l(j)*y.l(j));



t_cor.fx(j) = 0;
tFak_B.fx(j) = 0;
tFak_M.fx(j) = 0;
*t_cor.fx(j) = t_cor.l(j);


*model divtest / E_DIVnynyNY /;

fix ALL;
unfix J_LED;
unfix J_LED_NEW;
unfix J_LED_NEW2;
unfix J_LED_NEW3;
unfix J_LED_NEW4;
unfix J_LED_NEW5;
unfix J_LED_NEW6;

DIV.lo(j) = -inf;
DIV.up(j) =  inf;
J_DIV.fx(j) =  0;

ucB.lo(j) = -inf;
ucB.up(j) =  inf;
J_ucBNY.fx(j) =  0;

ucM.lo(j) = -inf;
ucM.up(j) =  inf;
J_ucMNY.fx(j) =  0;



*solve divtest using cns;

solve static_fremskriv using cns;

vis_div(j,'divt') = (div.l(j)+PIL.l(j)*IL.l(j)+SUBEU.l(j)+ (1-t_cor.l(j))*Fak_rest.l(j))/(PO.l(j)*y.l(j));


DP.fx(j) = DP.l(j)/0.6;

solve static_fremskriv using cns;

vis_div(j,'divDP') = (div.l(j)+PIL.l(j)*IL.l(j)+SUBEU.l(j)+ (1-t_cor.l(j))*Fak_rest.l(j))/(PO.l(j)*y.l(j));

*vis_div(j,'divg') = (div.l(j)+PIL.l(j)*IL.l(j)+SUBEU.l(j)-(r.l*(1+infl.l)+infl.l)*DP.l(j)/0.6*0.4/((1+infl.l)*(1+grow.l)) + (1-1/((1+grow.l)*(1+infl.l)))*DP.l(j)/0.6*0.4)/y.l(j);
*vis_div(j,'divbog') = vis_div(j,'divx') - t_cor.l(j)*(deltaKBBook.l(j)*KBBook.l(j)+deltaKMBook.l(j)*KMBook.l(j))/((1+grow.l)*(1+infl.l))/y.l(j); 
*vis_div('div_v',j) = div.l(j) / v.l(j);

display vis_div;
$exit


E_DIVnynyNY(j)..    DIV(j) =e= J_DIV(j) + 

(1-t_cor(j))*
(p(j)*Y(j) 
- PM(j)*M(j) - PE(j)*E(j) - sum(i,px_energi(j,i)*x_energi(j,i)) - (1+tFak_w(j))*w*L(j) 
- tFak_B(j)*ucB(j)*PInvB(j)*KB(j)/(1+grow) - tFak_M(j)*ucM(j)*PInvM(j)*KM(j)/(1+grow)
- sum((kilder,udled_type), TR_Eudled(j,kilder,udled_type)) - sum(udled_type, TR_Ieudled(j,udled_type)) 
+ sum(part,NegaUdled(part,j)*s_CCS(part,j))*10**(-6) + Subs_Y(j) + Subs_KEel(j) + Subs_KB(j) + Subs_TTE(j) + Subs_BG(j)
- Fak_rest(j)
- (r*(1+infl)+infl)*DP(j)/((1+infl)*(1+grow))) 

- PInvB(j)*InvB(j) - PInvM(j)*InvM(j) - PIL(j)*IL(j)

                                  - SUBEU(j)
                                  + t_cor(j)*(deltaKBBook(j)*KBBook(j)+deltaKMBook(j)*KMBook(j))/((1+grow)*(1+infl)) + (1-1/((1+grow)*(1+infl)))*DP(j);
