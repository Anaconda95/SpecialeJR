$oneolcom
********************************************************************************
* Model for assessing the distributional impacts of different revenue recycling*
*  schemes when accounting for pollution-intensive subsistence consumption     *
*  with Stone-Geary utility functions.                                         *                 *
*                                                                              *
* David Klenert, 2014-2015,  Potsdam Institute for Climate Impact Research     *
********************************************************************************

* Pure optimal taxation version

SETS
i              income quintiles                           / 1*5/

$include "SG_variables_params.inc"
********************************************************************************
*****                      Set model switches                              *****
********************************************************************************
Switch_Bench     =       0; !! after environmental tax reform
SWITCH_DetL0     =       1; !! before environmental tax reform

********************************************************************************
*****                     Set model parameters                             *****
********************************************************************************

p_helper=0.1;

Parameter phi(i)          productivity of individual households
                /1 0.03,
                 2 0.0825,
                 3 0.141,
                 4 0.229,
                 5 0.511/;
Parameter tau_w_preex(i);
tau_w_preex(i) = 0;

********************************************************************************
*****                 Set limits and starting values                       *****
********************************************************************************
* Limits
L.lo     =       min;    T_C.lo   =       min;   T_D.lo   =       min;   Z_C.lo   =       min;   Z_D.lo   =       min;
F_C.lo   =       min;    F_D.lo   =       min;   pr_C.lo  =       min;   pr_D.lo  =       min;   wage.lo  =       min;
lei.lo(i)=       min;   lei.up(i)=       24-1e-9;                       C.lo(i)  =       min;
D.lo(i)  =       D0+min;     tau_w.up(i)=     0;
*Starting values
C.l(i)=0.4;
*tau_w.l(i)=-0.4;

Equations

FirmProd1,FirmProd2,totalT,Firm1FOC1,Firm1FOC2,Firm2FOC1,Firm2FOC2,Copeland1,Copeland2,HHFOC1(i),HHFOC2(i),HHFOC3(i),numeraire,
GenEq_C,GenEq_D,Utility,Welfare,Tax,Inc_constraint,Dummy,Utility_NE,Welfare_NE
;
**********************************Firms*****************************************
FirmProd1..
                         F_C                   =e=     A_C * (gamma*T_C**r   + (1-gamma)  *Z_C**r)**(1/r);    !!A_C*T_C**gamma*Z_C**(1-gamma);
FirmProd2..
                         F_D                   =e=     A_D * (epsilon*T_D**r + (1-epsilon)*Z_D**r)**(1/r);      !!A_D*T_D**epsilon*Z_D**(1-epsilon);
Firm1FOC1..
                         wage                  =e=     gamma      *T_C**(r-1)*F_C**(1-r)*pr_C;
Firm1FOC2..
                         tau_P                 =e=     (1-gamma)  *Z_C**(r-1)*F_C**(1-r)*pr_C;
Firm2FOC1..
                         wage                  =e=     epsilon    *T_D**(r-1)*F_D**(1-r)*pr_D;
Firm2FOC2..
                         tau_P                 =e=     (1-epsilon)*Z_D**(r-1)*F_D**(1-r)*pr_D;
totalT..
                         0                     =e=     T_C + T_D -sum(i,phi(i)*(T(i)-lei(i)));
Copeland1..
                         Z_C                   =l=     x*T_C ;
Copeland2..
                         Z_D                   =l=     x*T_D ;
********************************Households**************************************
HHFOC1(i)..
                         pr_C*C(i)             =e= alpha/beta*(D(i)-D0)*pr_D;
HHFOC2(i)..
                         pr_D*(D(i)-D0)        =e= beta/delta*lei(i)*( (1-tau_w(i))*phi(i)*wage );
HHFOC3(i)..
                         C(i)*pr_C + D(i)*pr_D =e= (1-tau_w(i))*phi(i)*wage*(T(i)-lei(i)) + L;
******************************Market clearing***********************************
numeraire..
                         wage      =e=     1;
GenEq_C..
                         F_C       =e=     sum(i,C(i))+gov_spdg/(pr_C*2);!!*sum(i,C(i))/(sum(i,C(i))+sum(i,D(i)));!! F_C; !!
