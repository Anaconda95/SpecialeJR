* * * * * * Energirelaterede CO2-emissioner * * * * * *

Parameter CO2En_exBoD(j), CO2En_EloV, CO2En_Olier, CO2En_Indv, CO2En_Fora, CO2En_Luft, CO2En_Vej, CO2En_Jernb, CO2En_Soe, CO2En_SeOff, CO2En_hh, CO2En_Lmv;

CO2En_exBoD(j) = CO2Energi.l(j) - CO2BogD.l(j);

*El og varme
CO2En_EloV = CO2En_exBoD('350010a') + CO2En_exBoD('350010b') + CO2En_exBoD('350020a') + CO2En_exBoD('350020b') + CO2En_exBoD('350030a') + CO2En_exBoD('350030b') + CO2En_exBoD('383900');

*Olieraffinaderier
CO2En_Olier = CO2En_exBoD('190000a') + CO2En_exBoD('190000b');

*Indvinding
CO2En_Indv = CO2En_exBoD('060000a') + CO2En_exBoD('060000b') + CO2En_exBoD('080090');

*Forarbejdning
CO2En_Fora = CO2En_exBoD('100010a') + CO2En_exBoD('100010b') + CO2En_exBoD('100010c') + CO2En_exBoD('100020') + CO2En_exBoD('100030') + CO2En_exBoD('100040') + CO2En_exBoD('100050') + CO2En_exBoD('11200') + CO2En_exBoD('Industri') + CO2En_exBoD('160000') + CO2En_exBoD('200010') + CO2En_exBoD('200020') + CO2En_exBoD('210000') + CO2En_exBoD('220000') + CO2En_exBoD('230010') + CO2En_exBoD('230020') + CO2En_exBoD('240000') + CO2En_exBoD('250000') + CO2En_exBoD('280010') + CO2En_exBoD('280020') + CO2En_exBoD('36700');

*Luftfart
CO2En_Luft = CO2En_exBoD('51000a')  + CO2En_exBoD('51000b')  + CO2BogD.l('51000a');

*Vejtransport
CO2En_Vej = CO2En_exBoD('490030a') + CO2En_exBoD('490030b') + SUM(j, CO2BogD.l(j)) - CO2BogD.l('490030b') - CO2BogD.l('50000a') - CO2BogD.l('50000b') - CO2BogD.l('51000a') - CO2BogD.l('51000b') + CO2BogDHH.l;

*Jernbane
CO2En_Jernb = CO2En_exBoD('490012');

*Søfart
CO2En_Soe = CO2En_exBoD('50000a') + CO2En_exBoD('50000b') + CO2BogD.l('50000a');

*Service og offentlig
CO2En_SeOff = CO2En_exBoD('410009') + CO2En_exBoD('420000') + CO2En_exBoD('43000') + CO2En_exBoD('45000') + CO2En_exBoD('460000') + CO2En_exBoD('470000') + CO2En_exBoD('52000') + CO2En_exBoD('53000') + CO2En_exBoD('550000') + CO2En_exBoD('560000') + CO2En_exBoD('Tjenester') + CO2En_exBoD('Boliger') + CO2En_exBoD('Offentlig') + CO2En_exBoD('79000');

*Husholdninger
CO2En_hh = CO2EnergiHH.l - CO2BogDHH.l;

*Landbrug mv.
CO2En_Lmv = CO2En_exBoD('01000a') + CO2En_exBoD('01000b') + CO2En_exBoD('01000c') + CO2En_exBoD('01000d') + CO2En_exBoD('020000') + CO2En_exBoD('030000');

* * * * * * Ikke-energirelaterede CO2-emissioner * * * * * *

Parameter CO2IEn_Cement;

*Cementindustri
CO2IEn_Cement = CO2Ie.l('230020');

* * * * * * Ikke-energirelaterede emissioner af CH4, N2O og flour * * * * * *

Parameter CO2eMLF_Veg, CO2eMLF_Ani;

*Vegetabilsk landbrug (N2O)
CO2eMLF_Veg = CO2eMLF.l('01000a');

*Animalsk landbrug (CH4)
CO2eMLF_Ani = CO2eMLF.l('01000b') + CO2eMLF.l('01000c') + CO2eMLF.l('01000d');

* * * * * * Emissioner fra dansk territorium i alt * * * * * *

Parameter CO2eialt;

*Vegetabilsk landbrug (N2O)
CO2eialt = CO2eDK.l;
