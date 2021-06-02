*International realrente (det er vigtigt at r > grow)
r.l = 0.03;
* Inflationsrate
infl.l = 0.02;
* Vækstrate
grow.l = 0.0125;
* Danske aktiers andel af husholdningernes formue //NCF: Andelen af aktier i branche j, der ejes af danske husholdninger
* Sættes ned til 35% for at få mere homogen model
share_D.l(j) = 0.7; 
share_D.l('060000a') = 0; 
share_D.l('060000b') = 0; 


*Runes andele
*    a_     'Landbrug'
share_D.l(ja) = 0.998;  

share_D.l(jng) = 0.44; 
share_D.l(jne) = 0.44;
*     e_  'Råstofudvinding'
share_D.l('060000a') = 0;  
*Olieudvinding*
share_D.l('060000b') = 0;  
*Gasudvinding*
share_D.l('080090') = 0.44;  
*Service til råstofudvinding (inkl. kulimport)*

*    nf_     'Fremstilling - fødevarer'
share_D.l(jnf) = 0.44;  

*    nz_     'Fremstilling - øvrig' 
share_D.l(jnz) = 0.44; 

 
*    qzi_   'Service, ikke-konkurrerende' 
share_D.l('36700') = 0.44;  
*Vandforsyning, kloak- og rensningsanlæg*
share_D.l('383900') = 0.44;  
*Renovation, genbrug og forureningsbekæmpelse*
share_D.l('45000') = 0.588;  
*Bilhandel og -værksteder mv.*
share_D.l('470000') = 0.588;  
*Detailhandel*
share_D.l('490012') = 0.588;  
*Tog, bus, taxi mv.*
share_D.l('490030a') = 0.588;  
*National vejgodstransport*
share_D.l('50000a') = 0.588;  
*National skibsfart*
share_D.l('51000a') = 0.588;  
*National luftfart*
share_D.l('52000') = 0.588;  
*Hjælpevirksomhed til transport*
share_D.l('550000') = 0.903;  
*Hoteller mv.*
share_D.l('560000') = 0.903;  
*Restauranter*

*    b_      'Byggeri'
share_D.l(jb) = 0.914;  

*    qzk_   'Service, konkurrerende'
share_D.l('460000') = 0.588;  
*Engroshandel*
share_D.l('490030b') = 0.588;  
*International vejgodstransport*
share_D.l('51000b') = 0.588;  
*International luftfart*
share_D.l('53000') = 0.588;  
*Post og kurertjeneste*
share_D.l('79000') = 0.90;  
*Rejsebureauer*
*    qs_     'Tjenester    - søfart'
share_D.l('50000b') = 0.588;  
*International skibsfart*
*    qf_     'Tjenester    - finansielle'
share_D.l('Tjenester') = 0.90;  
*Andre tjenester*
*    h_     'Boligbrancen'
share_D.l('Boliger') = 0.98;  
*Boliger*
*    o_      'Offentlige tjenester'
share_D.l('Offentlig') = 1;  
*Offentlige tjenester*
*display share_D.l;




* Arbejdskraftsproduktivitet
thetaL.l(j) = 1;
thetaK.l(j) = 1;
thetaB.l(j) = 1;
thetaM.l(j) = 1;
thetaE.l(j) = 1;
tfp.l(j) = 1;

* Gældskvoter
* Andelen af virksomhedens kapitalapparat, som er gældsfinansieret (DREAM: 0.6, ADAM: 1.0)
kvote_DP.l(j) = 0.6;
* Gældsandelen for det offentlige sættes lig 1
kvote_DP.l(jo) = 1; 
* Skattemæssige afskrivningsrater - Værdier hentes fra Adams databank (BIVMP og BIVBP), her for 2014
deltaKMBook.l(j) = 0.25;
deltaKBBook.l(j) = 0.03372;

* Strukturel arbejdsløshedsprocent
unemp.l = 0.04;
* Arbejdsstyrken som andel af den samlede befolkning
labForceShare.l = 2.9/5.5;
* Maksimal arbejdstid relativt til faktisk arbejdstid (Sættes til 1 hvis der IKKE ønskes arbejdsudbudseffekter) 
h_bar.l = 1.0;
* Skat på løn
t_w.l = 0.376;
* Kapitalindomstskat
t_r.l = 0.308;
* Selskabsskat
t_cor.l(j) = 0.22;
t_cor.l(jo) = 0.00;
* Kompensationsgrad
rateComp.l = 0.6;
* Marginal forbrugsskattesats
tMarg_cD.l(j) = 0.245;
tMarg_cF.l(j) = tMarg_cD.l(j);

* Substitutionselasticiteter
* Elasticitet mellem materialer og KL-aggregat (DREAM:0.67, ADAM:0 MAKRO: Landbrug 0  Byggeri 0,41  Energi 0,10  Udvinding 0  Fremstilling 0,53  Søtransport 0  Tjenester 0)   
*EY.l(j) = 0.67;
EY.l(j) = 0.01;
EY.l(jnf) = 0.53; 
EY.l(jnz) = 0.53; 
EY.l(jb) = 0.41; 
*display EY.l;

