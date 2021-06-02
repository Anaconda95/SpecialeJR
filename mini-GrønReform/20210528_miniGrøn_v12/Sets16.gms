*------------------------------------------------------------
* Mængder
*------------------------------------------------------------
sets

d        "Samlet set med alle nests" /
m        "Samlet ikke-energi materialer"
me       "Samlet energi materialer"
im       "Samlede maskininvesteringer"
ib       "Samlede bygningsinvesteringer"
c        "Samlet forbrug"
ih       "Ikke-bolig"
nge      "Energi"
inge     "Ikke-energi"
iqo      "Ikke-service"
qo       "Service (Private og offentlige)"
q        "Service (Private tjenester)"
qz       "Øvrige tjenester"
h        'Boligbrancen'
ng       'Fremstilling - olieraffinering'
ne       'Fremstilling - energiforsyning'
a        'Landbrug'
e        'Råstofudvinding'
nf       'Fremstilling - fødevarer'
nz       'Fremstilling - øvrig' 
b        'Byggeri'
o        'Offentlige tjenester'
qs       'Tjenester    - søfart'
qf       'Tjenester    - finansielle'
qzi     'Tjenester    - øvrige    - ikke-konkurrenceudsat'
qzk     'Tjenester    - øvrige    - konkurrenceudsat'
h_   'Boligbrancen'
ng_  'Fremstilling - olieraffinering'
*    ne_     "Energi (El-, gas- og fjernvarmeforsyning)"
    35001  "24a Production and distribution of electricity"
    35002  "24b Manufacture and distribution of gas"
    35003  "24c Steam and hot water supply"
    36000  "25 Water collection, purification and supply"
a_   'Landbrug'
e_   'Råstofudvinding'
nf_  'Fremstilling - fødevarer'
nz_  'Fremstilling - øvrig' 
b_   'Byggeri'
o_   'Offentlige tjenester'
qs_  'Tjenester    - søfart'
qf_  'Tjenester    - finansielle'
qzi_ 'Tjenester    - øvrige    - ikke-konkurrenceudsat'
qzk_ 'Tjenester    - øvrige    - konkurrenceudsat'
ssum 'Teknisk variabel'
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
     h_     'Boligbrancen'
     ng_    'Fremstilling - olieraffinering'
*    ne_     "Energi (El-, gas- og fjernvarmeforsyning)"
    35001  "24a Production and distribution of electricity"
    35002  "24b Manufacture and distribution of gas"
    35003  "24c Steam and hot water supply"
    36000  "25 Water collection, purification and supply"
     a_     'Landbrug'
     e_     'Råstofudvinding'
     nf_    'Fremstilling - fødevarer'
     nz_    'Fremstilling - øvrig' 
     b_     'Byggeri'
     o_     'Offentlige tjenester'
     qs_    'Tjenester    - søfart'
     qf_    'Tjenester    - finansielle'
     qzi_   'Tjenester    - øvrige    - ikke-konkurrenceudsat'
     qzk_   'Tjenester    - øvrige    - konkurrenceudsat'
/

* Enkelte brancheaggregater
jh(j) 'Boligbranchen' /
h_     
/   
jng(j) 'Fremstilling - olieraffinering' /
ng_    
/
jne(j) 'Fremstilling - energi' /
*    ne_     "Energi (El-, gas- og fjernvarmeforsyning)"
  35001  "24a Production and distribution of electricity"
  35002  "24b Manufacture and distribution of gas"
  35003  "24c Steam and hot water supply"
  36000  "25 Water collection, purification and supply"
/
ja(j) 'Landbrug' /
a_     
/
je(j) 'Råstofudvinding' /
e_     
/
jnf(j) 'Fremstilling - fødevarer' /
nf_    
/
jnz(j) 'Fremstilling - øvrig'  /
nz_    
/
jb(j) 'Byggeri' /
b_     
/
jo(j) 'Offentlige tjenester' /
o_     
/      
jqs(j) 'Tjenester    - søfart' /
qs_    
/
jqf(j) 'Tjenester    - finansielle' /
qf_    
/
jqzi(j) 'Tjenester    - øvrige    - ikke-konkurrenceudsat' /
qzi_ 
/
jqzk(j) 'Tjenester    - øvrige    - konkurrenceudsat' /
qzk_   
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
c        "Samlet forbrug"
 ih      "Ikke-bolig"
  nge    "Energi"
  inge   "Ikke-energi"
   iqo   "Ikke-service"
   qo    "Service (Private og offentlige)"
    q    "Service (Private tjenester)"
     qz  "Øvrige tjenester"
set.dj  'Vare-aggregater'
set.j   "Disaggregeret forbrug"
/

dco(dc) "Øvre forbrugsaggregater (inkl. mellemgruppe)"/
c        "Samlet forbrug"
 ih      "Ikke-bolig"
  nge    "Energi"
  inge   "Ikke-energi"
   iqo   "Ikke-service"
   qo    "Service (Private og offentlige)"
    q    "Service (Private tjenester)"
     qz  "Øvrige tjenester"
set.dj  'Vare-aggregater'
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
  h     . h_
