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
*    a_     'Landbrug'
    01000  " 1 Agriculture and horticulture"
    02000  " 2 Forestry"
    03000  " 3 Fishing"
*    e_      'Råstofudvinding'
    0600a  " 4a Extration of oil"
    0600b  " 4b Extraction of gas (incl. coalimport)"
    08090  " 4c Extraction of gravel and stone and mining support service activities"
*    nf_     'Fremstilling - fødevarer'
    10120  " 5 Manufacture of food products, beverages and tobacco"
*    nz_     'Fremstilling - øvrig' 
    13150  " 6 Textiles and leather products"
    16000  " 7 Manufacture of wood and wood products"
    17000  " 8 Manufacture of paper and paper products"
    18000  " 9 Printing etc."
    20000  "11 Manufacture of chemicals"
    21000  "12 Pharmaceuticals"
    22000  "13 Manufacture of rubber and plastic products"
    23000  "14 Manufacture of other non-metallic mineral products"
    24000  "15 Manufacture of basic metals"
    25000  "16 Manufacture of fabricated metal products"
    26000  "17 Manufacture of electronic components"
    27000  "18 Electrical equipment"
    28000  "19 Manufacture of machinery"
    29000  "20 Manufacture of motor vehicles and related parts"
    30000  "21 Manufacture of ships and other transport equipment"
    31320  "22 Manufacture of furniture and other manufacturing"
    33000  "23 Repair and installation of machinery and equipment"
*    ng_     'Fremstilling - olieraffinering'
    19000  "10 Oil refinery etc."
*    ne_     "Energi (El-, gas- og fjernvarmeforsyning)"
    35001  "24a Production and distribution of electricity"
    35002  "24b Manufacture and distribution of gas"
    35003  "24c Steam and hot water supply"
    36000  "25 Water collection, purification and supply"
*    qzi_   'Service, ikke-konkurrerende' 
    37390  "26 Sewerage; waste collection, treatment and disposal activities etc."
    45000  "28 Wholesale and retail trade and repair of motor vehicles and motorcycles"
    47000  "30 Retail sale"
    49000  "31 Land transport and transport via pipelines"
    52000  "34 Support activities for transportation"
    55560  "36 Accommodation and food service activities"
    59600  "38 Motion picture and television programme prod., sound recording; radio and televisi"
    68100  "44 Buying and selling of real estate"
    68300  "45 Renting of non-residential buildings"
    69700  "48 Legal and accounting activities; activities of head offices; management consultanc"
    71000  "49 Architectural and engineering activities"
    72001  "50 Scientific research and development (market)"
    73000  "52 Advertising and market research"
    74750  "53 Other professional, scientific and technical activities; veterinary activities"
    77000  "54 Rental and leasing activities"
    78000  "55 Employment activities"
    85101  "61 Education (market)"
    93000  "65 Sports activities and amusement and recreation activities"
    94000  "66 Activities of membership organisations"
    95000  "67 Repair of personal goods"
    96000  "68 Other personal service activities"
    97000  "69 Activities of households as employers of domestic personnel"
*    b_      'Byggeri'
    41430  "27 Construction"
*    qzk_   'Service, konkurrerende'
    46000  "29 Wholesale"
    51000  "33 Air transport"
    53000  "35 Postal and courier activities"
    58000  "37 Publishing activities"
    61000  "39 Telecommunications"
    62630  "40 IT and information service activities"
    79000  "56 Travel agent activities"
    80820  "57 Security and investigation; services to buildings and landscape; other businness s"
*    qs_     'Tjenester    - søfart'
    50000  "32 Water transport"
*    qf_     'Tjenester    - finansielle'
    64000  "41 Financial service activities, except insurance and pension funding"
    65000  "42 Insurance and pension funding"
    66000  "43 Other financial activities"
*    h_     'Boligbrancen'
    68203  "46 Renting of residential buildings"
    68204  "47 Owner-occupied dwellings"
