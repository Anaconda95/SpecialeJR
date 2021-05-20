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
SWITCH_DetL0     =       1; !! before environmental tax reform, but determining Lump sum
SWITCH_noredist  =       0; !! no redistribution, but a tax reform
SWITCH_diff      =       0; !! if this param is set to 1, revenue recycling occurs via differentiated income tax cuts
SWITCH_unif      =       0; !! if this param is set to 1, revenue recycling occurs via uniform income tax cuts
SWITCH_ULS       =       0; !! if this param is set to 1, revenues are recycled via uniform lump-sum transfers
Switch_Bench     =       0; !! after environmental tax reform (both lump-sum and income tax cuts)


SETS
i              income quintiles                           / 1*5/
g              type of good                              /1*41/;  !!/C, D/;

!! Types of goods: 41 (43 less prostitution and illegal drugs)
* 1  Fødevarer
* 2  Ikke-alkoholiske drikkevarer
* 3  Alkoholiske drikkevare
* 4  Tobak mv.
* 5  Beklædning
* 6  Fodtøj
* 7  Husleje
* 8  Beregnet husleje af egen bolig
* 9  Vedligeholdelse og reparation af bolig
* 10 Vandforsyning og andre tjenester i forbindelse med boligen
* 11 Elektricitet, gas og andet brændsel
* 12 Møbler og boligudstyr, tæpper og anden gulvbelægning
* 13 Boligtekstiler
* 14 Husholdningsapparater og reparation heraf
* 15 Glas, service og husholdningsredskaber
* 16 Værktøj og udstyr til hus og have
* 17 Andre varer og tjenester til husholdningen
* 18 Medicinske produkter, apparater og medicinsk udstyr
* 19 Ambulant behandling
* 20 Hospitalstjenester
* 21 Køb af køretøjer
* 22 Drift af personlige transportmidler
* 23 Transporttjenester
* 24 Posttjenester
* 25 Telefon- og telefaxudstyr
* 26 Teletjenester
* 27 Audiovisuelt og fotografisk udstyr samt databehandlingsudstyr
* 28 Andre større varige forbrugsgoder til fritids- og kulturaktiviteter
* 29 Andet tilbehør og udstyr til fritid, haver og kæledyr
* 30 Fritids- og kulturtjenester
* 31 Aviser, bøger og papirvarer
* 32 Pakkerejser
* 33 Undervisning
* 34 Restauranter, cafeer og kantiner mv.
* 35 Overnatningsfaciliteter
* 36 Personlig pleje
* 37 Andre personlige effekter
* 38 Daginstitutioner og social forsorg
* 39 Forsikring
* 40 Finansielle tjenester
* 41 Andre tjenester

!!Alias(g,h);

Variables
* firm
T(g)           labor time in production of good g 
Z(g)           pollution in production of good g
Z_total         total pollution
wage           rental price labor

F(g)           production of good g

pr(g)          price of good g

T_total(i)     total time endowment of agents
P              total pollution

* households
a              help param
X(i,g)         amount of good g consumed by hh i
X_totalcons(i) sum of consumption of good g times price(g) for consumer i
E(i)           generic consumption good
lei(i)         leisure of hh i
inc            gross income

* government
U(i)           Utility (with environmental component)
U_NE(i)        Non-environmental utility
L              Lump-sum transfers
Rev            Tax revenue government
W              Welfare
W_NE           Non-environmental welfare
Gov(g)         Government consumption of good g
tau(g)         tax on polluting output
tau_P          pollution tax
tau_w(i)       non-linear income tax
tau_w_flat     flat income tax rebate
* tau_w_preex(i) temporary as a variable    !! comment this when not calculating the optimal pre-existing income tax
* gov_share      government share of output   !! comment this when not calculating the optimal pre-existing government consumption share
GovRev_pol     Government revenue from pollution taxes
GovRev_LS      Government revenue from lump-sum taxes
GovRev_inc     Government revenue from income taxes
gov_unprod     Unproductive government spending
RealCons(i)    Real consumption pr household 


