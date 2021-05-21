$oneolcom
********************************************************************************
* Model for assessing the distributional impacts of different revenue recycling*
*  schemes when accounting for pollution-intensive subsistence consumption     *
*  with Stone-Geary utility functions.                                         *                 *
*                                                                              *
* David Klenert, 2014-2015,  Potsdam Institute for Climate Impact Research     *
********************************************************************************

* Pure optimal taxation version
* model operation
Parameter
SWITCH_Diff    activate differentiated income tax cuts
SWITCH_Unif    activate uniform income tax cuts
SWITCH_ULS     activate uniform lump-sum transfers
SWITCH_UnifULS activate uniform income tax cuts plus ULS
SWITCH_Bench
SWITCH_opttax  activate social planner solution and the determination of optimal carbon taxes
SWITCH_optInctax calculate optimal preexisting income tax
SWITCH_optGovBud calculate optimal government budget for a given pre-existing income tax system
SWITCH_DetL0   determine the L0 for the actual system
SWITCH_opttaxsys determine optimal preexisting tax system
SWITCH_OUT     activate output tax instead of pollution tax
SWITCH_noredist activate tax reform but no change in taxes
;
********************************************************************************
*****                      Set model switches                              *****
********************************************************************************
** before environmental tax reform, but determining Lump sum
SWITCH_DetL0     =       1;
** no redistribution, but a tax reform 
SWITCH_noredist  =       0; 
** if this param is set to 1, revenue recycling occurs via differentiated income tax cuts
SWITCH_diff      =       0;
** if this param is set to 1, revenue recycling occurs via uniform income tax cuts
SWITCH_unif      =       0; 
** if this param is set to 1, revenues are recycled via uniform lump-sum transfers
SWITCH_ULS       =       0; 
** after environmental tax reform (both lump-sum and income tax cuts)
Switch_Bench     =       0; 




********************************************************************************
******************            Define SETS                   ********************
********************************************************************************

SETS
i              income quintiles                           / 1*5/
g              type of good                              /1*8/;

** Types of goods: 8
* 1  meat and dairy
* 2  other foods
* 3  housing
* 4  energy, housing
* 5  energy, transport
* 6  transport
* 7  other goods 
* 8  other services

**Alias(g,h);


**********************************************************************************
***********************     'Define variables'          **************************
**********************************************************************************


Variables

***************** 'ENDOGENE VARIABLE' *******************
**** 'firm'
T(g)           labor time in production of good g
Z(g)           pollution in production of good g
Z_total         total pollution
wage           rental price labor
F(g)           production of good g
pr(g)          price of good g


**** 'households'
X(i,g)         amount of good g consumed by hh i
X_totalcons(i) sum of consumption of good g times price(g) for consumer i
lei(i)         leisure of hh i
RealCons(i)    Real consumption pr household


**** 'government'
U(i)           Utility (with environmental component)
U_NE(i)        Non-environmental utility
L              Lump-sum transfers
W              Welfare
W_NE           Non-environmental welfare
gov_unprod     Unproductive government spending
GDP            Sum of all goods multiplied by the prices
RealGDP        Sum of all goods





**************' EKSOGENE variable ' *****************
T_total(i)     total time endowment of agents

** 'taxes'
tau_P          pollution tax
tau_w(i)       non-linear income tax
tau_w_flat     flat income tax rebate







***************** 'post processing' ******************

ConsPor(i,g)   Consumption share of good g of household i
ConsPor_total(i) Total consumption share
UtilPor(i)     Utility share
UtilPor_NE     Utility share non-environmental
gini_C         Gini coefficient consumption
gini_u         Gini coefficient utility
Gini_U_NE      Gini coefficient non-environmental utility
Z_dum          Dummy variable for market solution
;


*******************************************************************************
******************           Define parameters          ***********************
*******************************************************************************

