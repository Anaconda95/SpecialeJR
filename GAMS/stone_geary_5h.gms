********** Lille model med offentlig sektor (dvs ingen omfordeling) *************



* sets
* Husholdninger 
set HH /1*5/;


* Firmaer
set F /"D","C"/;
alias(F,FF);


*Variable
variables
L(F) 
w
Y(F)
p(F)
p_C(hh)
N
X(HH,F)
G  "Offentlig produktions"
X_total(F)
EV(hh)
EV_p(hh)
EV_I(hh)
p_C_0(hh)
w_0
N_0
lumpsum(hh)
EV_pct(hh)
EV_p_pct(hh)
Y_G
L_G
p_G
X_D_rel(hh)
X_D_0(hh)
sub
alpha(F,HH)
mu(F)
;

parameters
rho(HH)  "produktivitets-parameter for HH"
tau(f)   "Forbrugsskat"
share(F,HH)
;

equations
e1
e11
e2
e3
e4
e44
e5
e6
e7
e8
;


*Virksomehdernes efterspørgsel
e1(F)..       L(F) =e= Y(F);

e11..         L_G =e= Y_G;


*Nukprofit for hver virksomhed
e2(F)..       w*L(F) =e= p(F)*Y(F);


*Arbejdsmarked
e3..          sum(F,L(F))+L_G =e= sum(HH,rho(HH)*N);


* Privat efterspørgsel  * vi skal ændre i denne! 
#e4(HH,F)..    X(HH,F) =e= gamma(F,HH)*((1+tau(f))*p(F)/p_C(hh))**(-E_x(HH))*((w*rho(HH)*N)/p_C(hh));

#e4(HH,F)..    X(HH,F) =e= mu(F) + alpha(F,HH)/((1+tau(F))*p(F))*(w*rho(hh)*N-sub);

e4(HH)..      (w*rho(hh)*N-sum(F,p(F)*mu(F))) =e= ((X(HH,'D')-mu('D'))/(X(HH,'C')-mu('D'))*(alpha('C',HH)/alpha('D',HH))*((1+tau('D'))*p('D'))/((1+tau('C'))*p('C')))*(w*rho(hh)*N-sum(F,p(F)*mu(F))) ;

e44..         sub =e= sum(F,p(F)*mu(F));

* Budget restriktion
e5(HH)..      sum((f), (1+tau(F))*p(F)*X(HH,F)) =e= w*rho(HH)*N;

* Varermarkedsligevægt (udeladt ligevægt for clean good)
e6('D')..       sum(HH,X(HH,'D')) =e= Y('D');

* prisen er numeraire
e7..          w =e= 1;

* Off sektor
e8..          w*L_G =e= sum(HH, tau('D')*X(HH,'D'));

Model stone_geary /e1,e11,e2, e3, e4, e5, e6, e7, e8/;

* 25 lign
* 20 var

********** Kalibrering *********


rho('1') = 0.055;
rho('2') = 0.118;
rho('3') = 0.167;
rho('4') = 0.229;
rho('5') = 0.431;

w.l = 1;




p_C.l(hh) = 1;

p.l(F) = 1;

N.fx = 1000;

mu.l('C') = 0;
mu.l('D') = 8;

*alpha er først budget andele og derefter marginale budgetandele.  Y og alpha er kalibreret til fødevarer, el, gas og brændsel, som andel af samlet forbrug

sub.l = sum(F,p.l(F)*mu.l(F));

share('D','1') = 0.22;
share('D','2') = 0.21;
share('D','3') = 0.18;
share('D','4') = 0.18;
share('D','5') = 0.16;

share('C',hh) = 1 - share('D',hh) ;


X.l(HH,F) = (share(F,HH)/p.l(F))*(w.l*rho(hh)*N.l);

X.fx(HH,F) = X.l(HH,F);
sub.fx = sub.l;
p.fx(F) =1;

tau('D')=0;
tau('C')=0;

w.fx =1;

equations
c1
c2;

c1(f,hh).. alpha(F,HH) =e= (X(HH,F)-mu(F))*p(F)/(w*rho(hh)*N-sub);
c2(HH)..      sum((f), (1+tau(F))*p(F)*X(HH,F)) =e= w*rho(HH)*N;

model kali /c1,c2/;

solve kali using cns;




alpha.fx(F,HH) = alpha.l(F,HH);
mu.fx(F) = mu.l(F);
X.l(HH,F) = X.l(HH,F);
sub.l = sub.l;
p.l(F) =1;
w.l =1;

Y.l('D') = sum(HH,X.l(HH,'D'));
Y.l('C') = sum(HH,X.l(HH,'C'));

L.l(F) = Y.l(F);



G.l = tau('D')*sum(HH,X.l(HH,'D'));

Y_G.l = 0;
L_G.l =0;
p_G.l=1;

p_c_0.fx(hh) = p_c.l(hh);
w_0.fx = w.l;
N_0.fx = N.l;
X_D_0.l(hh) = X.l(hh,'D');
X_total.l(F) = sum(HH,X.l(HH,F));



execute_unload 'Output\stone_geary_5h_kal';


* Løser nulstød
solve stone_geary using cns;

X_total.l(F) = sum(HH,X.l(HH,F));

EV_p.l(hh) = ((p_c_0.l(hh)-p_c.l(hh))/p_c.l(hh))*(w.l*N.l*rho(hh));
EV_I.l(hh) = rho(hh)*w.l*N.l-rho(hh)*w_0.l*N_0.l;
EV.l(hh) =EV_p.l(hh)+EV_I.l(hh);
ev_pct.l(hh) = EV.l(hh)/(rho(hh)*N.l*w.l);
ev_p_pct.l(hh) = Ev_p.l(hh)/(rho(hh)*N.l*w.l);

execute_unload 'Output\stone_geary_5h_basis';


************* Stød: tau = 0.1 **********
tau('D')=0.1;
tau('C')=0;

solve stone_geary using cns;

X_total.l(F) = sum(HH,X.l(HH,F));

EV_p.l(hh) = ((p_c_0.l(hh)-p_c.l(hh))/p_c.l(hh))*(w.l*N.l*rho(hh));
EV_I.l(hh) = rho(hh)*w.l*N.l-rho(hh)*w_0.l*N_0.l;
EV.l(hh) =EV_p.l(hh)+EV_I.l(hh);
ev_pct.l(hh) = EV.l(hh)/(rho(hh)*N.l*w.l);
ev_p_pct.l(hh) = Ev_p.l(hh)/(rho(hh)*N.l*w.l);
X_D_rel.l(hh) = (X.l(hh,'D')-X_D_0.l(hh))/X_D_0.l(hh);

execute_unload 'Output\stone_geary_5h_tau01';

