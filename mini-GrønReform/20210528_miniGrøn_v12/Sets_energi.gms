sets

kilder48 /col01,col02,col03,col04,col05,col06,col07,col08,col09,col10,col11,col12,col13,col14,col15,col16,col17,col18,col19,col20,col21,col22,col23,col24,col25,col26,col27,col28,col29,col30,col31,col32,col33,col34,col35,col36,col37,col38,col39,col40,col41,col42
*col43,col44 //43 og 44 springes over i selve excelarket fra DST... mystisk.
col45,col46,col47,col48/

kilder /
BogD
*FlyB
*SkibB
El
*VE
FjVarm
VEVarm
*RaaOlie
Olie
BioOlie
RafGas
NordGas
NatGas
Biogas
Kul
Affald
Halm
Tpiller
Tbra
/

kilderHT(kilder) /
Halm
Tpiller
Tbra
/

kilderF(kilder) /
BogD
*FlyB
*SkibB
*RaaOlie
Olie
RafGas
NordGas
NatGas
Kul
/

kilderNotF(kilder) /
El
*VE
FjVarm
VEVarm
BioOlie
Biogas
Affald
Halm
Tpiller
Tbra
/

kilderFX(kilderF) /
*Olie
NatGas
*NGas
*Kul
*BogD
/

kilderFo(kilderF) /
*BogD
*FlyB
*SkibB
*RaaOlie
Olie
RafGas
NordGas
NatGas
Kul
/

CO2e_udled /
set.j
HH
Tot
/

CO2e_udledxTot(CO2e_udled) /
set.j
HH
/

CO2e_type /
BogD
*FlyB
*SkibB
*RaaOlie
Olie
RafGas
NordGas
NatGas
Kul
CO2rest
CO2
CO2e_Lattergas
CO2e_methan
CO2e_Flour
LULUCF
Tot
/

CO2e_typeE(CO2e_type) /
BogD
*FlyB
*SkibB
*RaaOlie
Olie
RafGas
NordGas
NatGas
Kul
/

CO2e_typexE(CO2e_type) /
CO2rest
CO2e_Lattergas
CO2e_methan
CO2e_Flour
LULUCF
/

CO2e_typeTotLU(CO2e_type) /
Tot
LULUCF
/

CO2e_typeLU(CO2e_type) /
LULUCF
/

CO2e_udled_j(CO2e_udled) /
set.j
/

mapkilder_2_CO2e_typeE(kilder,CO2e_typeE) /
BogD.BogD
*FlyB.FlyB
*SkibB.SkibB
*RaaOlie.RaaOlie
Olie.Olie
RafGas.RafGas
NordGas.NordGas
NatGas.NatGas
Kul.Kul
/


anvendelse /
set.j
HH
Tab
Eksport
/

mapanv_2_j(anvendelse,j) /
    01000a.01000a
    01000b.01000b  "Kvæg"
    01000c.01000c  "Svin"
    01000d.01000d  "Fjerkræ, pelsdyr mv."
    020000.020000  "Skovbrug"
    030000.030000  "Fiskeri"
*    e_      'Råstofudvinding'
    060000a.060000a  "Olieudvinding"
    060000b.060000b  "Gasudvinding"
    080090.080090  "Service til råstofudvinding (inkl. kulimport)"
*    nf_     'Fremstilling - fødevarer'
    100010a.100010a  "Slagterier (kvæg)"
    100010b.100010b  "Slagterier (svin)"
    100010c.100010c  "Slagterier (fjerkræ mv.)"
    100020.100020  "Fiskeindustri"
    100030.100030  "Mejerier"
    100040.100040  "Bagerier, brødfabrikker mv."
    100050.100050  "Anden fødevareindustri"
    11200.11200  "Drikke- og tobaksvareindustri"
*    nz_     'Fremstilling - øvrig' 
    Industri.Industri  "Anden industri"
    160000.160000  "Træindustri"
    200010.200010  "Fremst. af basiskemikalier"
    200020.200020  "Fremst. af maling og sæbe mv."
    210000.210000  "Medicinalindustri"
    220000.220000  "Plast- og gummiindustri"
    230010.230010  "Glasindustri og keramisk industri"
    230020.230020  "Betonindustri og teglværker"
    240000.240000  "Fremst. af metal"
    250000.250000  "Metalvareindustri"
    280010.280010  "Fremst. af motorer, vindmøller og pumper"
    280020.280020  "Fremst. af andre maskiner"
