rm(list=ls())

library("readxl")
library("dplyr")
library("rlang")
library("tidyverse")

varegrupper = list(
  "Aar",
  "Forbrug i alt",
  "01",         #FØDEVARER OG IKKE-ALKOHOLISKE DRIKKEVARER
  "01111",      #Ris
  "01112",      #Mel og gryn
  "01113",      #Brød
  "01114",      #Andet bagværk
  "01115",      #Pizza og quiche
  "01116",      #Pastaprodukter og couscous
  "01117",      #Morgenmadsprodukter
  "01118",      #Andre kornprodukter
  "01121",      #Okse- og kalvekød
  "01122",      #Svinekød
  "01123",      #Lamme- og gedekød
  "01124",      #Fjerkræ
  "01125",      #Andet kød
  "01126",      #Indmad ol
  "01127",      #Kød, tørret, saltet eller røget
  "01128",      #Andre tilberedninger af kød
  "01131",      #Fisk, fersk
  "01132",      #Fisk, frossen
  "01133",      #Skaldyr, fersk
  "01134",      #Skaldyr, frossen
  "01135",      #Fisk og skaldyr, tørrede, røgede eller saltede
  "01136",      #Fisk og skaldyr, konservede og forarbejdede
  "01141",      #Mælk, frisk
  "01142",      #Mælk med lavt fedtindhold, frisk
  "01143",      #Mælk, konserveret
  "01144",      #Yoghurt
  "01145",      #Ost
  "01146",      #Andre mejeriprodukter
  "01147",      #Æg
  "01151",      #Smør
  "01152",      #Margarine og andre vegetabilske fedtstoffer
  "01153",      #Olivenolie
  "01154",      #Andre spiselige olier
  "01155",      #Andre spiselige animalske fedtstoffer
  "01161",      #Frugt, frisk
  "01162",      #Frugt, frossen
  "01163",      #Frugter og nødder, tørrede
  "01164",      #Frugter og frugtbaserede produkter, konservede
  "01171",      #Grøntsager ekskl kartofler, frisk
  "01172",      #Grøntsager, frosne
  "01173",      #Grøntsager, tørrede og forarbejdede
  "01174",      #Kartofler og kartoffelprodukter
  "01175",      #Chips mv
  "01176",      #Andre rod-og knoldgrøntsager
  "01181",      #Sukker ol
  "01182",      #Syltetøj, marmelade og honning
  "01183",      #Chokolade
  "01184",      #Slik og marcipan
  "01185",      #Konsumis
  "01186",      #Kunstige sukkererstatninger
  "01191",      #Sovs, smagspræparater
  "01192",      #Salt, krydderier og køkkenurter
  "01193",      #Babymad
  "01194",      #Færdigretter
  "01199",      #Andre fødevarer
  "01211",      #Kaffe
  "01212",      #Te
  "01213",      #Kakao og chokoladepulver
  "01221",      #Mineralvand eller kildevand
  "01222",      #Læskedrikke
  "01223",      #Frugt- og grøntsagssaft samt koncentrater til saft
  "02"   ,      #ALKOHOLISKE DRIKKEVARER OG TOBAK
  "02111",      #Spiritus og likør
  "02112",      #Alkoholiske læskedrikke
  "02121",      #Vin af druer
  "02122",      #Vin af andre frugter
  "02123",      #Hedvin
  "02124",      #Vinbaserede drikkevarer og alkoholfri vin
  "02131",      #Pilsnerøl, guldøl
  "02132",      #Andre alkoholholdige øl
  "02133",      #Øl med lavt alkoholindhold og alkoholfri øl
  "02134",      #Øl-baserede drikkevarer
  "02201",      #Cigaretter
  "02202",      #Cigarer ol
  "02203",      #Andre tobaksvarer
  "02300",      #Euforiserende stoffer
  "03",         #BEKLÆDNING OG FODTØJ
  "03110",      #Materialer til beklædning
  "03121",      #Beklædning til mænd
  "03122",      #Beklædning til kvinder
  "03123",      #Beklædning til småbørn (0-2 år) og børn (3-13 år)
  "03131",      #Andre artikler til beklædning
  "03132",      #Beklædningstilbehør
  "03141",      #Vask og rensning af tøj
  "03142",      #Reparation og leje af beklædning
  "03211",      #Fodtøj til mænd
  "03212",      #Fodtøj til kvinder
  "03213",      #Fodtøj til børn under 14 år
  "03220",      #Reparation af fodtøj
  "04",         #BOLIGBENYTTELSE, ELEKTRICITET OG OPVARMNING
  "04110",      #Faktisk husleje betalt af lejere
  "04121",      #Lejernes faktiske husleje for fritidsbolig
  "04210",      #Beregnet lejeværdi af egen bolig
  "04220",      #Andre beregnede lejeværdier
  "04310",      #Materialer til vedligeholdelse og reparation af bolig
  "04321",      #Tjenesteydelser, blikkenslagere
  "04322",      #Tjenesteydelser, elektrikere
  "04323",      #Vedligeholdelse af varmeanlæg
  "04324",      #Tjenesteydelser, malere
  "04325",      #Tjenesteydelser, tømrere og snedkere
  "04329",      #Andre tjenester til vedligeholdelse og reparation af bolig
  "04410",      #Vandforsyning
  "04420",      #Renovation
  "04430",      #Vandafledningsafgift mv
  "04442",      #Sikkerhedstjenester
  "04449",      #Andre tjenester i forbindelse med boliger
  "04510",      #Elektricitet
  "04521",      #Natur- og bygas
  "04522",      #Flydende kulbrinter
  "04530",      #Flydende brændsel
  "04541",      #Kul
  "04549",      #Andet fast brændsel
  "04550",      #Fjernvarme mv
  "05",         #MØBLER, HUSHOLDNINGSUDSTYR OG HUSHOLDNINGSTJENESTER
  "05111",      #Boligmøbler
  "05112",      #Havemøbler
  "05113",      #Belysningsudstyr
  "05119",      #Andre møbler og  andet boligudstyr
  "05121",      #Gulvtæpper
  "05122",      #Anden gulvbelægning
  "05123",      #Montering af faste tæpper og gulvbelægning
  "05130",      #Reparation af møbler, boligudstyr og gulvbelægninger
  "05201",      #Møbelstof og gardiner
  "05202",      #Sengelinned
  "05203",      #Duge og håndklæder
  "05204",      #Reparation af boligtekstiler
  "05209",      #Andre boligtekstiler
  "05311",      #Køleskabe, frysere og køle-fryseskabe
  "05312",      #Vaskemaskiner, tørretumlere og opvaskemaskiner
  "05313",      #Komfurer
  "05314",      #Varmeapparater, klimaanlæg
  "05315",      #Rengøringsudstyr
  "05319",      #Andre større husholdningsapparater
  "05321",      #Foodprocessorer
  "05322",      #Kaffemaskiner, elkedler ol
  "05323",      #Strygejern
  "05324",      #Toaster, brødrister ol
  "05329",      #Andre mindre elektriske husholdningsapparater
  "05330",      #Reparation og leje af husholdningsmaskiner
  "05401",      #Glas, keramik og porcelæn
  "05402",      #Spisebestik, fade og sølvtøj
  "05403",      #Ikke-elektriske køkkenredskaber og artikler
  "05511",      #Motoriserede større redskaber og udstyr
  "05512",      #Reparation og leje af udstyr og større redskaber
  "05521",      #Ikke-motoriserede mindre redskaber
  "05522",      #Diverse tilbehør til mindre redskaber
  "05523",      #Reparation af ikke-motoriserede mindre redskaber, tilbehør
  "05611",      #Rengørings- og vedligeholdelsesprodukter
  "05612",      #Andre ikke-varige mindre husholdningsartikler
  "05621",      #Hjælp til hjem og have
  "05623",      #Leje af møbler og boligudstyr
  "05629",      #Rengøring og vinduespudsning
  "06",         #SUNDHED
  "06110",      #Farmaceutiske produkter
  "06121",      #Graviditetstest, kondomer mv
  "06129",      #Andre medicinske produkter ol
  "06131",      #Briller med korrigerende glas og kontaktlinser
  "06132",      #Høreapparater
  "06133",      #Reparation af terapeutiske apparater og udstyr
  "06139",      #Andre terapeutiske apparater
  "06211",      #Behandling hos praktiserende læge
  "06212",      #Behandling hos speciallæge
  "06220",      #Tandbehandling
  "06231",      #Tjenesteydelser, laboratorier og røntgenklinikker
  "06239",      #Andre paramedicinske tjenesteydelser
  "06300",      #Hospitalstjenester
  "07",         #TRANSPORT
  "07111",      #Nye biler
  "07112",      #Brugte biler
  "07120",      #Motorcykler
  "07130",      #Cykler
  "07211",      #Dæk
  "07212",      #Reservedele til personlige transportmidler
  "07213",      #Tilbehør til personlige transportmidler
  "07221",      #Diesel
  "07222",      #Benzin
  "07223",      #Andre brændstoffer til personlige transportmidler
  "07224",      #Smøremidler
  "07230",      #Vedligeholdelse og reparation af personlige transportmidler
  "07241",      #Leje af garage, fast parkering og personlige transportmidler
  "07242",      #Vejafgifter og parkeringsafgift
  "07243",      #Køretimer, kørekort og syn af bil
  "07311",      #Personbefordring med tog
  "07312",      #Personbefordring med metro
  "07321",      #Personbefordring med bus
  "07322",      #Personbefordring med taxi og lejet bil med fører
  "07331",      #Indenrigsflyvning
  "07332",      #International flyvning
  "07341",      #Personbefordring ad søvejen
  "07350",      #Kombineret personbefordring
  "07362",      #Flytning og opmagasinering
  "07369",      #Andre købte transporttjenester ol
  "08",         #KOMMUNIKATION
  "08101",      #Posttjenester
  "08201",      #Fastnettelefon og udstyr
  "08202",      #Mobiltelefon og udstyr
  "08204",      #Reparation af telefon- og telefaxudstyr
  "08301",      #Fastnettelefon, tjenester
  "08302",      #Mobiltelefon, tjenester
  "08303",      #Internet
  "08304",      #Kombinerede telekommunikationstjenester
  "09",         #FRITID OG KULTUR
  "09111",      #Musikanlæg, højttalere ol
  "09112",      #Tv, dvd-afspiller, videooptager ol
  "09119",      #Høretelefoner, digitale fotorammer, E-bogslæsere ol
  "09121",      #Kameraer
  "09123",      #Optiske instrumenter
  "09131",      #PCer, tablets mv
  "09132",      #Tilbehør til databehandlingsudstyr
  "09133",      #Software
  "09134",      #Regnemaskiner og andet databehandlingsudstyr
  "09141",      #Indspillede optagemedier
  "09142",      #Uindspillede optagemedier
  "09149",      #Andre optagemedier
  "09150",      #Reparation af audiovisuelt og fotografisk udstyr mv
  "09211",      #Autocampere, campingvogne og påhængsvogne
  "09213",      #Både, påhængsmotorer og montering af udstyr i både
  "09214",      #Heste og tilbehør
  "09215",      #Udstyr til spil og sport
  "09221",      #Musikinstrumenter
  "09230",      #Vedligeholdelse og reparation af andre større forbrugsgoder
  "09311",      #Spil og hobbyartikler
  "09312",      #Legetøj og festartikler
  "09321",      #Udstyr til sport
  "09322",      #Udstyr til camping og friluftsaktiviteter
  "09323",      #Reparation af udstyr til sport, camping og friluftsaktivitet
  "09331",      #Haveprodukter
  "09332",      #Planter og blomster
  "09341",      #Køb af kæledyr
  "09342",      #Artikler til kæledyr
  "09350",      #Dyrlæge og andre tjenester i forbindelse med kæledyr
  "09411",      #Fritids- og sportstjenester - tilstedeværelse
  "09412",      #Fritids- og sportstjenester - deltagelse
  "09421",      #Biografer, teatre, koncerter
  "09422",      #Museer, zoologiske haver mv
  "09423",      #Tv og radiolicens, abonnementer
  "09424",      #Leje af udstyr og tilbehør i forbindelse med kultur
  "09425",      #Fotografiske tjenester
  "09429",      #Andre kulturtjenester
  "09430",      #Hasardspil
  "09511",      #Skønliteratur
  "09512",      #Undervisningsbøger
  "09513",      #Anden faglitteratur
  "09514",      #E-bøger mv
  "09521",      #Aviser
  "09522",      #Blade og tidsskrifter
  "09530",      #Diverse tryksager
  "09541",      #Papirprodukter
  "09549",      #Andre papirvarer og tegnematerialer
  "09601",      #Indenlandske pakkerejser
  "09602",      #Udenlandske pakkerejser
  "10",         #UDDANNELSE
  "10102",      #Grundskole
  "10200",      #Ungdomsuddannelse
  "10400",      #Videregående uddannelse
  "10500",      #Undervisning uden for niveau
  "11",         #RESTAURANTER OG HOTELLER
  "11111",      #Restauranter, cafeer mv
  "11112",      #Fastfood, takeaway
  "11120",      #Kantiner
  "11201",      #Hoteller, moteller, kroer ol
  "11202",      #Feriecentre, campingpladser, vandrerhjem ol
  "11203",      #Anden indlogering
  "12",         #ANDRE VARER OG TJENESTER
  "12111",      #Frisør til mænd og børn 0-13 år
  "12112",      #Frisør til kvinder
  "12113",      #Behandlinger inden for personlig pleje
  "12121",      #Elektriske apparater til personlig pleje
  "12122",      #Reparation af elektriske apparater til personlig pleje
  "12131",      #Ikke-elektrisk udstyr
  "12132",      #Artikler til personlig hygiejne ol
  "12200",      #Prostitution
  "12311",      #Smykker
  "12312",      #Ure
  "12313",      #Reparation af smykker og ure
  "12321",      #Tasker, rygsække ol
  "12322",      #Babyartikler
  "12323",      #Reparation af andre personlige effekter
  "12329",      #Andre personlige effekter
  "12401",      #Børnepasning
  "12403",      #Madudbringning til pensionister
  "12510",      #Livsforsikringer
  "12520",      #Forsikring i forbindelse med boligen
  "12532",      #Privat sygeforsikring
  "12541",      #Transportforsikring
  "12542",      #Rejseforsikring
  "12550",      #Anden forsikring
  "12621",      #Gebyr til banker mv
  "12622",      #Revisor og anden finansiel rådgivning
  "12701",      #Administrationsgebyrer
  "12702",      #Juridiske tjenesteydelser
  "12703",      #Begravelsestjenester
  "12704")      #Andre gebyrer og tjenester

