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
W(t)     "L�nnen"
r(t)     "Renten"
P(b,t)     "Prisen i indlandet"

*Eksogene variable
delta(t) "Afskrivningsraten"
theta(t) "Arbejdskraftsproduktivitet"
rho      "Risikoaversion"
eta      "Tilbagediskonteringsrate"
myK(b)     "Produktionsv�gt kapital"
myL      "Produktionsv�gt arbejdskraft"
E        "Elasticitet i produktionsfkt"
g        "V�kst"
;



Equations
E_K(b,t)
E_W(t)
E_P(t)
E_uc(t)
E_I(t)
E_C(t)
E_Y(t)
E_V(t)
E_Vterm
E_ucterm
E_Cterm
;

E_K(t)    $ (ord(t) gt 1)..                         K(b,t-1)/(1+g)  =e= MyK(b) * (uc(t-1)/P(t))**(-E) * Y(t);
E_W(t)    $ (ord(t) gt 1)..                         theta(t)*L(t) =e= MyL * ((W(t)/theta(t))/P(t))**(-E)*Y(t);
E_P(t)    $ (ord(t) gt 1)..                         P(t)*Y(t)     =e= (uc(t-1)*K(t-1))/(1+g) + W(t)*L(t);
E_uc(t)   $ (ord(t) lt card(t))..                   uc(t)         =e= r(t+1) + delta(t);
E_I(t)    $ (ord(t) gt 1)..                         K(t)          =e= (1-delta(t))*K(t-1)/(1+g) + I(t);
E_C(t)    $ (ord(t) gt 1 and ord(t) lt card(t))..   C(t+1)*(1+g)  =e= ((1+r(t+1))/(1+eta))**(1/rho)*C(t);
E_Y(t)    $ (ord(t) gt 1)..                         Y(t)          =e= C(t) + I(t);
E_V(t)    $ (ord(t) gt 1 and ord(t) lt card(t))..   V(t+1)*(1+g)  =e= (1+r(t+1))*V(t) - (P(t+1)*Y(t+1)*(1+g) - w(t+1)*L(t+1)*(1+g) - P(t+1)*I(t+1)*(1+g));
E_Cterm..                                           C('t100')     =e= C('t99');
E_Vterm..                                           V('t100')     =e= V('t99');
E_ucterm..                                          uc('t100')    =e= uc('t99');

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

*Antagelser: p er numeriere. w sættes =1 i udgangspunktet.
p.fx(t)     = 1; 
w.l(t)      = 1;
r.l(t)      =0.05;

* Initialisering
L.fx(t)     = IO('lon','PS');
C.l(t)      = IO('PS','C');
I.l(t)      = IO('PS','I');
Y.l(t)      = sum(j,IO(j,'PS'));

* Kalibrering - delta kommer fra noten. 
eta.fx      = (1+r.l('t0'))/(1+g.l)**rho.l-1;
delta.fx(t) = 2*r.l('t0')-3*g.l; 

* Initialisering
K.fx('t0')  = IO('PS','I')*((1+g.l))/(delta.l('t0')+g.l);
K.l(t)      = K.l('t0');
uc.l(t)     = r.l(t) + delta.l(t);
V.l(t)      = ( p.l(t)*Y.l(t) - w.l(t)*L.l(t) - p.l(t)*I.l(t) ) / ((r.l(t)-g.l)/(1+g.l));

* Kalibrering
MyL.fx      =  IO('lon','PS')/sum(j,IO(j,'PS'));
MyK.fx      =  (K.l('t0')/(1+g.l))/Y.l('t0')*(r.l('t0')+delta.l('t0'))**E.l;


Solve Ramsey using CNS;

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