*    o_      'Offentlige tjenester'
    72002  "51 Scientific research and development (non-market)"
    84101  "59 Rescue service etc. (market)"
    84202  "58 Public administration etc."
    85202  "60 Education (non-market)"
    86000  "62 Human health activities"
    87880  "63 Residential care"
    90920  "64 Arts and entertainment; libraries, museums and other cultural activities; gambling"
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
    01000  " 1 Agriculture and horticulture"
    02000  " 2 Forestry"
    03000  " 3 Fishing"
*    e_      'Råstofudvinding'
    0600a  " 4a Extration of oil"
    0600b  " 4b Extraction of gas (incl. coalimport)"
    08090  " 4c Extraction of gravel and stone and mining support service activities"
*    nf_     'Fremstilling - fødevarer'
    10120  " 5 Manufacture of food products, beverages and tobacco"
*    nz_     'Fremstilling - øvrig' 
    13150  " 6 Textiles and leather products"
    16000  " 7 Manufacture of wood and wood products"
    17000  " 8 Manufacture of paper and paper products"
    18000  " 9 Printing etc."
    20000  "11 Manufacture of chemicals"
    21000  "12 Pharmaceuticals"
    22000  "13 Manufacture of rubber and plastic products"
    23000  "14 Manufacture of other non-metallic mineral products"
    24000  "15 Manufacture of basic metals"
    25000  "16 Manufacture of fabricated metal products"
    26000  "17 Manufacture of electronic components"
    27000  "18 Electrical equipment"
    28000  "19 Manufacture of machinery"
    29000  "20 Manufacture of motor vehicles and related parts"
    30000  "21 Manufacture of ships and other transport equipment"
    31320  "22 Manufacture of furniture and other manufacturing"
    33000  "23 Repair and installation of machinery and equipment"
*    ng_     'Fremstilling - olieraffinering'
    19000  "10 Oil refinery etc."
*    ne_     "Energi (El-, gas- og fjernvarmeforsyning)"
    35001  "24a Production and distribution of electricity"
    35002  "24b Manufacture and distribution of gas"
    35003  "24c Steam and hot water supply"
    36000  "25 Water collection, purification and supply"
*    qzi_   'Service, ikke-konkurrerende' 
    37390  "26 Sewerage; waste collection, treatment and disposal activities etc."
    45000  "28 Wholesale and retail trade and repair of motor vehicles and motorcycles"
    47000  "30 Retail sale"
    49000  "31 Land transport and transport via pipelines"
    52000  "34 Support activities for transportation"
    55560  "36 Accommodation and food service activities"
    59600  "38 Motion picture and television programme prod., sound recording; radio and televisi"
    68100  "44 Buying and selling of real estate"
    68300  "45 Renting of non-residential buildings"
    69700  "48 Legal and accounting activities; activities of head offices; management consultanc"
    71000  "49 Architectural and engineering activities"
    72001  "50 Scientific research and development (market)"
    73000  "52 Advertising and market research"
    74750  "53 Other professional, scientific and technical activities; veterinary activities"
    77000  "54 Rental and leasing activities"
    78000  "55 Employment activities"
    85101  "61 Education (market)"
    93000  "65 Sports activities and amusement and recreation activities"
    94000  "66 Activities of membership organisations"
    95000  "67 Repair of personal goods"
    96000  "68 Other personal service activities"
    97000  "69 Activities of households as employers of domestic personnel"
*    b_      'Byggeri'
    41430  "27 Construction"
*    qzk_   'Service, konkurrerende'
    46000  "29 Wholesale"
    51000  "33 Air transport"
    53000  "35 Postal and courier activities"
    58000  "37 Publishing activities"
    61000  "39 Telecommunications"
    62630  "40 IT and information service activities"
    79000  "56 Travel agent activities"
    80820  "57 Security and investigation; services to buildings and landscape; other businness s"
*    qs_     'Tjenester    - søfart'
    50000  "32 Water transport"
*    qf_     'Tjenester    - finansielle'
    64000  "41 Financial service activities, except insurance and pension funding"
    65000  "42 Insurance and pension funding"
    66000  "43 Other financial activities"
*    h_     'Boligbrancen'
    68203  "46 Renting of residential buildings"
    68204  "47 Owner-occupied dwellings"
