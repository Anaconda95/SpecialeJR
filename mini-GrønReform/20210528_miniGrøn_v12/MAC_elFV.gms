group elFV
*Eltot
Elvind
Elfossil
Peltot
Elkraft
Elaffald
Pelfossil
*PElvind
*PElkraft
*PElaffald

FVx
FVfossil
FVVE
PFVx
*PFVfossil
*PFVVE

ElvindinklC
ElfossilinklC
ElkraftinklC
ElaffaldinklC
*FVinklC
FVkraftinklC
FVaffaldinklC
FVxinklC
FVfossilinklC
FVVEinklC
;

Equations
E_FVxNy
E_FVkraftinklCNy
E_FVaffaldinklCNy
;

parameters paraFVKraft, paraFVaffald;

E_FVkraftinklCNy..    FVkraftinklC =E= paraFVKraft *  Elkraft  + vaegtHH('350010a','FjVarm') * CH('350010a');
E_FVaffaldinklCNy..  FVaffaldinklC =E= paraFVaffald * Elaffald + vaegtHH('383900','FjVarm')  * CH('383900');

E_FVxNy.. FVx =E= sum(j,FV_energi(j)) - paraFVKraft * Elkraft - paraFVaffald * Elaffald;

paraFVKraft  = sum(j, FV_kraftandel.l(j)*FV_energi.l(j))/Elkraft.l;
paraFVaffald = sum(j, FV_Renoandel.l(j) *FV_energi.l(j))/Elaffald.l;


model model_elFV /
*E_Eltot
E_Elvind
E_Elfossil
E_Peltot
E_Elkraft
E_Elaffald
E_Pelfossil
*E_PElvind
*E_PElkraft
*E_PElaffald

E_FVxNy
E_FVfossil
E_FVVE
E_PFVx
*E_PFVfossil
*E_PFVVE

*E_EltotinklC
E_ElvindinklC
E_ElfossilinklC
E_ElkraftinklC
E_ElaffaldinklC
*E_FVinklC
E_FVkraftinklCNy
E_FVaffaldinklCNy
E_FVxinklC
E_FVfossilinklC
E_FVVEinklC

E_CH
E_PCH
/;

display d1CH;
d1CH(dc) = 0;
d1CH('350010a') = 1;
d1CH('350010b') = 1;
d1CH('383900') = 1;
d1CH('neELEL') = 1;
d1CH('neReno') = 1;
d1CH('neEL') = 1;

fix ALL;
unfix elFV;
CH.lo(dc) $ d1CH(dc) = -inf;
CH.up(dc) $ d1CH(dc) =  inf;
PCH.lo(dco) $ d1CH(dco) = -inf;
PCH.up(dco) $ d1CH(dco) =  inf;
CH.fx('neEL') = CH.l('neEL'); 
J_CH.lo('neEL','ne') = -inf;
J_CH.up('neEL','ne') =  inf;


$ontext
                  nge
            /     0.4     \
     ng                      ne
   / 0.4 \               /   0.4    \
190000a 190000b      neEL               neV
                   / 0.2 \             / 0.1   \
               neELEL neReno       neGAS        neFV
              /  2 \    \          / 2 \     /  1.5  \  
          350010a ..b  383900  350020a ..b  350030a ..b
$offtext

solve model_elFV using cns;

display PElkraft.l, PElaffald.l, PFVfossil.l;

parameter results, dispresults;

results('PElkraftpre') = PElkraft.l;
results('PElaffaldpre') = PElaffald.l;
results('P350010apre') = PCH.l('350010a');
results('P383900pre') = PCH.l('383900');

parameter p_up, fig_el, fig_MAC, fig_el0;
p_up = 0;

dispresults('0','CO2redukAkku') = 0;
results('omkpostxTax') = PCH.l('neEL')*CH.l('neEL')+PEltot.l*Eltot.l;
fig_el0('kraft')=ElkraftinklC.l;
fig_el0('vind')=ElvindinklC.l;
fig_el0('reno')=ElaffaldinklC.l;


set loopstep /1*20/;