* Elasticitet mellem B og LKE (DREAM: 0.25 (dog KE og L), ADAM: 0)
EH.l(j) = 0.1;
* Elasticitet mellem KE og L (DREAM: 0.25, ADAM: 0-0.5 (dog K og L)
ELKE.l(j) = 0.33;
* Elasticitet mellem K og E (DREAM: 0.3, ADAM: 0-0.4 (dog KL og E))
EKE.l(j) = 0.3;
* Elasticitet mellem forskellige materiale-input - ikke-energi - øvre nest (DREAM: 0.1, ADAM: 0)
EM.l(j,'m') = 0.25;
* Elasticitet mellem forskellige materiale-input - ikke-energi - nedre nests (DREAM: 0, ADAM: 0)
EM.l(j,dmm) = 0.25;
* Elasticitet mellem forskellige materiale-input - energi - øvre nest (DREAM: 0.1, ADAM: 0)
EE.l(j,'me') = 0.9;
* Elasticitet mellem forskellige materiale-input - energi - nedre nest (DREAM: 0.1, ADAM: 0)
EE.l(j,dmem) = 0.9;
*EM.l(j) = 0.01;
* Elasticitet mellem indenlandske og udenlandske materialer - både energi og ikke-energi (DREAM:1.25, ADAM:0-1)
Exx.l(j) = 1.25;
* Elasticitet mellem forskellige investeringsinput - øvre nest (DREAM:0.1, ADAM:0)
EIM.l(j,'im') = 0.1;
EIB.l(j,'ib') = 0.1;
* Elasticitet mellem forskellige investeringsinput - nedre nest (DREAM:0, ADAM:0)
EIM.l(j,dimm) = 0;
EIB.l(j,dibm) = 0;
* Elasticitet mellem indenlandske og udenlandske investeringsinput (DREAM:1.25, ADAM:0-1)
EIMI.l(j) = 1.25;
EIBI.l(j) = 1.25;
* Elasticitet i nyttefunktionen. Dette gør modellen homogen (kan ikke være 1), EV-mål opfører sig dog dårligt når for tæt på 1, hvis arbejdsudbudseffekter er lukket!!!
EU.l = 0.9;
* Elasticitet mellem indenlandsk eksport og import til reeeksport! (DREAM: 0, ADAM: 0, i begge modeller er import til reeksport eksogen)
EEx.l(j) = 0;
* Elasticitet mellem indenlandsk og udenlandsk input til offentligt forbrug (DREAM: alle input er indenlandske, ADAM:0)
EG.l = 1.25;
* Elasticitet mellem indenlandsk og udenlandsk input til lagerinvesteringer (DREAM: ?, ADAM: 0-1)
EIL.l(j) = 1.25;

* Nestning overflødig, hvis alle elasticiteter er ens, men nu er der mulighed for at sætte dem forskelligt
* Elasticitet mellem indenlandsk og udenlandsk input til privat forbrug (DREAM: 1.25, ADAM:0-1)
ECC.l(j) = 1.25;
* Elasticitet mellem bolig og andet (DREAM 1.1 (er for høj skal ændres), ADAM 0.3)
ECH.l('c') = 0.3;
* Elasticitet mellem energi og andet (DREAM: 1.1 (er for høj skal ændres), ADAM: 0.54)
ECH.l('ih') = 0.5;
* Elasticitet mellem tjenesteydelser og andet (DREAM: 1.1 (for høj), ADAM: 1 usikkert bestemt og nestet anderledes)
* Denne parameter er vigtig for egenskaberne i en lukket økonomi - skal være mindre end 1 i en lukket økonomi for overgang fra industri til tjenester
ECH.l('inge') = 0.6;
* Elasticitet mellem offentlige og private tjenester (DREAM: 0, ADAM: 0)
ECH.l('qo') = 0.1;
* Elasticitet mellem forskellige tjenestegrupper med lav substitution (DREAM: 0, ADAM: 0)
ECH.l('q') = 0.1;
* Elasticitet mellem konkurrenceudsatte og ikke-konkurrenceudsatte øvrige tjenester (DREAM: 0, ADAM: 0 generelt og 2.2 mellem tjenester og turistrejser - i gns. ?)
ECH.l('qz') = 0.75;
* Elasticitet mellem ikke-tjenester (DREAM: 0, ADAM: 0-0.6)
ECH.l('iqo') = 0.5;
* Elasticitet mellem energiforsyning og raffineret olie (DREAM: 1.1 (er for høj skal ændres), ADAM: 0)
ECH.l('nge') = 0.4;
* Elasticiteter for andre underaggregater (DREAM: 0, ADAM: 0)
ECH.l('h') = 0.5;
ECH.l('ne') = 0.4;
ECH.l('ng') = 0.4;
ECH.l('a') = 0.5;
ECH.l('e') = 0.5;
ECH.l('nf') = 0.5;
ECH.l('nz') = 0.5;
ECH.l('b') = 0.5;
ECH.l('o') = 0.5;
ECH.l('qs') = 0.5;
ECH.l('qf') = 0.5;
ECH.l('qzi') = 0.5;
ECH.l('qzk') = 0.5;

*Arbejdsudbudseffekter slås fra ved at sætte Elas_hour.l = 0.000000001
Elas_hour.l = 0.1;
*Elas_hour.l = 0.000000001;


* Eksportelasticitet (DREAM:5, ADAM:0-3)
Elas_Ex.l(j) = 5;

Elas_Ex.l('350010a') = 10;
Elas_Ex.l('350010b') = 10;
*Elas_Ex.l('383900')  = 10;
Elas_Ex.l('060000a') = 10;
Elas_Ex.l('060000b') = 10;

* Dummy-sektors størrelse relativt til oprindelig qzi-sektor (mellem 0 og 1)
dummyShare.l = 0.06;


* * * * Nye elasticiteter * * * *

* Virksomhedernes substitution mellem indenlandske og udenlandske materialer - baseret på EMEC (DREAM/REFORM:1.25, ADAM:0-1)
* Tjenester
Exx.l(j) = 0.6;

* Landbrug, skovbrug
Exx.l('01000a') = 0.4;
Exx.l('01000b') = 0.4;
Exx.l('01000c') = 0.4;
Exx.l('01000d') = 0.4;
Exx.l('020000') = 0.4;

* Fiskeri
Exx.l('030000') = 1.4;

* Råolie og -gas
*Exx.l('060000a') = 0.2;
Exx.l('060000a') = 10;
*Exx.l('060000b') = 0.2;
Exx.l('060000b') = 10;

* Olieraffinaderier og bioolier
*Exx.l('190000a') = 1.3;
Exx.l('190000a') = 5;
*Exx.l('190000b') = 0.4;
Exx.l('190000b') = 5;

* Medicinalindustri og kemiske produkter
Exx.l('200010') = 1.8;
Exx.l('200020') = 1.8;
Exx.l('210000') = 1.8;

* Tung industri
Exx.l('220000') = 1.25;
Exx.l('230010') = 1.25;
Exx.l('240000') = 1.25;

* Anden industri og luftfart
Exx.l('100010a') = 0.7;
Exx.l('100010b') = 0.7;
Exx.l('100010c') = 0.7;
Exx.l('100020') = 0.7;
Exx.l('100030') = 0.7;
Exx.l('100040') = 0.7;
Exx.l('100050') = 0.7;
Exx.l('11200') = 0.7;
Exx.l('Industri') = 0.7;
Exx.l('160000') = 0.7;
Exx.l('230010') = 0.7;
Exx.l('250000') = 0.7;
Exx.l('280010') = 0.7;
Exx.l('280020') = 0.7;
Exx.l('51000a') = 0.7;
Exx.l('51000b') = 0.7;

* El, fjernvarme, gas og landtransport
*Exx.l('350010a') = 0.5;
*Exx.l('350010b') = 0.5;
Exx.l('350010a') = 10;
Exx.l('350010b') = 10;
* OBS: Giver en startværdi over +inf
Exx.l('350020a') = 0.5;
Exx.l('350020b') = 0.5;
Exx.l('350030a') = 0.5;
Exx.l('350030b') = 0.5;
Exx.l('36700') = 0.5;
*Exx.l('383900') = 0.5;
Exx.l('383900') = 5;
Exx.l('490030a') = 0.5;
Exx.l('490030b') = 0.5;
Exx.l('51000a') = 0.5;
Exx.l('51000b') = 0.5;

* Vand
Exx.l('36700') = 0.1;

* Byggeri og boliger
Exx.l('410009') = 0.3;
Exx.l('420000') = 0.3;
Exx.l('43000') = 0.3;
Exx.l('Boliger') = 0.3;

* Skibsfart
Exx.l('50000a') = 1.1;
Exx.l('50000b') = 1.1;


* Virksomhedernes substitution mellem indenlandske og udenlandske investeringsinputs (DREAM/REFORM:1.25, ADAM:0-1)
EIMI.l(j) = Exx.l(j);
EIBI.l(j) = Exx.l(j);

* Husholdningernes substitution mellem indenlandsk og udenlandsk input til privat forbrug (DREAM/REFORM: 1.25, ADAM:0-1)
ECC.l(j) = Exx.l(j);

* Substitution mellem indenlandsk og udenlandsk input til offentligt forbrug (DREAM: alle input er indenlandske, REFORM: 1.25, ADAM:0)
EG.l = Exx.l('Offentlig');

* Substitution mellem indenlandsk og udenlandsk input til lagerinvesteringer (REFORM: 1.25, ADAM: 0-1)
EIL.l(j) = Exx.l(j);