*    o_      'Offentlige tjenester'
    72002  "51 Scientific research and development (non-market)"
    84101  "59 Rescue service etc. (market)"
    84202  "58 Public administration etc."
    85202  "60 Education (non-market)"
    86000  "62 Human health activities"
    87880  "63 Residential care"
    90920  "64 Arts and entertainment; libraries, museums and other cultural activities; gambling"
/

* Enkelte brancheaggregater
jh(j) 'Boligbrancen' /
*    h_     'Boligbrancen'
 68203  "46 Renting of residential buildings"
 68204  "47 Owner-occupied dwellings"
/   
jng(j) 'Fremstilling - olieraffinering' /
*    ng_     'Fremstilling - olieraffinering'
    19000  "10 Oil refinery etc."
/
jne(j) 'Fremstilling - energi' /
*    ne_     "Energi (El-, gas- og fjernvarmeforsyning)"
  35001  "24a Production and distribution of electricity"
  35002  "24b Manufacture and distribution of gas"
  35003  "24c Steam and hot water supply"
  36000  "25 Water collection, purification and supply"
/
ja(j) 'Landbrug' /
*    a_     'Landbrug'
    01000  " 1 Agriculture and horticulture"
    02000  " 2 Forestry"
    03000  " 3 Fishing"
/
je(j) 'Råstofudvinding' /
*    e_      'Råstofudvinding'
    0600a  " 4a Extration of oil"
    0600b  " 4b Extraction of gas (incl. coalimport)"
    08090  " 4c Extraction of gravel and stone and mining support service activities"
/
jnf(j) 'Fremstilling - fødevarer' /
*    nf_     'Fremstilling - fødevarer'
    10120  " 5 Manufacture of food products, beverages and tobacco"
/
jnz(j) 'Fremstilling - øvrig'  /
*    nz_     'Fremstilling - øvrig' 
    13150  " 6 Textiles and leather products"
    16000  " 7 Manufacture of wood and wood products"
    17000  " 8 Manufacture of paper and paper products"
    18000  " 9 Printing etc."
    20000  "11 Manufacture of chemicals"
    21000  "12 Pharmaceuticals"
    22000  "13 Manufacture of rubber and plastic products"
    23000  "14 Manufacture of other non-metallic mineral products"
    24000  "15 Manufacture of basic metals"
    25000  "16 Manufacture of fabricated metal products"
    26000  "17 Manufacture of electronic components"
    27000  "18 Electrical equipment"
    28000  "19 Manufacture of machinery"
    29000  "20 Manufacture of motor vehicles and related parts"
    30000  "21 Manufacture of ships and other transport equipment"
    31320  "22 Manufacture of furniture and other manufacturing"
    33000  "23 Repair and installation of machinery and equipment"
/
jb(j) 'Byggeri' /
*    b_      'Byggeri'
    41430  "27 Construction"
/
jo(j) 'Offentlige tjenester' /
*    o_      'Offentlige tjenester'
    72002  "51 Scientific research and development (non-market)"
    84101  "59 Rescue service etc. (market)"
    84202  "58 Public administration etc."
    85202  "60 Education (non-market)"
    86000  "62 Human health activities"
    87880  "63 Residential care"
    90920  "64 Arts and entertainment; libraries, museums and other cultural activities; gambling"
/
jqs(j) 'Tjenester    - søfart' /
*    qs_     'Tjenester    - søfart'
    50000  "32 Water transport"
/
jqf(j) 'Tjenester    - finansielle' /
*    qf_     'Tjenester    - finansielle'
    64000  "41 Financial service activities, except insurance and pension funding"
    65000  "42 Insurance and pension funding"
    66000  "43 Other financial activities"