*    ng_     'Fremstilling - olieraffinering'
    190000a.190000a  "Olieraffinaderier mv."
    190000b.190000b  "Olieraffinaderier mv. (bioolie)"
*    ne_     "Energi (El-, gas- og fjernvarmeforsyning)"
    350010a.350010a  "Kraftvarmeværker"
    350010b.350010b  "Vind-, vand- og solkraft"
    350020a.350020a  "Naturgasforsyning"
    350020b.350020b  "Biogasforsyning"
    350030a.350030a  "Fjernvarmeværker"
    350030b.350030b  "Solvarme og geotermi"
    383900.383900  "Renovation, genbrug og forureningsbekæmpelse"
*    qzi_   'Service, ikke-konkurrerende' 
    36700.36700  "Vandforsyning, kloak- og rensningsanlæg"
    45000.45000  "Bilhandel og -værksteder mv."
    470000.470000  "Detailhandel"
    490012.490012  "Tog, bus, taxi mv."
    490030a.490030a  "National vejgodstransport"
    50000a.50000a  "National skibsfart"
    51000a.51000a  "National luftfart"
    52000.52000  "Hjælpevirksomhed til transport"
    550000.550000  "Hoteller mv."
    560000.560000  "Restauranter"
*    b_      'Byggeri'
    410009.410009  "Nybyggeri"
    420000.420000  "Anlægsvirksomhed"
    43000.43000  "Reparation og vedligeholdelse"
*    qzk_   'Service, konkurrerende'
    460000.460000  "Engroshandel"
    490030b.490030b  "International vejgodstransport"
    51000b.51000b  "International luftfart"
    53000.53000  "Post og kurertjeneste"
    79000.79000  "Rejsebureauer"
*    qs_     'Tjenester    - søfart'
    50000b.50000b  "International skibsfart"
*    qf_     'Tjenester    - finansielle'
    Tjenester.Tjenester  "Andre tjenester"
*    h_     'Boligbrancen'
    Boliger.Boliger  "Boliger"
*    o_      'Offentlige tjenester'
    Offentlig.Offentlig  "Offentlige tjenester"
  /

mapj_2_CO2e_udled(j,CO2e_udled) /
    01000a.01000a
    01000b.01000b  "Kvæg"
    01000c.01000c  "Svin"
    01000d.01000d  "Fjerkræ, pelsdyr mv."
    020000.020000  "Skovbrug"
    030000.030000  "Fiskeri"
*    e_      'Råstofudvinding'
    060000a.060000a  "Olieudvinding"
    060000b.060000b  "Gasudvinding"
    080090.080090  "Service til råstofudvinding (inkl. kulimport)"
*    nf_     'Fremstilling - fødevarer'
    100010a.100010a  "Slagterier (kvæg)"
    100010b.100010b  "Slagterier (svin)"
    100010c.100010c  "Slagterier (fjerkræ mv.)"
    100020.100020  "Fiskeindustri"
    100030.100030  "Mejerier"
    100040.100040  "Bagerier, brødfabrikker mv."
    100050.100050  "Anden fødevareindustri"
    11200.11200  "Drikke- og tobaksvareindustri"
*    nz_     'Fremstilling - øvrig' 
    Industri.Industri  "Anden industri"
    160000.160000  "Træindustri"
    200010.200010  "Fremst. af basiskemikalier"
    200020.200020  "Fremst. af maling og sæbe mv."
    210000.210000  "Medicinalindustri"
    220000.220000  "Plast- og gummiindustri"
    230010.230010  "Glasindustri og keramisk industri"
    230020.230020  "Betonindustri og teglværker"
    240000.240000  "Fremst. af metal"
    250000.250000  "Metalvareindustri"
    280010.280010  "Fremst. af motorer, vindmøller og pumper"
    280020.280020  "Fremst. af andre maskiner"
*    ng_     'Fremstilling - olieraffinering'
    190000a.190000a  "Olieraffinaderier mv."
    190000b.190000b  "Olieraffinaderier mv. (bioolie)"