* post processing
Xtotal(g)      Total consumption of good g
GDP            Sum of all goods multiplied by the prices
RealGDP        Sum of all goods
CbyD           Ratio clean to polluting consumption
ConsPor(i,g)   Consumption share of good g of household i
ConsPor_total(i) Total consumption share
UtilPor(i)     Utility share
UtilPor_NE     Utility share non-environmental
gini_C         Gini coefficient consumption
gini_u         Gini coefficient utility
Gini_U_NE      Gini coefficient non-environmental utility
rel_cons       Relative share of consumption of hh i
rel_burden     Relative income tax burden of hh i
suits_help     helping variable when calculating suits index
suits          Suits index of income tax system
inc_tax_total_burden total tax burden for calculating suits index

Z_dum          Dummy variable for market solution
;

Parameters
* firm
epsilon(g)     labor intensity in production of good g
s              elasticity of substitution btw. labor and pollution
r              CES Parameter
!! A_(g)       TFP in production 
abate          parameter for labor intensity of pollution in production
!!omega          factor in production before pollution

* households
alpha(g)       share of consumption of good g in utility
gamma          leisure exponent in utility
X0(g)          subsistence level consumption of of good g

* government
xi             environmental preference parameter
min            minimum value of variables
max            maximum value of variables
theta          exponent of damage function
p_helper       scan parameter for communication with R
gov_spdg       government spending requirement;


********************************************************************************
*****                     Set model parameters                             *****
********************************************************************************

*New Benchmark with priv cost !gamma was 0.2
gamma   = 0.2;   gov_spdg    = 5;
min         = 1e-9; max = 1e+5;    theta      = 1.0;  !!xi      = 0.1;   !!xi      = 0.05; for 2nd best
s         = 0.5;     abate           = 0.1;
r         = 1-1/s;   !!omega       = 1;


********************************************************************************
*****                     Set model parameters                             *****
********************************************************************************

p_helper=0.1;

***** These are from samlede matrice NY.xlsx - Co2-intensitet fanen. Calculated with
***** DRIVHUS-table and I/O-analysis.

Parameter epsilon(g)
/1 0.988945005971387,
2 0.993729118914515,
3 0.9967291398522,
4 0.996988651047752,
5 0.997259892220176,
6 0.99741215789911,
7 0.998943084260383,
8 0.999476353715811,
9 0.991657086131032,
10 0.989738610802956,
11 0.961829764901336,
12 0.997149616464907,
13 0.997198635518853,
14 0.997249355843452,
15 0.997133740307554,
16 0.997193937364577,
17 0.997479631039407,
18 0.997312322177201,
19 0.998866523881158,
20 0.998456650477496,
21 0.996871035305126,
22 0.994354201361273,
23 0.989151866313408,
24 0.996166595642025,
25 0.998620281505936,
26 0.997530703059004,
27 0.997251806569867,
28 0.996352695630801,
29 0.994629012616214,
30 0.996712004697894,
31 0.997587644785825,
32 0.982222651183186,
33 0.998412660967904,
34 0.994141431288769,
35 0.99510685939491,
36 0.997469893530467,
37 0.997260012932241,
38 0.998237776828783,
39 0.999366310557111,
40 0.999324687981881,
41 0.998161056948552 /;

!! These alphas sum to 0.8 as far as we remember (LOL)

Parameter alpha(g)
/1 0.0647,
2 0.0076,
3 0.0071,
4 0.0058,
5 0.0205,
6 0.0047,
7 0.0868,
8 0.1394,
9 0.0069,
10 0.0186,
11 0.0289,
12 0.0124,
13 0.0034,
14 0.0032,
15 0.0036,
16 0.0036,
17 0.0057,
18 0.0074,
19 0.0129,
20 0.0043,
21 0.0095,
22 0.0413,
23 0.0193,
24 0.0002,
25 0.0025,
26 0.0124,
27 0.0127,
28 0.0028,
29 0.014,
30 0.0357,
31 0.0087,
32 0.0164,
33 0.0085,
34 0.0463,
35 0.0081,
36 0.0148,
37 0.0038,
38 0.0169,
39 0.0225,
40 0.0451,
41 0.0091/;

