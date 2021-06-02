*------------------------------------------------------------
* Mængder
*------------------------------------------------------------
sets

d     "Samlet set med alle nests" /
m     "Samlet ikke-energi materialer"
me    "Samlet energi materialer"
im    "Samlede maskininvesteringer"
ib    "Samlede bygningsinvesteringer"
c     "Samlet forbrug"
ih     "Ikke-bolig"
  nge    "Energi"
  inge   "Ikke-energi"
   iqo   "Ikke-service"
   qo    "Service (Private og offentlige)"
    q    "Service (Private tjenester)"
     qz  "Øvrige tjenester"
h        'Boligbrancen'
ng       'Fremstilling - olieraffinering'
ne       'Fremstilling - energiforsyning'
  neEL
   neReno
   neELEL
  neV
   neGAS
   neFV
a        'Landbrug'
a1
a2
a3
a4
e        'Råstofudvinding'
nf       'Fremstilling - fødevarer'
nf1
nf2
nf3
nf4
nf5
nf6
nz       'Fremstilling - øvrig' 
b        'Byggeri'
o        'Offentlige tjenester'
qs       'Tjenester    - søfart'
qf       'Tjenester    - finansielle'
qzi     'Tjenester    - øvrige    - ikke-konkurrenceudsat'
qzk     'Tjenester    - øvrige    - konkurrenceudsat'
*    a_     'Landbrug'
    01000a  "Vegetabilske produkter"
    01000b  "Kvæg"
    01000c  "Svin"
    01000d  "Fjerkræ, pelsdyr mv."
    020000  "Skovbrug"
    030000  "Fiskeri"
*    e_      'Råstofudvinding'
    060000a  "Olieudvinding"
    060000b  "Gasudvinding"
    080090  "Service til råstofudvinding (inkl. kulimport)"
*    nf_     'Fremstilling - fødevarer'
    100010a  "Slagterier (kvæg)"
    100010b  "Slagterier (svin)"
    100010c  "Slagterier (fjerkræ mv.)"
    100020  "Fiskeindustri"
    100030  "Mejerier"
    100040  "Bagerier, brødfabrikker mv."
    100050  "Anden fødevareindustri"
    11200  "Drikke- og tobaksvareindustri"
*    nz_     'Fremstilling - øvrig' 
    Industri  "Anden industri"
    160000  "Træindustri"
    200010  "Fremst. af basiskemikalier"
    200020  "Fremst. af maling og sæbe mv."
    210000  "Medicinalindustri"
    220000  "Plast- og gummiindustri"
    230010  "Glasindustri og keramisk industri"
    230020  "Betonindustri og teglværker"
    240000  "Fremst. af metal"
    250000  "Metalvareindustri"
    280010  "Fremst. af motorer, vindmøller og pumper"
    280020  "Fremst. af andre maskiner"
*    ng_     'Fremstilling - olieraffinering'
    190000a  "Olieraffinaderier mv."
    190000b  "Olieraffinaderier mv. (bioolie)"
*    ne_     "Energi (El-, gas- og fjernvarmeforsyning)"
    350010a  "Kraftvarmeværker"
    350010b  "Vind-, vand- og solkraft"
    350020a  "Naturgasforsyning"
    350020b  "Biogasforsyning"
    350030a  "Fjernvarmeværker"
    350030b  "Solvarme og geotermi"
*    qzi_   'Service, ikke-konkurrerende' 
    36700  "Vandforsyning, kloak- og rensningsanlæg"
    383900  "Renovation, genbrug og forureningsbekæmpelse"
    45000  "Bilhandel og -værksteder mv."
    470000  "Detailhandel"
    490012  "Tog, bus, taxi mv."
    490030a  "National vejgodstransport"
    50000a  "National skibsfart"
    51000a  "National luftfart"
    52000  "Hjælpevirksomhed til transport"
    550000  "Hoteller mv."
    560000  "Restauranter"
*    b_      'Byggeri'
    410009  "Nybyggeri"
    420000  "Anlægsvirksomhed"
    43000  "Reparation og vedligeholdelse"
*    qzk_   'Service, konkurrerende'
    460000  "Engroshandel"
    490030b  "International vejgodstransport"
    51000b  "International luftfart"
    53000  "Post og kurertjeneste"
    79000  "Rejsebureauer"
*    qs_     'Tjenester    - søfart'
    50000b  "International skibsfart"
*    qf_     'Tjenester    - finansielle'
    Tjenester  "Andre tjenester"
*    h_     'Boligbrancen'
    Boliger  "Boliger"
