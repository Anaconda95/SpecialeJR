

* * * * * Eksogenisering og fremskrivning af output fra Nordsøen * * * * * *

*Fra DREAM:
*	2030	2050
*Olie 	0.5948	0.0065
*Gas	0.7380	0.0002

Y.fx('060000a') = Y.l('060000a')*0.5948;
Y.fx('060000b') = Y.l('060000b')*0.7380;

* Markups låses op i Nordsøen

markup.lo('060000a') = -inf;
markup.up('060000a') = inf;

markup.lo('060000b') = -inf;
markup.up('060000b') = inf;

solve static_fremskriv using cns;


* * * * * Verdensmarkedspriser på fossile brændsler * * * * * 

*Fra IEA:

*			2018	2030	2050
*			Råolie DKK2018/tønde
*Current Policies	430	701	992
*Stated Policies	430	556	745
*Sustainable Development430	392	354
*			Naturgas DKK2018/Mbtu
*Current Policies	48	56	69
*Stated Policies	48	51	62
*Sustainable Development48	47	47


* Verdensmarkedspris på olie

Parameter PF_060000a_temp, PF_190000a_temp;
PF_060000a_temp = PF.l('060000a');
PF_190000a_temp = PF.l('190000a');

Display PF.l;

PF.fx('060000a') = PF_060000a_temp*1.1;
PF.fx('190000a') = PF_190000a_temp*1.1;

solve static_fremskriv using cns;

PF.fx('060000a') = PF_060000a_temp*1.2;
PF.fx('190000a') = PF_190000a_temp*1.2;

solve static_fremskriv using cns;

PF.fx('060000a') = PF_060000a_temp*556/430;
PF.fx('190000a') = PF_190000a_temp*556/430;

solve static_fremskriv using cns;


* Verdensmarkedspris på naturgas

PF.fx('060000b') = PF.l('060000b')*51/48;
PF.fx('350020a') = PF.l('350020a')*51/48;

solve static_fremskriv using cns;


* * * * * Afgifter og tilskud * * * * * 
parameter 
pre_tDuty_xD(j,i,tax)  
pre_tDuty_xF(j,i,tax)  
pre_tDuty_IBD(j,i,tax)  
pre_tDuty_IMD(j,i,tax)  
pre_tDuty_IBF(j,i,tax)  
pre_tDuty_IMF(j,i,tax)  
pre_tDuty_cD(i,tax)     
pre_tDuty_cF(i,tax)     
pre_tDuty_ExD(i,tax)    
pre_tDuty_ExF(i,tax)    
pre_tDuty_ILD(i,tax)    
pre_tDuty_ILF(i,tax)    
pre_tDuty_GD(i,tax)     
pre_tDuty_GF(i,tax)     
;

pre_tDuty_xD(j,i,tax) =tDuty_xD.l(j,i,tax); 
pre_tDuty_xF(j,i,tax) =tDuty_xF.l(j,i,tax); 
pre_tDuty_IBD(j,i,tax)=tDuty_IBD.l(j,i,tax);
pre_tDuty_IMD(j,i,tax)=tDuty_IMD.l(j,i,tax);
pre_tDuty_IBF(j,i,tax)=tDuty_IBF.l(j,i,tax);
pre_tDuty_IMF(j,i,tax)=tDuty_IMF.l(j,i,tax);
pre_tDuty_cD(i,tax)   =tDuty_cD.l(i,tax);   
pre_tDuty_cF(i,tax)   =tDuty_cF.l(i,tax);   
pre_tDuty_ExD(i,tax)  =tDuty_ExD.l(i,tax);  
pre_tDuty_ExF(i,tax)  =tDuty_ExF.l(i,tax);  
pre_tDuty_ILD(i,tax)  =tDuty_ILD.l(i,tax);  
pre_tDuty_ILF(i,tax)  =tDuty_ILF.l(i,tax);  
pre_tDuty_GD(i,tax)   =tDuty_GD.l(i,tax);  
pre_tDuty_GF(i,tax)   =tDuty_GF.l(i,tax);   

$ontext


*set loopstep5 /1*20/;