# Definerer 8 varegrupper: ----------

kod_fisk_mej = c (    "01121",      #Okse- og kalvekød
                      "01122",      #Svinekød
                      "01123",      #Lamme- og gedekød
                      "01124",      #Fjerkræ
                      "01125",      #Andet kød
                      "01126",      #Indmad ol
                      "01127",      #Kød, tørret, saltet eller røget
                      "01128",      #Andre tilberedninger af kød
                      "01131",      #Fisk, fersk
                      "01132",      #Fisk, frossen
                      "01133",      #Skaldyr, fersk
                      "01134",      #Skaldyr, frossen
                      "01135",      #Fisk og skaldyr, tørrede, røgede eller saltede
                      "01136",      #Fisk og skaldyr, konservede og forarbejdede
                      "01141",      #Mælk, frisk
                      "01142",      #Mælk med lavt fedtindhold, frisk
                      "01143",      #Mælk, konserveret
                      "01144",      #Yoghurt
                      "01145",      #Ost
                      "01146",      #Andre mejeriprodukter
                      "01147",      #Æg
                      "01151")      #Smør
ovr_fode     = c ( "01111",      #Ris
                     "01112",      #Mel og gryn
                     "01113",      #Brød
                     "01114",      #Andet bagværk
                     "01115",      #Pizza og quiche
                     "01116",      #Pastaprodukter og couscous
                     "01117",      #Morgenmadsprodukter
                     "01118",      #Andre kornprodukter
                     "01152",      #Margarine og andre vegetabilske fedtstoffer
                     "01153",      #Olivenolie
                     "01154",      #Andre spiselige olier
                     "01155",      #Andre spiselige animalske fedtstoffer
                     "01161",      #Frugt, frisk
                     "01162",      #Frugt, frossen
                     "01163",      #Frugter og nødder, tørrede
                     "01164",      #Frugter og frugtbaserede produkter, konservede
                     "01171",      #Grøntsager ekskl kartofler, frisk
                     "01172",      #Grøntsager, frosne
                     "01173",      #Grøntsager, tørrede og forarbejdede
                     "01174",      #Kartofler og kartoffelprodukter
                     "01175",      #Chips mv
                     "01176",      #Andre rod-og knoldgrøntsager
                     "01181",      #Sukker ol
                     "01182",      #Syltetøj, marmelade og honning
                     "01183",      #Chokolade
                     "01184",      #Slik og marcipan
                     "01185",      #Konsumis
                     "01186",      #Kunstige sukkererstatninger
                     "01191",      #Sovs, smagspræparater
                     "01192",      #Salt, krydderier og køkkenurter
                     "01193",      #Babymad
                     "01194",      #Færdigretter
                     "01199",      #Andre fødevarer
                     "01211",      #Kaffe
                     "01212",      #Te
                     "01213",      #Kakao og chokoladepulver
                     "01221",      #Mineralvand eller kildevand
                     "01222",      #Læskedrikke
                     "01223",      #Frugt- og grøntsagssaft samt koncentrater til saft
                     "02"   ,      #ALKOHOLISKE DRIKKEVARER OG TOBAK
                     "02111",      #Spiritus og likør
                     "02112",      #Alkoholiske læskedrikke
                     "02121",      #Vin af druer
                     "02122",      #Vin af andre frugter
                     "02123",      #Hedvin
                     "02124",      #Vinbaserede drikkevarer og alkoholfri vin
                     "02131",      #Pilsnerøl, guldøl
                     "02132",      #Andre alkoholholdige øl
                     "02133",      #Øl med lavt alkoholindhold og alkoholfri øl
                     "02134",      #Øl-baserede drikkevarer
                     "02201",      #Cigaretter
                     "02202",      #Cigarer ol
                     "02203",      #Andre tobaksvarer
                     "02300")      #Euforiserende stoffer)

