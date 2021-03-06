********** Lille model med offentlig sektor (dvs ingen omfordeling) *************

* sets
* Husholdninger 
set HH /1*2/;

* Firmaer
set g /1*2/;
alias(g,gg);

*Endogene variable
variables
w 'loen'
t(g) 'labour input'
F(g) 'produktion'
z(g) 'polluion'
p(g) 'priser'
x(hh,g) 'forbrug af vare g i husholdninger'
L 'offforbrug'
;

*Eksogene variable
variables
T_total(hh)
Gov_spdg; 
*Parametre

parameters
abate 'copeland parameter'
b(g)'minimumsforbrug'
alpha(g) 'marginal budget share'
phi(hh) 'produktivitet i husholding hh'
epsilon(g) 'forurening'
r 'CES parameter'
s 'elasticity of substitution'
tau_p 'co2-skat'
;

equations
*FirmProd(g)
FirmFOC1(g)
FirmFOC2(g)
NulProfit(g)
Copeland(g)
TimeConstr
HHFOC1(hh,g)
HHBudget(hh)
Lumpsum
Numeraire
GenEq(g)
; 
*FirmProd(g)..                               F(g)     =e=    (epsilon(g)*T(g)**r + (1-epsilon(g))*Z(g)**r)**(1/r); 
FirmFOC1(g)..                                    w   =e=     epsilon(g)    *T(g)**(r-1)*F(g)**(1-r)*p(g);
FirmFOC2(g)..                                 tau_P  =e=     (1-epsilon(g))*Z(g)**(r-1)*F(g)**(1-r)*p(g);
Nulprofit(g)..                   w*T(g) + tau_P*Z(g) =e=     p(g)*F(g);
Copeland(g)..                                Z(g)    =l=     abate*T(g);
TimeConstr..                                  0      =e=     sum(g, T(g) ) -sum(hh, phi(hh) *T_total(hh)  );
HHFOC1(hh,g)$(ord(g) lt 2)..    p(g)*(x(hh,g)-b(g))  =e= (alpha(g)/alpha(g+1))*((x(hh,g+1)-b(g+1))*p(g+1));
HHBudget(hh)..                   sum(g,p(g)*x(hh,g)) =e= phi(hh)*w*T_total(hh) + L;
Lumpsum..                                        L   =e= sum(g,tau_P*z(g))/card(hh)     ;
Numeraire..                                      w   =e= 1;
GenEq(g)$(ord(g) lt 2)..                        F(g) =e= sum(hh,X(hh,g));

***********************************************************************************************************************
************************************ Kalibrering **********************************************************************
***********************************************************************************************************************

*Parametre
abate=1;
Parameters b(g)       'minimum consumption'  
                 /1 1
                  2 3/
          alpha(g) marginal budget share'
          /1 0.6
          2 0.4/
          phi(hh) 'produktivitet i husholding hh'
          /1 0.2
           2 0.8/
           epsilon(g) 'forurening'
           /1 0.99
           2 0.94/
;
s=0.5;
r    = 1-1/s;
tau_p = 0.4;
            

*Kalibrering
w.l=1;
T_total.fx(hh)=24;
Gov_spdg.fx=5;
p.l(g)=1;
Parameter subsist;
subsist = sum(g,p.l(g)*b(g));
x.l(hh,g) = b(g) +  (    alpha(g)*( w.l*phi(hh)*T_total.l(hh) - subsist )  )/p.l(g);
F.l(g) = sum(hh,x.l(hh,g));
T.l(g) = ( w.l/ ( epsilon(g)*F.l(g)**(1-r)*p.l(g) ))**(1/(r-1));
z.l(g) = (tau_p/((1-epsilon(g))*F.l(g)**(1-r)*p.l(g)))**(1/(r-1));
L.l = sum(g,z.l(g)*tau_p)/card(hh);

*T_total.fx(hh)=sum(g,T.l(g))


Model Klenert /all/;

Solve Klenert using cns;

*Test om man kan hæve skatten - det kan man, og prisen på det forurenende gode stiger.
*tau_P=1;
*Solve Klenert using cns;
        


