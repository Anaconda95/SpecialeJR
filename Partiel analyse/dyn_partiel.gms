* sets
* Husholdninger 
set i /1*6/;

* Firmaer
set g /1*8/;
alias(g,gg);

set t /2018*2040/;


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
disp_inc(i)
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
disp_inc(i)=disp_inc_data(i);

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

solve partial using CNS;
x_resul(i,g,'shock')=x.l(i,g);
sigma(g)=p_0(g)/(p.l(g));
EVLES(i,'shock')= mu.l(i)*(prod(g,sigma(g)**alpha(i,g))-1)   +  sum(g,p_0(g)*b(i,g)) -  prod(g,  sigma(g)**alpha(i,g))*sum(gg,b(i,gg)*p.l(gg))   ;
EVLESinc(i,'shock') = EVLES(i,'shock')/mu.l(i);

Parameter EVexp_t(i,t)
EVdispinc_t(i,t)
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

Table p_1250indfast_frem(g,t)
  2018 2019 2020 2021 2022 2023 2024 2025   2026   2027   2028   2029   2030   2031   2032   2033   2034   2035   2036   2037   2038   2039   2040
1    1    1    1    1    1    1    1    1 1.0091 1.0176 1.0261 1.0339 1.0416 1.0416 1.0416 1.0416 1.0416 1.0416 1.0416 1.0416 1.0416 1.0416 1.0416
2    1    1    1    1    1    1    1    1 1.0042 1.0081 1.0119 1.0154 1.0187 1.0187 1.0187 1.0187 1.0187 1.0187 1.0187 1.0187 1.0187 1.0187 1.0187
3    1    1    1    1    1    1    1    1 1.0018 1.0035 1.0051 1.0064 1.0077 1.0077 1.0077 1.0077 1.0077 1.0077 1.0077 1.0077 1.0077 1.0077 1.0077
4    1    1    1    1    1    1    1    1 1.0085 1.0147 1.0192 1.0204 1.0222 1.0222 1.0222 1.0222 1.0222 1.0222 1.0222 1.0222 1.0222 1.0222 1.0222
5    1    1    1    1    1    1    1    1 1.0625 1.1224 1.1793 1.2348 1.2853 1.2853 1.2853 1.2853 1.2853 1.2853 1.2853 1.2853 1.2853 1.2853 1.2853
6    1    1    1    1    1    1    1    1 1.0017 1.0032 1.0046 1.0058 1.0070 1.0070 1.0070 1.0070 1.0070 1.0070 1.0070 1.0070 1.0070 1.0070 1.0070
7    1    1    1    1    1    1    1    1 1.0023 1.0043 1.0062 1.0078 1.0093 1.0093 1.0093 1.0093 1.0093 1.0093 1.0093 1.0093 1.0093 1.0093 1.0093
8    1    1    1    1    1    1    1    1 1.0019 1.0036 1.0052 1.0064 1.0077 1.0077 1.0077 1.0077 1.0077 1.0077 1.0077 1.0077 1.0077 1.0077 1.0077
;

Table p_1250straks_frem(g,t)
  2018 2019 2020 2021   2022   2023   2024   2025   2026   2027   2028   2029   2030   2031   2032   2033   2034   2035   2036   2037   2038   2039   2040
1    1    1    1    1 1.0464 1.0461 1.0477 1.0466 1.0455 1.0440 1.0435 1.0424 1.0416 1.0416 1.0416 1.0416 1.0416 1.0416 1.0416 1.0416 1.0416 1.0416 1.0416
2    1    1    1    1 1.0228 1.0222 1.0225 1.0218 1.0212 1.0204 1.0199 1.0192 1.0187 1.0187 1.0187 1.0187 1.0187 1.0187 1.0187 1.0187 1.0187 1.0187 1.0187
3    1    1    1    1 1.0108 1.0102 1.0099 1.0095 1.0091 1.0088 1.0084 1.0080 1.0077 1.0077 1.0077 1.0077 1.0077 1.0077 1.0077 1.0077 1.0077 1.0077 1.0077
4    1    1    1    1 1.8741 1.0596 1.0526 1.0471 1.0424 1.0367 1.0320 1.0255 1.0222 1.0222 1.0222 1.0222 1.0222 1.0222 1.0222 1.0222 1.0222 1.0222 1.0222
5    1    1    1    1 1.3317 1.3288 1.3249 1.3161 1.3126 1.3059 1.2988 1.2935 1.2853 1.2853 1.2853 1.2853 1.2853 1.2853 1.2853 1.2853 1.2853 1.2853 1.2853
6    1    1    1    1 1.0099 1.0094 1.0091 1.0088 1.0084 1.0080 1.0077 1.0073 1.0070 1.0070 1.0070 1.0070 1.0070 1.0070 1.0070 1.0070 1.0070 1.0070 1.0070
7    1    1    1    1 1.0134 1.0126 1.0124 1.0118 1.0113 1.0108 1.0103 1.0097 1.0093 1.0093 1.0093 1.0093 1.0093 1.0093 1.0093 1.0093 1.0093 1.0093 1.0093
8    1    1    1    1 1.0114 1.0109 1.0106 1.0101 1.0096 1.0091 1.0086 1.0081 1.0077 1.0077 1.0077 1.0077 1.0077 1.0077 1.0077 1.0077 1.0077 1.0077 1.0077
;