Parameter X0(g)    /1 0.05, 2 0, 3 0, 4 0, 5 0, 6 0, 7 0, 8 0, 9 0,
                    10 0.01, 11 0.02, 12 0, 13 0, 14 0, 15 0, 16 0,
                    17 0, 18 0, 19 0, 20 0, 21 0, 22 0, 23 0.01, 24 0,
                    25 0, 26 0, 27 0, 28 0, 29 0, 30 0, 31 0, 32 0,
                    33 0, 34 0, 35 0, 36 0, 37 0, 38 0, 39 0, 40 0, 41 0/;

Parameter phi(i)       productivity of individual households danish data         
                 /1 0.055, 
                 2 0.118,
                 3 0.167,
                 4 0.229,
                 5 0.431/;

Parameter tau_w_preex(i)  pre-existing (progressive) tax on income
                /1   0.200,!! calibrated to data on
                 2   0.244,
                 3   0.279,
                 4   0.308,
                 5   0.360/;

!!Skal denne udkommenteres eller ej? -RLK


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
tau_w.up(i)=     0;  !!tau_w.up var udkommenteret -RLK
gov_unprod.lo = 0;

*Starting values
!!parameter initx(i) /1 0.4, 2 0.45, 3 0.5, 4 0.5, 5 0.55/;
!!X.l(i,g)=initx(i);
!!pr.l(g)=1;

Equations

FirmProd(g),totalT,FirmFOC1(g),FirmFOC2(g),Copeland(g),HHFOC1(i,g),HHFOC2(i,g),HHFOC3(i),numeraire,
GenEq(g),Utility,Welfare,Tax,AltTax1,AltTax2,Z_totaldef, X_totalconsdef, Inc_constraint,Dummy,GDPcalc,RealGDPcalc,RealConscalc, Utility_NE,Welfare_NE
;
**********************************Firms*****************************************
FirmProd(g)..
                         F(g)                  =e=    (epsilon(g)*T(g)**r + (1-epsilon(g))*Z(g)**r)**(1/r);      !!A_D*T_D**epsilon*Z_D**(1-epsilon);
FirmFOC1(g)..
                         wage                  =e=     epsilon(g)    *T(g)**(r-1)*F(g)**(1-r)*pr(g);
FirmFOC2(g)..
                         tau_P                 =e=     (1-epsilon(g))*Z(g)**(r-1)*F(g)**(1-r)*pr(g);
totalT..
                         0                     =e=     sum(g,T(g)) -sum(i,phi(i)*(T_total(i)-lei(i)));
Copeland(g)..
                         Z(g)                  =l=     abate*T(g);

********************************Households**************************************

HHFOC1(i,g)$(ord(g) lt 41)..  
                         pr(g)*(X(i,g)-X0(g))  =e= (alpha(g)/alpha(g+1))*((X(i,g+1)-X0(g+1))*pr(g+1));
HHFOC2(i,g)..
                         pr(g+40)*(X(i,g+40)-X0(g+40))  =e= (alpha(g+40)/gamma)*lei(i)*( (1-tau_w(i)-tau_w_preex(i)-tau_w_flat)*phi(i)*wage );                                           
HHFOC3(i)..
                         sum(g,X(i,g)*pr(g))   =e= (1-tau_w(i)-tau_w_preex(i)-tau_w_flat)*phi(i)*wage*(T_total(i)-lei(i)) + L;                        

*****************************Market clearing***********************************
numeraire..
                         wage      =e=     1;
GenEq(g)..
                         F(g)      =e=     sum(i,X(i,g))+ (gov_spdg+gov_unprod)/(pr(g)*card(g));!!*sum(i,C(i))/(sum(i,C(i))+sum(i,D(i)));!! F_C; !!

********************************Government**************************************
Tax..
                         Gov_spdg + gov_unprod   =e=    tau_p*sum(g,Z(g)) + wage*sum(i,(tau_w_preex(i)+tau_w(i)+tau_w_flat)*phi(i)*(T_total(i)-lei(i))) - 5*L; !!                 
