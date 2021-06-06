* sets
* Husholdninger 
set i /1*6/;

* Firmaer
set g /1*8/;
alias(g,gg);

set t /1*30/;


variables
X(i,g)
p(g)
mu(i)
;

parameters
alpha(i,g)
b(i,g)
beta1(i,g)
beta2(i,g)
;

Equations
E_demand(i,g)
E_budget(i)
;

*Forbrugernes efterspørgsel
E_demand(i,g) $(ord(g) lt 8)..       p(g)*x(i,g) =e= p(g)*b(i,g) + alpha(i,g)*(mu(i)-sum(gg,p(gg)*b(i,gg)));
*Forbrugernes budgetbegrænsning - sikrer identifikation af den udeladte vare.
E_budget(i)..         sum(g,p(g)*x(i,g)) =e= mu(i);

*kalibrering
$include Data_LES_RLK.gms

alpha(i,g)=alphas(i,g);
b(i,g)=min_cons(i,g);
beta1(i,g)=beta1est(i,g);
beta2(i,g)=beta2est(i,g);

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
p.fx('2')=1.0;
p.fx('4')=1.5;
p.fx('5')=1.7;
p.fx('6')=1.0;

solve partial using CNS;
x_resul(i,g,'shock')=x.l(i,g);
sigma(g)=p_0(g)/(p.l(g));
EVLES(i,'shock')= mu.l(i)*(prod(g,sigma(g)**alpha(i,g))-1)   +  sum(g,p_0(g)*b(i,g)) -  prod(g,  sigma(g)**alpha(i,g))*sum(gg,b(i,gg)*p.l(gg))   ;
EVLESinc(i,'shock') = EVLES(i,'shock')/mu.l(i);

Parameter EVinc_t(i,t)
EVLES_t(i,T)
b_resul(i,g,t)
x_resul_t(i,g,t)
CS_g(i,g,t)
CS_inc(i,t)
delta_x_avg(g,t)
x_kraka_t(i,g,t)
CS_kraka_g(i,g,t)
CS_kraka_inc(i,t)
;
loop(t,
   solve partial using CNS;

*  storing results -------------------------
    sigma(g)=p_0(g)/(p.l(g));
    EVLES_t(i,t)= mu.l(i)*(prod(g,sigma(g)**alpha(i,g))-1)   +  sum(g,p_0(g)*b(i,g)) -  prod(g,  sigma(g)**alpha(i,g))*sum(gg,b(i,gg)*p.l(gg))   ;
    EVinc_t(i,t) = EVLES_t(i,t)/mu.l(i);
    CS_g(i,g,t) = x.l(i,g)*( p.l(g) - p_0(g) ) + (x_resul(i,g,'nul') - x.l(i,g) )*( p.l(g) - p_0(g) )*0.5; 
    CS_inc(i,t)   =  sum(g, CS_g(i,g,t) )/mu.l(i);
    b_resul(i,g,t) = b(i,g);
    x_resul_t(i,g,t) = x.l(i,g);
    delta_x_avg(g,t) = x.l('6',g)/x_resul('6',g,'nul');
    x_kraka_t(i,g,t) = x_resul(i,g,'nul')*delta_x_avg(g,t);
    CS_kraka_g(i,g,t) = x_kraka_t(i,g,t)*( p.l(g) - p_0(g) ) + (x_resul(i,g,'nul') - x_kraka_t(i,g,t) )*( p.l(g) - p_0(g) )*0.5; 
    CS_kraka_inc(i,t)   =  sum(g, CS_kraka_g(i,g,t) )/mu.l(i);
    

*  updating the minimum consumption --------------
*    b(i,g)       = 0.85*b(i,g);
    b(i,g)       =  beta1(i,g)*x.l(i,g) + beta2(i,g)*b(i,g);
    
*    mu.fx(i) = mu.l(i)*1.02;
);