bol   = c(       "04110",      #Faktisk husleje betalt af lejere
                   "04121",      #Lejernes faktiske husleje for fritidsbolig
                   "04210",      #Beregnet lejeværdi af egen bolig
                   "04220",      #Andre beregnede lejeværdier
                   "04310",      #Materialer til vedligeholdelse og reparation af bolig
                   "04321",      #Tjenesteydelser, blikkenslagere
                   "04322",      #Tjenesteydelser, elektrikere
                   "04323",      #Vedligeholdelse af varmeanlæg
                   "04324",      #Tjenesteydelser, malere
                   "04325",      #Tjenesteydelser, tømrere og snedkere
                   "04329",      #Andre tjenester til vedligeholdelse og reparation af bolig
                   "04410",      #Vandforsyning)    
                   #"04420",      #Renovation SKAL VÆRE I TJENESTER
                   "04430",      #Vandafledningsafgift mv
                   "04442",      #Sikkerhedstjenester
                   "04449")      #Andre tjenester i forbindelse med boliger

ene_hje = c(    "04510",      #Elektricitet
                   "04521",      #Natur- og bygas
                   "04522",      #Flydende kulbrinter
                   "04530",      #Flydende brændsel
                   "04541",      #Kul
                   "04549",      #Andet fast brændsel
                   "04550")      #Fjernvarme mv 