Z_totaldef..
                         Z_total    =e=    sum(g,Z(g));
X_totalconsdef(i)..
                         X_totalcons(i) =e= sum(g,X(i,g)*pr(g));
Inc_constraint(i)$(ord(i) lt 5)..
                         U(i+1)    =g=     prod(g,(X(i,g)-X0(g))**alpha(g))*( T_total(i)-(X_totalcons(i) -L )/( (1-tau_w(i)-tau_w_preex(i)-tau_w_flat)*phi(i+1)*wage ) )**gamma-xi*Z_total**theta;   !! Gregor approach
Utility(i)..
                         U(i)      =e=     prod(g,(X(i,g)-X0(g))**alpha(g))*lei(i)**gamma - xi*(Z_total**theta);
Utility_NE(i)..
                         U_NE(i)   =e=     prod(g,(X(i,g)-X0(g))**alpha(g))*lei(i)**gamma;
Welfare..
                         W         =e=     sum(i, U(i));     
Welfare_NE..
                         W_NE      =e=     sum(i, U_NE(i));
Dummy..
                         Z_dum     =e=     0;
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


********************************************************************************
*****                    Set additional variables                          *****
********************************************************************************

!!gov.fx(g)  = 1;
T_total.fx(i)   =        24;         !! time endowment to each worker
tau_P.fx  =        0;!!0.043;        !! fixed pre-existing carbon price (extraction cost or such)

*Starting values
!!parameter initx(i) /1 0.05, 2 0.1, 3 0.3, 4 0.4, 5 0.55/;
!!X.l(i,g)=initx(i);
!!!pr.l(g)=1;



if (SWITCH_DetL0 eq 1,

         !!Execute_loadpoint 'sg-initial_41goods.gdx';
        !! Execute_loadpoint 'sg-results_4_diff_and_L_opt_41goods.gdx';
         Execute_loadpoint 'precali_before_L0.gdx';
         xi             =      0;      !! set environmental damages to zero
       
         
         tau_P.lo       =     -20;
         tau_P.up       =     30;

         !! L.fx           =      0;
         tau_w.fx(i)    =      0;
         tau.fx(g)       =     0;
         tau_w_flat.fx  =      0;
         
         Solve SG_SP      maximizing w_NE using nlp;
         Solve SG_SP      maximizing w_NE using nlp;
         Solve SG_SP      maximizing w_NE using nlp;
         
         


!!$include "SG_calculate_ginis_etc.inc"
         execute_unload 'precali_before_ny.gdx';
!!         execute '=gdx2xls precali_before_arbejdslejr.gdx';
)