loop(loopstep,



p_up = 0.05;
PElkraft.fx = PElkraft.l *(1+p_up); 
PElaffald.fx = PElaffald.l * (1+p_up*CO2e.l('383900')/Y.l('383900')/(CO2e.l('350010a')/Y.l('350010a')));
*PFVfossil.fx = PFVfossil.l * (1+p_up*CO2e.l('350030a')/Y.l('350030a')/(CO2e.l('350010a')/Y.l('350010a')));
PCH.fx('350010a') = PCH.l('350010a') *(1+p_up);
PCH.fx('383900')  = PCH.l('383900') * (1+p_up*CO2e.l('383900')/Y.l('383900')/(CO2e.l('350010a')/Y.l('350010a')));
*PCH.fx('350010a')  = PFVfossil.l * (1+p_up*CO2e.l('350030a')/Y.l('350030a')/(CO2e.l('350010a')/Y.l('350010a')));

*display PElkraft.l, PElaffald.l, PFVfossil.l;


results('Elkraftpre') = Elkraft.l;
results('Elaffaldpre') = Elaffald.l;
results('Elvindpre') = Elvind.l;
results('ElkraftpreT') = ElkraftinklC.l;
results('ElaffaldpreT') = ElaffaldinklC.l;
results('ElvindpreT') = ElvindinklC.l;

results('omkpre') = results('omkpostxTax');
results('co2pre') = CO2e.l('383900')+CO2e.l('350010a');

solve model_elFV using cns;

results('Elkraftdiff') = Elkraft.l/results('Elkraftpre')-1;
results('Elaffalddiff') = Elaffald.l/results('Elaffaldpre')-1;
results('Elvinddiff') = Elvind.l/results('Elvindpre')-1;
results('ElkraftdiffT') = ElkraftinklC.l/results('ElkraftpreT')-1;
results('ElaffalddiffT') = ElaffaldinklC.l/results('ElaffaldpreT')-1;
results('ElvinddiffT') = ElvindinklC.l/results('ElvindpreT')-1;
results('Elkraftpost') = Elkraft.l;
results('Elaffaldpost') = Elaffald.l;
results('Elvindpost') = Elvind.l;
results('ElkraftpostT') = ElkraftinklC.l;
results('ElaffaldpostT') = ElaffaldinklC.l;
results('ElvindpostT') = ElvindinklC.l;
CO2e.fx('383900')  = CO2e.l('383900') *(1+results('ElaffalddiffT'));
CO2e.fx('350010a') = CO2e.l('350010a')*(1+results('ElkraftdiffT'));

results('omkpost') = PCH.l('neEL')*CH.l('neEL')+PEltot.l*Eltot.l;
results('omkpostxTax') = results('omkpost') - (PElkraft.l -results('PElkraftpre')) *Elkraft.l
                                            - (PElaffald.l-results('PElaffaldpre'))*Elaffald.l
                                            - (PCH.l('350010a')-results('P350010apre'))*CH.l('350010a')
                                            - (PCH.l('383900')-results('P383900pre'))*CH.l('383900');

results('co2post') = CO2e.l('383900')+CO2e.l('350010a');



dispresults(loopstep,'kraft') = results('ElkraftdiffT');
dispresults(loopstep,'vind') = results('ElvinddiffT');
dispresults(loopstep,'reno') = results('ElaffalddiffT');
dispresults(loopstep,'omk_stigning') = results('omkpostxTax')/results('omkpre')-1;
dispresults(loopstep,'MAC') = (results('omkpostxTax')-results('omkpre'))/(results('co2pre')-results('co2post')) * 10**6;
dispresults(loopstep,'CO2reduk') = results('co2pre')-results('co2post');
results('CO2redukAkku') = results('co2pre')-results('co2post')+results('CO2redukAkku');

fig_el(loopstep,'kraft')=ElkraftinklC.l;
fig_el(loopstep,'vind')=ElvindinklC.l;
fig_el(loopstep,'reno')=ElaffaldinklC.l;

fig_MAC(loopstep,'CO2')=results('CO2redukAkku');
fig_MAC(loopstep,'MAC')=dispresults(loopstep,'MAC');
);








display results, dispresults;

display fig_el0, fig_el, fig_MAC;

*Ønskede produktionsforskydninger
*Ved høje udledninger i udgangspunktet i 350010a (SP) skal 350010a gå ned, 383900 uændret og 350010b op  
*Ved lave udledninger i udgangspunktet i 350010a (SP) sker reduktionerne primært via CCS, hvormed 350010a skal være uændret (inkl. CCS), 383900 skal ned og 350010b uændret  