*    ne_     "Energi (El-, gas- og fjernvarmeforsyning)"
    350010a.350010a  "Kraftvarmeværker"
    350010b.350010b  "Vind-, vand- og solkraft"
    350020a.350020a  "Naturgasforsyning"
    350020b.350020b  "Biogasforsyning"
    350030a.350030a  "Fjernvarmeværker"
    350030b.350030b  "Solvarme og geotermi"
    383900.383900  "Renovation, genbrug og forureningsbekæmpelse"
*    qzi_   'Service, ikke-konkurrerende' 
    36700.36700  "Vandforsyning, kloak- og rensningsanlæg"
    45000.45000  "Bilhandel og -værksteder mv."
    470000.470000  "Detailhandel"
    490012.490012  "Tog, bus, taxi mv."
    490030a.490030a  "National vejgodstransport"
    50000a.50000a  "National skibsfart"
    51000a.51000a  "National luftfart"
    52000.52000  "Hjælpevirksomhed til transport"
    550000.550000  "Hoteller mv."
    560000.560000  "Restauranter"
*    b_      'Byggeri'
    410009.410009  "Nybyggeri"
    420000.420000  "Anlægsvirksomhed"
    43000.43000  "Reparation og vedligeholdelse"
*    qzk_   'Service, konkurrerende'
    460000.460000  "Engroshandel"
    490030b.490030b  "International vejgodstransport"
    51000b.51000b  "International luftfart"
    53000.53000  "Post og kurertjeneste"
    79000.79000  "Rejsebureauer"
*    qs_     'Tjenester    - søfart'
    50000b.50000b  "International skibsfart"
*    qf_     'Tjenester    - finansielle'
    Tjenester.Tjenester  "Andre tjenester"
*    h_     'Boligbrancen'
    Boliger.Boliger  "Boliger"
*    o_      'Offentlige tjenester'
    Offentlig.Offentlig  "Offentlige tjenester"
  /  
  
mapanv_2_udled(anvendelse,CO2e_udled) /  
    01000a.01000a
    01000b.01000b  "Kvæg"
    01000c.01000c  "Svin"
    01000d.01000d  "Fjerkræ, pelsdyr mv."
    020000.020000  "Skovbrug"
    030000.030000  "Fiskeri"
*    e_      'Råstofudvinding'
    060000a.060000a  "Olieudvinding"
    060000b.060000b  "Gasudvinding"
    080090.080090  "Service til råstofudvinding (inkl. kulimport)"
*    nf_     'Fremstilling - fødevarer'
    100010a.100010a  "Slagterier (kvæg)"
    100010b.100010b  "Slagterier (svin)"
    100010c.100010c  "Slagterier (fjerkræ mv.)"
    100020.100020  "Fiskeindustri"
    100030.100030  "Mejerier"
    100040.100040  "Bagerier, brødfabrikker mv."
    100050.100050  "Anden fødevareindustri"
    11200.11200  "Drikke- og tobaksvareindustri"
*    nz_     'Fremstilling - øvrig' 
    Industri.Industri  "Anden industri"
    160000.160000  "Træindustri"
    200010.200010  "Fremst. af basiskemikalier"
    200020.200020  "Fremst. af maling og sæbe mv."
    210000.210000  "Medicinalindustri"
    220000.220000  "Plast- og gummiindustri"
    230010.230010  "Glasindustri og keramisk industri"
    230020.230020  "Betonindustri og teglværker"
    240000.240000  "Fremst. af metal"
    250000.250000  "Metalvareindustri"
    280010.280010  "Fremst. af motorer, vindmøller og pumper"
    280020.280020  "Fremst. af andre maskiner"
*    ng_     'Fremstilling - olieraffinering'
    190000a.190000a  "Olieraffinaderier mv."
    190000b.190000b  "Olieraffinaderier mv. (bioolie)"
*    ne_     "Energi (El-, gas- og fjernvarmeforsyning)"
    350010a.350010a  "Kraftvarmeværker"
    350010b.350010b  "Vind-, vand- og solkraft"
    350020a.350020a  "Naturgasforsyning"
    350020b.350020b  "Biogasforsyning"
    350030a.350030a  "Fjernvarmeværker"
    350030b.350030b  "Solvarme og geotermi"
    383900.383900  "Renovation, genbrug og forureningsbekæmpelse"