*loop(loopstep5,

tDuty_xD.fx(j,i,'tax16')   = 0.95*tDuty_xD.l(j,i,'tax16')  ;
tDuty_xF.fx(j,i,'tax16')   = 0.95*tDuty_xF.l(j,i,'tax16')  ;
tDuty_IBD.fx(j,i,'tax16')  = 0.95*tDuty_IBD.l(j,i,'tax16') ; 
tDuty_IMD.fx(j,i,'tax16')  = 0.95*tDuty_IMD.l(j,i,'tax16') ; 
tDuty_IBF.fx(j,i,'tax16')  = 0.95*tDuty_IBF.l(j,i,'tax16') ; 
tDuty_IMF.fx(j,i,'tax16')  = 0.95*tDuty_IMF.l(j,i,'tax16') ; 
tDuty_cD.fx(i,'tax16')     = 0.95*tDuty_cD.l(i,'tax16')    ; 
tDuty_cF.fx(i,'tax16')     = 0.95*tDuty_cF.l(i,'tax16')    ; 
tDuty_ExD.fx(i,'tax16')    = 0.95*tDuty_ExD.l(i,'tax16')   ; 
tDuty_ExF.fx(i,'tax16')    = 0.95*tDuty_ExF.l(i,'tax16')   ; 
tDuty_ILD.fx(i,'tax16')    = 0.95*tDuty_ILD.l(i,'tax16')   ; 
tDuty_ILF.fx(i,'tax16')    = 0.95*tDuty_ILF.l(i,'tax16')   ; 
tDuty_GD.fx(i,'tax16')     = 0.95*tDuty_GD.l(i,'tax16')    ; 
tDuty_GF.fx(i,'tax16')     = 0.95*tDuty_GF.l(i,'tax16')    ; 

tDuty_xD.fx(j,i,'tax22')   = 0.95*tDuty_xD.l(j,i,'tax22')  ;
tDuty_xF.fx(j,i,'tax22')   = 0.95*tDuty_xF.l(j,i,'tax22')  ;
tDuty_IBD.fx(j,i,'tax22')  = 0.95*tDuty_IBD.l(j,i,'tax22') ; 
tDuty_IMD.fx(j,i,'tax22')  = 0.95*tDuty_IMD.l(j,i,'tax22') ; 
tDuty_IBF.fx(j,i,'tax22')  = 0.95*tDuty_IBF.l(j,i,'tax22') ; 
tDuty_IMF.fx(j,i,'tax22')  = 0.95*tDuty_IMF.l(j,i,'tax22') ; 
tDuty_cD.fx(i,'tax22')     = 0.95*tDuty_cD.l(i,'tax22')    ; 
tDuty_cF.fx(i,'tax22')     = 0.95*tDuty_cF.l(i,'tax22')    ; 
tDuty_ExD.fx(i,'tax22')    = 0.95*tDuty_ExD.l(i,'tax22')   ; 
tDuty_ExF.fx(i,'tax22')    = 0.95*tDuty_ExF.l(i,'tax22')   ; 
tDuty_ILD.fx(i,'tax22')    = 0.95*tDuty_ILD.l(i,'tax22')   ; 
tDuty_ILF.fx(i,'tax22')    = 0.95*tDuty_ILF.l(i,'tax22')   ; 
tDuty_GD.fx(i,'tax22')     = 0.95*tDuty_GD.l(i,'tax22')    ; 
tDuty_GF.fx(i,'tax22')     = 0.95*tDuty_GF.l(i,'tax22')    ; 

*J_E.up(j) $ (PE.l(j) lt 0.1) = inf;
*J_E.lo(j) $ (PE.l(j) lt 0.1) = -inf;
*PE.fx(j) $ (PE.l(j) lt 0.1) = PE.l(j);

solve static_fremskriv using cns;

Display PE.l;

*);
$offtext
* Udfasning af PSO-afgift og VE-støtte (PSO-afgift)
tDuty_xD.fx(j,i,'tax16')   = 0;
tDuty_xF.fx(j,i,'tax16')   = 0;
tDuty_IBD.fx(j,i,'tax16')  = 0; 
tDuty_IMD.fx(j,i,'tax16')  = 0; 
tDuty_IBF.fx(j,i,'tax16')  = 0; 
tDuty_IMF.fx(j,i,'tax16')  = 0; 
tDuty_cD.fx(i,'tax16')     = 0; 
tDuty_cF.fx(i,'tax16')     = 0; 
tDuty_ExD.fx(i,'tax16')    = 0; 
tDuty_ExF.fx(i,'tax16')    = 0; 
tDuty_ILD.fx(i,'tax16')    = 0; 
tDuty_ILF.fx(i,'tax16')    = 0; 
tDuty_GD.fx(i,'tax16')     = 0; 
tDuty_GF.fx(i,'tax16')     = 0; 

tDuty_xD.fx(j,i,'tax22')   = 0;
tDuty_xF.fx(j,i,'tax22')   = 0;
tDuty_IBD.fx(j,i,'tax22')  = 0; 
tDuty_IMD.fx(j,i,'tax22')  = 0; 
tDuty_IBF.fx(j,i,'tax22')  = 0; 
tDuty_IMF.fx(j,i,'tax22')  = 0; 
tDuty_cD.fx(i,'tax22')     = 0; 
tDuty_cF.fx(i,'tax22')     = 0; 
tDuty_ExD.fx(i,'tax22')    = 0; 
tDuty_ExF.fx(i,'tax22')    = 0; 
tDuty_ILD.fx(i,'tax22')    = 0; 
tDuty_ILF.fx(i,'tax22')    = 0; 
tDuty_GD.fx(i,'tax22')     = 0; 
tDuty_GF.fx(i,'tax22')     = 0; 

solve static_fremskriv using cns;

*J_E.fx(j) = J_E.l(j);
*PE.up(j) = inf;
*PE.lo(j) = -inf;
*offtext
* Lempelse af elvarmeafgiften

* Ifølge Erhhttps://www.pwc.dk/da/artikler/2020/06/klimaaftale-afgiftsaendringer.html sænkes elvarmeafgiften til 0,8 øre pr. kWh for husholdninger og 0,8 øre pr. kWh for virksomheder.
* I 2016 var elvarmeafgiften 38,3 øre pr. kWh. Elvarmeafgiften sænkes derfor til hhv. 2% og 1% af niveauet i 2016 for husholdninger og virksomheder.
* Andel el til opvarmning i 2016 (ca.) - baseret på Energistatistikken: Husholdninger: 15%, Virksomheder 3%

