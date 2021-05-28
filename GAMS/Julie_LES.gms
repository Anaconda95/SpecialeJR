
* sets
* Husholdninger 
set i /1*5/;


* Firmaer
set g /1*8/;
alias(g,gg);


*Variable
variables
*b(i,g)
*alpha(i,g)
transfers(i)
Lumpsum
Gov_unprod
gov_spdg
Tau_fradrag(g)
Tau_P(g) 
Z(g)   "Forurenings-input"
L(g)   "Arbejdskraftsinput"
w
Y(g)
p(g)
p_C(i)
N
X(i,g)  "Privat forbrug"
Gov  "Offentlig produktions"
X_total(g)
EV(i)
EV_p(i)
EV_I(i)
p_C_0(i)
w_0
N_0
EV_pct(i)
EV_p_pct(i)
Y_G
L_G
p_G
X_D_rel(i)
X_D_0(i)
sub(i)
mu(g)
ind(i)
;

parameters
abate
rho(i)  "produktivitets-parameter for HH"
tau(g)   "Forbrugsskat"
share(g,i)
alpha(i,g)
b(i,g)
epsilon(g)
r
;

equations
FirmProd
FirmFOC1
FirmFOC2
Nulprofit
Copeland
Arbejd
numeraire
varermarked
offentlig
Budget
LES;


*Virksomehdernes efterspørgsel


FirmFOC1(g)..            w                     =e=     epsilon(g)*L(g)**(r-1)*Y(g)**(1-r)*p(g);

FirmFOC2(g)..
                         tau_P(g)              =e=     (1-epsilon(g))*Z(g)**(r-1)*Y(g)**(1-r)*p(g);


Nulprofit(g)..           w*L(g)+tau_P(g)*Z(g)  =e=     tau_fradrag(g) + p(g)*Y(g);


Copeland(g)..            Z(g)                  =l=     abate*L(g);


Arbejd..                sum(g,L(g))            =e=     sum(i,rho(i)*N);


LES(i,g)..    p(g)*(X(i,g)-b(i,g))    =e=       (alpha(i,g)/alpha(i,g+1))*(X(i,g+1)-b(i,g+1))*p(g+1);


Budget(i)..            sum(g,p(g)*X(i,g))      =e=       rho(i)*N*w  + Lumpsum ;


Offentlig..            Gov_spdg                =e=       sum(g,tau_P(g)*Z(g)) - sum(g,tau_fradrag(g)) - Lumpsum*5;
 
numeraire..               w                    =e=       1;

varermarked(g)..         Y(g)                  =e=       sum((i),X(i,g)) + Gov_spdg/(8);



********** Kalibrering *********

@import_from_modules("Data_LES")  
parameter s;
s            = 0.5;     
abate        = 1;
r            = 1-1/s;  

rho(i) = cons_share(i);

w.l = 1;

p.fx(g) = 1;
*# p.l(g) = prices(g);


X.l(i,g) = cons(i,g)*prices(g);


************* "Nok smart at starte det hele med husholdningernes forbrug"
** 'husholdninger'
** kalibrere b'erne så de passer til X'er

***** "Problem: vi kan ikke kalibrere b'erne, da den ikke kan løses. Vi kan godt kalibrere alphaerne"
****** "Problem: den kan ikke løse ligningerne, hvis X eller b er endogene"

* Midlertidige p'er
parameter pris_kali;
pris_kali = 1;
equations LES_kali1, LES_kali2;
*LES_kali1(g)..    X('2',g) - b('2',g) =e= (alpha('2',g)/pris_kali)*(ind('2')-sum(gg,pris_kali*b('2',gg)));
*LES_kali2..      ind('2') =e= sum(g,X('2',g)*pris_kali);

*LES_kali1(g)..    X('3',g) - b('3',g) =e= (alpha('3',g)/pris_kali)*(ind('3')-sum(gg,pris_kali*b('3',gg)));
*LES_kali2..      ind('3') =e= sum(g,X('3',g)*pris_kali);

LES_kali1(g)..    X('5',g) - b('5',g) =e= (alpha('5',g)/pris_kali)*(ind('5')-sum(gg,pris_kali*b('5',gg)));
LES_kali2..      ind('5') =e= sum(g,X('5',g)*pris_kali);

equations LES2;
LES2(g)..    pris_kali*(X('2',g)-b('2',g))    =e=       (alpha('2',g)/alpha('2',g+1))*(X('2',g+1)-b('2',g+1))*pris_kali;


*** "Status: Den kan godt løse X for hh 2, 3 og 5 for de ny-kalibrerede alphaer - men ikke den relative efterspørgsel"
X.l(i,g) = X.l(i,g);
*alpha.l(i,g) = alphas(i,g);
alpha(i,g) = alphak(i,g);
b(i,g) = min_cons(i,g)*prices(g);
p.fx(g) = 1;
ind.l(i) = sum(g,X.l(i,g));
b(i,g) =0;

model hh /LES2/;
solve hh using cns;

*** 'har løst for alphaer:'
*
*
*