*    qzi_   'Service, ikke-konkurrerende' 
    36700.36700  "Vandforsyning, kloak- og rensningsanlæg"
    45000.45000  "Bilhandel og -værksteder mv."
    470000.470000  "Detailhandel"
    490012.490012  "Tog, bus, taxi mv."
    490030a.490030a  "National vejgodstransport"
    50000a.50000a  "National skibsfart"
    51000a.51000a  "National luftfart"
    52000.52000  "Hjælpevirksomhed til transport"
    550000.550000  "Hoteller mv."
    560000.560000  "Restauranter"
*    b_      'Byggeri'
    410009.410009  "Nybyggeri"
    420000.420000  "Anlægsvirksomhed"
    43000.43000  "Reparation og vedligeholdelse"
*    qzk_   'Service, konkurrerende'
    460000.460000  "Engroshandel"
    490030b.490030b  "International vejgodstransport"
    51000b.51000b  "International luftfart"
    53000.53000  "Post og kurertjeneste"
    79000.79000  "Rejsebureauer"
*    qs_     'Tjenester    - søfart'
    50000b.50000b  "International skibsfart"
*    qf_     'Tjenester    - finansielle'
    Tjenester.Tjenester  "Andre tjenester"
*    h_     'Boligbrancen'
    Boliger.Boliger  "Boliger"
*    o_      'Offentlige tjenester'
    Offentlig.Offentlig  "Offentlige tjenester"
    HH.HH
  /
  
$ontext  
udled_type /
co2
co2xBio
co2Bio
so2
nox
co
NH3
N2O
CH4
NMVOC
PM10
PM2halv
SF6
PFC
HFC
/  
$offtext
udled_type /
co2
so2
nox
co
NH3
N2O
CH4
NMVOC
PM10
PM2_5
TSP
BC
SF6
PFC
HFC
/

drivhus(udled_type) /
co2
N2O
CH4
SF6
PFC
HFC
/

udled_type2 /
co2xBio
N2O
CH4
/

MROinfo /
DKshipWorld
DKflyWorld
DKtransWorld
DKotherWorld
LULUCF
EmiDK
/

hh_c /
04510
04520
04530
04545
07220a
07220b
/
;

alias(kilder,kilder_a);

$ontext
anvendelse120 /
Ialt
Husholdninger
Brancherialt
set.brancher117
/






map48_2_kilder(kilder48,kilder) /
(col07,col08,col09,col10,col11,col12,col13,col14,col15,col16,col17,col20).BogD
(col29,col30,col36,col37,col38,col39,col40).Bio
(col31,col32,col33,col46).El
(col04,col05).Gas
(col23,col24,col25).NGas
(col21,col26,col27,col28).Kul
(col02,col18,col19,col22).Olie
(col34,col35,col45,col47).Varme
/


map117_2_j(brancher117,j) /
010000.01000
020000.02000
030000.03000
060000.(0600a,0600b)
(080090
090000).08090
(100010
100020
100030
100040
100050
110000
120000).10120
(130000
140000
150000).13150
160000.16000
170000.17000
180000.18000
190000.19000
(200010
200020).20000
210000.21000
220000.22000
(230010
230020).23000
240000.24000
250000.25000
(260010
260020).26000
(270010
270020
270030).27000
(280010
280020).28000
290000.29000
300000.30000
(310000
320010
320020).31320
330000.33000
350010.35001
350020.35002
350030.35003
360000.36000
(370000
383900).37390
(410009
420000
430003
430004).41430
(450010
450020).45000
460000.46000
470000.47000
(490010
490020
490030).49000
500000.50000
510000.51000
520000.52000
530000.53000
(550000
560000).55560
(580010
580020).58000
(590000
600000).59600
610000.61000
(620000
630000).62630
(640010
640020).64000
650000.65000
660000.66000
680010.68100
680030.68300
680023.68203
680024.68204
(690010
690020
700000).69700
710000.71000
720001.72001
720002.72002
730000.73000
(740000
750000).74750
770000.77000
780000.78000
790000.79000
(800000
810000
820000).80820
(840010
840022).84202
840021.84101
(850010
850020
850030
850042).85202
850041.85101
(860010
860020).86000
(870000
880000).87880
(900000
910001
910002
920000).90920
(930011
930012
930020).93000
940000.94000
950000.95000
960000.96000
970000.97000
/