*    o_      'Offentlige tjenester'
    Offentlig  "Offentlige tjenester"
    ssum     'Tekninsk variabel til udskrivning'
/

dj(d) "Brancheaggregater" /
    h     'Boligbrancen'
    ng    'Fremstilling - olieraffinering'
    ne    'Fremstilling - energi'
    a     'Landbrug'
    e     'Råstofudvinding'
    nf    'Fremstilling - fødevarer'
    nz    'Fremstilling - øvrig' 
    b     'Byggeri'
    o     'Offentlige tjenester'
    qs    'Tjenester    - søfart'
    qf    'Tjenester    - finansielle'
    qzi   'Tjenester    - øvrige    - ikke-konkurrenceudsat'
    qzk   'Tjenester    - øvrige    - konkurrenceudsat'
/  

djme(dj) "Brancheaggregater for energi" /
    ng     'Fremstilling - olieraffinering'
    ne     "Energi (El-, gas- og fjernvarmeforsyning)"
/  

djm(dj) "Brancheaggregater for ikke-energi" /
    h     'Boligbrancen'
*    ng     'Fremstilling - olieraffinering'
*    ne     "Energi (El-, gas- og fjernvarmeforsyning)"
    a     'Landbrug'
    e     'Råstofudvinding'
    nf    'Fremstilling - fødevarer'
    nz    'Fremstilling - øvrig' 
    b     'Byggeri'
    o     'Offentlige tjenester'
    qs    'Tjenester    - søfart'
    qf    'Tjenester    - finansielle'
    qzi   'Tjenester    - øvrige    - ikke-konkurrenceudsat'
    qzk   'Tjenester    - øvrige    - konkurrenceudsat'
/  

djp(dj) "Brancheaggregater for private brancher" /
    h     'Boligbrancen'
    ng    'Fremstilling - olieraffinering'
    ne    'Fremstilling - energi'
    a     'Landbrug'
    e     'Råstofudvinding'
    nf    'Fremstilling - fødevarer'
    nz    'Fremstilling - øvrig' 
    b     'Byggeri'
*    o     'Offentlige tjenester'
    qs    'Tjenester    - søfart'
    qf    'Tjenester    - finansielle'
    qzi   'Tjenester    - øvrige    - ikke-konkurrenceudsat'
    qzk   'Tjenester    - øvrige    - konkurrenceudsat'
/  



j(d) "Brancher på disaggregeret niveau"/
*    a_     'Landbrug'
    01000a  "Vegetabilske produkter"
    01000b  "Kvæg"
    01000c  "Svin"
    01000d  "Fjerkræ, pelsdyr mv."
    020000  "Skovbrug"
    030000  "Fiskeri"
*    e_      'Råstofudvinding'
    060000a  "Olieudvinding"
    060000b  "Gasudvinding"
    080090  "Service til råstofudvinding (inkl. kulimport)"
*    nf_     'Fremstilling - fødevarer'
    100010a  "Slagterier (kvæg)"
    100010b  "Slagterier (svin)"
    100010c  "Slagterier (fjerkræ mv.)"
    100020  "Fiskeindustri"
    100030  "Mejerier"
    100040  "Bagerier, brødfabrikker mv."
    100050  "Anden fødevareindustri"
    11200  "Drikke- og tobaksvareindustri"
*    nz_     'Fremstilling - øvrig' 
    Industri  "Anden industri"
    160000  "Træindustri"
    200010  "Fremst. af basiskemikalier"
    200020  "Fremst. af maling og sæbe mv."
    210000  "Medicinalindustri"
    220000  "Plast- og gummiindustri"
    230010  "Glasindustri og keramisk industri"
    230020  "Betonindustri og teglværker"
    240000  "Fremst. af metal"
    250000  "Metalvareindustri"
    280010  "Fremst. af motorer, vindmøller og pumper"
    280020  "Fremst. af andre maskiner"
*    ng_     'Fremstilling - olieraffinering'
    190000a  "Olieraffinaderier mv."
    190000b  "Olieraffinaderier mv. (bioolie)"
*    ne_     "Energi (El-, gas- og fjernvarmeforsyning)"
    350010a  "Kraftvarmeværker"
    350010b  "Vind-, vand- og solkraft"
    350020a  "Naturgasforsyning"
    350020b  "Biogasforsyning"
    350030a  "Fjernvarmeværker"
    350030b  "Solvarme og geotermi"
    383900  "Renovation, genbrug og forureningsbekæmpelse"