tDuty_xD.fx(j,i,'tax8')   = ((1-0.03)+0.03*0.01)*tDuty_xD.l(j,i,'tax8')  ;
tDuty_xF.fx(j,i,'tax8')   = ((1-0.03)+0.03*0.01)*tDuty_xF.l(j,i,'tax8')  ;
tDuty_IBD.fx(j,i,'tax8')  = ((1-0.03)+0.03*0.01)*tDuty_IBD.l(j,i,'tax8') ; 
tDuty_IMD.fx(j,i,'tax8')  = ((1-0.03)+0.03*0.01)*tDuty_IMD.l(j,i,'tax8') ; 
tDuty_IBF.fx(j,i,'tax8')  = ((1-0.03)+0.03*0.01)*tDuty_IBF.l(j,i,'tax8') ; 
tDuty_IMF.fx(j,i,'tax8')  = ((1-0.03)+0.03*0.01)*tDuty_IMF.l(j,i,'tax8') ; 
tDuty_cD.fx(i,'tax8')     = ((1-0.15)+0.15*0.02)*tDuty_cD.l(i,'tax8')    ; 
tDuty_cF.fx(i,'tax8')     = ((1-0.15)+0.15*0.02)*tDuty_cF.l(i,'tax8')    ; 
tDuty_ExD.fx(i,'tax8')    = ((1-0.03)+0.03*0.01)*tDuty_ExD.l(i,'tax8')   ; 
tDuty_ExF.fx(i,'tax8')    = ((1-0.03)+0.03*0.01)*tDuty_ExF.l(i,'tax8')   ; 
tDuty_ILD.fx(i,'tax8')    = ((1-0.03)+0.03*0.01)*tDuty_ILD.l(i,'tax8')   ; 
tDuty_ILF.fx(i,'tax8')    = ((1-0.03)+0.03*0.01)*tDuty_ILF.l(i,'tax8')   ; 
tDuty_GD.fx(i,'tax8')     = ((1-0.03)+0.03*0.01)*tDuty_GD.l(i,'tax8')    ; 
tDuty_GF.fx(i,'tax8')     = ((1-0.03)+0.03*0.01)*tDuty_GF.l(i,'tax8')    ; 

solve static_fremskriv using cns;

* Fremskrivning af elafgiften for husholdningerne
* elforbrug til apparater forventes at falde fra 82 til 69 pct. i basisfremskrivningen
tDuty_cD.fx(i,'tax8')     = tDuty_cD.l(i,'tax8') * 69/82; 
tDuty_cF.fx(i,'tax8')     = tDuty_cF.l(i,'tax8') * 69/82;
* I basisfremskrivningen stiger elforbruget med 28 pct.  - I vores stiger det med 35 pct. For at ramme provenuet sætter vi satsen ned
tDuty_cD.fx(i,'tax8')     = tDuty_cD.l(i,'tax8') * 128/135; 
tDuty_cF.fx(i,'tax8')     = tDuty_cF.l(i,'tax8') * 128/135;
* Den vedtagede politik, der ligger udover basisfremskrivningen medfører en yderligere stigning i elforbruget (bliver 42 pct. højere ift 2016),
* som går til ikke-apparater. Satsen nedskaleres tilsvarende for at holde provenuet uændret.
tDuty_cD.fx(i,'tax8')     = tDuty_cD.l(i,'tax8') * 135/142; 
tDuty_cF.fx(i,'tax8')     = tDuty_cF.l(i,'tax8') * 135/142;

* Fremskrivning af elafgiften for virksomhederne
* Sammensætningen antages ikke at have betydning, da der ikke er samme sammensætningseffekt mht. satser. Forbruget stiger dog 67 pct. i vores fremskrivning mod 48 i basisfremskrivningen.
tDuty_xD.fx(j,i,'tax8')   = 148/167*tDuty_xD.l(j,i,'tax8')  ;
tDuty_xF.fx(j,i,'tax8')   = 148/167*tDuty_xF.l(j,i,'tax8')  ;
tDuty_IBD.fx(j,i,'tax8')  = 148/167*tDuty_IBD.l(j,i,'tax8') ; 
tDuty_IMD.fx(j,i,'tax8')  = 148/167*tDuty_IMD.l(j,i,'tax8') ; 
tDuty_IBF.fx(j,i,'tax8')  = 148/167*tDuty_IBF.l(j,i,'tax8') ; 
tDuty_IMF.fx(j,i,'tax8')  = 148/167*tDuty_IMF.l(j,i,'tax8') ; 
tDuty_ExD.fx(i,'tax8')    = 148/167*tDuty_ExD.l(i,'tax8')   ; 
tDuty_ExF.fx(i,'tax8')    = 148/167*tDuty_ExF.l(i,'tax8')   ; 
tDuty_ILD.fx(i,'tax8')    = 148/167*tDuty_ILD.l(i,'tax8')   ; 
tDuty_ILF.fx(i,'tax8')    = 148/167*tDuty_ILF.l(i,'tax8')   ; 
tDuty_GD.fx(i,'tax8')     = 148/167*tDuty_GD.l(i,'tax8')    ; 
tDuty_GF.fx(i,'tax8')     = 148/167*tDuty_GF.l(i,'tax8')    ; 

