variables KE_udled(j), KE_udled_rela(j), T_udled(j), T_udled_rela(j), KB_udled(j), KB_udled_rela(j);

KE_udled.l(j) = Eudled.l(j,'natgas','CO2')
             +Eudled.l(j,'rafgas','CO2')
             +Eudled.l(j,'Nordgas','CO2')
             +Eudled.l(j,'biogas','CO2')
             +Eudled.l(j,'olie','CO2')
             +Eudled.l(j,'kul','CO2')
             +Eudled.l(j,'affald','CO2'); 

KE_udled_rela.l(j) = KE_udled.l(j)/KE2.l(j);


T_udled.l(j) = Eudled.l(j,'BogD','CO2')
             +Eudled.l(j,'BioOlie','CO2');

T_udled_rela.l(j) = T_udled.l(j)/T.l(j);


KB_udled.l(j) = CO2e.l(j) - KE_udled.l(j) - T_udled.l(j);

KB_udled_rela.l(j) $ j_land(j) = KB_udled.l(j) / KBtot.l(j);


execute_unload "ensartet_andel_udled.gdx"
KE_udled.l
KE_udled_rela.l
T_udled.l
T_udled_rela.l
KB_udled.l
KB_udled_rela.l
;