/
jqzi(j) 'Tjenester    - øvrige    - ikke-konkurrenceudsat' /
*    qzi_   'Service, ikke-konkurrerende' 
    37390  "26 Sewerage; waste collection, treatment and disposal activities etc."
    45000  "28 Wholesale and retail trade and repair of motor vehicles and motorcycles"
    47000  "30 Retail sale"
    49000  "31 Land transport and transport via pipelines"
    52000  "34 Support activities for transportation"
    55560  "36 Accommodation and food service activities"
    59600  "38 Motion picture and television programme prod., sound recording; radio and televisi"
    68100  "44 Buying and selling of real estate"
    68300  "45 Renting of non-residential buildings"
    69700  "48 Legal and accounting activities; activities of head offices; management consultanc"
    71000  "49 Architectural and engineering activities"
    72001  "50 Scientific research and development (market)"
    73000  "52 Advertising and market research"
    74750  "53 Other professional, scientific and technical activities; veterinary activities"
    77000  "54 Rental and leasing activities"
    78000  "55 Employment activities"
    85101  "61 Education (market)"
    93000  "65 Sports activities and amusement and recreation activities"
    94000  "66 Activities of membership organisations"
    95000  "67 Repair of personal goods"
    96000  "68 Other personal service activities"
    97000  "69 Activities of households as employers of domestic personnel"
/
jqzk(j) 'Tjenester    - øvrige    - konkurrenceudsat' /
*    qzk_   'Service, konkurrerende'
    46000  "29 Wholesale"
    51000  "33 Air transport"
    53000  "35 Postal and courier activities"
    58000  "37 Publishing activities"
    61000  "39 Telecommunications"
    62630  "40 IT and information service activities"
    79000  "56 Travel agent activities"
    80820  "57 Security and investigation; services to buildings and landscape; other businness s"
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
  h     . (68203,68204)
*  ng    . (19000)
*  ne    . (35001,35002,35003,36000)
*  a     . a_
  a     . (01000,02000,03000)
*  e     . e_
  e     . (0600a,0600b,08090)
*  nf    . nf_
  nf    . (10120)
*  nz    . nz_
  nz    . (13150,16000,17000,18000,20000,21000,22000,23000,
           24000,25000,26000,27000,28000,29000,30000,31320,33000)
*  b     . b_
  b     . (41430)
*  o     . o_  
  o     . (72002,84101,84202,85202,86000,87880,90920)  
*  qs    . qs_
  qs    . (50000)
*  qf    . qf_
  qf    . (64000,65000,66000)
*  qzi . qzi_
  qzi   . (37390,45000,47000,49000,52000,55560,59600,68100,
           68300,69700,71000,72001,73000,74750,77000,78000,
           85101,93000,94000,95000,96000,97000)
*  qzk . qzk_
  qzk   . (46000,51000,53000,58000,61000,62630,79000,80820)
/;

set mapdm2i(i,dm) "Mapping af disaggregeret ikke-energi materialer til brancher" /
*h_   . h_
    68203 . 68203
    68204 . 68204
*    19000 . 19000
*    35001 . 35001 
*    35002 . 35002 
*    35003 . 35003 
*    36000 . 36000
*a_   . a_
    01000 . 01000
    02000 . 02000
    03000 . 03000
*e_   . e_
    0600a . 0600a
    0600b . 0600b
    08090 . 08090
*nf_  . nf_
    10120 . 10120
*nz_  . nz_
    13150 . 13150
    16000 . 16000
    17000 . 17000  
    18000 . 18000
    20000 . 20000
    21000 . 21000
    22000 . 22000
    23000 . 23000
    24000 . 24000
    25000 . 25000
    26000 . 26000
    27000 . 27000 
    28000 . 28000 
    29000 . 29000 
    30000 . 30000 
    31320 . 31320 
    33000 . 33000 
*b_   . b_
    41430 . 41430
*o_   . o_
    72002 . 72002
    84101 . 84101
    84202 . 84202
    85202 . 85202
    86000 . 86000
    87880 . 87880
    90920 . 90920
*qs_  . qs_
    50000 . 50000
*qf_  . qf_
    64000 . 64000
    65000 . 65000
    66000 . 66000
*qzi_ . qzi_
    37390 . 37390
    45000 . 45000
    47000 . 47000
    49000 . 49000
    52000 . 52000
    55560 . 55560
    59600 . 59600
    68100 . 68100
    68300 . 68300
    69700 . 69700
    71000 . 71000
    72001 . 72001
    73000 . 73000
    74750 . 74750
    77000 . 77000
    78000 . 78000
    85101 . 85101
    93000 . 93000
    94000 . 94000
    95000 . 95000
    96000 . 96000
    97000 . 97000