solve static_fremskriv using cns;


* Olieafgiften for husholdninger nedskaleres lidt pga. færre dieselbiler i 2030 (bilkommissionens grundforløb)
tDuty_cD.fx(i,'tax9')     = 37/43*pre_tDuty_cD(i,'tax9')   ; 
tDuty_cF.fx(i,'tax9')     = 37/43*pre_tDuty_cF(i,'tax9')   ; 

* Kul- og affaldsafgiften lægges kun på leverancer fra affladsforbrænning, da kulforbruget udfases

tDuty_xD.fx(j,i,'tax10')   = 0;
tDuty_xF.fx(j,i,'tax10')   = 0;
tDuty_IBD.fx(j,i,'tax10')  = 0; 
tDuty_IMD.fx(j,i,'tax10')  = 0; 
tDuty_IBF.fx(j,i,'tax10')  = 0; 
tDuty_IMF.fx(j,i,'tax10')  = 0; 
tDuty_cD.fx(i,'tax10')     = 0; 
tDuty_cF.fx(i,'tax10')     = 0; 
tDuty_ExD.fx(i,'tax10')    = 0; 
tDuty_ExF.fx(i,'tax10')    = 0; 
tDuty_ILD.fx(i,'tax10')    = 0; 
tDuty_ILF.fx(i,'tax10')    = 0; 
tDuty_GD.fx(i,'tax10')     = 0; 
tDuty_GF.fx(i,'tax10')     = 0; 

tDuty_xD.fx(j,'383900','tax10')   = pre_tDuty_xD(j,'383900','tax10') ;
tDuty_xF.fx(j,'383900','tax10')   = pre_tDuty_xF(j,'383900','tax10') ;
tDuty_IBD.fx(j,'383900','tax10')  = pre_tDuty_IBD(j,'383900','tax10'); 
tDuty_IMD.fx(j,'383900','tax10')  = pre_tDuty_IMD(j,'383900','tax10'); 
tDuty_IBF.fx(j,'383900','tax10')  = pre_tDuty_IBF(j,'383900','tax10'); 
tDuty_IMF.fx(j,'383900','tax10')  = pre_tDuty_IMF(j,'383900','tax10'); 
tDuty_cD.fx('383900','tax10')     = pre_tDuty_cD('383900','tax10')   ; 
tDuty_cF.fx('383900','tax10')     = pre_tDuty_cF('383900','tax10')   ; 
tDuty_ExD.fx('383900','tax10')    = pre_tDuty_ExD('383900','tax10')  ; 
tDuty_ExF.fx('383900','tax10')    = pre_tDuty_ExF('383900','tax10')  ; 
tDuty_ILD.fx('383900','tax10')    = pre_tDuty_ILD('383900','tax10')  ; 
tDuty_ILF.fx('383900','tax10')    = pre_tDuty_ILF('383900','tax10')  ; 
tDuty_GD.fx('383900','tax10')     = pre_tDuty_GD('383900','tax10')   ; 
tDuty_GF.fx('383900','tax10')     = pre_tDuty_GF('383900','tax10')   ;

solve static_fremskriv using cns;

* CO2-afgiften lægges kun på leverancer fra olieraffinaderier, gasforsyning og affaldsforbrænding, da CO2 stort set udfases i fjernvarme og kraftvarme

tDuty_xD.fx(j,i,'tax11')   = 0;
tDuty_xF.fx(j,i,'tax11')   = 0;
tDuty_IBD.fx(j,i,'tax11')  = 0; 
tDuty_IMD.fx(j,i,'tax11')  = 0; 
tDuty_IBF.fx(j,i,'tax11')  = 0; 
tDuty_IMF.fx(j,i,'tax11')  = 0; 
tDuty_cD.fx(i,'tax11')     = 0; 
tDuty_cF.fx(i,'tax11')     = 0; 
tDuty_ExD.fx(i,'tax11')    = 0; 
tDuty_ExF.fx(i,'tax11')    = 0; 
tDuty_ILD.fx(i,'tax11')    = 0; 
tDuty_ILF.fx(i,'tax11')    = 0; 
tDuty_GD.fx(i,'tax11')     = 0; 
tDuty_GF.fx(i,'tax11')     = 0; 