************   Solution for both diff. and lump-sum  ********************
if (SWITCH_Bench eq 1,

         Execute_loadpoint 'precali_before_ny.gdx';

         xi             =     0.00125;

         L.lo           =      0.2333;
         L.up           =      1e1;
         tau_w.lo(i)    =     -20;
         tau_w.up(i)    =      0.0;
         tau_P.lo       =     -10;
         tau_P.up       =      30;
         tau_P.fx       =      0.16;

         tau.fx(g)      =      0;
         tau_w_flat.fx  =      0;

         Solve SG_SP      maximizing w_NE using nlp;
         Solve SG_SP      maximizing w_NE using nlp;
         Solve SG_SP      maximizing w_NE using nlp;

!!$include "SG_calculate_ginis_etc.inc"
         execute_unload 'precali_after_lumpanddiff.gdx';
         execute '=gdx2xls precali_after_lumpanddiff.gdx';
);
************   Solution for only diff.  ********************
if (SWITCH_diff eq 1,
         Execute_loadpoint 'precali_before_ny.gdx';

         xi             =     0.00125;

         L.fx           =      0.2333;
         tau.fx(g)       =     0;
         tau_w_flat.fx  =      0;

         tau_w.lo(i)    =     -20;
         tau_w.up(i)    =      0.0;
         tau_P.fx       =      0.16;

         Solve SG_SP      maximizing w_NE using nlp;
         Solve SG_SP      maximizing w_NE using nlp;
         Solve SG_SP      maximizing w_NE using nlp;

!!$include "SG_calculate_ginis_etc.inc"
         execute_unload 'precali_after_diff.gdx';
       !!  execute '=gdx2xls precali_after_diff.gdx';
);
****************** solution for only uniform inc. tax cuts
if (SWITCH_unif eq 1,
          Execute_loadpoint 'precali_before_ny.gdx';

         !!xi             =     0.00125;

         L.fx           =      0.2333;
         tau.fx(g)       =      0;
         tau_w.fx(i)    =      0;

         tau_w_flat.lo  =     -20;
         tau_w_flat.up  =      20;
         tau_P.lo       =     -10;
         tau_P.up       =      30;
         tau_P.fx       =      0.16;

         Solve SG_SP      maximizing w_NE using nlp;
         Solve SG_SP      maximizing w_NE using nlp;
         Solve SG_SP      maximizing w_NE using nlp;

!!$include "SG_calculate_ginis_etc.inc"
         execute_unload 'precali_after_unif.gdx';
         !!execute '=gdx2xls precali_after_unif.gdx';
);
************   Solution for only lump-sum  ********************
if (SWITCH_ULS eq 1,
        Execute_loadpoint 'precali_before_ny.gdx';

         !!xi             =     0.00125;

         tau_w.fx(i)    =       0;
         tau.fx(g)      =       0;
         tau_w_flat.fx  =       0;

         L.lo           =      0;!!-1e2;
         L.up           =      1e2;
         tau_P.lo       =     -10;
         tau_P.up       =      30;
         tau_P.fx       =     0.16;
        


         Solve SG_SP      maximizing w_NE using nlp;
         Solve SG_SP      maximizing w_NE using nlp;
         Solve SG_SP      maximizing w_NE using nlp;

!!$include "SG_calculate_ginis_etc.inc"
        execute_unload 'precali_after_lump.gdx';
      !!   execute '=gdx2xls precali_after_lump.gdx';
);

******** A tax with no redistribution *******************

if (SWITCH_noredist eq 1,
          Execute_loadpoint 'precali_before_ny.gdx';

         xi             =      0;
         
         L.fx           =      0.233;
         

         !!L.lo           =      -1e2;!!-1e2;
         !!L.up           =      1e2;
         tau.fx(g)      =      0;
         tau_w.fx(i)    =      0;

         tau_w_flat.fx  =      0;
         tau_P.lo       =     -10;
         tau_P.up       =      30;
         

         tau_P.fx       =     0.16;

         Solve SG_SP      maximizing w_NE using nlp;
         Solve SG_SP      maximizing w_NE using nlp;
         Solve SG_SP      maximizing w_NE using nlp;

!!$include "SG_calculate_ginis_etc.inc"
         execute_unload 'precal_after_noredist.gdx';
         !!execute '=gdx2xls precal_after_noredist_arbejdslejr.gdx';
);

$call gdxmerge precali_before_ny.gdx precali_after_lumpanddiff.gdx precal_after_noredist.gdx precali_after_lump.gdx precali_after_unif.gdx precali_after_diff.gdx output = nye_resultater

execute '=gdx2xls nye_resultater.gdx'

$ontext
Variable AllX(*,*,*);
$gdxIn merged.gdx
$load AllX=X
$gdxIn

option  AllX:5:1:2;
display AllX.L;


