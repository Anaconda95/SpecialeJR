$Title Hjemmeopgave 4.1

*suppressing output
$offsymxref offsymlist
option limcol =0, limrow=0;
option solprint=off;
*------------------------------------------------------------------------*
*Objekter og dimensioner
*------------------------------------------------------------------------*
sets t /t0*t100/;
set  b /1*2/;

Variables
*Endogene variable
K(b,t)     "Kapital"
Y(b,t)     "Output"
L(b,t)     "Arbejdsudbud"
I(b,t)     "Investeringer"
C(b,t)     "Privatforbrug"
V(b,t)     "Virksomhedernes v�rdi"
uc(t)    "User-cost for kapital"
W(b,t)     "L�nnen"
r(t)     "Renten"
P(b,t)     "Prisen i indlandet"
C_tot(t)     "C"

*Eksogene variable
delta(t) "Afskrivningsraten"
theta(t) "Arbejdskraftsproduktivitet"
rho      "Risikoaversion"
eta      "Tilbagediskonteringsrate"
myK(b)   "Produktionsv�gt kapital"
myL(b)   "Produktionsv�gt arbejdskraft"
E        "Elasticitet i produktionsfkt"
g        "V�kst"
alpha   "Vægt i forbruget"
;



Equations
E_K(b,t)
E_W(b,t)
E_P(b,t)
E_uc(t)
E_I(b,t)
E_C_tot(t)
E_C(b,t)
E_Y(b,t)
E_V(b,t)
E_Vterm
E_ucterm
E_Cterm
;

E_K(b,t)    $ (ord(t) gt 1)..                          K(b,t-1)/(1+g)   =e= MyK(b) * (uc(t-1)/P(b,t))**(-E) * Y(b,t);
E_W(b,t)    $ (ord(t) gt 1)..                          theta(t)*L(b,t)  =e= MyL(b) * ((W(b,t)/theta(t))/P(b,t))**(-E)*Y(b,t);
E_P(b,t)    $ (ord(t) gt 1)..                          P(b,t)*Y(b,t)    =e= (uc(t-1)*K(b,t-1))/(1+g) + W(b,t)*L(b,t);
E_uc(t)     $ (ord(t) lt card(t))..                      uc(t)            =e= r(t+1) + delta(t);
E_I(b,t)    $ (ord(t) gt 1)..                          K(b,t)           =e= (1-delta(t))*K(b,t-1)/(1+g) + I(b,t);
E_C_tot(t)$ (ord(t) gt 1)..                            C_tot(t)         =e= C('1',t)**alpha*C('2',t)**(1-alpha);
E_C(b,t)    $ (ord(t) gt 1 and ord(t) lt card(t))..    C_tot(t+1)*(1+g) =e= ((1+r(t+1))/(1+eta))**(1/rho)*C_tot(t);
E_Y(b,t)    $ (ord(t) gt 1)..                          Y(b,t)           =e= C(b,t) + I(b,t);
E_V(b,t)    $ (ord(t) gt 1 and ord(t) lt card(t))..    V(b,t+1)*(1+g)   =e= (1+r(t+1))*V(b,t) - (P(b,t+1)*Y(b,t+1)*(1+g) - w(b,t+1)*L(b,t+1)*(1+g) - P(b,t+1)*I(b,t+1)*(1+g));
E_Cterm(b)..                                           C(b,'t100')      =e= C(b,'t99');
E_Vterm(b)..                                           V(b,'t100')      =e= V(b,'t99');
E_ucterm..                                             uc('t100')       =e= uc('t99');

Model Ramsey /ALL/;
*------------------------------------------------------------------------*
* Data
*------------------------------------------------------------------------*

Sets
j "Input" /
PS   "Privat sektor"
Lon  "Lonsum"
Rest "restindkomst"
/
o "Output" /
PS   "Privat sektor"
C    "forbrug"
I    "Investeringer" /
;
Table IO(j,o) "Input-output-tabel"
        PS     C    I
PS       0   800  200
lon    700     0    0
Rest   300     0    0
;

* Eksogene parametre
E.fx        = 0.7;
theta.fx(t) = 1;
g.fx        = 0.02;
rho.fx      = 2;
alpha.fx    = 0.5;

*Antagelser: p er numeriere. w sættes =1 i udgangspunktet.
p.fx('1',t)  = 1;
p.l('2',t)   = 1;
w.l(b,t)       = 1;
r.l(t)       =0.05;

* Initialisering
L.fx(b,t)     = IO('lon','PS');
C.l(b,t)      = IO('PS','C');
I.l(b,t)      = IO('PS','I');
Y.l(b,t)      = sum(j,IO(j,'PS'));

* Kalibrering - delta kommer fra noten. 
eta.fx      = (1+r.l('t0'))/(1+g.l)**rho.l-1;
delta.fx(t) = 2*r.l('t0')-3*g.l; 