*qzk_ . qzk_
    46000 . 46000
    51000 . 51000
    53000 . 53000
    58000 . 58000
    61000 . 61000
    62630 . 62630
    79000 . 79000
    80820 . 80820
/;

set mapdme2dmeo(dmeo,dme)   "Mapping til øvre forbrugsaggregater fra lavere forbrugskomponenter" /
  me  . (ne,ng)
*  ne  . ne_
  ne    . (35001,35002,35003,36000)
*  ng    . ng_
  ng    . (19000)
/;

*Maskininvesterings-mappings
set mapdim2dimo(dimo,dim)   "Mapping til øvre maskininvesteringsaggregater fra laverekomponenter" /
  im    . (h,qzk,qzi,a,e,b,ne,ng,nf,nz,qf,qs,o)
*  h   . h_
  h     . (68203,68204)
*  ng    . ng_
  ng    . (19000)
*  ne  . ne_
  ne    . (35001,35002,35003,36000)
*  a     . a_
  a     . (01000,02000,03000)
*  e     . e_
  e     . (0600a,0600b,08090)
*  nf    . nf_
  nf    . (10120)
*  nz    . nz_
  nz    . (13150,16000,17000,18000,20000,21000,22000,23000,
           24000,25000,26000,27000,28000,29000,30000,31320,33000)
*  b     . b_
  b     . (41430)
*  o     . o_  
  o     . (72002,84101,84202,85202,86000,87880,90920)  
*  qs    . qs_
  qs    . (50000)
*  qf    . qf_
  qf    . (64000,65000,66000)
*  qzi . qzi_
  qzi   . (37390,45000,47000,49000,52000,55560,59600,68100,
           68300,69700,71000,72001,73000,74750,77000,78000,
           85101,93000,94000,95000,96000,97000)
*  qzk . qzk_
  qzk   . (46000,51000,53000,58000,61000,62630,79000,80820)
/;

set mapdim2i(i,dim) "Mapping af disaggregeret maskininvesteringer til brancher" /
*h_   . h_
    68203 . 68203
    68204 . 68204
*ng_  . ng_
    19000 . 19000
*ne_  . ne_
    35001 . 35001 
    35002 . 35002 
    35003 . 35003 
    36000 . 36000
*a_   . a_
    01000 . 01000
    02000 . 02000
    03000 . 03000
*e_   . e_
    0600a . 0600a
    0600b . 0600b
    08090 . 08090
*nf_  . nf_
    10120 . 10120
*nz_  . nz_
    13150 . 13150
    16000 . 16000
    17000 . 17000  
    18000 . 18000
    20000 . 20000
    21000 . 21000
    22000 . 22000
    23000 . 23000
    24000 . 24000
    25000 . 25000
    26000 . 26000
    27000 . 27000 
    28000 . 28000 
    29000 . 29000 
    30000 . 30000 
    31320 . 31320 
    33000 . 33000 
*b_   . b_
    41430 . 41430
*o_   . o_
    72002 . 72002
    84101 . 84101
    84202 . 84202
    85202 . 85202
    86000 . 86000
    87880 . 87880
    90920 . 90920
*qs_  . qs_
    50000 . 50000
*qf_  . qf_
    64000 . 64000
    65000 . 65000
    66000 . 66000
*qzi_ . qzi_
    37390 . 37390
    45000 . 45000
    47000 . 47000
    49000 . 49000
    52000 . 52000
    55560 . 55560
    59600 . 59600
    68100 . 68100
    68300 . 68300
    69700 . 69700
    71000 . 71000
    72001 . 72001
    73000 . 73000
    74750 . 74750
    77000 . 77000
    78000 . 78000
    85101 . 85101
    93000 . 93000
    94000 . 94000
    95000 . 95000
    96000 . 96000
    97000 . 97000
*qzk_ . qzk_
    46000 . 46000
    51000 . 51000
    53000 . 53000
    58000 . 58000
    61000 . 61000
    62630 . 62630
    79000 . 79000
    80820 . 80820
