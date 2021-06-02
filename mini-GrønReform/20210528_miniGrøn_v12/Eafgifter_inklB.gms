LUMPSUM.fx $ (%LUK% EQ 1) = LUMPSUM.l;
t_w.lo $ (%LUK% EQ 1) = -inf;
t_w.up $ (%LUK% EQ 1) =  inf;
t_w.fx $ (%LUK% EQ 0) = t_w.l;
LUMPSUM.lo $ (%LUK% EQ 0) = -inf;
LUMPSUM.up $ (%LUK% EQ 0) =  inf;

* Fjerner eksisterende klimarelaterede afgifter og tilskud

sets tax_klima(tax) "Klimarelaterede afgifter" / 
tax1        "Benzinafgift"
*tax2        "Registreringsafgift"
tax8        "El-afgift"
tax9        "Visse olieprodukter (diesel)"
tax10       "Sten og brunkul mv." 
*tax12       "Råstofafgift"
tax15       "Naturgas afgift"
/;

set loopstep0 /1*30/;

loop(loopstep0,

tDuty_xD.fx(j,i,tax_klima)   = 0.9*tDuty_xD.l(j,i,tax_klima)  ;
tDuty_xF.fx(j,i,tax_klima)   = 0.9*tDuty_xF.l(j,i,tax_klima)  ;
tDuty_IBD.fx(j,i,tax_klima)  = 0.9*tDuty_IBD.l(j,i,tax_klima) ; 
tDuty_IMD.fx(j,i,tax_klima)  = 0.9*tDuty_IMD.l(j,i,tax_klima) ; 
tDuty_IBF.fx(j,i,tax_klima)  = 0.9*tDuty_IBF.l(j,i,tax_klima) ; 
tDuty_IMF.fx(j,i,tax_klima)  = 0.9*tDuty_IMF.l(j,i,tax_klima) ; 
tDuty_cD.fx(i,tax_klima)     = 0.9*tDuty_cD.l(i,tax_klima)    ; 
tDuty_cF.fx(i,tax_klima)     = 0.9*tDuty_cF.l(i,tax_klima)    ; 
tDuty_ExD.fx(i,tax_klima)    = 0.9*tDuty_ExD.l(i,tax_klima)   ; 
tDuty_ExF.fx(i,tax_klima)    = 0.9*tDuty_ExF.l(i,tax_klima)   ; 
tDuty_ILD.fx(i,tax_klima)    = 0.9*tDuty_ILD.l(i,tax_klima)   ; 
tDuty_ILF.fx(i,tax_klima)    = 0.9*tDuty_ILF.l(i,tax_klima)   ; 
tDuty_GD.fx(i,tax_klima)     = 0.9*tDuty_GD.l(i,tax_klima)    ; 
tDuty_GF.fx(i,tax_klima)     = 0.9*tDuty_GF.l(i,tax_klima)    ; 

solve static_fremskriv using cns;

);

tDuty_xD.fx(j,i,tax_klima)   = 0;
tDuty_xF.fx(j,i,tax_klima)   = 0;
tDuty_IBD.fx(j,i,tax_klima)  = 0; 
tDuty_IMD.fx(j,i,tax_klima)  = 0; 
tDuty_IBF.fx(j,i,tax_klima)  = 0; 
tDuty_IMF.fx(j,i,tax_klima)  = 0; 
tDuty_cD.fx(i,tax_klima)     = 0; 
tDuty_cF.fx(i,tax_klima)     = 0; 
tDuty_ExD.fx(i,tax_klima)    = 0; 
tDuty_ExF.fx(i,tax_klima)    = 0; 
tDuty_ILD.fx(i,tax_klima)    = 0; 
tDuty_ILF.fx(i,tax_klima)    = 0; 
tDuty_GD.fx(i,tax_klima)     = 0; 
tDuty_GF.fx(i,tax_klima)     = 0; 

solve static_fremskriv using cns;

Display BoP.l;

execute_unload "gekko\gdx_work\%filnavn%.gdx";