*    qzi_   'Service, ikke-konkurrerende' 
    36700  "Vandforsyning, kloak- og rensningsanlæg"
    45000  "Bilhandel og -værksteder mv."
    470000  "Detailhandel"
    490012  "Tog, bus, taxi mv."
    490030a  "National vejgodstransport"
    50000a  "National skibsfart"
    51000a  "National luftfart"
    52000  "Hjælpevirksomhed til transport"
    550000  "Hoteller mv."
    560000  "Restauranter"
*    b_      'Byggeri'
    410009  "Nybyggeri"
    420000  "Anlægsvirksomhed"
    43000  "Reparation og vedligeholdelse"
*    qzk_   'Service, konkurrerende'
    460000  "Engroshandel"
    490030b  "International vejgodstransport"
    51000b  "International luftfart"
    53000  "Post og kurertjeneste"
    79000  "Rejsebureauer"
*    qs_     'Tjenester    - søfart'
    50000b  "International skibsfart"
*    qf_     'Tjenester    - finansielle'
    Tjenester  "Andre tjenester"
*    h_     'Boligbrancen'
    Boliger  "Boliger"
*    o_      'Offentlige tjenester'
    Offentlig  "Offentlige tjenester"
/

* Enkelte brancheaggregater
jh(j) 'Boligbrancen' /
*    h_     'Boligbrancen'
    Boliger  "Boliger"
/   
jng(j) 'Fremstilling - olieraffinering' /
*    ng_     'Fremstilling - olieraffinering'
    190000a  "Olieraffinaderier mv."
    190000b  "Olieraffinaderier mv. (bioolie)"
/
jne(j) 'Fremstilling - energi' /
*    ne_     "Energi (El-, gas- og fjernvarmeforsyning)"
    350010a  "Kraftvarmeværker"
    350010b  "Vind-, vand- og solkraft"
    350020a  "Naturgasforsyning"
    350020b  "Biogasforsyning"
    350030a  "Fjernvarmeværker"
    350030b  "Solvarme og geotermi"
    383900  "Renovation, genbrug og forureningsbekæmpelse"
/
ja(j) 'Landbrug' /
*    a_     'Landbrug'
    01000a  "Vegetabilske produkter"
    01000b  "Kvæg"
    01000c  "Svin"
    01000d  "Fjerkræ, pelsdyr mv."
    020000  "Skovbrug"
    030000  "Fiskeri"
/
je(j) 'Råstofudvinding' /
*    e_      'Råstofudvinding'
    060000a  "Olieudvinding"
    060000b  "Gasudvinding"
    080090  "Service til råstofudvinding (inkl. kulimport)"
/
jnf(j) 'Fremstilling - fødevarer' /
*    nf_     'Fremstilling - fødevarer'
    100010a  "Slagterier (kvæg)"
    100010b  "Slagterier (svin)"
    100010c  "Slagterier (fjerkræ mv.)"
    100020  "Fiskeindustri"
    100030  "Mejerier"
    100040  "Bagerier, brødfabrikker mv."
    100050  "Anden fødevareindustri"
    11200  "Drikke- og tobaksvareindustri"
/
jnz(j) 'Fremstilling - øvrig'  /
*    nz_     'Fremstilling - øvrig' 
    Industri  "Anden industri"
    160000  "Træindustri"
    200010  "Fremst. af basiskemikalier"
    200020  "Fremst. af maling og sæbe mv."
    210000  "Medicinalindustri"
    220000  "Plast- og gummiindustri"
    230010  "Glasindustri og keramisk industri"
    230020  "Betonindustri og teglværker"
    240000  "Fremst. af metal"
    250000  "Metalvareindustri"
    280010  "Fremst. af motorer, vindmøller og pumper"
    280020  "Fremst. af andre maskiner"
/
jb(j) 'Byggeri' /
*    b_      'Byggeri'
    410009  "Nybyggeri"
    420000  "Anlægsvirksomhed"
    43000  "Reparation og vedligeholdelse"
/
jo(j) 'Offentlige tjenester' /
*    o_      'Offentlige tjenester'
    Offentlig  "Offentlige tjenester"
/
jqs(j) 'Tjenester    - søfart' /
*    qs_     'Tjenester    - søfart'
    50000b  "International skibsfart"
/
jqf(j) 'Tjenester    - finansielle' /
*    qf_     'Tjenester    - finansielle'
    Tjenester  "Andre tjenester"
