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
b(i,g)'minimumsforbrug'
L 'offforbrug'
exp(i) 'total expenditure'
supernum(i) 'supernumeraryincome'
alpha(i,g) 'marginal budget share'
;

*Eksogene variable
variables
T_total(i)
Gov_spdg;

*Parametre

parameters
abate 'copeland parameter'


phi(i) 'produktivitet i husholding i'
epsilon(g) 'forurening'
r 'CES parameter'
s 'elasticity of substitution'
tau_p 'co2-skat'
tau_w(i) 'wage tax'
;

equations
*FirmProd(g)
SUPERNUMeq(i)
HHFOC1(i,g)
*HHBudget(i)
;

*HHFOC1(i,g)$(ord(g) lt 8)..    p(g)*(x(i,g)-b(i,g))  =e= (alpha(i,g)/alpha(i,g+1))*((x(i,g+1)-b(i,g+1))*p(g+1));
SUPERNUMeq(i)..                     supernum(i) =e=  exp(i) - sum(g,p(g)*b(i,g));
HHFOC1(i,g)..         p(g)*x(i,g) =e= p(g)*b(i,g) + alpha(i,g)*supernum(i);
*HHBudget(i)..                       sum(g,p(g)*x(i,g)) =e= exp(i);

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

alpha.l(i,g)=alphas(i,g)

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

b.fx(i,g)=min_cons(i,g)/1000;

display b.l;

Table cons(i,g) "samlet forbrug"
    1       2       3       4       5       6       7       8
1   10256   21605   53703   21172   4269    19137   32006   44053
2   11974   24952   60790   22313   5245    25933   39999   60168
3   15165   31208   76997   26468   8292    37151   52196   84311
4   16065   33840   82148   26185   10166   44085   61141   92510
5   17722   37644   115872  27160   10329   62408   85645   114118
;

x.fx(i,g) = cons(i,g)/1000;
exp.fx(i) = sum(g,x.l(i,g));
p.fx(g)=1;
supernum.l(i) = exp.l(i)-sum(g,p.l(g)*b.l(i,g));


Model calib /all/;
Solve calib using cns;