ene_tra = c(   "07221",      #Diesel
                   "07222",      #Benzin
                   "07223",      #Andre brændstoffer til personlige transportmidler
                   "07224")      #Smøremidler

tra =    c (    "07111",      #Nye biler
                   "07112",      #Brugte biler
                   "07120",      #Motorcykler
                   "07130",      #Cykler
                   "07211",      #Dæk
                   "07212",      #Reservedele til personlige transportmidler
                   "07213",      #Tilbehør til personlige transportmidler
                   "07230",      #Vedligeholdelse og reparation af personlige transportmidler
                   "07241",      #Leje af garage, fast parkering og personlige transportmidler
                   "07242",      #Vejafgifter og parkeringsafgift
                   "07243",      #Køretimer, kørekort og syn af bil
                   "07311",      #Personbefordring med tog
                   "07312",      #Personbefordring med metro
                   "07321",      #Personbefordring med bus
                   "07322",      #Personbefordring med taxi og lejet bil med fører
                   "07331",      #Indenrigsflyvning
                   "07332",      #International flyvning
                   "07341",      #Personbefordring ad søvejen
                   "07350",      #Kombineret personbefordring
                   "07362",      #Flytning og opmagasinering
                   "07369")      #Andre købte transporttjenester ol         )

ovr_var = c(    "03110",      #Materialer til beklædning
                   "03121",      #Beklædning til mænd
                   "03122",      #Beklædning til kvinder
                   "03123",      #Beklædning til småbørn (0-2 år) og børn (3-13 år)
                   "03131",      #Andre artikler til beklædning
                   "03132",      #Beklædningstilbehør
                   #"03141",      #Vask og rensning af tøj
                   #"03142",      #Reparation og leje af beklædning
                   "03211",      #Fodtøj til mænd
                   "03212",      #Fodtøj til kvinder
                   "03213",      #Fodtøj til børn under 14 år
                   #"03220",      #Reparation af fodtøj)
                   "05111",      #Boligmøbler
                   "05112",      #Havemøbler
                   "05113",      #Belysningsudstyr
                   "05119",      #Andre møbler og  andet boligudstyr
                   "05121",      #Gulvtæpper
                   "05122",      #Anden gulvbelægning
                   "05123",      #Montering af faste tæpper og gulvbelægning
                   "05130",      #Reparation af møbler, boligudstyr og gulvbelægninger
                   "05201",      #Møbelstof og gardiner
                   "05202",      #Sengelinned
                   "05203",      #Duge og håndklæder
                   "05204",      #Reparation af boligtekstiler
                   "05209",      #Andre boligtekstiler
                   "05311",      #Køleskabe, frysere og køle-fryseskabe
                   "05312",      #Vaskemaskiner, tørretumlere og opvaskemaskiner
                   "05313",      #Komfurer
                   "05314",      #Varmeapparater, klimaanlæg
                   "05315",      #Rengøringsudstyr
                   "05319",      #Andre større husholdningsapparater
                   "05321",      #Foodprocessorer
                   "05322",      #Kaffemaskiner, elkedler ol
                   "05323",      #Strygejern
                   "05324",      #Toaster, brødrister ol
                   "05329",      #Andre mindre elektriske husholdningsapparater
                   "05330",      #Reparation og leje af husholdningsmaskiner
                   "05401",      #Glas, keramik og porcelæn
                   "05402",      #Spisebestik, fade og sølvtøj
                   "05403",      #Ikke-elektriske køkkenredskaber og artikler
                   "05511",      #Motoriserede større redskaber og udstyr
                   "05512",      #Reparation og leje af udstyr og større redskaber
                   "05521",      #Ikke-motoriserede mindre redskaber
                   "05522",      #Diverse tilbehør til mindre redskaber
                   "05523",      #Reparation af ikke-motoriserede mindre redskaber, tilbehør
                   "05611",      #Rengørings- og vedligeholdelsesprodukter
                   "05612",      #Andre ikke-varige mindre husholdningsartikler
                   #"05621",      #Hjælp til hjem og have
                   #"05623",      #Leje af møbler og boligudstyr
                   #"05629",      #Rengøring og vinduespudsning
                   "06110",      #Farmaceutiske produkter
                   "06121",      #Graviditetstest, kondomer mv
                   "06129",      #Andre medicinske produkter ol
                   "06131",      #Briller med korrigerende glas og kontaktlinser
                   "06132",      #Høreapparater
                   "06133",      #Reparation af terapeutiske apparater og udstyr
                   "06139",      #Andre terapeutiske apparater
                   "09111",      #Musikanlæg, højttalere ol
                   "09112",      #Tv, dvd-afspiller, videooptager ol
                   "09119",      #Høretelefoner, digitale fotorammer, E-bogslæsere ol
                   "09121",      #Kameraer
                   "09123",      #Optiske instrumenter
                   "09131",      #PCer, tablets mv
                   "09132",      #Tilbehør til databehandlingsudstyr
                   "09133",      #Software
                   "09134",      #Regnemaskiner og andet databehandlingsudstyr
                   "09141",      #Indspillede optagemedier
                   "09142",      #Uindspillede optagemedier
                   "09149",      #Andre optagemedier
                   "09150",      #Reparation af audiovisuelt og fotografisk udstyr mv
                   "09211",      #Autocampere, campingvogne og påhængsvogne
                   "09213",      #Både, påhængsmotorer og montering af udstyr i både
                   "09214",      #Heste og tilbehør
                   "09215",      #Udstyr til spil og sport
                   "09221",      #Musikinstrumenter
                   "09230",      #Vedligeholdelse og reparation af andre større forbrugsgoder
                   "09311",      #Spil og hobbyartikler
                   "09312",      #Legetøj og festartikler
                   "09321",      #Udstyr til sport
                   "09322",      #Udstyr til camping og friluftsaktiviteter
                   "09323",      #Reparation af udstyr til sport, camping og friluftsaktivitet
                   "09331",      #Haveprodukter
                   "09332",      #Planter og blomster
                   "09341",      #Køb af kæledyr
                   "09342",      #Artikler til kæledyr
                   "09350",      #Dyrlæge og andre tjenester i forbindelse med kæledyr
                   "09511",      #Skønliteratur
                   "09512",      #Undervisningsbøger
                   "09513",      #Anden faglitteratur
                   "09514",      #E-bøger mv
                   "09521",      #Aviser
                   "09522",      #Blade og tidsskrifter
                   "09530",      #Diverse tryksager
                   "09541",      #Papirprodukter
                   "09549",      #Andre papirvarer og tegnematerialer
                   "12121",      #Elektriske apparater til personlig pleje
                   "12122",      #Reparation af elektriske apparater til personlig pleje
                   "12131",      #Ikke-elektrisk udstyr
                   "12132",      #Artikler til personlig hygiejne ol
                   "12311",      #Smykker
                   "12312",      #Ure
                   "12313",      #Reparation af smykker og ure
                   "12321",      #Tasker, rygsække ol
                   "12322",      #Babyartikler
                   "12323",      #Reparation af andre personlige effekter
                   "12329")      #Andre personlige effekter