/
jqzi(j) 'Tjenester    - øvrige    - ikke-konkurrenceudsat' /
*    qzi_   'Service, ikke-konkurrerende' 
    36700  "Vandforsyning, kloak- og rensningsanlæg"
    45000  "Bilhandel og -værksteder mv."
    470000  "Detailhandel"
    490012  "Tog, bus, taxi mv."
    490030a  "National vejgodstransport"
    50000a  "National skibsfart"
    51000a  "National luftfart"
    52000  "Hjælpevirksomhed til transport"
    550000  "Hoteller mv."
    560000  "Restauranter"
/
jqzk(j) 'Tjenester    - øvrige    - konkurrenceudsat' /
*    qzk_   'Service, konkurrerende'
    460000  "Engroshandel"
    490030b  "International vejgodstransport"
    51000b  "International luftfart"
    53000  "Post og kurertjeneste"
    79000  "Rejsebureauer"
/
   
  
jp(j) "Private brancher"/
set.jh
set.jng
set.jne
set.ja
set.je
set.jnf
set.jnz
set.jb
set.jqs
set.jqf
set.jqzi
set.jqzk
/

pbe(j) "Private byerhverv"/
set.jnf
set.jnz
set.jb
set.jqf
set.jqzi
set.jqzk
/

fremst(j) "Fremstillingsvirksomhed"/
set.jne
set.jng
set.jnf
set.jnz
/   

jme(j) "Energibrancher"/
set.jne
set.jng
/   

jm(j) "Ikke-energi-brancher"/
set.jh
*set.jng
*set.jne
set.ja
set.je
set.jnf
set.jnz
set.jb
set.jo
set.jqs
set.jqf
set.jqzi
set.jqzk
/   

* Materialenests
dx(d) / 
m          "Samlet ikke-energi materialer"
me         "Samlet energi materialer"
set.dj     "Materiale-aggregater"
set.j      "Disaggregerede materialer"
/

dm(dx) "Ikke-energi materialer" /
m          "Samlet ikke-energi materialer"
set.djm    "Ikke-energi materialer"
set.jm     "Disaggregeret ikke-energi materialer"
/

dmo(dm) "Øvre ikke-energi materialeaggregater"/
m          "Samlet ikke-energi materialer"
set.djm    "Ikke-energi materiale-aggregater"
/  

dmm(dmo) "Brancheaggregater" /
set.djm    "Ikke-energi materiale-aggregater"
/  

dmi(dm) "Ikke-energi-brancher"/
set.jm     "Disaggregeret ikke-energi materialer"
/

dme(dx) "Energi materialer" /
me         "Samlet energi materialer"
set.djme   "Energi materialer"
set.jme    "Disaggregeret energi materialer"
/

dmeo(dme) "Øvre energi materialeaggregater"/
me        "Samlet energi materialer"
set.djme  "Energi materialer" 
/  

dmem(dmeo) "Brancheaggregater" /
set.djme   "Energi materialer"
/  

dmei(dme) "Energibrancher"/
set.jme
/   

* Maskininvesteringsnests
dim(d) / 
im         "Samlede maskininvesteringer"
set.dj     "Maskininvesterings-aggregater"
set.j      "Disaggregerede maskininvesteringer"
/

dimo(dim) "Øvre maskininvesteringseaggregater"/
im         "Samlede maskininvesteringer"
set.dj     "Maskininvesterings-aggregater"
/  

dimm(dimo) "Brancheaggregater" /
set.dj     "Maskininvesterings-aggregater"
/  

dimi(dim) "Ikke-energi-brancher"/
set.j      "Disaggregerede maskininvesteringer"
/

* Bygningsinvesteringsnests
dib(d) / 
ib         "Samlede bygningsinvesteringer"
set.dj     "bygningsinvesterings-aggregater"
set.j      "Disaggregerede bygningsinvesteringer"
/

dibo(dib) "Øvre bygningsinvesteringseaggregater"/
ib         "Samlede bygningsinvesteringer"
set.dj     "bygningsinvesterings-aggregater"
/  

dibm(dibo) "Brancheaggregater" /
set.dj     "bygningsinvesterings-aggregater"
/  

dibi(dib) "Ikke-energi-brancher"/
set.j      "Disaggregerede bygningsinvesteringer"
/

* Forbrugsnests
dc(d) "Forbrugskomponenter" /
c           "Samlet forbrug"
ih          "Ikke-bolig"
  nge    "Energi"
  inge   "Ikke-energi"
   iqo   "Ikke-service"
   qo    "Service (Private og offentlige)"
    q    "Service (Private tjenester)"
     qz  "Øvrige tjenester"
    set.dj  'Vare-aggregater'    