tDuty_xD.fx(j,'190000a','tax11')   = pre_tDuty_xD(j,'190000a','tax11') ;
tDuty_xF.fx(j,'190000a','tax11')   = pre_tDuty_xF(j,'190000a','tax11') ;
tDuty_IBD.fx(j,'190000a','tax11')  = pre_tDuty_IBD(j,'190000a','tax11'); 
tDuty_IMD.fx(j,'190000a','tax11')  = pre_tDuty_IMD(j,'190000a','tax11'); 
tDuty_IBF.fx(j,'190000a','tax11')  = pre_tDuty_IBF(j,'190000a','tax11'); 
tDuty_IMF.fx(j,'190000a','tax11')  = pre_tDuty_IMF(j,'190000a','tax11'); 
tDuty_cD.fx('190000a','tax11')     = pre_tDuty_cD('190000a','tax11')   ; 
tDuty_cF.fx('190000a','tax11')     = pre_tDuty_cF('190000a','tax11')   ; 
tDuty_ExD.fx('190000a','tax11')    = pre_tDuty_ExD('190000a','tax11')  ; 
tDuty_ExF.fx('190000a','tax11')    = pre_tDuty_ExF('190000a','tax11')  ; 
tDuty_ILD.fx('190000a','tax11')    = pre_tDuty_ILD('190000a','tax11')  ; 
tDuty_ILF.fx('190000a','tax11')    = pre_tDuty_ILF('190000a','tax11')  ; 
tDuty_GD.fx('190000a','tax11')     = pre_tDuty_GD('190000a','tax11')   ; 
tDuty_GF.fx('190000a','tax11')     = pre_tDuty_GF('190000a','tax11')   ;

tDuty_xD.fx(j,'190000b','tax11')   = pre_tDuty_xD(j,'190000b','tax11') ;
tDuty_xF.fx(j,'190000b','tax11')   = pre_tDuty_xF(j,'190000b','tax11') ;
tDuty_IBD.fx(j,'190000b','tax11')  = pre_tDuty_IBD(j,'190000b','tax11'); 
tDuty_IMD.fx(j,'190000b','tax11')  = pre_tDuty_IMD(j,'190000b','tax11'); 
tDuty_IBF.fx(j,'190000b','tax11')  = pre_tDuty_IBF(j,'190000b','tax11'); 
tDuty_IMF.fx(j,'190000b','tax11')  = pre_tDuty_IMF(j,'190000b','tax11'); 
tDuty_cD.fx('190000b','tax11')     = pre_tDuty_cD('190000b','tax11')   ; 
tDuty_cF.fx('190000b','tax11')     = pre_tDuty_cF('190000b','tax11')   ; 
tDuty_ExD.fx('190000b','tax11')    = pre_tDuty_ExD('190000b','tax11')  ; 
tDuty_ExF.fx('190000b','tax11')    = pre_tDuty_ExF('190000b','tax11')  ; 
tDuty_ILD.fx('190000b','tax11')    = pre_tDuty_ILD('190000b','tax11')  ; 
tDuty_ILF.fx('190000b','tax11')    = pre_tDuty_ILF('190000b','tax11')  ; 
tDuty_GD.fx('190000b','tax11')     = pre_tDuty_GD('190000b','tax11')   ; 
tDuty_GF.fx('190000b','tax11')     = pre_tDuty_GF('190000b','tax11')   ;

tDuty_xD.fx(j,'350020a','tax11')   = pre_tDuty_xD(j,'350020a','tax11') ;
tDuty_xF.fx(j,'350020a','tax11')   = pre_tDuty_xF(j,'350020a','tax11') ;
tDuty_IBD.fx(j,'350020a','tax11')  = pre_tDuty_IBD(j,'350020a','tax11'); 
tDuty_IMD.fx(j,'350020a','tax11')  = pre_tDuty_IMD(j,'350020a','tax11'); 
tDuty_IBF.fx(j,'350020a','tax11')  = pre_tDuty_IBF(j,'350020a','tax11'); 
tDuty_IMF.fx(j,'350020a','tax11')  = pre_tDuty_IMF(j,'350020a','tax11'); 
tDuty_cD.fx('350020a','tax11')     = pre_tDuty_cD('350020a','tax11')   ; 
tDuty_cF.fx('350020a','tax11')     = pre_tDuty_cF('350020a','tax11')   ; 
tDuty_ExD.fx('350020a','tax11')    = pre_tDuty_ExD('350020a','tax11')  ; 
tDuty_ExF.fx('350020a','tax11')    = pre_tDuty_ExF('350020a','tax11')  ; 
tDuty_ILD.fx('350020a','tax11')    = pre_tDuty_ILD('350020a','tax11')  ; 
tDuty_ILF.fx('350020a','tax11')    = pre_tDuty_ILF('350020a','tax11')  ; 
tDuty_GD.fx('350020a','tax11')     = pre_tDuty_GD('350020a','tax11')   ; 
tDuty_GF.fx('350020a','tax11')     = pre_tDuty_GF('350020a','tax11')   ;

tDuty_xD.fx(j,'383900','tax11')   = pre_tDuty_xD(j,'383900','tax11') ;
tDuty_xF.fx(j,'383900','tax11')   = pre_tDuty_xF(j,'383900','tax11') ;
tDuty_IBD.fx(j,'383900','tax11')  = pre_tDuty_IBD(j,'383900','tax11'); 
tDuty_IMD.fx(j,'383900','tax11')  = pre_tDuty_IMD(j,'383900','tax11'); 
tDuty_IBF.fx(j,'383900','tax11')  = pre_tDuty_IBF(j,'383900','tax11'); 
tDuty_IMF.fx(j,'383900','tax11')  = pre_tDuty_IMF(j,'383900','tax11'); 
tDuty_cD.fx('383900','tax11')     = pre_tDuty_cD('383900','tax11')   ; 
tDuty_cF.fx('383900','tax11')     = pre_tDuty_cF('383900','tax11')   ; 
tDuty_ExD.fx('383900','tax11')    = pre_tDuty_ExD('383900','tax11')  ; 
tDuty_ExF.fx('383900','tax11')    = pre_tDuty_ExF('383900','tax11')  ; 
tDuty_ILD.fx('383900','tax11')    = pre_tDuty_ILD('383900','tax11')  ; 
tDuty_ILF.fx('383900','tax11')    = pre_tDuty_ILF('383900','tax11')  ; 
tDuty_GD.fx('383900','tax11')     = pre_tDuty_GD('383900','tax11')   ; 
tDuty_GF.fx('383900','tax11')     = pre_tDuty_GF('383900','tax11')   ;

