********** Lille model med offentlig sektor (dvs ingen omfordeling) *************



* sets
* Husholdninger 
set HH /1*5/;

* Firmaer
set F /"D","C"/;


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
;

parameters
gamma(F,HH)
E_x(HH)  "Forbrugselasticitet"
rho(HH)  "produktivitets-parameter for HH"
tau(f)   "Forbrugsskat"
;

equations
e1
e11
e2
e3
e4
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


* Privat efterspørgsel
e4(HH,F)..    X(HH,F) =e= gamma(F,HH)*((1+tau(f))*p(F)/p_C(hh))**(-E_x(HH))*((w*rho(HH)*N)/p_C(hh));


* Budget restriktion
e5(HH)..      sum((f), (1+tau(F))*p(F)*X(HH,F)) =e= w*rho(HH)*N;

* Varermarkedsligevægt (udeladt ligevægt for clean good)
e6('D')..       sum(HH,X(HH,'D')) =e= Y('D');

* prisen er numeraire
e7..          w =e= 1;

* Off sektor
e8..          w*L_G =e= sum(HH, tau('D')*X(HH,'D'));

Model lille_model_off /e1,e11,e2, e3, e4, e5, e6, e7, e8/;



********** Kalibrering *********

E_x(hh) = 0.5;


rho('1') = 0.055;
rho('2') = 0.118;
rho('3') = 0.167;
rho('4') = 0.229;
rho('5') = 0.431;

w.l = 1;

Y.l('D') = 180;
Y.l('C') = 820;

L.l(F) = Y.l(F);


p_C.l(hh) = 1;

p.l(F) = 1;

N.fx = 1000;

*Gamma og Y er kalibreret til fødevarer, el, gas og brændsel, som andel af samlet forbrug


gamma('D','1') = 0.22;
gamma('D','2') = 0.21;
gamma('D','3') = 0.18;
gamma('D','4') = 0.18;
gamma('D','5') = 0.16;

gamma('C',hh) = 1 - gamma('D',hh) ;

X.l(hh,f) = gamma(f,hh)*w.l*rho(hh)*N.l;


tau('D')=0;
tau('C')=0;

G.l = tau('D')*sum(HH,X.l(HH,'D'));

Y_G.l = 0;
L_G.l =0;
p_G.l=1;

p_c_0.fx(hh) = p_c.l(hh);
w_0.fx = w.l;
N_0.fx = N.l;
X_D_0.l(hh) = X.l(hh,'D');



* Løser nulstød
solve lille_model_off using cns;

X_total.l(F) = sum(HH,X.l(HH,F));

EV_p.l(hh) = ((p_c_0.l(hh)-p_c.l(hh))/p_c.l(hh))*(w.l*N.l*rho(hh));
EV_I.l(hh) = rho(hh)*w.l*N.l-rho(hh)*w_0.l*N_0.l;
EV.l(hh) =EV_p.l(hh)+EV_I.l(hh);
ev_pct.l(hh) = EV.l(hh)/(rho(hh)*N.l*w.l);
ev_p_pct.l(hh) = Ev_p.l(hh)/(rho(hh)*N.l*w.l);

execute_unload 'Output\lille_model_off_5h_basis';


************* Stød: tau = 0.1 **********
tau('D')=0.1;
tau('C')=0;

solve lille_model_off using cns;

X_total.l(F) = sum(HH,X.l(HH,F));

EV_p.l(hh) = ((p_c_0.l(hh)-p_c.l(hh))/p_c.l(hh))*(w.l*N.l*rho(hh));
EV_I.l(hh) = rho(hh)*w.l*N.l-rho(hh)*w_0.l*N_0.l;
EV.l(hh) =EV_p.l(hh)+EV_I.l(hh);
ev_pct.l(hh) = EV.l(hh)/(rho(hh)*N.l*w.l);
ev_p_pct.l(hh) = Ev_p.l(hh)/(rho(hh)*N.l*w.l);
X_D_rel.l(hh) = (X.l(hh,'D')-X_D_0.l(hh))/X_D_0.l(hh);

execute_unload 'Output\lille_model_off_5h_tau01';


************* Stød: E_x  **********
tau('D')=0.1;
tau('C')=0;

E_x('1') = 0.1;
E_x('2') = 0.3;
E_x('3') = 0.7;
E_x('4') = 2;
E_x('5') = 3;



solve lille_model_off using cns;

X_total.l(F) = sum(HH,X.l(HH,F));

EV_p.l(hh) = ((p_c_0.l(hh)-p_c.l(hh))/p_c.l(hh))*(w.l*N.l*rho(hh));
EV_I.l(hh) = rho(hh)*w.l*N.l-rho(hh)*w_0.l*N_0.l;
EV.l(hh) =EV_p.l(hh)+EV_I.l(hh);
ev_pct.l(hh) = EV.l(hh)/(rho(hh)*N.l*w.l);
ev_p_pct.l(hh) = Ev_p.l(hh)/(rho(hh)*N.l*w.l);
X_D_rel.l(hh) = (X.l(hh,'D')-X_D_0.l(hh))/X_D_0.l(hh);


execute_unload 'Output\lille_model_off_5h_tau01_Ex';
