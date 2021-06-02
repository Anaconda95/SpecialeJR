********** Lille model med offentlig sektor (dvs ingen omfordeling) *************

* sets
* Husholdninger 
set i /1*5/;

* Firmaer
set g /1*8/;
alias(g,gg);

*Endogene variable
variables
w 'loen'
t(g) 'labour input'
F(g) 'produktion'
z(g) 'polluion'
p(g) 'priser'
x(i,g) 'forbrug af vare g i husholdninger'
L 'offforbrug'
;

*Eksogene variable
variables
T_total(i)
Gov_spdg; 
*Parametre

parameters
abate 'copeland parameter'
b(i,g)'minimumsforbrug'
alpha(i,g) 'marginal budget share'
phi(i) 'produktivitet i husholding i'
epsilon(g) 'forurening'
r 'CES parameter'
s 'elasticity of substitution'
tau_p 'co2-skat'
tau_w(i) 'wage tax'
;

equations
*FirmProd(g)
FirmFOC1(g)
FirmFOC2(g)
NulProfit(g)
Copeland(g)
TimeConstr
HHFOC1(i,g)
HHBudget(i)
Lumpsum
Numeraire
GenEq(g)
; 
*FirmProd(g)..                               F(g)     =e=    (epsilon(g)*T(g)**r + (1-epsilon(g))*Z(g)**r)**(1/r); 
FirmFOC1(g)..                                    w   =e=     epsilon(g)    *T(g)**(r-1)*F(g)**(1-r)*p(g);
FirmFOC2(g)..                                 tau_P  =e=     (1-epsilon(g))*Z(g)**(r-1)*F(g)**(1-r)*p(g);
Nulprofit(g)..                   w*T(g) + tau_P*Z(g) =e=     p(g)*F(g);
Copeland(g)..                                Z(g)    =l=     abate*T(g);
TimeConstr..                                  0      =e=     sum(g, T(g) ) -sum(i, phi(i) *T_total(i)  );
HHFOC1(i,g)$(ord(g) lt 8)..    p(g)*(x(i,g)-b(i,g))  =e= (alpha(i,g)/alpha(i,g+1))*((x(i,g+1)-b(i,g+1))*p(g+1));
HHBudget(i)..                   sum(g,p(g)*x(i,g)) =e= (1-tau_w(i))*phi(i)*w*T_total(i) + L;
Lumpsum..                                 Gov_spdg   =e= sum(g,tau_P*z(g)) + sum(i,tau_w(i)*phi(i)*w*T_total(i)) - L*card(i)  ;
Numeraire..                                      w   =e= 1;
GenEq(g)$(ord(g) lt 8)..                        F(g) =e= sum(i,X(i,g)) + gov_spdg/( p(g)*card(g)  );

***********************************************************************************************************************
************************************ Kalibrering **********************************************************************
***********************************************************************************************************************

*Parametre
abate=1;


Table alphas(i,g) "Alphaer"
    1     2     3     4     5     6     7     8
1   0.008 0.032 0.131 0.105 0.03  0.231 0.291 0.172   
2   0.039 0.081 0.104 0.029 0.025 0.276 0.244 0.202
3   0.034 0.067 0.122 0.122 0.025 0.244 0.169 0.217
4   0.029 0.037 0.11  0.068 0.018 0.207 0.286 0.244
5   0.028 0.036 0.072 0.112 0.03  0.241 0.293 0.188
;

alpha(i,g)=alphas(i,g)

Table min_cons(i,g) "b'er"
    1       2       3       4       5       6       7       8
1   10821   21847   42808   14298   2399    6665    19287   33753
2   11143   22634   53459   17990   4850    5361    34469   55109
3   13129   26875   64495   18501   6440    16588   38986   64683
4   15838   31219   76719   24004   8812    36676   51615   87761
5   14087   32069   99980   18914   8167    35575   40409   86531
;
*** må justere 1,1 og 1,2 lidt ned, da de er højere end cons
min_cons("1","1") = 10100;
min_cons('1','2') = 21500;

b(i,g)=min_cons(i,g)/1000;

display b;

Table cons(i,g) "samlet forbrug"
    1       2       3       4       5       6       7       8
1   10256   21605   53703   21172   4269    19137   32006   44053
2   11974   24952   60790   22313   5245    25933   39999   60168
3   15165   31208   76997   26468   8292    37151   52196   84311
4   16065   33840   82148   26185   10166   44085   61141   92510
5   17722   37644   115872  27160   10329   62408   85645   114118
;

x.l(i,g) = cons(i,g)/1000;

Parameter cons_share(i) "kvintilers forbrugsandel"
/1   0.126784
2   0.154558
3   0.204001
4   0.225123
5   0.289534/
;

phi(i)=cons_share(i);

Parameter CO2_koef(g) "Varegruppernes co2-andel af produktion"
/1   0.0823176
2   0.129274392
3   0.024987882
4   0.401554549
5   0.115478351
6   0.113095265
7   0.052594913
8   0.034791298/
;

epsilon(g)=1-CO2_koef(g);

*Sætter skatterne lig nul.
tau_w(i)=0;

s=0.5;
r    = 1-1/s;

*Kalibrering
w.l=1;
*T_total.fx(i)=24;
Gov_spdg.fx=3;
p.l(g)=1;
tau_p=1.5;

F.l(g)  = sum(i,x.l(i,g));
T.l(g)  = ( w.l/ ( epsilon(g)*F.l(g)**(1-r)*p.l(g) ))**(1/(r-1));
T_total.fx(i)=sum(g,T.l(g));

z.l(g) = (tau_p/((1-epsilon(g))*F.l(g)**(1-r)*p.l(g)))**(1/(r-1));
L.l = (sum(g,tau_P*z.l(g)) + sum(i,tau_w(i)*phi(i)*w.l*T_total.l(i)) - Gov_spdg.l)/card(i);

******
*Checking calibration
******
Parameters
xtot_pre(g)
xtot(g);

xtot_pre(g)=sum(i, x.l(i,g));
Model Klenert /all/;

Solve Klenert using cns;

xtot(g)=sum(i, x.l(i,g));

$ontext  

Parameters
m(i) 'samlet forbrug til i'
p_0 'priser i basisforløb'
sigma(g) 'hjælpevariabel til EV-mål'
EVLES(i)  'EV-mål'
EVLESdivinc(i) 'EV/indkomst';

m(i)=w.l*phi(i)*T_total.l(i)+L.l;
p_0(g)=p.l(g);
sigma(g)=p_0(g)/p.l(g);

EVLES(i)= m(i)*(  prod(g,sigma(g)**alpha(i,g))-1  )+  sum(g,p_0(g)*b(i,g)) - prod(g,sigma(g)**alpha(i,g))*(sum(g,p.l(g)*b(i,g)));

display EVLES;

*Test om man kan hæve skatten - det kan man, og prisen på det forurenende gode stiger.
*lgie her kan man ikke hæve den for meget....
tau_P=2;
Solve Klenert using cns;

m(i)=w.l*phi(i)*T_total.l(i)+L.l;
sigma(g)=p_0(g)/p.l(g);
EVLES(i)= m(i)*(  prod(g,sigma(g)**alpha(i,g))-1  )+  sum(g,p_0(g)*b(i,g)) - prod(g,sigma(g)**alpha(i,g))*(sum(g,p.l(g)*b(i,g)));

EVLESdivinc(i) = EVLES(i)/m(i);
display EVLESdivinc;


  

$offtext