solve static_fremskriv using cns;

* Gasafgiften lægges kun på leverancer fra gas og affaldsforbrænding, da gas udfases i fjernvarme og kraftvarmeværker

tDuty_xD.fx(j,i,'tax15')   = 0.5 * pre_tDuty_xD(j,i,'tax15') ;
tDuty_xF.fx(j,i,'tax15')   = 0.5 * pre_tDuty_xF(j,i,'tax15') ;
tDuty_IBD.fx(j,i,'tax15')  = 0.5 * pre_tDuty_IBD(j,i,'tax15'); 
tDuty_IMD.fx(j,i,'tax15')  = 0.5 * pre_tDuty_IMD(j,i,'tax15'); 
tDuty_IBF.fx(j,i,'tax15')  = 0.5 * pre_tDuty_IBF(j,i,'tax15'); 
tDuty_IMF.fx(j,i,'tax15')  = 0.5 * pre_tDuty_IMF(j,i,'tax15'); 
tDuty_cD.fx(i,'tax15')     = 0.5 * pre_tDuty_cD(i,'tax15')   ; 
tDuty_cF.fx(i,'tax15')     = 0.5 * pre_tDuty_cF(i,'tax15')   ; 
tDuty_ExD.fx(i,'tax15')    = 0.5 * pre_tDuty_ExD(i,'tax15')  ; 
tDuty_ExF.fx(i,'tax15')    = 0.5 * pre_tDuty_ExF(i,'tax15')  ; 
tDuty_ILD.fx(i,'tax15')    = 0.5 * pre_tDuty_ILD(i,'tax15')  ; 
tDuty_ILF.fx(i,'tax15')    = 0.5 * pre_tDuty_ILF(i,'tax15')  ; 
tDuty_GD.fx(i,'tax15')     = 0.5 * pre_tDuty_GD(i,'tax15')   ; 
tDuty_GF.fx(i,'tax15')     = 0.5 * pre_tDuty_GF(i,'tax15')   ;

tDuty_xD.fx(j,'383900','tax15')   = pre_tDuty_xD(j,'383900','tax15') ;
tDuty_xF.fx(j,'383900','tax15')   = pre_tDuty_xF(j,'383900','tax15') ;
tDuty_IBD.fx(j,'383900','tax15')  = pre_tDuty_IBD(j,'383900','tax15'); 
tDuty_IMD.fx(j,'383900','tax15')  = pre_tDuty_IMD(j,'383900','tax15'); 
tDuty_IBF.fx(j,'383900','tax15')  = pre_tDuty_IBF(j,'383900','tax15'); 
tDuty_IMF.fx(j,'383900','tax15')  = pre_tDuty_IMF(j,'383900','tax15'); 
tDuty_cD.fx('383900','tax15')     = pre_tDuty_cD('383900','tax15')   ; 
tDuty_cF.fx('383900','tax15')     = pre_tDuty_cF('383900','tax15')   ; 
tDuty_ExD.fx('383900','tax15')    = pre_tDuty_ExD('383900','tax15')  ; 
tDuty_ExF.fx('383900','tax15')    = pre_tDuty_ExF('383900','tax15')  ; 
tDuty_ILD.fx('383900','tax15')    = pre_tDuty_ILD('383900','tax15')  ; 
tDuty_ILF.fx('383900','tax15')    = pre_tDuty_ILF('383900','tax15')  ; 
tDuty_GD.fx('383900','tax15')     = pre_tDuty_GD('383900','tax15')   ; 
tDuty_GF.fx('383900','tax15')     = pre_tDuty_GF('383900','tax15')   ;

tDuty_xD.fx(j,'350020a','tax15')   = pre_tDuty_xD(j,'350020a','tax15') ;
tDuty_xF.fx(j,'350020a','tax15')   = pre_tDuty_xF(j,'350020a','tax15') ;
tDuty_IBD.fx(j,'350020a','tax15')  = pre_tDuty_IBD(j,'350020a','tax15'); 
tDuty_IMD.fx(j,'350020a','tax15')  = pre_tDuty_IMD(j,'350020a','tax15'); 
tDuty_IBF.fx(j,'350020a','tax15')  = pre_tDuty_IBF(j,'350020a','tax15'); 
tDuty_IMF.fx(j,'350020a','tax15')  = pre_tDuty_IMF(j,'350020a','tax15'); 
tDuty_cD.fx('350020a','tax15')     = pre_tDuty_cD('350020a','tax15')   ; 
tDuty_cF.fx('350020a','tax15')     = pre_tDuty_cF('350020a','tax15')   ; 
tDuty_ExD.fx('350020a','tax15')    = pre_tDuty_ExD('350020a','tax15')  ; 
tDuty_ExF.fx('350020a','tax15')    = pre_tDuty_ExF('350020a','tax15')  ; 
tDuty_ILD.fx('350020a','tax15')    = pre_tDuty_ILD('350020a','tax15')  ; 
tDuty_ILF.fx('350020a','tax15')    = pre_tDuty_ILF('350020a','tax15')  ; 
tDuty_GD.fx('350020a','tax15')     = pre_tDuty_GD('350020a','tax15')   ; 
tDuty_GF.fx('350020a','tax15')     = pre_tDuty_GF('350020a','tax15')   ;

