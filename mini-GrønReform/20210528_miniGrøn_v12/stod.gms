

*Indtast stødet
CCS.fx = 10;

solve static_energi using cns;

display BoP.l, CO2eTaxRev_j.l, PCCS.l, CCSExp.l;

execute_unload "gekko\gdx_work\stod.gdx";