mapanv124_2_HH(anvendelse124) /
04510
04520
04530
04545
07220
/


mapanv124_2_117(anvendelse124,brancher117) /
010000.010000
020000.020000
030000.030000
060000.060000
080090.080090
090000.090000
100010.100010
100020.100020
100030.100030
100040.100040
100050.100050
110000.110000
120000.120000
130000.130000
140000.140000
150000.150000
160000.160000
170000.170000
180000.180000
190000.190000
200010.200010
200020.200020
210000.210000
220000.220000
230010.230010
230020.230020
240000.240000
250000.250000
260010.260010
260020.260020
270010.270010
270020.270020
270030.270030
280010.280010
280020.280020
290000.290000
300000.300000
310000.310000
320010.320010
320020.320020
330000.330000
350010.350010
350020.350020
350030.350030
360000.360000
370000.370000
383900.383900
410009.410009
420000.420000
430003.430003
430004.430004
450010.450010
450020.450020
460000.460000
470000.470000
490010.490010
490020.490020
490030.490030
500000.500000
510000.510000
520000.520000
530000.530000
550000.550000
560000.560000
580010.580010
580020.580020
590000.590000
600000.600000
610000.610000
620000.620000
630000.630000
640010.640010
640020.640020
650000.650000
660000.660000
680010.680010
680030.680030
680023.680023
680024.680024
690010.690010
690020.690020
700000.700000
710000.710000
720001.720001
720002.720002
730000.730000
740000.740000
750000.750000
770000.770000
780000.780000
790000.790000
800000.800000
810000.810000
820000.820000
840010.840010
840022.840022
840021.840021
850010.850010
850020.850020
850030.850030
850042.850042
850041.850041
860010.860010
860020.860020
870000.870000
880000.880000
900000.900000
910001.910001
910002.910002
920000.920000
930011.930011
930012.930012
930020.930020
940000.940000
950000.950000
960000.960000
970000.970000
/

mapanv120_2_117(anvendelse120,brancher117) /
010000.010000
020000.020000
030000.030000
060000.060000
080090.080090
090000.090000
100010.100010
100020.100020
100030.100030
100040.100040
100050.100050
110000.110000
120000.120000
130000.130000
140000.140000
150000.150000
160000.160000
170000.170000
180000.180000
190000.190000
200010.200010
200020.200020
210000.210000
220000.220000
230010.230010
230020.230020
240000.240000
250000.250000
260010.260010
260020.260020
270010.270010
270020.270020
270030.270030
280010.280010
280020.280020
290000.290000
300000.300000
310000.310000
320010.320010
320020.320020
330000.330000
350010.350010
350020.350020
350030.350030
360000.360000
370000.370000
383900.383900
410009.410009
420000.420000
430003.430003
430004.430004
450010.450010
450020.450020
460000.460000
470000.470000
490010.490010
490020.490020
490030.490030
500000.500000
510000.510000
520000.520000
530000.530000
550000.550000
560000.560000
580010.580010
580020.580020
590000.590000
600000.600000
610000.610000
620000.620000
630000.630000
640010.640010
640020.640020
650000.650000
660000.660000
680010.680010
680030.680030
680023.680023
680024.680024
690010.690010
690020.690020
700000.700000
710000.710000
720001.720001
720002.720002
730000.730000
740000.740000
750000.750000
770000.770000
780000.780000
790000.790000
800000.800000
810000.810000
820000.820000
840010.840010
840022.840022
840021.840021
850010.850010
850020.850020
850030.850030
850042.850042
850041.850041
860010.860010
860020.860020
870000.870000
880000.880000
900000.900000
910001.910001
910002.910002
920000.920000
930011.930011
930012.930012
930020.930020
940000.940000
950000.950000
960000.960000
970000.970000
/

