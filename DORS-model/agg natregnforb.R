setwd("~/Documents/GitHub/SpecialeJR /DORS-model")

library("readxl")
library("dplyr")
library("rlang")

options(scipen=999)
forb16 <- read_xlsx("forbrug74grupper2016.xlsx")
df <- forb16

## definerer nationalregnskabsvaregrupper ----
varegrupper = list(
"01110", #Brød og kornprodukter
"01120",  #Kød
"01130", #Fisk
"01141",  #Æg
"01142", #Mælk, fløde, yoghurt mv.
"01143",  #Ost
"01150", #Olie og fedtstoffer
"01167",  #Frugt og grøntsager
"01179", #Kartofler mv.
"01181",  #Sukker
"01182", #Is, chokolade og sukkervarer
"01190",  #Næringsmidler i.a.n.
"01210", #Kaffe, te og kakao
"01220",  #Mineralvand, sodavand, juice samt frugt- og grønsagssaft
"02112", #Vin og spiritus
"02130",  #Øl
"02900", #Tobak mv.
"03113",  #Beklædningsartikler
"03140", #Rensning, reparation og leje af beklædning
"03200",  #Fodtøj
"04100", #Husleje
"04200",  #Beregnet husleje af egen bolig
"04300", #Vedligeholdelse og reparation af boligen
"04401",  #Vand og vandafledningsafgift
"04402", #Renovation mv.
"04510",  #Elektricitet
"04520", #Gas
"04530",  #Flydende brændsel
"04545", #Fjernvarme mv.
"05100",  #Møbler og gulvtæpper mv.
"05200", #Boligtekstiler
"05312",  #Husholdningsapparater
"05330", #Vedligeholdelse af husholdningsapparater
"05400",  #Glas, service og husholdningsredskaber
"05500", #Værktøj og udstyr til hus og have
"05610",  #Rengøringsmidler mv.
"05620", #Hushjælp mv.
"06112",  #Medicin, vitaminer mv.
"06130", #Briller, høreapparater mv.
"06200",  #Læger, tandlæge mv.
"06300", #Hospitalers tjenesteydelser
"07100",  #Køb af køretøjer
"07213", #Vedligeholdelse af køretøjer
"07220",  #Brændstof og smøremidler til køretøjer
"07240", #Andre tjenesteydelser vedrørende køretøjer
"07300",  #Transporttjenester
"08100", #Posttjenester
"08200",  #Telefon- og datakommunikationsudstyr
"08300", #Telefon- og datakommunikationstjenester
"09110",  #Radio- og tv-apparater mv.
"09120", #Fotoudstyr, videokameraer mv.
"09130",  #Pcere mv.
"09140", #Cdere, dvdere mv.
"09150",  #Reparation af radio, tv, pc mv.
"09200", #Andre større forbrugsgoder i forbindelse med fritid og kultur
"09300",  #Andet tilbehør og udstyr til fritid, haver og kæledyr
"09400", #Forlystelser, tv-licens mv.
"09513",  #Bøger, aviser, tidskrifter og blade
"09540", #Papirvarer og tegnematerialer
"09600",  #Pakkede ferierejser
"10000", #Undervisning
"11100",  #Restauranter, caféer mv.
"11200", #Hoteller mv.
"12110",  #Frisører mv.
"12123", #Toiletartikler, barbermaskiner mv.
"12310",  #Smykker og ure mv.
"12320", #Andre personlige effekter
"12401",  #Plejehjem, dagcentre mv.
"12402", #Daginstitutioner for børn
"12500",  #Forsikring
"12600", #Finansielle tjenester i.a.n.
"12700")  #Advokater, andre tjenesteydelser i.a.n.




##definerer 8 forbrugsgrupper --------
kod_fisk_mej = c (     "01120", #Kød
                       "01130", #Fisk
                       "01141", #Æg
                       "01142", #Mælk, fløde, yoghurt mv.
                       "01143") #Ost