* Initialisering
K.fx(b,'t0')  = IO('PS','I')*((1+g.l))/(delta.l('t0')+g.l);
K.l(b,t)      = K.l(b,'t0');
uc.l(t)       = r.l(t) + delta.l(t);
V.l(b,t)      = ( p.l(b,t)*Y.l(b,t) - w.l(b,t)*L.l(b,t) - p.l(b,t)*I.l(b,t) ) / ((r.l(t)-g.l)/(1+g.l));

* Kalibrering
MyL.fx(b)      =  IO('lon','PS')/sum(j,IO(j,'PS'));
MyK.fx(b)      =  (K.l(b,'t0')/(1+g.l))/Y.l(b,'t0')*(r.l('t0')+delta.l('t0'))**E.l;


Solve Ramsey using CNS;

$ontext

set objekt  /Y,I,C,p,w,r,K,L,uc,V,eta,delta,theta/;
Parameter grund(t,objekt);
grund(t,'Y')=y.l(t);
grund(t,'I')=i.l(t);
grund(t,'C')=c.l(t);
grund(t,'p')=p.l(t);
grund(t,'w')=w.l(t);
grund(t,'r')=r.l(t);
grund(t,'K')=K.l(t);
grund(t,'L')=p.l(t);
grund(t,'uc')=uc.l(t);
grund(t,'V')=V.l(t);
grund(t,'delta')=delta.l(t);
grund(t,'theta')=theta.l(t);

display grund;


*2 stød til produktiviteten. Først 1 med 10 pct. i periode 1. Og et med 10 pct. i periode 5.

*Først periode 1.
theta.fx(t)$ (ord(t) gt 1)=theta.l('t0')*1.1;
Solve Ramsey using CNS;

Parameter shock1(t,objekt);
shock1(t,'Y')=y.l(t);
shock1(t,'I')=i.l(t);
shock1(t,'C')=c.l(t);
shock1(t,'p')=p.l(t);
shock1(t,'w')=w.l(t);
shock1(t,'r')=r.l(t);
shock1(t,'K')=K.l(t);
shock1(t,'L')=p.l(t);
shock1(t,'uc')=uc.l(t);
shock1(t,'V')=V.l(t);
shock1(t,'delta')=delta.l(t);
shock1(t,'theta')=theta.l(t);

display shock1;

*Så periode 2
theta.fx(t)=1;
theta.fx(t)$ (ord(t) gt 5)=theta.l('t0')*1.1;

Solve Ramsey using CNS;

Parameter shock2(t,objekt);
shock2(t,'Y')=y.l(t);
shock2(t,'I')=i.l(t);
shock2(t,'C')=c.l(t);
shock2(t,'p')=p.l(t);
shock2(t,'w')=w.l(t);
shock2(t,'r')=r.l(t);
shock2(t,'K')=K.l(t);
shock2(t,'L')=p.l(t);
shock2(t,'uc')=uc.l(t);
shock2(t,'V')=V.l(t);
shock2(t,'delta')=delta.l(t);
shock2(t,'theta')=theta.l(t);

display shock2;


****************
*    TSUNAMI   *
****************

theta.fx(t)=1;
K.fx('t0')     = (IO('PS','I')*((1+g.l))/(delta.l('t0')+g.l))*0.8;


Solve Ramsey using CNS;

Parameter tsunami(t,objekt);
tsunami(t,'Y')=y.l(t);
tsunami(t,'I')=i.l(t);
tsunami(t,'C')=c.l(t);
tsunami(t,'p')=p.l(t);
tsunami(t,'w')=w.l(t);
tsunami(t,'r')=r.l(t);
tsunami(t,'K')=K.l(t);
tsunami(t,'L')=p.l(t);
tsunami(t,'uc')=uc.l(t);
tsunami(t,'V')=V.l(t);
tsunami(t,'delta')=delta.l(t);
tsunami(t,'theta')=theta.l(t);

display tsunami;

*********************************************
********* Afskrivningsrate ******************
*********************************************

K.fx('t0')     = (IO('PS','I')*((1+g.l))/(delta.l('t0')+g.l));
delta.fx(t) = (2*r.l('t0')-3*g.l)*0.9; 

Solve Ramsey using CNS;

Parameter afskriv(t,objekt);
afskriv(t,'Y')=y.l(t);
afskriv(t,'I')=i.l(t);
afskriv(t,'C')=c.l(t);
afskriv(t,'p')=p.l(t);
afskriv(t,'w')=w.l(t);
afskriv(t,'r')=r.l(t);
afskriv(t,'K')=K.l(t);
afskriv(t,'L')=p.l(t);
afskriv(t,'uc')=uc.l(t);
afskriv(t,'V')=V.l(t);
afskriv(t,'delta')=delta.l(t);
afskriv(t,'theta')=theta.l(t);


execute_unload "hjopg4-1-1.gdx", grund,shock1,shock2,tsunami,afskriv;






$offtext