Parameters
**** 'firms'
epsilon(g)     labor intensity in production of good g
s              elasticity of substitution btw. labor and pollution
r              CES Parameter
abate          parameter for labor intensity of pollution in production


**** 'households'
alpha(g)       share of consumption of good g in utility
gamma          leisure exponent in utility
X0(g)          subsistence level consumption of of good g
phi(i)

**** 'government'
xi             environmental preference parameter
theta          exponent of damage function
gov_spdg       government spending requirement

**** 'taxes'
tau_w_preex(i)


**** 'help parameters'
min            minimum value of variables
max            maximum value of variables;






*******************************************************************************
************************      Define equations   ******************************
*******************************************************************************

Equations

FirmProd(g),totalT,FirmFOC1(g),FirmFOC2(g),Copeland(g),HHFOC1(i,g),HHFOC2(i,g),HHFOC3(i),numeraire,
GenEq(g),Utility,Welfare,Tax,AltTax1,AltTax2,Z_totaldef, X_totalconsdef, Inc_constraint,Dummy,GDPcalc,RealGDPcalc,RealConscalc, Utility_NE,Welfare_NE
;
**********************************Firms*****************************************
FirmProd(g)..
                         F(g)                  =e=    (epsilon(g)*T(g)**r + (1-epsilon(g))*Z(g)**r)**(1/r);
FirmFOC1(g)..
                         wage                  =e=     epsilon(g)    *T(g)**(r-1)*F(g)**(1-r)*pr(g);
FirmFOC2(g)..
                         tau_P                 =e=     (1-epsilon(g))*Z(g)**(r-1)*F(g)**(1-r)*pr(g);
totalT..
                         0                     =e=     sum(g,T(g)) -sum(i,phi(i)*(T_total(i)-lei(i)));
Copeland(g)..
                         Z(g)                  =l=     abate*T(g);

********************************Households**************************************

HHFOC1(i,g)$(ord(g) lt 8)..
                         pr(g)*(X(i,g)-X0(g))  =e= (alpha(g)/alpha(g+1))*((X(i,g+1)-X0(g+1))*pr(g+1));

HHFOC2(i,g)..
                         pr(g+7)*(X(i,g+7)-X0(g+7))  =e= (alpha(g+7)/gamma)*lei(i)*( (1-tau_w(i)-tau_w_preex(i)-tau_w_flat)*phi(i)*wage );

HHFOC3(i)..
                         sum(g,X(i,g)*pr(g))   =e= (1-tau_w(i)-tau_w_preex(i)-tau_w_flat)*phi(i)*wage*(T_total(i)-lei(i)) + L;

*****************************Market clearing***********************************
numeraire..
                         wage      =e=     1;
GenEq(g)..
                         F(g)      =e=     sum(i,X(i,g))+ (gov_spdg+gov_unprod)/(pr(g)*card(g));

********************************Government**************************************
Tax..
                         Gov_spdg + gov_unprod   =e=    tau_p*sum(g,Z(g)) + wage*sum(i,(tau_w_preex(i)+tau_w(i)+tau_w_flat)*phi(i)*(T_total(i)-lei(i))) - card(i)*L; 
Z_totaldef..
                         Z_total    =e=    sum(g,Z(g));
X_totalconsdef(i)..
                         X_totalcons(i) =e= sum(g,X(i,g)*pr(g));
Inc_constraint(i)$(ord(i) lt 5)..
                         U(i+1)    =g=     prod(g,(X(i,g)-X0(g))**alpha(g))*( T_total(i)-(X_totalcons(i) -L )/( (1-tau_w(i)-tau_w_preex(i)-tau_w_flat)*phi(i+1)*wage ) )**gamma-xi*Z_total**theta; 
Utility(i)..
                         U(i)      =e=     prod(g,(X(i,g)-X0(g))**alpha(g))*lei(i)**gamma - xi*(Z_total**theta);
Utility_NE(i)..
                         U_NE(i)   =e=     prod(g,(X(i,g)-X0(g))**alpha(g))*lei(i)**gamma;