ovr_fode     =c ( "01110", #Brød og kornprodukter
                  "01150", #Olie og fedtstoffer
                  "01167", #Frugt og grøntsager
                  "01179", #Kartofler mv.
                  "01181", #Sukker
                  "01182", #Is, chokolade og sukkervarer
                  "01190", #Næringsmidler i.a.n.
                  "01210", #Kaffe, te og kakao
                  "01220", #Mineralvand, sodavand, juice samt frugt- og grønsagssaft
                  "02112", #Vin og spiritus
                  "02130", #Øl
                  "02900") #Tobak mv.

bol   =c(          "04100", #Husleje
                   "04200", #Beregnet husleje af egen bolig
                   "04300", #Vedligeholdelse og reparation af boligen
                   "04401") #Vand og vandafledningsafgift

ene_hje = c(       "04510", #Elektricitet
                   "04520", #Gas
                   "04530", #Flydende brændsel
                   "04545") #Fjernvarme mv.

ene_tra = c (     "07220") #Brændstof og smøremidler til køretøjer    
                   
tra =    c(        "07100", #Køb af køretøjer
                   "07213", #Vedligeholdelse af køretøjer
                   "07240", #Andre tjenesteydelser vedrørende køretøjer
                   "07300") #Transporttjenester

ovr_var = c(       "03113", #Beklædningsartikler
                   "03200", #Fodtøj
                   "05100", #Møbler og gulvtæpper mv.
                   "05200", #Boligtekstiler
                   "05312", #Husholdningsapparater
                   "05330", #Vedligeholdelse af husholdningsapparater
                   "05400", #Glas, service og husholdningsredskaber
                   "05500", #Værktøj og udstyr til hus og have
                   "05610", #Rengøringsmidler mv.
                   "06112", #Medicin, vitaminer mv.
                   "06130", #Briller, høreapparater mv.
                   "09110", #Radio- og tv-apparater mv.
                   "09120", #Fotoudstyr, videokameraer mv.
                   "09130", #Pcere mv.
                   "09140", #Cdere, dvdere mv.
                   "09150", #Reparation af radio, tv, pc mv.
                   "09200", #Andre større forbrugsgoder i forbindelse med fritid og kultur
                   "09300", #Andet tilbehør og udstyr til fritid, haver og kæledyr
                   "09400", #Forlystelser, tv-licens mv.
                   "09513", #Bøger, aviser, tidskrifter og blade
                   "09540", #Papirvarer og tegnematerialer
                   "12123", #Toiletartikler, barbermaskiner mv.
                   "12310", #Smykker og ure mv.
                   "12320") #Andre personlige effekter

ovr_tje =     c(       "03140", #Rensning, reparation og leje af beklædning
                       "04402", #Renovation mv.
                       "05620", #Hushjælp mv.
                       "06200", #Læger, tandlæge mv.
                       "06300", #Hospitalers tjenesteydelser
                       "08100", #Posttjenester
                       "08200", #Telefon- og datakommunikationsudstyr
                       "08300", #Telefon- og datakommunikationstjenester
                       "09600", #Pakkede ferierejser
                       "10000", #Undervisning
                       "11100", #Restauranter, caféer mv.
                       "11200", #Hoteller mv.
                       "12110", #Frisører mv.
                       "12401", #Plejehjem, dagcentre mv.
                       "12402", #Daginstitutioner for børn
                       "12500", #Forsikring
                       "12600", #Finansielle tjenester i.a.n.
                       "12700") #Advokater, andre tjenesteydelser i.a.n."

##laver nyt data sæt ----
cnams <- c("Meat and dairy","Other foods","Housing","Energy for housing",
           "Energy for transport","Transport","Other goods","Other services", "I alt")
forb20168=c(1:9)
names(forb20168) <- cnams

forb20168[1] =sum(df[kod_fisk_mej])
forb20168[2] =sum(df[ovr_fode])
forb20168[3] =sum(df[bol])
forb20168[4] =sum(df[ene_hje])
forb20168[5] =sum(df[ene_tra])
forb20168[6] =sum(df[tra])
forb20168[7] =sum(df[ovr_var])
forb20168[8] =sum(df[ovr_tje])
forb20168[9] =df$`I alt`

write.xlsx(forb20168, "/Users/rasmuskaslund/Documents/GitHub/SpecialeJR /DORS-model/Output.xlsx", sheetName = "forb20168", 
           col.names = TRUE, row.names = TRUE, append = TRUE)


