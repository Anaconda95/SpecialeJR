
* sets
* Husholdninger 
set i /1*5/;


* Firmaer
set g /1*8/;
alias(g,gg);


*Variable
variables
transfers(i)
Lumpsum
Gov_unprod
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
sub
mu(g)
;

parameters
abate
rho(i)  "produktivitets-parameter for HH"
tau(g)   "Forbrugsskat"
share(g,i)
alpha(i,g)
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
Husholdning;


*Virksomehdernes efterspørgsel

numeraire..               w                    =e=     1;

varermarked(g)..         Y(g)                  =e=     sum(i,X(i,g));

*#FirmProd(g)..           Y(g)                   =e=     (epsilon(g)*L(g)**r + (1-epsilon(g))*Z(g)**r)**(1/r);

FirmFOC1(g)..
                         w                     =e=     epsilon(g)*L(g)**(r-1)*Y(g)**(1-r)*p(g);
FirmFOC2(g)..
                         tau_P(g)              =e=     (1-epsilon(g))*Z(g)**(r-1)*Y(g)**(1-r)*p(g);

Nulprofit(g)..           w*L(g)+tau_P(g)*Z(g)  =e=     tau_fradrag(g) + p(g)*Y(g);


Copeland(g)..            Z(g)                  =l=     abate*L(g);

Arbejd..                sum(g,L(g))            =e=     sum(i,rho(i)*N);

*** Husholdninger: 
Husholdning(i)..         rho(i)*N*w            =e=  sum(g,X(i,g));


Offentlig..            sum(g,tau_P(g)*Z(g))    =e=  sum(g,tau_fradrag(g)) + Gov_unprod;



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

*#  Produktionen i hver forbrugsgruppe må være lig forbruget - vi tager udgangspunkt i forbruget ! 
Y.l(g) = sum(i,X.l(i,g));

## CO2 koefficienter ud fra forbrug som produktion 
epsilon(g) = 1 - Emissions(g)/sum(i,X.l(i,g));

L.l(g) = (epsilon(g)*Y.l(g)**(1-r)*p.l(g))**(-1/(r-1));

N.l = sum(g,L.l(g))/sum(i,rho(i));

Z.l(g) = Emissions(g);

*#tau_P.l = (1-epsilon('1'))*Z.l('1')**(r-1)*Y.l('1')**(1-r)*p.l('1');

Model firms /FirmFOC1, FirmFOC2, Nulprofit, Copeland, Arbejd, numeraire/;
**solve firms using cns;

*********** 'starter med L'
*Y.fx(g) = sum(i,X.l(i,g));
p.fx(g) = 1;

model labor /numeraire,FirmFOC1/;
*solve labor using cns;


 
parameter LL(g) "L fundet i løsning" 
/1	  72893.0605
2	 150429.1065
3	 410124.9038
4	 113139.1730
5	  39754.4003
6	 187323.4576
7	 254753.6586
8	 410877.8299/
;


L.l(g) = LL(g);

N.l = sum(g,L.l(g))/sum(i,rho(i));

model arb /numeraire, FirmFOC1, Arbejd/;
*solve arb using cns;


**
**** 'N fundet i løsning'
N.l = 1639295.5902;


*Z.fx(g) = Emissions(g);

tau_P.l(g) = (1-epsilon(g))*Z.l(g)**(r-1)*Y.l(g)**(1-r)*p.l(g);

model tau_PP /numeraire, FirmFOC1, Arbejd, FirmFOC2/;
**solve tau_PP using cns;

parameter tauPP(g) "tau_P fundet i løsning"
/1 32.8289
2  23.5632
3  75.1649
4  11.5784
5  43.8083
6  29.3278
7  48.2093
8  51.6003/;

tau_P.l(g) = tauPP(g);
Z.l(g) = Emissions(g);

tau_fradrag.l(g) = w.l*L.l(g)+tau_P.l(g)*Z.l(g) -p.l(g)*Y.l(g);



*solve firms using cns; 

parameter skattefradrag(g) "skattefradrag fra løsning"
/1   72893.0605
2    150429.1065
3    410124.9038
4    113139.1730
5     39754.4003
6    187323.4576
7    254753.6586
8    410877.8299/;



tau_fradrag.fx(g) = skattefradrag(g);
N.fx = 1639295.5902;

Lumpsum.fx=0;

Gov_unprod.l =  sum(g,tau_P.l(g)*Z.l(g)) -sum(g,tau_fradrag.l(g)); 

X.fx(i,g) = X.l(i,g);

model govv /FirmFOC1, FirmFOC2, Nulprofit, Copeland,  numeraire, varermarked, offentlig/;
*solve govv using cns;

gov_unprod.l = 22879.6798  ;

** 'husholdninger'
Y.fx(g) = Y.l(g);
model hh /numeraire, varermarked, husholdning/;
**solve hh using cns;

parameter husind(i);
husind(i) = rho(i)*N.l+ rho(i)*Gov_unprod.l;
parameter husforbrug(i);
husforbrug(i) = sum(g,X.l(i,g));
parameter husdiff(i);
husdiff(i) = husind(i)-husforbrug(i);
parameter sumdiff;
sumdiff = sum(i, husdiff(i));

** Den samlede forskel i indkomst og forbrug udgøres præcis af den mængde indkomst staten har til overs.
** Man kan godt antage, at det i stedet er forbrugerne, der får løn af at eje kapitalen til forurening 
** Man kan fastsætte en fordelingsnøgle i basis-forløbet, som man beholder til senere. 
** Det er lidt ærgerligt, at fordelingsnøglen fra data ikke virker.... 

display husind, husforbrug, husdiff, sumdiff, gov_unprod.l;
*display epsilon;