Table p_landbrugkun_frem(g,t)
  2018 2019 2020 2021   2022   2023   2024   2025   2026   2027   2028   2029   2030   2031   2032   2033   2034   2035   2036   2037   2038   2039   2040
1    1    1    1    1 1.0303 1.0323 1.0368 1.0358 1.0348 1.0330 1.0330 1.0325 1.0319 1.0319 1.0319 1.0319 1.0319 1.0319 1.0319 1.0319 1.0319 1.0319 1.0319
2    1    1    1    1 1.0106 1.0113 1.0129 1.0125 1.0122 1.0116 1.0116 1.0114 1.0112 1.0112 1.0112 1.0112 1.0112 1.0112 1.0112 1.0112 1.0112 1.0112 1.0112
3    1    1    1    1 1.0001 1.0001 1.0001 1.0001 1.0001 1.0001 1.0001 1.0001 1.0001 1.0001 1.0001 1.0001 1.0001 1.0001 1.0001 1.0001 1.0001 1.0001 1.0001
4    1    1    1    1 1.0007 1.0008 1.0009 1.0009 1.0009 1.0008 1.0008 1.0008 1.0008 1.0008 1.0008 1.0008 1.0008 1.0008 1.0008 1.0008 1.0008 1.0008 1.0008
5    1    1    1    1 1.0003 1.0003 1.0003 1.0003 1.0003 1.0003 1.0003 1.0003 1.0003 1.0003 1.0003 1.0003 1.0003 1.0003 1.0003 1.0003 1.0003 1.0003 1.0003
6    1    1    1    1 1.0004 1.0004 1.0005 1.0004 1.0004 1.0004 1.0004 1.0004 1.0004 1.0004 1.0004 1.0004 1.0004 1.0004 1.0004 1.0004 1.0004 1.0004 1.0004
7    1    1    1    1 1.0028 1.0030 1.0034 1.0033 1.0032 1.0031 1.0031 1.0030 1.0030 1.0030 1.0030 1.0030 1.0030 1.0030 1.0030 1.0030 1.0030 1.0030 1.0030
8    1    1    1    1 1.0016 1.0017 1.0020 1.0019 1.0018 1.0018 1.0018 1.0017 1.0017 1.0017 1.0017 1.0017 1.0017 1.0017 1.0017 1.0017 1.0017 1.0017 1.0017
;
Table p_udenbenz_frem(g,t)
  2018 2019 2020 2021 2022 2023 2024 2025   2026   2027   2028   2029   2030   2031   2032   2033   2034   2035   2036   2037   2038   2039   2040
1    1    1    1    1    1    1    1    1 1.0091 1.0176 1.0261 1.0339 1.0416 1.0416 1.0416 1.0416 1.0416 1.0416 1.0416 1.0416 1.0416 1.0416 1.0416
2    1    1    1    1    1    1    1    1 1.0042 1.0081 1.0119 1.0154 1.0187 1.0187 1.0187 1.0187 1.0187 1.0187 1.0187 1.0187 1.0187 1.0187 1.0187
3    1    1    1    1    1    1    1    1 1.0018 1.0035 1.0051 1.0064 1.0077 1.0077 1.0077 1.0077 1.0077 1.0077 1.0077 1.0077 1.0077 1.0077 1.0077
4    1    1    1    1    1    1    1    1 1.0085 1.0147 1.0192 1.0204 1.0222 1.0222 1.0222 1.0222 1.0222 1.0222 1.0222 1.0222 1.0222 1.0222 1.0222
5    1    1    1    1    1    1    1    1 1.0000 1.0000 1.0000 1.0000 1.0000 1.0000 1.0000 1.0000 1.0000 1.0000 1.0000 1.0000 1.0000 1.0000 1.0000
6    1    1    1    1    1    1    1    1 1.0017 1.0032 1.0046 1.0058 1.0070 1.0070 1.0070 1.0070 1.0070 1.0070 1.0070 1.0070 1.0070 1.0070 1.0070
7    1    1    1    1    1    1    1    1 1.0023 1.0043 1.0062 1.0078 1.0093 1.0093 1.0093 1.0093 1.0093 1.0093 1.0093 1.0093 1.0093 1.0093 1.0093
8    1    1    1    1    1    1    1    1 1.0019 1.0036 1.0052 1.0064 1.0077 1.0077 1.0077 1.0077 1.0077 1.0077 1.0077 1.0077 1.0077 1.0077 1.0077
;

loop(t,
 P.fx(g)=p.l(g)*1.02 
*P.fx(g)=p_1250indfast_frem(g,t);
*   P.fx(g)=p_1250straks_frem(g,t);
*P.fx(g)=p_landbrugkun_frem(g,t);
*P.fx(g)=p_udenbenz_frem(g,t);
*   b(i,g)=0;

   solve partial using CNS;

*  storing results -------------------------
    sigma(g)=p_0(g)/(p.l(g));
    EVLES_t(i,t)= mu.l(i)*(prod(g,sigma(g)**alpha(i,g))-1)   +  sum(g,p_0(g)*b(i,g)) -  prod(g,  sigma(g)**alpha(i,g))*sum(gg,b(i,gg)*p.l(gg))   ;
    EVexp_t(i,t) = EVLES_t(i,t)/mu.l(i);
    EVdispinc_t(i,t) = EVLES_t(i,t)/disp_inc(i);
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
*Letting expenditure rise by 2 pct.
mu.fx(i)   =  mu.l(i)*1.2
    
    
* updating prices
    
*    mu.fx(i) = mu.l(i)*1.02;
);
