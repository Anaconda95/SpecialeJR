* sets
* Husholdninger 
set i /1*5/;

* Firmaer
set g /1*8/;
alias(g,gg);

set t /1*20/;


variables
X(i,g)
p(g)
mu(i)
;

parameters
alpha(i,g)
b(i,g)
;

Equations
E_demand(i,g)
E_budget(i)
;

*Virksomehdernes efterspørgsel
E_demand(i,g) $(ord(g) lt 8)..       p(g)*x(i,g) =e= p(g)*b(i,g) + alpha(i,g)*(mu(i)-sum(gg,p(gg)*b(i,gg)));

E_budget(i)..         sum(g,p(g)*x(i,g)) =e= mu(i);

*kalibrering
Table alphas(i,g) "Alphaer"
    1       2       3       4       5       6       7       8
1   0.008   0.032   0.131   0.105   0.030   0.231   0.291   0.172
2   0.039   0.081   0.104   0.029   0.025   0.276   0.244   0.202
3   0.034   0.067   0.122   0.122   0.025   0.244   0.169   0.217
4   0.034   0.078   0.138   0.077   0.025   0.265   0.199   0.183
5   0.029   0.037   0.110   0.068   0.018   0.207   0.286   0.244
;

Table min_cons(i,g) "b'er"
    1       2       3       4       5      6       7       8
1   10909   21550   48713   13844   2477   7485    18870   40249
2   12183   24504   61209   20266   5261   15140   34093   56516
3   13789   27975   71355   17931   6887   20248   39001   66892
4   15835   30456   78808   20647   9136   32363   46510   82814
5   14664   32489   102284  18966   9092   34011   48831   80181 
;
alpha(i,g)=alphas(i,g);
b(i,g)=min_cons(i,g);


*** må justere 1,1 og 1,2 lidt ned, da de er højere end cons
*min_cons("1","1") = 10100;
*min_cons('1','2') = 21500;


Table cons(i,g) "samlet forbrug - predicted"
     1      2       3        4       5       6       7       8
1   11283   22965   54572    18531   3823    17838   31908   47962
2   13164   26551   63835    20990   5903    22125   40246   61621
3   16193   32784   80140    26684   8714    37740   51101   82459
4   17683   34673   86232    24798   10476   46639   57196   92668
5   18630   37553   117211   28242   11567   62088   87753   113346
;

x.l(i,g)=cons(i,g);
mu.fx(i)=sum(g,x.l(i,g));
p.fx(g)=1;

set stod /kali, nul, shock/;
Parameter x_resul(i,g,stod);
x_resul(i,g,'kali')=x.l(i,g);

*m(hh)=w.l*rho(hh)*N.l;
Parameters p_0(g)
sigma(g)
EVLES(i,stod)
EVLESinc(i,stod)
;
p_0(g)=p.l(g);
sigma(g)=p_0(g)/(p.l(g));

EVLES(i,'kali')= mu.l(i)*(prod(g,sigma(g)**alpha(i,g))-1)   +  sum(g,p_0(g)*b(i,g)) -  prod(g,  sigma(g)**alpha(i,g))*sum(gg,b(i,gg)*p.l(gg))    ;

Model partial /all/;
solve partial using CNS;
x_resul(i,g,'nul')=x.l(i,g);
sigma(g)=p_0(g)/(p.l(g));
EVLES(i,'nul')= mu.l(i)*(prod(g,sigma(g)**alpha(i,g))-1)   +  sum(g,p_0(g)*b(i,g)) -  prod(g,  sigma(g)**alpha(i,g))*sum(gg,b(i,gg)*p.l(gg))   ;
EVLESinc(i,'shock') = EVLES(i,'shock')/mu.l(i);

p.fx('1')=1.8;
p.fx('2')=1.1;
p.fx('4')=1.5;
p.fx('5')=1.5;
p.fx('6')=1.2;

solve partial using CNS;
x_resul(i,g,'shock')=x.l(i,g);
sigma(g)=p_0(g)/(p.l(g));
EVLES(i,'shock')= mu.l(i)*(prod(g,sigma(g)**alpha(i,g))-1)   +  sum(g,p_0(g)*b(i,g)) -  prod(g,  sigma(g)**alpha(i,g))*sum(gg,b(i,gg)*p.l(gg))   ;
EVLESinc(i,'shock') = EVLES(i,'shock')/mu.l(i);

Parameter EVinc_t(i,t)
EVLES_t(i,T);

loop(t,
   solve partial using CNS;

*  storing results -------------------------
   sigma(g)=p_0(g)/(p.l(g));
   EVLES_t(i,t)= mu.l(i)*(prod(g,sigma(g)**alpha(i,g))-1)   +  sum(g,p_0(g)*b(i,g)) -  prod(g,  sigma(g)**alpha(i,g))*sum(gg,b(i,gg)*p.l(gg))   ;
   EVinc_t(i,t) = EVLES_t(i,t)/mu.l(i);

*  updating the state variables --------------
   b(i,g)       =  0.8*b(i,g)
);