set.j   "Disaggregeret forbrug"
neEL
neV
   neReno
   neELEL
   neGAS
   neFV
nf1
nf2
nf3
nf4
nf5
nf6
a1
a2
a3
a4
/

dco(dc) "Øvre forbrugsaggregater (inkl. mellemgruppe)"/
c           "Samlet forbrug"
ih          "Ikke-bolig"
  nge    "Energi"
  inge   "Ikke-energi"
   iqo   "Ikke-service"
   qo    "Service (Private og offentlige)"
    q    "Service (Private tjenester)"
     qz  "Øvrige tjenester"
    set.dj  'Vare-aggregater'
neEL
neV
   neReno
   neELEL
   neGAS
   neFV
nf1
nf2
nf3
nf4
nf5
nf6
a1
a2
a3
a4
/  

dcm(dco) "Mellemgruppe forbrugsaggregater"/
    set.dj  'Vare-aggregater'   
/  

dci(dc) "Disaggregerede forbrugsgrupper"/
set.j
/   

dcio(dc) "Øvre forbrugsaggregater (inkl. mellemgruppe)"/
c        "Samlet forbrug"
 ih      "Ikke-bolig"
  nge    "Energi"
  inge   "Ikke-energi"
   iqo   "Ikke-service"
   qo    "Service (Private og offentlige)"
*    q    "Service (Private tjenester)"
     qz  "Øvrige tjenester"
set.djp  'Vare-aggregater for private brancher'
set.j   "Disaggregeret forbrug"
/  
;

alias(dj,di);
alias(j,i);
alias(j,jj);
alias(jm,jjm);
alias(jme,jjme);

*Materiale-mappings
set mapdm2dmo(dmo,dm)   "Mapping til øvre ikke-energi materialeaggregater fra lavere ikke-energi materialekomponenter" /
  m     . (h,qzk,qzi,a,e,b,nf,nz,qf,qs,o)
*  h   . h_
  h     . (Boliger)
*  ng    . (190000a,190000b)
*  ne    . (350010a,350010b,350020a,350020b,350030a,350030b,383900)
*  a     . a_
  a     . (01000a,01000b,01000c,01000d,020000,030000)
*  e     . e_
  e     . (060000a,060000b,080090)
*  nf    . nf_
  nf    . (100010a,100010b,100010c,100020,100030,100040,100050,11200)
*  nz    . nz_
  nz    . (Industri,160000,200010,200020,210000,220000,230010,230020,240000,250000,280010,280020)
*  b     . b_
  b     . (410009,420000,43000)
*  o     . o_  
  o     . (Offentlig)  
*  qs    . qs_
  qs    . (50000b)
*  qf    . qf_
  qf    . (Tjenester)
*  qzi . qzi_
  qzi   . (36700,45000,470000,490012,490030a,50000a,51000a,52000,550000,560000)
*  qzk . qzk_
  qzk   . (460000,490030b,51000b,53000,79000)
/;

set mapdm2i(i,dm) "Mapping af disaggregeret ikke-energi materialer til brancher" /
*h_   . h_
    01000a . 01000a
    01000b . 01000b
    01000c . 01000c
    01000d . 01000d
    020000 . 020000
    030000 . 030000
    060000a . 060000a
    060000b . 060000b
    080090 . 080090
    100010a . 100010a
    100010b . 100010b
    100010c . 100010c
    100020 . 100020
    100030 . 100030
    100040 . 100040
    100050 . 100050
    11200 . 11200
    Industri . Industri
    160000 . 160000
*    190000a . 190000a
*    190000b . 190000b
    200010 . 200010
    200020 . 200020
    210000 . 210000
    220000 . 220000
    230010 . 230010
    230020 . 230020
    240000 . 240000
    250000 . 250000
    280010 . 280010
    280020 . 280020
*    350010a . 350010a
*    350010b . 350010b
*    350020a . 350020a
*    350020b . 350020b
*    350030a . 350030a
*    350030b . 350030b
    36700 . 36700
*    383900 . 383900
    410009 . 410009
    420000 . 420000
    43000 . 43000
    45000 . 45000
    460000 . 460000
    470000 . 470000
    490012 . 490012
    490030a . 490030a
    490030b . 490030b
    50000a . 50000a
    50000b . 50000b
    51000a . 51000a
    51000b . 51000b
    52000 . 52000
    53000 . 53000
    550000 . 550000
    560000 . 560000
    Tjenester . Tjenester
    Boliger . Boliger
    Offentlig . Offentlig
    79000 . 79000