Welfare..
                         W         =e=     sum(i, U(i));
Welfare_NE..
                         W_NE      =e=     sum(i, U_NE(i));
***Dummy..
***                         Z_dum     =e=     0;
GDPcalc..
                         GDP       =e=     sum(g,F(g)*pr(g));
RealGDPcalc..
                         RealGDP   =e=     sum(g,F(g));

RealConscalc(i)..        RealCons(i)  =e=  sum(g, X(i,g));


model SG_MM /totalT,FirmProd,FirmFOC1,FirmFOC2,Copeland, HHFOC1,
HHFOC2,HHFOC3,GenEq,numeraire,Tax,Z_totaldef, X_totalconsdef,Inc_constraint,Utility,Utility_NE,Welfare_NE,Welfare,Dummy/;

model SG_SP /totalT,FirmProd,FirmFOC1,FirmFOC2,Copeland, HHFOC1,
HHFOC2,HHFOC3,GenEq,numeraire,Tax,Z_totaldef, X_totalconsdef,Inc_constraint,Utility,Utility_NE,Welfare_NE,Welfare,GDPcalc, RealGDPcalc, RealConscalc/;

option nlp=conopt;






****************************************************************************************
***********************       Calibration to real data      ****************************
****************************************************************************************

********** 'parameters' ***********
gamma        = 0.2;   
gov_spdg     = 5;
min          = 1e-9; 
max          = 1e+5;    
theta        = 1.0;  
s            = 0.5;     
abate        = 1;
r            = 1-1/s;   


** JMN: hvordan er parametrene givet værdier uden at skulle defineres igen??
Parameter epsilon(g)
/1 0.988945005971387,
2 0.993729118914515,
3 0.9967291398522,
4 0.996988651047752,
5 0.997259892220176,
6 0.99741215789911,
7 0.998943084260383,
8 0.999476353715811
/;

*** These alphas sum to 0.8 as far as we remember (LOL)
*** JMN: sætter midlertidige alphaer
Parameter alpha(g)
/1 0.1,
2 0.1,
3 0.1,
4 0.1,
5 0.1,
6 0.1,
7 0.1,
8 0.1/;

*** JMN: sætter midlertidige b'er
Parameter X0(g)    /1 0.05, 2 0.05, 3 0.05, 4 0.05, 5 0, 6 0, 7 0, 8 0/;

Parameter phi(i)       productivity of individual households danish data
                 /1 0.055,
                 2 0.118,
                 3 0.167,
                 4 0.229,
                 5 0.431/;

Parameter tau_w_preex(i)  pre-existing (progressive) tax on income
                /1   0.200,
                 2   0.244,
                 3   0.279,
                 4   0.308,
                 5   0.360/;


***************' Variable'
***parameter initx(i) /1 0.4, 2 0.45, 3 0.5, 4 0.5, 5 0.55/;
***X.l(i,g)=initx(i);
***pr.l(g)=1;

********************************************************************************
*****                 Set limits and starting values                       *****
********************************************************************************
* Limits
L.lo     =       min; L.up=max;
T.lo(g)   =       min; T.up(g)=max;
Z.lo(g)   =       min; Z.up(g)=max;
Z_total.lo = min;  Z_total.up = max;
F.lo(g)   =       min;    F.up(g) = max;
pr.lo(g)  =       min;   pr.up(g) = max;
wage.lo  =       min;  wage.up = max;
lei.lo(i)=       min;   lei.up(i)=       24-1e-9;
X.lo(i,g)  =    X0(g) + min; X.up(i,g)= max;
X_totalcons.lo(i)=min; X_totalcons.up(i)=max;
tau_w.up(i)=     0; 
gov_unprod.lo = 0;

*Starting values





** time endowment to each worker
T_total.fx(i)   =        24;        
** fixed pre-existing carbon price (extraction cost or such) 
tau_P.fx  =        0;      