FILE out / 'output.put'/ ;
!! file for differentiated labor tax cut
out.pw = 4000;
PUT out;
PUT 'F_C',',','F_D',',','tau_p',',','L',',','gamma',',','epsilon',',','alpha',',','delta',',','xi',',','damexp',',','D0',',','T',',','T_C',',','T_D',',','Z_C',',','Z_D',',','Z_total',',','pr_C',',','pr_D',',','wage',',','C1',',','C2',',','C3',',','C4',',','C5',',','D1',',','D2',',','D3',',','D4',',','D5',',','C_total',',','D_total',',','ConsPor_C1',',','ConsPor_C2',',','ConsPor_C3',',','ConsPor_C4',',','ConsPor_C5',',','ConsPor_D1',',','ConsPor_D2',',','ConsPor_D3',',','ConsPor_D4',',','ConsPor_D5',',','ConsPor_total1',',','ConsPor_total2',',','ConsPor_total3'
,',','ConsPor_total4',',','ConsPor_total5',',','UtilPor1',',','UtilPor2',',','UtilPor3',',','UtilPor4',',','UtilPor5',',','UtilPor1_NE',',','UtilPor2_NE',',','UtilPor3_NE',',','UtilPor4_NE',',','UtilPor5_NE',',','Gini_C',',','Gini_U',',','Gini_U_NE',',','Welfare_E',',','Welfare_NE',',',
'lei1',',','lei2',',','lei3',',','lei4',',','lei5',',','tau_w_1',',','tau_w_2',',','tau_w_3',',','tau_w_4',',','tau_w_5',',','U1',',','U2',',','U3',',','U4',',','U5',',','U1_NE',',','U2_NE',',','U3_NE',',','U4_NE',',','U5_NE';
put /;
PUT F_C.l:0:6,',',F_D.l:0:6,',',tau_p.l:0:12,',',L.l:0:6
,',',gamma:0:4,',',epsilon:0:4,',',alpha:0:4,',',delta:0:4,',',xi:0:4,',',damexp:0:4,',',D0:0:4,',',T.l('1'):0:4,',',T_C.l:0:4,',',T_D.l:0:4,',',Z_C.l:0:4,',',Z_D.l:0:4,',',Ztotal.l:0:4
,',',pr_C.l:0:4,',',pr_D.l:0:4,',',wage.l:0:4,',',C.l('1'):0:4,',',C.l('2'):0:4,',',C.l('3'):0:4,',',C.l('4'):0:4,',',C.l('5'):0:4
,',',D.l('1'):0:4,',',D.l('2'):0:4,',',D.l('3'):0:4,',',D.l('4'):0:4,',',D.l('5'):0:4,',',C_total.l:0:4,',',D_total.l:0:4,',',ConsPor_C.l('1'):0:6,',',ConsPor_C.l('2'):0:6,',',ConsPor_C.l('3'):0:6,',',
ConsPor_C.l('4'):0:6,',',ConsPor_C.l('5'):0:6,',',ConsPor_D.l('1'):0:6,',',ConsPor_D.l('2'):0:6,',',ConsPor_D.l('3'):0:6,',',ConsPor_D.l('4'):0:6,',',ConsPor_D.l('5'):0:6,',',ConsPor_total.l('1'):0:6,',',ConsPor_total.l('2'):0:6,',',ConsPor_total.l('3'):0:6,',',
ConsPor_total.l('4'):0:6,',',ConsPor_total.l('5'):0:6,',',UtilPor.l('1'):0:6,',',UtilPor.l('2'):0:6,',',UtilPor.l('3'):0:6,',',UtilPor.l('4'):0:6,',',UtilPor.l('5'):0:6
,',',UtilPor_NE.l('1'):0:6,',',UtilPor_NE.l('2'):0:6,',',UtilPor_NE.l('3'):0:6,',',UtilPor_NE.l('4'):0:6,',',UtilPor_NE.l('5'):0:6
,',',gini_c.l:0:6,',',gini_u.l:0:6,',',gini_u_NE.l:0:6,',',W.l:0:6,',',W_NE.l:0:6,',',lei.l('1'):0:4,',',lei.l('2'):0:4,',',lei.l('3'):0:4,',',lei.l('4'):0:4,',',lei.l('5'):0:4,',',tau_w.l('1'):0:4
,',',tau_w.l('2'):0:4,',',tau_w.l('3'):0:4,',',tau_w.l('4'):0:4,',',tau_w.l('5'):0:4,',',U.l('1'):0:4,',',U.l('2'):0:4,',',U.l('3'):0:4,',',U.l('4'):0:4,',',U.l('5'):0:4
,',',U_NE.l('1'):0:4,',',U_NE.l('2'):0:4,',',U_NE.l('3'):0:4,',',U_NE.l('4'):0:4,',',U_NE.l('5'):0:4;
PUTCLOSE out;
$offtext