solve static_fremskriv using cns;

tDuty_xD.fx(j,i,'tax15')   = 0.2 * pre_tDuty_xD(j,i,'tax15') ;
tDuty_xF.fx(j,i,'tax15')   = 0.2 * pre_tDuty_xF(j,i,'tax15') ;
tDuty_IBD.fx(j,i,'tax15')  = 0.2 * pre_tDuty_IBD(j,i,'tax15'); 
tDuty_IMD.fx(j,i,'tax15')  = 0.2 * pre_tDuty_IMD(j,i,'tax15'); 
tDuty_IBF.fx(j,i,'tax15')  = 0.2 * pre_tDuty_IBF(j,i,'tax15'); 
tDuty_IMF.fx(j,i,'tax15')  = 0.2 * pre_tDuty_IMF(j,i,'tax15'); 
tDuty_cD.fx(i,'tax15')     = 0.2 * pre_tDuty_cD(i,'tax15')   ; 
tDuty_cF.fx(i,'tax15')     = 0.2 * pre_tDuty_cF(i,'tax15')   ; 
tDuty_ExD.fx(i,'tax15')    = 0.2 * pre_tDuty_ExD(i,'tax15')  ; 
tDuty_ExF.fx(i,'tax15')    = 0.2 * pre_tDuty_ExF(i,'tax15')  ; 
tDuty_ILD.fx(i,'tax15')    = 0.2 * pre_tDuty_ILD(i,'tax15')  ; 
tDuty_ILF.fx(i,'tax15')    = 0.2 * pre_tDuty_ILF(i,'tax15')  ; 
tDuty_GD.fx(i,'tax15')     = 0.2 * pre_tDuty_GD(i,'tax15')   ; 
tDuty_GF.fx(i,'tax15')     = 0.2 * pre_tDuty_GF(i,'tax15')   ;

tDuty_xD.fx(j,'383900','tax15')   = pre_tDuty_xD(j,'383900','tax15') ;
tDuty_xF.fx(j,'383900','tax15')   = pre_tDuty_xF(j,'383900','tax15') ;
tDuty_IBD.fx(j,'383900','tax15')  = pre_tDuty_IBD(j,'383900','tax15'); 
tDuty_IMD.fx(j,'383900','tax15')  = pre_tDuty_IMD(j,'383900','tax15'); 
tDuty_IBF.fx(j,'383900','tax15')  = pre_tDuty_IBF(j,'383900','tax15'); 
tDuty_IMF.fx(j,'383900','tax15')  = pre_tDuty_IMF(j,'383900','tax15'); 
tDuty_cD.fx('383900','tax15')     = pre_tDuty_cD('383900','tax15')   ; 
tDuty_cF.fx('383900','tax15')     = pre_tDuty_cF('383900','tax15')   ; 
tDuty_ExD.fx('383900','tax15')    = pre_tDuty_ExD('383900','tax15')  ; 
tDuty_ExF.fx('383900','tax15')    = pre_tDuty_ExF('383900','tax15')  ; 
tDuty_ILD.fx('383900','tax15')    = pre_tDuty_ILD('383900','tax15')  ; 
tDuty_ILF.fx('383900','tax15')    = pre_tDuty_ILF('383900','tax15')  ; 
tDuty_GD.fx('383900','tax15')     = pre_tDuty_GD('383900','tax15')   ; 
tDuty_GF.fx('383900','tax15')     = pre_tDuty_GF('383900','tax15')   ;

tDuty_xD.fx(j,'350020a','tax15')   = pre_tDuty_xD(j,'350020a','tax15') ;
tDuty_xF.fx(j,'350020a','tax15')   = pre_tDuty_xF(j,'350020a','tax15') ;
tDuty_IBD.fx(j,'350020a','tax15')  = pre_tDuty_IBD(j,'350020a','tax15'); 
tDuty_IMD.fx(j,'350020a','tax15')  = pre_tDuty_IMD(j,'350020a','tax15'); 
tDuty_IBF.fx(j,'350020a','tax15')  = pre_tDuty_IBF(j,'350020a','tax15'); 
tDuty_IMF.fx(j,'350020a','tax15')  = pre_tDuty_IMF(j,'350020a','tax15'); 
tDuty_cD.fx('350020a','tax15')     = pre_tDuty_cD('350020a','tax15')   ; 
tDuty_cF.fx('350020a','tax15')     = pre_tDuty_cF('350020a','tax15')   ; 
tDuty_ExD.fx('350020a','tax15')    = pre_tDuty_ExD('350020a','tax15')  ; 
tDuty_ExF.fx('350020a','tax15')    = pre_tDuty_ExF('350020a','tax15')  ; 
tDuty_ILD.fx('350020a','tax15')    = pre_tDuty_ILD('350020a','tax15')  ; 
tDuty_ILF.fx('350020a','tax15')    = pre_tDuty_ILF('350020a','tax15')  ; 
tDuty_GD.fx('350020a','tax15')     = pre_tDuty_GD('350020a','tax15')   ; 
tDuty_GF.fx('350020a','tax15')     = pre_tDuty_GF('350020a','tax15')   ;