ovr_tje =     c(    "03141",      #Vask og rensning af tøj
                       "03142",      #Reparation og leje af beklædning
                       "04420",      #Renovation
                       "05621",      #Hjælp til hjem og have
                       "05623",      #Leje af møbler og boligudstyr
                       "05629",      #Rengøring og vinduespudsning
                       "06211",      #Behandling hos praktiserende læge
                       "06212",      #Behandling hos speciallæge
                       "06220",      #Tandbehandling
                       "06231",      #Tjenesteydelser, laboratorier og røntgenklinikker
                       "06239",      #Andre paramedicinske tjenesteydelser
                       "06300",      #Hospitalstjenester
                       "08101",      #Posttjenester
                       "08201",      #Fastnettelefon og udstyr
                       "08202",      #Mobiltelefon og udstyr
                       "08204",      #Reparation af telefon- og telefaxudstyr
                       "08301",      #Fastnettelefon, tjenester
                       "08302",      #Mobiltelefon, tjenester
                       "08303",      #Internet
                       "08304",      #Kombinerede telekommunikationstjenester
                       "09411",      #Fritids- og sportstjenester - tilstedeværelse
                       "09412",      #Fritids- og sportstjenester - deltagelse
                       "09421",      #Biografer, teatre, koncerter
                       "09422",      #Museer, zoologiske haver mv
                       "09423",      #Tv og radiolicens, abonnementer
                       "09424",      #Leje af udstyr og tilbehør i forbindelse med kultur
                       "09425",      #Fotografiske tjenester
                       "09429",      #Andre kulturtjenester
                       "09430",      #Hasardspil
                       "09601",      #Indenlandske pakkerejser
                       "09602",      #Udenlandske pakkerejser
                       "10102",      #Grundskole
                       "10200",      #Ungdomsuddannelse
                       "10400",      #Videregående uddannelse
                       "10500",      #Undervisning uden for niveau
                       "11111",      #Restauranter, cafeer mv
                       "11112",      #Fastfood, takeaway
                       "11120",      #Kantiner
                       "11201",      #Hoteller, moteller, kroer ol
                       "11202",      #Feriecentre, campingpladser, vandrerhjem ol
                       "11203",      #Anden indlogering
                       "12111",      #Frisør til mænd og børn 0-13 år
                       "12112",      #Frisør til kvinder
                       "12113",      #Behandlinger inden for personlig pleje
                       "12200",      #Prostitution
                       "12401",      #Børnepasning
                       "12403",      #Madudbringning til pensionister
                       "12510",      #Livsforsikringer
                       "12520",      #Forsikring i forbindelse med boligen
                       "12532",      #Privat sygeforsikring
                       "12541",      #Transportforsikring
                       "12542",      #Rejseforsikring
                       "12550",      #Anden forsikring
                       "12621",      #Gebyr til banker mv
                       "12622",      #Revisor og anden finansiel rådgivning
                       "12701",      #Administrationsgebyrer
                       "12702",      #Juridiske tjenesteydelser
                       "12703",      #Begravelsestjenester
                       "12704")      #Andre gebyrer og tjenester



