
set ns73  "Investing industries in national accounting definition" /
    01000a  "Vegetabilske produkter"
    01000b  "Kvæg"
    01000c  "Svin"
    01000d  "Fjerkræ, pelsdyr mv."
    020000  "Skovbrug"
    030000  "Fiskeri"
    060000a  "Olieudvinding"
    060000b  "Gasudvinding"
    080090  "Service til råstofudvinding (inkl. kulimport)"
    100010a  "Slagterier (kvæg)"
    100010b  "Slagterier (svin)"
    100010c  "Slagterier (fjerkræ mv.)"
    100020  "Fiskeindustri"
    100030  "Mejerier"
    100040  "Bagerier, brødfabrikker mv."
    100050  "Anden fødevareindustri"
    11200  "Drikke- og tobaksvareindustri"
    Industri  "Anden industri"
    160000  "Træindustri"
    190000a  "Olieraffinaderier mv."
    190000b  "Olieraffinaderier mv. (bioolie)"
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
    350010a  "Kraftvarmeværker"
    350010b  "Vind-, vand- og solkraft"
    350020a  "Naturgasforsyning"
    350020b  "Biogasforsyning"
    350030a  "Fjernvarmeværker"
    350030b  "Solvarme og geotermi"
    36700  "Vandforsyning, kloak- og rensningsanlæg"
    383900  "Renovation, genbrug og forureningsbekæmpelse"
    410009  "Nybyggeri"
    420000  "Anlægsvirksomhed"
    43000  "Reparation og vedligeholdelse"
    45000  "Bilhandel og -værksteder mv."
    460000  "Engroshandel"
    470000  "Detailhandel"
    490012  "Tog, bus, taxi mv."
    490030a  "National vejgodstransport"
    490030b  "International vejgodstransport"
    50000a  "National skibsfart"
    50000b  "International skibsfart"
    51000a  "National luftfart"
    51000b  "International luftfart"
    52000  "Hjælpevirksomhed til transport"
    53000  "Post og kurertjeneste"
    550000  "Hoteller mv."
    560000  "Restauranter"
    Tjenester  "Andre tjenester"
    Boliger  "Boliger"
    Offentlig  "Offentlige tjenester"
    79000  "Rejsebureauer"
/;

set npi5 "Primary inputs in national accounting definition" / 
  nTp    "Commodity taxes, net"
  nTv    "VAT"
  nTo    "Other production taxes net (empty at constant or previous year's prices)"
  nW     "Compensation of employees (empty at constant or previous year's prices)"
  nCap   "Gross operating surplus and mixed income"
/;

alias(ns73,ns73c);
alias(ns73,ns73r);
alias(jo,joa);

set mapns732j(j,ns73)   "Mapping commodities to producer" /
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
  
set mapb2h(jh,jb) /
*    h_ . b_
    Boliger . 410009
/;

set mapi2d(d,i)   "Mapping goods to producer" /
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