mapj_2_CO2e_udled(j,CO2e_udled) /

    01000.01000  " 1 Agriculture and horticulture"
    02000.02000  " 2 Forestry"
    03000.03000  " 3 Fishing"
    0600a.0600a  " 4a Extration of oil"
    0600b.0600b  " 4b Extraction of gas (incl. coalimport)"
    08090.08090  " 4c Extraction of gravel and stone and mining support service activities"
    10120.10120  " 5 Manufacture of food products, beverages and tobacco"
    13150.13150  " 6 Textiles and leather products"
    16000.16000  " 7 Manufacture of wood and wood products"
    17000.17000  " 8 Manufacture of paper and paper products"
    18000.18000  " 9 Printing etc."
    20000.20000  "11 Manufacture of chemicals"
    21000.21000  "12 Pharmaceuticals"
    22000.22000  "13 Manufacture of rubber and plastic products"
    23000.23000  "14 Manufacture of other non-metallic mineral products"
    24000.24000  "15 Manufacture of basic metals"
    25000.25000  "16 Manufacture of fabricated metal products"
    26000.26000  "17 Manufacture of electronic components"
    27000.27000  "18 Electrical equipment"
    28000.28000  "19 Manufacture of machinery"
    29000.29000  "20 Manufacture of motor vehicles and related parts"
    30000.30000  "21 Manufacture of ships and other transport equipment"
    31320.31320  "22 Manufacture of furniture and other manufacturing"
    33000.33000  "23 Repair and installation of machinery and equipment"
    19000.19000  "10 Oil refinery etc."
    35001.35001  "24a Production and distribution of electricity"
    35002.35002  "24b Manufacture and distribution of gas"
    35003.35003  "24c Steam and hot water supply"
    36000.36000  "25 Water collection, purification and supply"
    37390.37390  "26 Sewerage; waste collection, treatment and disposal activities etc."
    45000.45000  "28 Wholesale and retail trade and repair of motor vehicles and motorcycles"
    47000.47000  "30 Retail sale"
    49000.49000  "31 Land transport and transport via pipelines"
    52000.52000  "34 Support activities for transportation"
    55560.55560  "36 Accommodation and food service activities"
    59600.59600  "38 Motion picture and television programme prod., sound recording; radio and televisi"
    68100.68100  "44 Buying and selling of real estate"
    68300.68300  "45 Renting of non-residential buildings"
    69700.69700  "48 Legal and accounting activities; activities of head offices; management consultanc"
    71000.71000  "49 Architectural and engineering activities"
    72001.72001  "50 Scientific research and development (market)"
    73000.73000  "52 Advertising and market research"
    74750.74750  "53 Other professional, scientific and technical activities; veterinary activities"
    77000.77000  "54 Rental and leasing activities"
    78000.78000  "55 Employment activities"
    85101.85101  "61 Education (market)"
    93000.93000  "65 Sports activities and amusement and recreation activities"
    94000.94000  "66 Activities of membership organisations"
    95000.95000  "67 Repair of personal goods"
    96000.96000  "68 Other personal service activities"
    97000.97000  "69 Activities of households as employers of domestic personnel"
    41430.41430  "27 Construction"
    46000.46000  "29 Wholesale"
    51000.51000  "33 Air transport"
    53000.53000  "35 Postal and courier activities"
    58000.58000  "37 Publishing activities"
    61000.61000  "39 Telecommunications"
    62630.62630  "40 IT and information service activities"
    79000.79000  "56 Travel agent activities"
    80820.80820  "57 Security and investigation; services to buildings and landscape; other businness s"
    50000.50000  "32 Water transport"
    64000.64000  "41 Financial service activities, except insurance and pension funding"
    65000.65000  "42 Insurance and pension funding"
    66000.66000  "43 Other financial activities"
    68203.68203  "46 Renting of residential buildings"
    68204.68204  "47 Owner-occupied dwellings"
    72002.72002  "51 Scientific research and development (non-market)"
    84101.84101  "59 Rescue service etc. (market)"
    84202.84202  "58 Public administration etc."
    85202.85202  "60 Education (non-market)"
    86000.86000  "62 Human health activities"
    87880.87880  "63 Residential care"
    90920.90920  "64 Arts and entertainment; libraries, museums and other cultural activities; gambling"
/



j_indu(j)   "industribrancherne under j" /
*    01000  " 1 Agriculture and horticulture"
*    02000  " 2 Forestry"
*    03000
*    08090  " 4c Extraction of gravel and stone and mining support service activities"
*    10120  " 5 Manufacture of food products, beverages and tobacco"
13150
16000
17000
18000
*19000
20000
21000
22000
23000
24000
25000
26000
27000
28000
29000
30000
31320
33000
/

;
$offtext