*Starting values
**parameter initx(i) /1 0.05, 2 0.1, 3 0.3, 4 0.4, 5 0.55/;
**X.l(i,g)=initx(i);
**pr.l(g)=1;



xi             =      0;      


tau_P.lo       =     -20;
tau_P.up       =     30;

tau_w.fx(i)    =      0;
tau_w_flat.fx  =      0;

***********************************************************************************
**************             'Løser modellen BASELINE'                 **************
***********************************************************************************

Solve SG_SP      maximizing w_NE using nlp;








**************************  'FLERE LØSNINGER' ************************************************
*if (SWITCH_DetL0 eq 1,
*
*         **Execute_loadpoint 'sg-initial_41goods.gdx';
*        ** Execute_loadpoint 'sg-results_4_diff_and_L_opt_41goods.gdx';
*         **Execute_loadpoint 'precali_before_L0.gdx';
*         ** set environmental damages to zero
*         xi             =      0;      
*
*
*         tau_P.lo       =     -20;
*         tau_P.up       =     30;
*
*         ** L.fx           =      0;
*         tau_w.fx(i)    =      0;
*         tau.fx(g)       =     0;
*         tau_w_flat.fx  =      0;
*
*         Solve SG_SP      maximizing w_NE using nlp;
*         Solve SG_SP      maximizing w_NE using nlp;
*         Solve SG_SP      maximizing w_NE using nlp;
*
*
*
*
***$include "SG_calculate_ginis_etc.inc"
*         execute_unload 'precali_before_ny.gdx';
*         **execute '=gdx2xls precali_before_arbejdslejr.gdx';
*)
*
*************   Solution for both diff. and lump-sum  ********************
*if (SWITCH_Bench eq 1,
*
*         Execute_loadpoint 'precali_before_ny.gdx';
*
*         xi             =     0.00125;
*
*         L.lo           =      0.2333;
*         L.up           =      1e1;
*         tau_w.lo(i)    =     -20;
*         tau_w.up(i)    =      0.0;
*         tau_P.lo       =     -10;
*         tau_P.up       =      30;
*         tau_P.fx       =      0.3;
*
*         tau.fx(g)      =      0;
*         tau_w_flat.fx  =      0;
*
*         Solve SG_SP      maximizing w_NE using nlp;
*         Solve SG_SP      maximizing w_NE using nlp;
*         Solve SG_SP      maximizing w_NE using nlp;
*
***$include "SG_calculate_ginis_etc.inc"
*         execute_unload 'precali_after_lumpanddiff.gdx';
*         execute '=gdx2xls precali_after_lumpanddiff.gdx';
*);
*************   Solution for only diff.  ********************
*if (SWITCH_diff eq 1,
*         Execute_loadpoint 'precali_before_ny.gdx';
*
*         xi             =     0.00125;
*
*         L.fx           =      0.2333;
*         tau.fx(g)       =     0;
*         tau_w_flat.fx  =      0;
*
*         tau_w.lo(i)    =     -20;
*         tau_w.up(i)    =      0.0;
*         tau_P.fx       =      0.3;
*
*         Solve SG_SP      maximizing w_NE using nlp;
*         Solve SG_SP      maximizing w_NE using nlp;
*         Solve SG_SP      maximizing w_NE using nlp;
*
***$include "SG_calculate_ginis_etc.inc"
*         execute_unload 'precali_after_diff.gdx';
*       **  execute '=gdx2xls precali_after_diff.gdx';
*);
******************* solution for only uniform inc. tax cuts
*if (SWITCH_unif eq 1,
*          Execute_loadpoint 'precali_before_ny.gdx';
*
*         **xi             =     0.00125;
*
*         L.fx           =      0.2333;
*         tau.fx(g)       =      0;
*         tau_w.fx(i)    =      0;
*
*         tau_w_flat.lo  =     -20;
*         tau_w_flat.up  =      20;
*         tau_P.lo       =     -10;
*         tau_P.up       =      30;
*         tau_P.fx       =      0.3;
*
*         Solve SG_SP      maximizing w_NE using nlp;
*         Solve SG_SP      maximizing w_NE using nlp;
*         Solve SG_SP      maximizing w_NE using nlp;
*
***$include "SG_calculate_ginis_etc.inc"
*         execute_unload 'precali_after_unif.gdx';
*         !!execute '=gdx2xls precali_after_unif.gdx';
*);
*************   Solution for only lump-sum  ********************
*if (SWITCH_ULS eq 1,
*        Execute_loadpoint 'precali_before_ny.gdx';
*
*         **xi             =     0.00125;
*
*         tau_w.fx(i)    =       0;
*         tau.fx(g)      =       0;
*         tau_w_flat.fx  =       0;
*
*         L.lo           =      0;!!-1e2;
*         L.up           =      1e2;
*         tau_P.lo       =     -10;
*         tau_P.up       =      30;
*         tau_P.fx       =     0.3;
*
*
*
*         Solve SG_SP      maximizing w_NE using nlp;
*         Solve SG_SP      maximizing w_NE using nlp;
*         Solve SG_SP      maximizing w_NE using nlp;
*
***$include "SG_calculate_ginis_etc.inc"
*        execute_unload 'precali_after_lump.gdx';
*      **   execute '=gdx2xls precali_after_lump.gdx';
*);
*
********* A tax with no redistribution *******************
*
*if (SWITCH_noredist eq 1,
*          Execute_loadpoint 'precali_before_ny.gdx';
*
*         xi             =      0;
*
*         L.fx           =      0.233;
*
*
*         **L.lo           =      -1e2;!!-1e2;
*         **L.up           =      1e2;
*         tau.fx(g)      =      0;
*         tau_w.fx(i)    =      0;
*
*         tau_w_flat.fx  =      0;
*         tau_P.lo       =     -10;
*         tau_P.up       =      30;
*
*
*         tau_P.fx       =     0.3;
*
*         Solve SG_SP      maximizing w_NE using nlp;
*         Solve SG_SP      maximizing w_NE using nlp;
*         Solve SG_SP      maximizing w_NE using nlp;
*
***$include "SG_calculate_ginis_etc.inc"
*         execute_unload 'precal_after_noredist.gdx';
*         **execute '=gdx2xls precal_after_noredist_arbejdslejr.gdx';
*);
*
*$call gdxmerge precali_before_ny.gdx precali_after_lumpanddiff.gdx precal_after_noredist.gdx precali_after_lump.gdx precali_after_unif.gdx precali_after_diff.gdx
*
*execute '=gdx2xls merged.gdx'
*
*$ontext
*Variable AllX(*,*,*);
*$gdxIn merged.gdx
*$load AllX=X
*$gdxIn
*
*option  AllX:5:1:2;
*display AllX.L;
*
*
*FILE out / 'output.put'/ ;
*** file for differentiated labor tax cut
*out.pw = 4000;
*PUT out;
*PUT 'F_C',',','F_D',',','tau_p',',','L',',','gamma',',','epsilon',',','alpha',',','delta',',','xi',',','damexp',',','D0',',','T',',','T_C',',','T_D',',','Z_C',',','Z_D',',','Z_total',',','pr_C',',','pr_D',',','wage',',','C1',',','C2',',','C3',',','C4',',','C5',',','D1',',','D2',',','D3',',','D4',',','D5',',','C_total',',','D_total',',','ConsPor_C1',',','ConsPor_C2',',','ConsPor_C3',',','ConsPor_C4',',','ConsPor_C5',',','ConsPor_D1',',','ConsPor_D2',',','ConsPor_D3',',','ConsPor_D4',',','ConsPor_D5',',','ConsPor_total1',',','ConsPor_total2',',','ConsPor_total3'
*,',','ConsPor_total4',',','ConsPor_total5',',','UtilPor1',',','UtilPor2',',','UtilPor3',',','UtilPor4',',','UtilPor5',',','UtilPor1_NE',',','UtilPor2_NE',',','UtilPor3_NE',',','UtilPor4_NE',',','UtilPor5_NE',',','Gini_C',',','Gini_U',',','Gini_U_NE',',','Welfare_E',',','Welfare_NE',',',
*'lei1',',','lei2',',','lei3',',','lei4',',','lei5',',','tau_w_1',',','tau_w_2',',','tau_w_3',',','tau_w_4',',','tau_w_5',',','U1',',','U2',',','U3',',','U4',',','U5',',','U1_NE',',','U2_NE',',','U3_NE',',','U4_NE',',','U5_NE';
*put /;
*PUT F_C.l:0:6,',',F_D.l:0:6,',',tau_p.l:0:12,',',L.l:0:6
*,',',gamma:0:4,',',epsilon:0:4,',',alpha:0:4,',',delta:0:4,',',xi:0:4,',',damexp:0:4,',',D0:0:4,',',T.l('1'):0:4,',',T_C.l:0:4,',',T_D.l:0:4,',',Z_C.l:0:4,',',Z_D.l:0:4,',',Ztotal.l:0:4
*,',',pr_C.l:0:4,',',pr_D.l:0:4,',',wage.l:0:4,',',C.l('1'):0:4,',',C.l('2'):0:4,',',C.l('3'):0:4,',',C.l('4'):0:4,',',C.l('5'):0:4
*,',',D.l('1'):0:4,',',D.l('2'):0:4,',',D.l('3'):0:4,' ,',D.l('4'):0:4,',',D.l('5'):0:4,',',C_total.l:0:4,',',D_total.l:0:4,',',ConsPor_C.l('1'):0:6,',',ConsPor_C.l('2'):0:6,',',ConsPor_C.l('3'):0:6,',',
*ConsPor_C.l('4'):0:6,',',ConsPor_C.l('5'):0:6,',',ConsPor_D.l('1'):0:6,',',ConsPor_D.l('2'):0:6,',',ConsPor_D.l('3'):0:6,',',ConsPor_D.l('4'):0:6,',',ConsPor_D.l('5'):0:6,',',ConsPor_total.l('1'):0:6,',',ConsPor_total.l('2'):0:6,',',ConsPor_total.l('3'):0:6,',',
*ConsPor_total.l('4'):0:6,',',ConsPor_total.l('5'):0:6,',',UtilPor.l('1'):0:6,',',UtilPor.l('2'):0:6,',',UtilPor.l('3'):0:6,',',UtilPor.l('4'):0:6,',',UtilPor.l('5'):0:6
*,',',UtilPor_NE.l('1'):0:6,',',UtilPor_NE.l('2'):0:6,',',UtilPor_NE.l('3'):0:6,',',UtilPor_NE.l('4'):0:6,',',UtilPor_NE.l('5'):0:6
*,',',gini_c.l:0:6,',',gini_u.l:0:6,',',gini_u_NE.l:0:6,',',W.l:0:6,',',W_NE.l:0:6,',',lei.l('1'):0:4,',',lei.l('2'):0:4,',',lei.l('3'):0:4,',',lei.l('4'):0:4,',',lei.l('5'):0:4,',',tau_w.l('1'):0:4
*,',',tau_w.l('2'):0:4,',',tau_w.l('3'):0:4,',',tau_w.l('4'):0:4,',',tau_w.l('5'):0:4,',',U.l('1'):0:4,',',U.l('2'):0:4,',',U.l('3'):0:4,',',U.l('4'):0:4,',',U.l('5'):0:4
*,',',U_NE.l('1'):0:4,',',U_NE.l('2'):0:4,',',U_NE.l('3'):0:4,',',U_NE.l('4'):0:4,',',U_NE.l('5'):0:4;
*PUTCLOSE out;
*$offtext