/;

set mapdme2dmeo(dmeo,dme)   "Mapping til øvre forbrugsaggregater fra lavere forbrugskomponenter" /
  me  . (ne,ng)
*  ne  . ne_
  ne    . (350010a,350010b,350020a,350020b,350030a,350030b,383900)
*  ng    . ng_
  ng    . (190000a,190000b)
/;

*Maskininvesterings-mappings
set mapdim2dimo(dimo,dim)   "Mapping til øvre maskininvesteringsaggregater fra lavere komponenter" /
  im    . (h,qzk,qzi,a,e,b,ne,ng,nf,nz,qf,qs,o)
*  h   . h_
  h     . (Boliger)
*  ng    . ng_
  ng    . (190000a,190000b)
*  ne  . ne_
  ne    . (350010a,350010b,350020a,350020b,350030a,350030b,383900)
*  a     . a_
  a     . (01000a,01000b,01000c,01000d,020000,030000)
*  e     . e_
  e     . (060000a,060000b,080090)
*  nf    . nf_
  nf    . (100010a,100010b,100010c,100020,100030,100040,100050,11200)
*  nz    . nz_
  nz    . (Industri,160000,200010,200020,210000,220000,230010,230020,240000,250000,280010,280020)
*  b     . b_
  b     . (410009,420000,43000)
*  o     . o_  
  o     . (Offentlig)  
*  qs    . qs_
  qs    . (50000b)
*  qf    . qf_
  qf    . (Tjenester)
*  qzi . qzi_
  qzi   . (36700,45000,470000,490012,490030a,50000a,51000a,52000,550000,560000)
*  qzk . qzk_
  qzk   . (460000,490030b,51000b,53000,79000)
/;

set mapdim2i(i,dim) "Mapping af disaggregeret maskininvesteringer til brancher" /
    01000a . 01000a
    01000b . 01000b
    01000c . 01000c
    01000d . 01000d
    020000 . 020000
    030000 . 030000
    060000a . 060000a
    060000b . 060000b
    080090 . 080090
    100010a . 100010a
    100010b . 100010b
    100010c . 100010c
    100020 . 100020
    100030 . 100030
    100040 . 100040
    100050 . 100050
    11200 . 11200
    Industri . Industri
    160000 . 160000
    190000a . 190000a
    190000b . 190000b
    200010 . 200010
    200020 . 200020
    210000 . 210000
    220000 . 220000
    230010 . 230010
    230020 . 230020
    240000 . 240000
    250000 . 250000
    280010 . 280010
    280020 . 280020
    350010a . 350010a
    350010b . 350010b
    350020a . 350020a
    350020b . 350020b
    350030a . 350030a
    350030b . 350030b
    36700 . 36700
    383900 . 383900
    410009 . 410009
    420000 . 420000
    43000 . 43000
    45000 . 45000
    460000 . 460000
    470000 . 470000
    490012 . 490012
    490030a . 490030a
    490030b . 490030b
    50000a . 50000a
    50000b . 50000b
    51000a . 51000a
    51000b . 51000b
    52000 . 52000
    53000 . 53000
    550000 . 550000
    560000 . 560000
    Tjenester . Tjenester
    Boliger . Boliger
    Offentlig . Offentlig
    79000 . 79000
/;

*Bygningsinvesterings-mappings
set mapdib2dibo(dibo,dib)   "Mapping til øvre bygningsinvesteringsaggregater fra laverekomponenter" /
  ib    . (h,qzk,qzi,a,e,b,ne,ng,nf,nz,qf,qs,o)
*  h   . h_
  h     . (Boliger)
*  ng    . ng_
  ng    . (190000a,190000b)
*  ne  . ne_
  ne    . (350010a,350010b,350020a,350020b,350030a,350030b,383900)
*  a     . a_
  a     . (01000a,01000b,01000c,01000d,020000,030000)
*  e     . e_
  e     . (060000a,060000b,080090)
*  nf    . nf_
  nf    . (100010a,100010b,100010c,100020,100030,100040,100050,11200)
*  nz    . nz_
  nz    . (Industri,160000,200010,200020,210000,220000,230010,230020,240000,250000,280010,280020)
*  b     . b_
  b     . (410009,420000,43000)
*  o     . o_  
  o     . (Offentlig)  
*  qs    . qs_
  qs    . (50000b)
*  qf    . qf_
  qf    . (Tjenester)