/;

*Bygningsinvesterings-mappings
set mapdib2dibo(dibo,dib)   "Mapping til øvre bygningsinvesteringsaggregater fra laverekomponenter" /
  ib    . (h,qzk,qzi,a,e,b,ne,ng,nf,nz,qf,qs,o)
*  h   . h_
  h     . (68203,68204)
*  ng    . ng_
  ng    . (19000)
*  ne  . ne_
  ne    . (35001,35002,35003,36000)
*  a     . a_
  a     . (01000,02000,03000)
*  e     . e_
  e     . (0600a,0600b,08090)
*  nf    . nf_
  nf    . (10120)
*  nz    . nz_
  nz    . (13150,16000,17000,18000,20000,21000,22000,23000,
           24000,25000,26000,27000,28000,29000,30000,31320,33000)
*  b     . b_
  b     . (41430)
*  o     . o_  
  o     . (72002,84101,84202,85202,86000,87880,90920)  
*  qs    . qs_
  qs    . (50000)
*  qf    . qf_
  qf    . (64000,65000,66000)
*  qzi . qzi_
  qzi   . (37390,45000,47000,49000,52000,55560,59600,68100,
           68300,69700,71000,72001,73000,74750,77000,78000,
           85101,93000,94000,95000,96000,97000)
*  qzk . qzk_
  qzk   . (46000,51000,53000,58000,61000,62630,79000,80820)
/;

set mapdib2i(i,dib) "Mapping af disaggregeret bygningsinvesteringer til brancher" /
*h_   . h_
    68203 . 68203
    68204 . 68204
*ng_  . ng_
    19000 . 19000
*ne_  . ne_
    35001 . 35001 
    35002 . 35002 
    35003 . 35003 
    36000 . 36000
*a_   . a_
    01000 . 01000
    02000 . 02000
    03000 . 03000
*e_   . e_
    0600a . 0600a
    0600b . 0600b
    08090 . 08090
*nf_  . nf_
    10120 . 10120
*nz_  . nz_
    13150 . 13150
    16000 . 16000
    17000 . 17000  
    18000 . 18000
    20000 . 20000
    21000 . 21000
    22000 . 22000
    23000 . 23000
    24000 . 24000
    25000 . 25000
    26000 . 26000
    27000 . 27000 
    28000 . 28000 
    29000 . 29000 
    30000 . 30000 
    31320 . 31320 
    33000 . 33000 
*b_   . b_
    41430 . 41430
*o_   . o_
    72002 . 72002
    84101 . 84101
    84202 . 84202
    85202 . 85202
    86000 . 86000
    87880 . 87880
    90920 . 90920
*qs_  . qs_
    50000 . 50000
*qf_  . qf_
    64000 . 64000
    65000 . 65000
    66000 . 66000
*qzi_ . qzi_
    37390 . 37390
    45000 . 45000
    47000 . 47000
    49000 . 49000
    52000 . 52000
    55560 . 55560
    59600 . 59600
    68100 . 68100
    68300 . 68300
    69700 . 69700
    71000 . 71000
    72001 . 72001
    73000 . 73000
    74750 . 74750
    77000 . 77000
    78000 . 78000
    85101 . 85101
    93000 . 93000
    94000 . 94000
    95000 . 95000
    96000 . 96000
    97000 . 97000
*qzk_ . qzk_
    46000 . 46000
    51000 . 51000
    53000 . 53000
    58000 . 58000
    61000 . 61000
    62630 . 62630
    79000 . 79000
    80820 . 80820
/;

set mapdme2i(i,dme) "Mapping af disaggregeret forbrug til brancher" /
*ne_  . ne_
    35001 . 35001 
    35002 . 35002 
    35003 . 35003 
    36000 . 36000
*ng_  . ng_
    19000 . 19000
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
*  h   . h_
  h     . (68203,68204)
*  ng    . ng_
  ng    . (19000)
*  ne  . ne_
  ne    . (35001,35002,35003,36000)
*  a     . a_
  a     . (01000,02000,03000)
*  e     . e_
  e     . (0600a,0600b,08090)
*  nf    . nf_
  nf    . (10120)