fu02_l <- read_xlsx("C:/specialeJR/Prisdata DST/fu02_loeb_og_faste.xlsx", sheet="Loebende priser")
fu02_f <- read_xlsx("C:/specialeJR/Prisdata DST/fu02_loeb_og_faste.xlsx", sheet="Faste priser")


names(fu02_l) <- varegrupper
names(fu02_f) <- varegrupper


#### Lav prisindeks ####
indeks = fu02_l %>% select("Aar")
indeks[,"Pris kod_fisk_mej"] = rowSums(fu02_l %>% select(all_of(kod_fisk_mej)))/rowSums(fu02_f %>% select(all_of(kod_fisk_mej)))
indeks[,"Pris ovr_fode"] = rowSums(fu02_l %>% select(all_of(ovr_fode)))/rowSums(fu02_f %>% select(all_of(ovr_fode)))
indeks[,"Pris bol"] = rowSums(fu02_l %>% select(all_of(bol)))/rowSums(fu02_f %>% select(all_of(bol)))
indeks[,"Pris ene_hje"] = rowSums(fu02_l %>% select(all_of(ene_hje)))/rowSums(fu02_f %>% select(all_of(ene_hje)))
indeks[,"Pris ene_tra"] = rowSums(fu02_l %>% select(all_of(ene_tra)))/rowSums(fu02_f %>% select(all_of(ene_tra)))
indeks[,"Pris tra"] = rowSums(fu02_l %>% select(all_of(tra)))/rowSums(fu02_f %>% select(all_of(tra)))
indeks[,"Pris ovr_var"] = rowSums(fu02_l %>% select(all_of(ovr_var)))/rowSums(fu02_f %>% select(all_of(ovr_var)))
indeks[,"Pris ovr_tje"] = rowSums(fu02_l %>% select(all_of(ovr_tje)))/rowSums(fu02_f %>% select(all_of(ovr_tje)))


write.csv(indeks, "C:/specialeJR/Prisdata DST/PRISINDEKS.csv", row.names = FALSE)