*  qzi . qzi_
  qzi   . (36700,45000,470000,490012,490030a,50000a,51000a,52000,550000,560000)
*  qzk . qzk_
  qzk   . (460000,490030b,51000b,53000,79000)
/;

set mapdib2i(i,dib) "Mapping af disaggregeret bygningsinvesteringer til brancher" /
    01000a . 01000a
    01000b . 01000b
    01000c . 01000c
    01000d . 01000d
    020000 . 020000
    030000 . 030000
    060000a . 060000a
    060000b . 060000b
    080090 . 080090
    100010a . 100010a
    100010b . 100010b
    100010c . 100010c
    100020 . 100020
    100030 . 100030
    100040 . 100040
    100050 . 100050
    11200 . 11200
    Industri . Industri
    160000 . 160000
    190000a . 190000a
    190000b . 190000b
    200010 . 200010
    200020 . 200020
    210000 . 210000
    220000 . 220000
    230010 . 230010
    230020 . 230020
    240000 . 240000
    250000 . 250000
    280010 . 280010
    280020 . 280020
    350010a . 350010a
    350010b . 350010b
    350020a . 350020a
    350020b . 350020b
    350030a . 350030a
    350030b . 350030b
    36700 . 36700
    383900 . 383900
    410009 . 410009
    420000 . 420000
    43000 . 43000
    45000 . 45000
    460000 . 460000
    470000 . 470000
    490012 . 490012
    490030a . 490030a
    490030b . 490030b
    50000a . 50000a
    50000b . 50000b
    51000a . 51000a
    51000b . 51000b
    52000 . 52000
    53000 . 53000
    550000 . 550000
    560000 . 560000
    Tjenester . Tjenester
    Boliger . Boliger
    Offentlig . Offentlig
    79000 . 79000
/;

set mapdme2i(i,dme) "Mapping af disaggregeret forbrug til brancher" /
*ne_  . ne_
    350010a . 350010a
    350010b . 350010b
    350020a . 350020a
    350020b . 350020b
    350030a . 350030a
    350030b . 350030b
    383900 . 383900
*ng_  . ng_
    190000a . 190000a
    190000b . 190000b
/;

*Forbrugs-mappings
set mapdc2dco(dco,dc)   "Mapping til øvre forbrugsaggregater fra lavere forbrugskomponenter" /
  c     . (h,ih)
  ih    . (nge,inge)
  nge   . (ng,ne)
  ne    . (neel,neV)
  neel  . (neELEL,neReno)
  neV   . (neGAS,neFV)
  inge  . (qo,iqo)
  iqo   . (a,e,nf,nz,b)
  qo    . (o,q)
  q     . (qs,qf,qz)
  qz    . (qzk,qzi)
*  h   . h_
  h     . (Boliger)
*  ng    . ng_
  ng    . (190000a,190000b)
*  ne  . ne_
  neELEL . (350010a,350010b)
  neReno . (383900)  
  neGAS  . (350020a,350020b)
  neFV   . (350030a,350030b)  
*  a     . a_
*  a     . (01000a,01000b,01000c,01000d,020000,030000)
  a     . (a1,020000)
  a1    . (a2,01000a)
  a2    . (a3,030000)
  a3    . (a4,01000d)
  a4    . (01000b,01000c)
*  e     . e_
  e     . (060000a,060000b,080090)
*  nf    . nf_
*  nf    . (100010a,100010b,100010c,100020,100030,100040,100050,11200)
   nf    . (nf1,11200)
   nf1   . (nf2,100050)
   nf2   . (nf3,100040)
   nf3   . (nf4,100030)
   nf4   . (nf5,100020)
   nf5   . (nf6,100010c)
   nf6   . (100010a,100010b)
*  nz    . nz_
  nz    . (Industri,160000,200010,200020,210000,220000,230010,230020,240000,250000,280010,280020)
*  b     . b_
  b     . (410009,420000,43000)
*  o     . o_  
  o     . (Offentlig)  
*  qs    . qs_
  qs    . (50000b)
*  qf    . qf_
  qf    . (Tjenester)
*  qzi . qzi_
  qzi   . (36700,45000,470000,490012,490030a,50000a,51000a,52000,550000,560000)
*  qzk . qzk_
  qzk   . (460000,490030b,51000b,53000,79000)
/;