*  ng    . ng_
*  ne    . ne_
  a     . a_
  e     . e_
  nf    . nf_
  nz    . nz_
  b     . b_
  o     . o_  
  qs    . qs_
  qf    . qf_
  qzi   . qzi_
  qzk   . qzk_
/;

set mapdm2i(i,dm) "Mapping af disaggregeret ikke-energi materialer til brancher" /
  h_    . h_
*  ng_   . ng_
*  ne_   . ne_
  a_    . a_
  e_    . e_
  nf_   . nf_
  nz_   . nz_
  b_    . b_
  o_    . o_  
  qs_   . qs_
  qf_   . qf_
  qzi_  . qzi_
  qzk_  . qzk_
/;

set mapdme2dmeo(dmeo,dme)   "Mapping til øvre energi materialeaggregater fra lavere energi materialekomponenter" /
  me  . (ne,ng)
  ng  . ng_
*  ne  . ne_
  ne    . (35001,35002,35003,36000)
/;

set mapdme2i(i,dme) "Mapping af disaggregeret energi materialer til brancher" /
  ng_   . ng_
*ne_  . ne_
    35001 . 35001 
    35002 . 35002 
    35003 . 35003 
    36000 . 36000
/;

*Maskininvesterings-mappings
set mapdim2dimo(dimo,dim)   "Mapping til øvre maskininvesteringsaggregater fra laverekomponenter" /
  im    . (h,qzk,qzi,a,e,b,ne,ng,nf,nz,qf,qs,o)
  h     . h_
  ng    . ng_
*  ne  . ne_
  ne    . (35001,35002,35003,36000)
  a     . a_
  e     . e_
  nf    . nf_
  nz    . nz_
  b     . b_
  o     . o_  
  qs    . qs_
  qf    . qf_
  qzi   . qzi_
  qzk   . qzk_
/;

set mapdim2i(i,dim) "Mapping af disaggregeret maskininvesteringer til brancher" /
  h_    . h_
  ng_   . ng_
*ne_  . ne_
    35001 . 35001 
    35002 . 35002 
    35003 . 35003 
    36000 . 36000
  a_    . a_
  e_    . e_
  nf_   . nf_
  nz_   . nz_
  b_    . b_
  o_    . o_  
  qs_   . qs_
  qf_   . qf_
  qzi_  . qzi_
  qzk_  . qzk_
/;

*Bygningsinvesterings-mappings
set mapdib2dibo(dibo,dib)   "Mapping til øvre bygningsinvesteringsaggregater fra laverekomponenter" /
  ib    . (h,qzk,qzi,a,e,b,ne,ng,nf,nz,qf,qs,o)
  h     . h_
  ng    . ng_
*  ne  . ne_
  ne    . (35001,35002,35003,36000)
  a     . a_
  e     . e_
  nf    . nf_
  nz    . nz_
  b     . b_
  o     . o_  
  qs    . qs_
  qf    . qf_
  qzi   . qzi_
  qzk   . qzk_
/;

set mapdib2i(i,dib) "Mapping af disaggregeret bygningsinvesteringer til brancher" /
  h_    . h_
  ng_   . ng_
*ne_  . ne_
    35001 . 35001 
    35002 . 35002 
    35003 . 35003 
    36000 . 36000
  a_    . a_
  e_    . e_
  nf_   . nf_
  nz_   . nz_
  b_    . b_
  o_    . o_  
  qs_   . qs_
  qf_   . qf_
  qzi_  . qzi_
  qzk_  . qzk_
/;

*Forbrugs-mappings
set mapdc2dco(dco,dc)   "Mapping til øvre forbrugsaggregater fra lavere forbrugskomponenter" /
  c     . (h,ih)
  ih    . (nge,inge)
  nge   . (ng,ne)
  inge  . (qo,iqo)
  iqo   . (a,e,nf,nz,b)
  qo    . (o,q)
  q     . (qs,qf,qz)
  qz    . (qzk,qzi)
  h     . h_
  ng    . ng_
*  ne  . ne_
  ne    . (35001,35002,35003,36000)
  a     . a_
  e     . e_
  nf    . nf_
  nz    . nz_
  b     . b_
  o     . o_  
  qs    . qs_
  qf    . qf_
  qzi   . qzi_
  qzk   . qzk_
/;

set mapdc2i(i,dc) "Mapping af disaggregeret forbrug til brancher" /
  h_    . h_
  ng_   . ng_
*ne_  . ne_
    35001 . 35001 
    35002 . 35002 
    35003 . 35003 
    36000 . 36000
  a_    . a_
  e_    . e_
  nf_   . nf_
  nz_   . nz_
  b_    . b_
  o_    . o_  
  qs_   . qs_
  qf_   . qf_
  qzi_  . qzi_
  qzk_  . qzk_
/;

*Mapping mellem 13 og 16 brancher
set mapj2dj(dj,j)   "Mapping fra 13 til 16 brancher" /
  h     . h_
  ng    . ng_
*  ne  . ne_
  ne    . (35001,35002,35003,36000)
  a     . a_
  e     . e_
  nf    . nf_
  nz    . nz_
  b     . b_
  o     . o_  
  qs    . qs_
  qf    . qf_
  qzi   . qzi_
  qzk   . qzk_
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