**#  Indkomsten i hver kvintil, må være lig forbruget 
**# Så for priser lig 1, er:
*L.l(g)= sum(i,X.l(i,g));
*
**## CO2 koefficienter ud fra forbrug som produktion 
**## epsilon er labor share
*epsilon(g) = 1 - Emissions(g)/sum(i,X.l(i,g));
*
*N.l = sum(g,L.l(g))/sum(i,rho(i));
*
*Z.l(g) = Emissions(g);
*
**#tau_P.l = (1-epsilon('1'))*Z.l('1')**(r-1)*Y.l('1')**(1-r)*p.l('1');
*
*Model firms /FirmFOC1, FirmFOC2, Nulprofit, Copeland, Arbejd, numeraire/;
***solve firms using cns;
*
************* 'starter med Y'
**L.fx(g)= sum(i,X.l(i,g));
*Y.l(g) = (w.l/(epsilon(g)*L.l(g)**(r-1)))**(1/(1-r));
*p.fx(g) = 1;
*
*model labor /numeraire,FirmFOC1/;
**solve labor using cns;
*
*
* 
*parameter YY(g) "Y fundet i løsning" 
*/1	  75183.2103
*2	 157096.1108
*3	 415654.8122
*4	 123834.4645
*5	  40683.0606
*6	 193936.1735
*7	 260149.9189
*8	 418997.8972/
*;
*
*Y.l(g) = YY(g);
*
*N.l = sum(g,L.l(g))/sum(i,rho(i));
*
*model arb /numeraire, FirmFOC1, Arbejd/;
**solve arb using cns;
*
****** 'N fundet i løsning'
*N.l = 1662175.2700;
*
*
**Z.fx(g) = Emissions(g);
*
*tau_P.l(g) = (1-epsilon(g))*Z.l(g)**(r-1)*Y.l(g)**(1-r)*p.l(g);
*
*model tau_PP /numeraire, FirmFOC1, Arbejd, FirmFOC2/;
**solve tau_PP using cns;
*
*parameter tauPP(g) "tau_P fundet i løsning"
*/1 33.8604
*2  24.6075
*3  76.1783
*4  12.6729
*5  44.8317
*6  30.3631
*7  49.2305
*8  52.6201/;
*
*tau_P.l(g) = tauPP(g);
*Z.l(g) = Emissions(g);
*
*tau_fradrag.l(g) = w.l*L.l(g)+tau_P.l(g)*Z.l(g) -p.l(g)*Y.l(g);
*
*model fradrag /numeraire, FirmFOC1, Arbejd, FirmFOC2, Nulprofit/;
**solve fradrag using cns;
*
*
*parameter skattefradrag(g) "skattefradrag fra løsning"
*/1    75201.1972
*2    157169.9723
*3    415673.4526
*4    124087.0979
*5     40688.4838
*6    193994.5281
*7    260178.4944
*8    419038.0149/;
*
*
*
*tau_fradrag.fx(g) = skattefradrag(g);
*N.fx = N.l;
*
*Lumpsum.fx=0;
*
*gov_spdg.l = sum(g,Y.l(g))-sum((i,g),X.l(i,g));
*
*X.fx(i,g) = X.l(i,g);
*
*model govv /FirmFOC1, FirmFOC2, Nulprofit, Copeland,  numeraire, varermarked, offentlig/;
**solve govv using cns;
*
*
***** 'gov psdg fra løsning'
*gov_spdg.l = 23276.7515   ;
*
*
*
*
*parameter husind(i);
*husind(i) = rho(i)*N.l+ rho(i)*Gov_unprod.l;
*parameter husforbrug(i);
*husforbrug(i) = sum(g,X.l(i,g));
*parameter husdiff(i);
*husdiff(i) = husind(i)-husforbrug(i);
*parameter sumdiff;
*sumdiff = sum(i, husdiff(i));
*
*** Den samlede forskel i indkomst og forbrug udgøres præcis af den mængde indkomst staten har til overs.
*** Man kan godt antage, at det i stedet er forbrugerne, der får løn af at eje kapitalen til forurening 
*** Man kan fastsætte en fordelingsnøgle i basis-forløbet, som man beholder til senere. 
*** Det er lidt ærgerligt, at fordelingsnøglen fra data ikke virker.... 
*
*display husind, husforbrug, husdiff, sumdiff, gov_unprod.l;
**display epsilon;



****** "Prøver at skrive hele modellen op"
gov_spdg.l = 23276.7515   ;
X.l(i,g) = cons(i,g)*prices(g);
N.fx = 1662175.2700;
Z.fx(g) = Emissions(g);
tau_P.l(g) = tauPP(g);
Lumpsum.fx=0;
Y.l(g) = YY(g);
tau_fradrag.fx(g) = skattefradrag(g);
epsilon(g) = 1 - Emissions(g)/sum(i,X.l(i,g));
L.fx(g)= sum(i,X.l(i,g));
*alpha.fx(i,g) =alphak(i,g);
*b.fx(i,g) =  min_cons(i,g)*prices(g);


Model model1 /FirmFOC1,FirmFOC2,Nulprofit,Copeland,Arbejd,LES,Budget,offentlig,numeraire,varermarked/;
*solve model1 using cns;





