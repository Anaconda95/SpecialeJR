Variables
* firm
T_C            labor time in clean production
T_D            labor time in dirty production
T_Z            private (labor) costs of pollution
Z_C            pollution in clean production
Z_D            pollution in dirty production
Ztotal         total pollution
wage           rental price labor

F_C            clean production
F_D            dirty production

pr_C           price of clean good
pr_D           price of dirty good

T(i)           total time endowment of agents
P              total pollution

* households
a              help param
C(i)           amount of clean good consumed by hh i
D(i)           amount of dirty good consumed by hh i
E(i)           generic consumption good
lei(i)         leisure of hh i
inc            gross income

* government
gC
gD
U(i)           Utility (with environmental component)
U_NE           Non-environmental utility
L              Lump-sum transfers
Rev            Tax revenue government
W              Welfare
W_NE           Non-environmental welfare
Gov_C          Government consumption clean
Gov_D          Government consumption polluting
tau_D          tax on polluting output
tau_P          pollution tax
tau_w(i)       non-linear income tax
tau_w_flat     flat income tax rebate
* tau_w_preex(i) temporary as a variable    !! comment this when not calculating the optimal pre-existing income tax
* gov_share      government share of output   !! comment this when not calculating the optimal pre-existing government consumption share
GovRev_pol     Government revenue from pollution taxes
GovRev_LS      Government revenue from lump-sum taxes
GovRev_inc     Government revenue from income taxes


* post processing
C_total        Total clean consumption
D_total        Total polluting consumption
GDP            Sum of all goods multiplied by the prices
CbyD           Ratio clean to polluting consumption
ConsPor_C(i)   Clean consumption share
ConsPor_D(i)   Polluting consumption share
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

Z              Dummy variable for market solution
;

Parameters
* firm
gamma          labor intensity clean production
epsilon        labor intensity dirty production
s              elasticity of substitution btw. labor and pollution
r              CES Parameter
A_C            technical change clean production
A_D            technical change dirty production
x              parameter for labor intensity of pollution in production
omega          factor in production before pollution

* households
alpha          share of clean consumption in utility
beta           share of dirty consumption in utility
delta          leisure exponent in utility
D0             subsistence level of dirty good consumption
C0

* government
xi             damage parameter
min            minimum value of variables
damexp         exponent of damage function
p_helper       scan parameter for communication with R
gov_spdg       government spending requirement


* model operation
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
;

********************************************************************************
*****                     Set model parameters                             *****
********************************************************************************

*New Benchmark with priv cost
gamma     = 0.995;    epsilon     = 0.92;      A_C     = 1;     A_D         = 1;    !!epsilon     = 0.92;
alpha     = 0.7;     beta        = 0.2;      delta   = 0.2;   gov_spdg    = 5;
D0        = 0.5;     min         = 1e-9;     xi      = 0.1;  damexp      = 1.0;    !!xi      = 0.05; for 2nd best
s         = 0.5;     x           = 1;
r         = 1-1/s;   omega       = 1;

*Benchmark standard model
*gamma     = 0.95;    epsilon     = 0.5;      A_C     = 1;     A_D         = 1;
*alpha     = 0.7;     beta        = 0.2;      delta   = 0.2;   gov_spdg    = 8.696;
*D0        = 0.5;     min         = 1e-9;     xi      = 0.02;  damexp      = 1.1;
*s         = 0.9;     x           = 0.08;

*Benchmark with priv cost
*gamma     = 0.95;    epsilon     = 0.5;      A_C     = 1;     A_D         = 1;
*alpha     = 0.6;     beta        = 0.25;      delta   = 0.2;  gov_spdg    = 1;!!8.696;
*D0        = 0.25;     min         = 1e-9;     xi      = 0.2;  damexp      = 1.1;
*s         = 0.9;     x           = 0.08;
*r         = 1-1/s;