solve static_fremskriv using cns;

*$ontext
tDuty_xD.fx(j,i,'tax15')   = 0;
tDuty_xF.fx(j,i,'tax15')   = 0;
tDuty_IBD.fx(j,i,'tax15')  = 0; 
tDuty_IMD.fx(j,i,'tax15')  = 0; 
tDuty_IBF.fx(j,i,'tax15')  = 0; 
tDuty_IMF.fx(j,i,'tax15')  = 0; 
tDuty_cD.fx(i,'tax15')     = 0; 
tDuty_cF.fx(i,'tax15')     = 0; 
tDuty_ExD.fx(i,'tax15')    = 0; 
tDuty_ExF.fx(i,'tax15')    = 0; 
tDuty_ILD.fx(i,'tax15')    = 0; 
tDuty_ILF.fx(i,'tax15')    = 0; 
tDuty_GD.fx(i,'tax15')     = 0; 
tDuty_GF.fx(i,'tax15')     = 0;

tDuty_xD.fx(j,'383900','tax15')   = pre_tDuty_xD(j,'383900','tax15') ;
tDuty_xF.fx(j,'383900','tax15')   = pre_tDuty_xF(j,'383900','tax15') ;
tDuty_IBD.fx(j,'383900','tax15')  = pre_tDuty_IBD(j,'383900','tax15'); 
tDuty_IMD.fx(j,'383900','tax15')  = pre_tDuty_IMD(j,'383900','tax15'); 
tDuty_IBF.fx(j,'383900','tax15')  = pre_tDuty_IBF(j,'383900','tax15'); 
tDuty_IMF.fx(j,'383900','tax15')  = pre_tDuty_IMF(j,'383900','tax15'); 
tDuty_cD.fx('383900','tax15')     = pre_tDuty_cD('383900','tax15')   ; 
tDuty_cF.fx('383900','tax15')     = pre_tDuty_cF('383900','tax15')   ; 
tDuty_ExD.fx('383900','tax15')    = pre_tDuty_ExD('383900','tax15')  ; 
tDuty_ExF.fx('383900','tax15')    = pre_tDuty_ExF('383900','tax15')  ; 
tDuty_ILD.fx('383900','tax15')    = pre_tDuty_ILD('383900','tax15')  ; 
tDuty_ILF.fx('383900','tax15')    = pre_tDuty_ILF('383900','tax15')  ; 
tDuty_GD.fx('383900','tax15')     = pre_tDuty_GD('383900','tax15')   ; 
tDuty_GF.fx('383900','tax15')     = pre_tDuty_GF('383900','tax15')   ;

tDuty_xD.fx(j,'350020a','tax15')   = pre_tDuty_xD(j,'350020a','tax15') ;
tDuty_xF.fx(j,'350020a','tax15')   = pre_tDuty_xF(j,'350020a','tax15') ;
tDuty_IBD.fx(j,'350020a','tax15')  = pre_tDuty_IBD(j,'350020a','tax15'); 
tDuty_IMD.fx(j,'350020a','tax15')  = pre_tDuty_IMD(j,'350020a','tax15'); 
tDuty_IBF.fx(j,'350020a','tax15')  = pre_tDuty_IBF(j,'350020a','tax15'); 
tDuty_IMF.fx(j,'350020a','tax15')  = pre_tDuty_IMF(j,'350020a','tax15'); 
tDuty_cD.fx('350020a','tax15')     = pre_tDuty_cD('350020a','tax15')   ; 
tDuty_cF.fx('350020a','tax15')     = pre_tDuty_cF('350020a','tax15')   ; 
tDuty_ExD.fx('350020a','tax15')    = pre_tDuty_ExD('350020a','tax15')  ; 
tDuty_ExF.fx('350020a','tax15')    = pre_tDuty_ExF('350020a','tax15')  ; 
tDuty_ILD.fx('350020a','tax15')    = pre_tDuty_ILD('350020a','tax15')  ; 
tDuty_ILF.fx('350020a','tax15')    = pre_tDuty_ILF('350020a','tax15')  ; 
tDuty_GD.fx('350020a','tax15')     = pre_tDuty_GD('350020a','tax15')   ; 
tDuty_GF.fx('350020a','tax15')     = pre_tDuty_GF('350020a','tax15')   ;


solve static_fremskriv using cns;
*offtext

* * * * * *

* Udfasning af kul hos kraftvarmeværker - erstattes af halm og træ
m_K_energi.fx('350010a') = 0.001;
m_HT_energi.fx('350010a') = 1 - m_A_energi.l('350010a') - m_K_energi.l('350010a');

solve static_fremskriv using cns;


* * * * * *

display BoP.l, gdp.l, gdpf0.l;


$include vis_andele.gms