GenEq_D..
                         F_D       =e=     sum(i,D(i))+gov_spdg/(pr_D*2);!!*sum(i,D(i))/(sum(i,C(i))+sum(i,D(i)));!!  *F_D; !!
********************************Government**************************************
Tax..
                         Gov_spdg =e=     (tau_p)*(Z_C+Z_D) + wage*sum(i,tau_w(i)*phi(i)*(T(i)-lei(i))) - 5*L; !!CHANGE HERE IF WE MAKE MORE DECILES

Inc_constraint(i)$(ord(i) lt 5)..
                         U(i+1)    =g=     C(i)**alpha*(D(i)-D0)**beta*( T(i)-( C(i)*pr_C + D(i)*pr_D  -L )/( (1-tau_w(i))*phi(i+1)*wage ) )**delta-xi*(Z_C+Z_D)**damexp;!! Gregor approach
Utility(i)..
                         U(i)      =e=     C(i)**alpha*(D(i)-D0)**beta*lei(i)**delta - xi*(Z_C+Z_D)**damexp;
Utility_NE(i)..
                         U_NE(i)   =e=     C(i)**alpha*(D(i)-D0)**beta*lei(i)**delta;
Welfare..
                         W         =e=     sum(i, U(i));      !!U('1')*0.92+U('2')*0.94+U('3')*0.96+U('4')*0.98+U('5')-xi*(Z_C+Z_D)**damexp;!!
Welfare_NE..
                         W_NE      =e=     sum(i, U_NE(i));
Dummy..
                         Z         =e=     0;
 
model SG_MM /totalT,FirmProd1,FirmProd2,Firm1FOC1,Firm1FOC2,Firm2FOC1,Firm2FOC2,Copeland1,Copeland2,HHFOC1,HHFOC2,HHFOC3,GenEq_C,GenEq_D,numeraire,Tax,Inc_constraint,Utility,Utility_NE,Welfare_NE,Welfare,Dummy/;
model SG_SP /totalT,FirmProd1,FirmProd2,Firm1FOC1,Firm1FOC2,Firm2FOC1,Firm2FOC2,Copeland1,Copeland2,HHFOC1,HHFOC2,HHFOC3,GenEq_C,GenEq_D,numeraire,Tax,Inc_constraint,Utility,Utility_NE,Welfare_NE,Welfare/;     
option nlp=conopt;

********************************************************************************
*****                    Set additional variables                          *****
********************************************************************************

gov_C.fx  = 1;
gov_D.fx  = 1;
T.fx(i)   =        24;               !! time endowment to each worker
tau_P.fx  =        0;!!0.043;        !! fixed pre-existing carbon price (extraction cost or such)



if (SWITCH_DetL0 eq 1,
         
        Execute_loadpoint 'sg-results_4_diff_and_L_opt_LOAD3.gdx';


         tau_P.lo       =     -10;
         tau_P.up       =     10;
         L.lo           =    -1e2;
         L.up           =     1e2;
         tau_w.lo(i)    =     -20;
         tau_w.up(i)    =     20;
         
         tau_D.fx       =      0;
         tau_w_flat.fx=0;

         Solve SG_SP      maximizing w_NE using nlp;
         Solve SG_SP      maximizing w_NE using nlp;
         Solve SG_SP      maximizing w_NE using nlp;


$include "SG_calculate_ginis_etc.inc"
         execute_unload 'sg-initial.gdx';
)

************   Solution for both diff. and lump-sum  ********************
if (SWITCH_Bench eq 1,
         Execute_loadpoint 'sg-results_4_diff_and_L_opt_LOAD3.gdx';

         xi             =     0.1;!!p_helper;

         L.lo           =     -1e1;
         L.up           =      1e1;
         tau_w.lo(i)    =     -20;
         tau_w.up(i)    =      20;
         tau_P.lo       =     -10;
         tau_P.up       =      10;
         tau_D.fx       =      0;
         tau_w_flat.fx=0;

         Solve SG_SP      maximizing w using nlp;
         Solve SG_SP      maximizing w using nlp;
         Solve SG_SP      maximizing w using nlp;

$include "SG_calculate_ginis_etc.inc"
         execute_unload 'sg-results_4_diff_and_L_opt.gdx';
);



*$ontext
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
*$offtext