set mapdc2i(i,dc) "Mapping af disaggregeret forbrug til brancher" /
    01000a . 01000a
    01000b . 01000b
    01000c . 01000c
    01000d . 01000d
    020000 . 020000
    030000 . 030000
    060000a . 060000a
    060000b . 060000b
    080090 . 080090
    100010a . 100010a
    100010b . 100010b
    100010c . 100010c
    100020 . 100020
    100030 . 100030
    100040 . 100040
    100050 . 100050
    11200 . 11200
    Industri . Industri
    160000 . 160000
    190000a . 190000a
    190000b . 190000b
    200010 . 200010
    200020 . 200020
    210000 . 210000
    220000 . 220000
    230010 . 230010
    230020 . 230020
    240000 . 240000
    250000 . 250000
    280010 . 280010
    280020 . 280020
    350010a . 350010a
    350010b . 350010b
    350020a . 350020a
    350020b . 350020b
    350030a . 350030a
    350030b . 350030b
    36700 . 36700
    383900 . 383900
    410009 . 410009
    420000 . 420000
    43000 . 43000
    45000 . 45000
    460000 . 460000
    470000 . 470000
    490012 . 490012
    490030a . 490030a
    490030b . 490030b
    50000a . 50000a
    50000b . 50000b
    51000a . 51000a
    51000b . 51000b
    52000 . 52000
    53000 . 53000
    550000 . 550000
    560000 . 560000
    Tjenester . Tjenester
    Boliger . Boliger
    Offentlig . Offentlig
    79000 . 79000
/;

*Mapping mellem 13 og 73 brancher
set mapj2dj(dj,j)   "Mapping fra 73 til 13 brancher" /
*  h   . h_
  h     . (Boliger)
*  ng    . ng_
  ng    . (190000a,190000b)
*  ne  . ne_
  ne    . (350010a,350010b,350020a,350020b,350030a,350030b,383900)
*  a     . a_
  a     . (01000a,01000b,01000c,01000d,020000,030000)
*  e     . e_
  e     . (060000a,060000b,080090)
*  nf    . nf_
  nf    . (100010a,100010b,100010c,100020,100030,100040,100050,11200)
*  nz    . nz_
  nz    . (Industri,160000,200010,200020,210000,220000,230010,230020,240000,250000,280010,280020)
*  b     . b_
  b     . (410009,420000,43000)
*  o     . o_  
  o     . (Offentlig)  
*  qs    . qs_
  qs    . (50000b)
*  qf    . qf_
  qf    . (Tjenester)
*  qzi . qzi_
  qzi   . (36700,45000,470000,490012,490030a,50000a,51000a,52000,550000,560000)
*  qzk . qzk_
  qzk   . (460000,490030b,51000b,53000,79000)
/;

sets tax / 
tax0        "Samlet afgift"
tax1        "Benzinafgift"
tax2        "Registreringsafgift"
tax3        "Tobaksafgift"
tax4        "Chokolade- og sukkerafgift"
tax5        "Mættet fedt"
tax6        "Øl-vin og spiritusafgift"
tax7        "The, kaffe og mineralvand" 
tax8        "El-afgift"
tax9        "Visse olieprodukter (diesel)"
tax10       "Sten og brunkul mv." 
tax11       "C02-afgift"
tax12       "Råstofafgift"
tax13       "Emballage, affald mv."
tax14       "Vandafgift"
tax15       "Naturgas afgift"
tax16       "PSO-afgift"
tax17       "Tinglysningsafgift mv."
tax18       "Forsikringsafgift"
tax19       "Øvrige Afgifter"
tax20       "Transportsubsidie"
tax21       "Elproduktionstilskud"
tax22       "Tilskud til Ve (PSO-afgift)"
tax23       "Øvrige subsidier"
/;

sets taxd(tax) "Uden samlet afgift" / 
tax1        "Benzinafgift"
tax2        "Registreringsafgift"
tax3        "Tobaksafgift"
tax4        "Chokolade- og sukkerafgift"
tax5        "Mættet fedt"
tax6        "Øl-vin og spiritusafgift"
tax7        "The, kaffe og mineralvand" 
tax8        "El-afgift"
tax9        "Visse olieprodukter (diesel)"
tax10       "Sten og brunkul mv." 
tax11       "C02-afgift"
tax12       "Råstofafgift"
tax13       "Emballage, affald mv."
tax14       "Vandafgift"
tax15       "Naturgas afgift"
tax16       "PSO-afgift"
tax17       "Tinglysningsafgift mv."
tax18       "Forsikringsafgift"
tax19       "Øvrige Afgifter"
tax20       "Transportsubsidie"
tax21       "Elproduktionstilskud"
tax22       "Tilskud til Ve (PSO-afgift)"
tax23       "Øvrige subsidier"
/;