*  nz    . nz_
  nz    . (13150,16000,17000,18000,20000,21000,22000,23000,
           24000,25000,26000,27000,28000,29000,30000,31320,33000)
*  b     . b_
  b     . (41430)
*  o     . o_  
  o     . (72002,84101,84202,85202,86000,87880,90920)  
*  qs    . qs_
  qs    . (50000)
*  qf    . qf_
  qf    . (64000,65000,66000)
*  qzi . qzi_
  qzi   . (37390,45000,47000,49000,52000,55560,59600,68100,
           68300,69700,71000,72001,73000,74750,77000,78000,
           85101,93000,94000,95000,96000,97000)
*  qzk . qzk_
  qzk   . (46000,51000,53000,58000,61000,62630,79000,80820)
/;

set mapdc2i(i,dc) "Mapping af disaggregeret forbrug til brancher" /
*h_   . h_
    68203 . 68203
    68204 . 68204
*ng_  . ng_
    19000 . 19000
*ne_  . ne_
    35001 . 35001 
    35002 . 35002 
    35003 . 35003 
    36000 . 36000
*a_   . a_
    01000 . 01000
    02000 . 02000
    03000 . 03000
*e_   . e_
    0600a . 0600a
    0600b . 0600b
    08090 . 08090
*nf_  . nf_
    10120 . 10120
*nz_  . nz_
    13150 . 13150
    16000 . 16000
    17000 . 17000  
    18000 . 18000
    20000 . 20000
    21000 . 21000
    22000 . 22000
    23000 . 23000
    24000 . 24000
    25000 . 25000
    26000 . 26000
    27000 . 27000 
    28000 . 28000 
    29000 . 29000 
    30000 . 30000 
    31320 . 31320 
    33000 . 33000 
*b_   . b_
    41430 . 41430
*o_   . o_
    72002 . 72002
    84101 . 84101
    84202 . 84202
    85202 . 85202
    86000 . 86000
    87880 . 87880
    90920 . 90920
*qs_  . qs_
    50000 . 50000
*qf_  . qf_
    64000 . 64000
    65000 . 65000
    66000 . 66000
*qzi_ . qzi_
    37390 . 37390
    45000 . 45000
    47000 . 47000
    49000 . 49000
    52000 . 52000
    55560 . 55560
    59600 . 59600
    68100 . 68100
    68300 . 68300
    69700 . 69700
    71000 . 71000
    72001 . 72001
    73000 . 73000
    74750 . 74750
    77000 . 77000
    78000 . 78000
    85101 . 85101
    93000 . 93000
    94000 . 94000
    95000 . 95000
    96000 . 96000
    97000 . 97000
*qzk_ . qzk_
    46000 . 46000
    51000 . 51000
    53000 . 53000
    58000 . 58000
    61000 . 61000
    62630 . 62630
    79000 . 79000
    80820 . 80820
/;

*Mapping mellem 13 og 73 brancher
set mapj2dj(dj,j)   "Mapping fra 73 til 13 brancher" /
*  h   . h_
  h     . (68203,68204)
*  ng    . ng_
  ng    . (19000)
*  ne  . ne_
  ne    . (35001,35002,35003,36000)
*  a     . a_
  a     . (01000,02000,03000)
*  e     . e_
  e     . (0600a,0600b,08090)
*  nf    . nf_
  nf    . (10120)
*  nz    . nz_
  nz    . (13150,16000,17000,18000,20000,21000,22000,23000,
           24000,25000,26000,27000,28000,29000,30000,31320,33000)
*  b     . b_
  b     . (41430)
*  o     . o_  
  o     . (72002,84101,84202,85202,86000,87880,90920)  
*  qs    . qs_
  qs    . (50000)
*  qf    . qf_
  qf    . (64000,65000,66000)
*  qzi . qzi_
  qzi   . (37390,45000,47000,49000,52000,55560,59600,68100,
           68300,69700,71000,72001,73000,74750,77000,78000,
           85101,93000,94000,95000,96000,97000)
*  qzk . qzk_
  qzk   . (46000,51000,53000,58000,61000,62630,79000,80820)
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
