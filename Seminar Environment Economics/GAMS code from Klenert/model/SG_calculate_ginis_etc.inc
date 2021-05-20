*************************** Calculate Parameters  ******************************

Ztotal.l       = Z_C.l+Z_D.l;
C_total.l      = sum(i,C.l(i));
D_total.l      = sum(i,D.l(i));
GDP.l           = F_C.l*pr_C.l + F_D.l*pr_D.l;
CbyD.l         = C_total.lo/D_total.lo;
ConsPor_C.l(i) = C.l(i)/C_total.l;
ConsPor_D.l(i) = D.l(i)/D_total.l;
ConsPor_total.l(i) = (pr_C.l*C.l(i)+pr_D.l*D.l(i))/(pr_C.l*C_total.l+pr_D.l*D_total.l);
Gini_C.l       = (1 - 2* ( 0.5*0.2*ConsPor_total.l('1')
                         + 0.5*0.2*ConsPor_total.l('2') + 0.2* ConsPor_total.l('1')
                         + 0.5*0.2*ConsPor_total.l('3') + 0.2*(ConsPor_total.l('1')+ ConsPor_total.l('2'))
                         + 0.5*0.2*ConsPor_total.l('4') + 0.2*(ConsPor_total.l('1')+ ConsPor_total.l('2')+ ConsPor_total.l('3'))
                         + 0.5*0.2*ConsPor_total.l('5') + 0.2*(ConsPor_total.l('1')+ ConsPor_total.l('2')+ ConsPor_total.l('3')+ ConsPor_total.l('4'))
))/0.8;
********************************************************************************
UtilPor.l(i)   = U.l(i)/W.l;
Gini_U.l       = (1 - 2* ( 0.5*0.2*UtilPor.l('1')
                         + 0.5*0.2*UtilPor.l('2') + 0.2* UtilPor.l('1')
                         + 0.5*0.2*UtilPor.l('3') + 0.2*(UtilPor.l('1')+ UtilPor.l('2'))
                         + 0.5*0.2*UtilPor.l('4') + 0.2*(UtilPor.l('1')+ UtilPor.l('2')+ UtilPor.l('3'))
                         + 0.5*0.2*UtilPor.l('5') + 0.2*(UtilPor.l('1')+ UtilPor.l('2')+ UtilPor.l('3')+ UtilPor.l('4'))
))/0.8;
********************************************************************************
UtilPor_NE.l(i)   = U_NE.l(i)/W_NE.l;
Gini_U_NE.l       = (1 - 2* ( 0.5*0.2*UtilPor_NE.l('1')
                         + 0.5*0.2*UtilPor_NE.l('2') + 0.2* UtilPor_NE.l('1')
                         + 0.5*0.2*UtilPor_NE.l('3') + 0.2*(UtilPor_NE.l('1')+ UtilPor_NE.l('2'))
                         + 0.5*0.2*UtilPor_NE.l('4') + 0.2*(UtilPor_NE.l('1')+ UtilPor_NE.l('2')+ UtilPor_NE.l('3'))
                         + 0.5*0.2*UtilPor_NE.l('5') + 0.2*(UtilPor_NE.l('1')+ UtilPor_NE.l('2')+ UtilPor_NE.l('3')+ UtilPor_NE.l('4'))
))/0.8;
********************************************************************************
GovRev_pol.l$(tau_D.l eq 0) =  Ztotal.l*tau_p.l;   !!for pollution tax
GovRev_pol.l$(tau_p.l eq 0) =  tau_D.l*pr_D.l*sum(i,D.l(i));   !!for output tax

GovRev_LS.l          =  (-5)*L.l;
GovRev_inc.l         =  wage.l*sum(i,(tau_w_preex(i)+tau_w_flat.l+tau_w.l(i))*phi(i)*(T.l(i)-lei.l(i)));

inc.l(i)         = phi(i)*wage.l*(T.l(i)-lei.l(i));
********************************************************************************
***** Suits index

*suits_help.l(i)  = tau_w.l(i);  !! suits_help is set to zero if the hh receives subsidies (because burden is zero). it is set to its tax rate if the hh pays taxes.

*loop(i,if((suits_help.l(i) lt 0), suits_help.l(i)=0*suits_help.l(i)));

inc_tax_total_burden.l =  sum(i,wage.l*(tau_w_preex(i)+tau_w.l(i)+tau_w_flat.l)*phi(i)*( T.l(i)-lei.l(i) ) );

rel_cons.l(i)    =      ConsPor_total.l(i);    !! ( pr_C.l*C.l(i) + pr_D.l*D.l(i) )/(pr_C.l*C_total.l + pr_D.l*D_total.l);
rel_burden.l(i)  =      (wage.l*(tau_w_preex(i)+tau_w.l(i)+tau_w_flat.l)*phi(i)*( T.l(i)-lei.l(i) ) )/( inc_tax_total_burden.l ) ;

suits.l            =    1-2*sum(i,rel_cons.l(i)*( rel_burden.l(i-1)+rel_burden.l(i)/2 ));!! 1 - 0.5*sum(i,( rel_cons.l(i)-rel_cons.l(i-1) ) + ( rel_burden.l(i) + rel_burden.l(i-1) ) )/5000;
********************************************************************************
