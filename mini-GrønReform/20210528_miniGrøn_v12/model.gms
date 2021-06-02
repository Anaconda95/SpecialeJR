*--------------------------------------------
* REFORM 2.4h, 1/10-2016
*--------------------------------------------
* Multisektor model, DREAM
*--------------------------------------------
* PSP, GRA 7/2-2014: Endelig udgave af version 0.1
* GRA 11/02-2014 :    Opsplitning i qzk og qzi 
* PSP 12/02-2014 :    Opsplitning af privat forbrug 
* PSP 12/02-2014 :    Dummysektor
* PSP 12/02-2014 :    Fejl rettet i off. saldo
* GRA 12/02-2014 :    Usercost 
* PSP 13/02-2014 :    Vækstkorrektion blevet korrekt
* PSP 13/02-2014 :    Arbejdsudbudseffekt er slået fra ved at sætte h_bar = 1 (var før 1.2)
* GRA 13/02-2014 :    BNP i faste priser
* PSP 18/02-2014 :    TFP og rapportering
* PSP 19/02-2014 :    Gældskvote
* PSP 19/02-2014 :    Rettelse af bug i nettoindkomst
* PSP 24/02-2014 :    EV-mål
* PSP 28/02-2014 :    tfp_H. En TFP der kun virker på KM, KB og L 
* PSP 03/03-2014 :    Investeringer fjernet fra offentlig saldo (de blev sat ind den 12/2) 
* PSP 04/03-2014 :    Bug i EV-mål rettet 
* PAB 05/03-2014 :    Peter Baches rettelser indført 
* GRA 06/03-2014 :    Moms indført og eksportafgifter lagt til saldo
* PSP 11/03-2014 :    Offentlig gæld + primær saldo 
* GRA 12/03-2014 :    Selskabsskat
* PSP 14/03-2014 :    EV-mål
* GRA 17/03-2014 :    Mulighed for restrikteret offentlig branche med fast K/Y- og L/Y-forhold
* PSP 24/03-2014 :    udskrivDREAM.gms (EV-mål udskrives i en xls-fil per stød)
* GRA 24/03-2014 :    Branchefordelt udenlandsk aktiejerskabsandel
* GRA 31/03-2014 :    Udvidelse af modellen fra 13 til 26 brancher
* GRA 01/04-2014 :    Forskellig marginal og gns. skattesats på forbruget
* GRA 10/04-2014 :    Rettelse i forbindelse med marginal og gns. skattesats
* GRA 02/06-2014 :    Opdeling af indirekte skatter på produktsskatter, produktionsskatter og told
* GRA 28/08-2014 :    Reduktion af modellen fra 26 til 16(+1dummy) brancher (1.3)
* GRA 28/08-2014 :    Boligforbrug lægges yderst i nestningsstrukturen (1.4)
* GRA 29/08-2014 :    Opdeling af kapital på bygnings- og maskinkapital (1.5)
* GRA 19/09-2014 :    Udvidelse af modellen fra 16 til 73 brancher
* GRA 24/09-2014 :    Forbrug, materialer og investeringer nestet på 2 underniveauer med hhv. 13 og 73 varegrupper (2.1.5)
* GRA 25/09-2014 :    Ny nestningsstruktur for forbruget og ingen effekt fra privat forbrug til privat eft.sp. efter off. tj. (2.1.6)
* GRA 30/09-2014 :    Moms og produktskattesatser i kalibreringen beregnes mere disaggregeret (2.1.9)
* GRA 01/10-2014 :    Lagerinvesteringer indgår i virksomhedens omkostninger (2.1.10)
* GRA 06/11-2014 :    Virksomhederne tager hensyn til, at de ikke kan trække lagerinvesteringer fra i skat (2.1.11)
* GRA 16/01-2015 :    Privat eft.sp. efter off. tj. genindføres, da 2.1.6-rettelse giver konvergensproblemer  (2.1.12)
* GRA 16/01-2015 :    Mulighed for endogent offentligt forbrug  (2.1.12)
* GRA 16/01-2015 :    Modelversion med 0-celler i IO-tabellen og alle leverancer under ½ mio. afrundet til 0. (2.1.12)
* GRA 16/01-2015 :    Model kalibreres på reviderede nationalregnskabstal for 2007 og 2010 (2.1.13)
* GRA 19/01-2015 :    Der kan nu køres med 13, 73 og 16 brancher (2.1.14)
* GRA 22/01-2015 :    Mulighed for dummy-branche (2.1.15)
* RBJ 12/11-2015 :    Modellen kalibreres til konjunkturrenset data med hhv. 16 og 73 brancher
* RBJ 15/12-2015 :    Tilføjet konjunkturrenset databank, så investeringerne (og derved også kapitalapparatet) ikke er nul, undtaget hvor det er givet af NR. Momsskattesats for indenlandske bygningsinvesteringer (i post og kurrer aktiviteter) er rettet.
* RBJ 26/04-2016 :    Offentligt forbrug ændres fra at følge BNP til at følge BVT
* RBJ 26/04-2016 :    Told fjernes fra offentlig saldo - betales til EU
* RBJ 04/05-2016 :    Faktisk outputpris ændret
* RBJ 04/05-2016 :    EU subsidie udskilt fra øvrige produktionsskatter 
* RBJ 12/05-2016 :    Justering af formuedannelse - se Peter Baches papir (Forslag til justering af formuedannelse i REFORM (23/6-2015)) 
* RBJ 12/05-2016 :    Mulighed for endogent arbejdsudbud 
* RBJ 31/05-2016 :    Mulighed for at vælge mellem forbrugsskattesats på 24,5 % (tMarg_c) og skattesatser fra data 
* RBJ 01/06-2016 :    Mulighed for at vælge mellem additiv (endogent arbejdsudbud) og multiplikativ nyttefunktion for forbrugeren 
* RBJ 16/06-2016 :    Ændrede substitutionselasticiteter i produktion og forbrug
* RBJ 01/10-2016 :    Produktionsskatter opdeles
* RBJ 11/06-2018 :    Modelleringen af produktafgifter ændres fra værdiafgift til stykafgift
* RBJ 15/06-2018 :    Modellen kalibreres og konjunkturrenses med til for 2002-2014.

*--------------------------------------------
option decimals=7;

*------------------------------------------------------------
* Mængder
*------------------------------------------------------------
include sets_16.gms

function Pos(x) = ((%x)*(%x))**0.5;

*------------------------------------------------------------
* Ligninger
*------------------------------------------------------------
equations
E_Ktot      "samlet kapitalapparat"
E_GDP       "Definition af BNP"
E_GDPf0     "Definition af BNP i faste priser"
E_BVT(j)    "Definition af BVT"
E_BVTtot    "Definition af samlet BVT"
E_BVTf0(j)  "Definition af BVT i faste priser"
E_BVTf0tot  "Definition af samlet BVT i faste priser"
E_NVTf0(j)  "Definition af NVT i faste priser"
E_NVTf0tot  "Definition af samlet NVT i faste priser"
E_M(j)      "Efterspørgsel efter materialer"
E_H(j)      "Efterspørgsel efter H-aggregat"
E_LKE(j)    "Efterspørgsel efter LKE-aggregat"
E_KE(j)     "Efterspørgsel efter KE-aggregat"
E_PO(j)     "Nulprofitbetingelse: Bestemmer optimeringspris PO"
E_P(j)      "Markup-prisdannelse"
E_KB(j)     "Efterspørgsel efter KB"
E_KM(j)     "Efterspørgsel efter KM"
E_E(j)      "Efterspørgsel efter energi"
E_KBbook(j) "Bygningskapitalapparatets bogførte værdi"
E_KMbook(j) "Maskinkapitalapparatets bogførte værdi"
E_ucB(j)    "Usercost rate for bygninger"
E_ucM(j)    "Usercost rate for maskiner"
E_L(j)      "Efterspørgsel efter L"
E_PH(j)     "Nulprofitbetingelse: Bestemmer prisen PH" 
E_PLKE(j)   "Nulprofitbetingelse: Bestemmer prisen PLKE" 
E_PKE(j)    "Nulprofitbetingelse: Bestemmer prisen PKE" 
E_x(j,i)    "Materialeefterspørgsel"
E_xmm(j)    "Samlet ikke-energi materialeefterspørgsel"
E_xeme(j)   "Samlet energi materialeefterspørgsel"
E_xm(j,dm,dmo)   "Efterspørgsel efter x - ikke-energi"
E_xe(j,dme,dmeo) "Efterspørgsel efter x - energi"
E_PM(j)     "Nulprofitbetingelse: Bestemmer prisen PM" 
E_PE(j)     "Nulprofitbetingelse: Bestemmer prisen PE" 
E_xD(j,i)   "Efterspørgsel efter xD (indenlandske materialer)"
E_xF(j,i)   "Efterspørgsel efter xF (udenlandske materialer)" 
E_Px(j,i)   "Nulprofitbetingelse: Bestemmer prisen Px" 
E_Pxm(j,dmo)   "Nulprofitbetingelse: Bestemmer prisen Pxm" 
E_Pxe(j,dmeo)  "Nulprofitbetingelse: Bestemmer prisen Pxe" 
E_Pxm_i(j,dmi)  "Prisen for ikke-energi materialeaggregater" 
E_Pxe_i(j,dmei) "Prisen for energi materialeaggregater"
E_InvB(j)     "Efterspørgsel efter Investeringsaggegat for bygninger" 
E_InvM(j)     "Efterspørgsel efter Investeringsaggegat for maskiner" 
E_IBib(j)     "Efterspørgsel efter Investeringsinput af bygninger samlet"
E_IBI(j,i)    "Efterspørgsel efter Investeringsinput af bygninger"
E_IB(j,dib,dibo) "Efterspørgsel efter Investeringsinput af bygninger"
E_IMim(j)     "Efterspørgsel efter Investeringsinput af maskiner samlet"
E_IMI(j,i)    "Efterspørgsel efter Investeringsinput af maskiner"
E_IM(j,dim,dimo) "Efterspørgsel efter Investeringsinput af maskiner"
E_PInvB(j)    "Nulprofitbetingelse: Bestemmer prisen PInvB" 
E_PInvM(j)    "Nulprofitbetingelse: Bestemmer prisen PInvM" 

E_IBD(j,i)  "Efterspørgsel efter Investeringsinput af bygninger (indenlandsk)"
E_IMD(j,i)  "Efterspørgsel efter Investeringsinput af maskiner (indenlandsk)"
E_IBF(j,i)  "Efterspørgsel efter Investeringsinput af bygninger (udenlandsk)" 
E_IMF(j,i)  "Efterspørgsel efter Investeringsinput af maskiner (udenlandsk)" 
E_PIBI(j,i) "Nulprofitbetingelse: Bestemmer prisen PIBI"
E_PIB(j,dibo) "Nulprofitbetingelse: Bestemmer prisen PIB for dimo"
E_PIB_i(j,dibi) "Nulprofitbetingelse: Bestemmer prisen PIB for dimi"
E_PIMI(j,i) "Nulprofitbetingelse: Bestemmer prisen PIMI"
E_PIM(j,dimo) "Nulprofitbetingelse: Bestemmer prisen PIM for dimo"
E_PIM_i(j,dimi) "Nulprofitbetingelse: Bestemmer prisen PIM for dimi"

E_IL(j)    "Lagerinvesteringer"
E_ILD(j)   "Lagerinvesteringer fra indenlandsk produktion"
E_ILF(j)   "Lagerinvesteringer fra import"
E_PIL(j)   "Lagerinvesteringernes prisaggregat"

E_DIV(j)   "Dividender"
E_V(j)     "Virksomhedens værdi"
E_DP(j)    "Virksomhedernes gæld"

E_YEmp     "Disponibel indkomst for beskæftigede"
E_YNotEmp  "Disponibel indkomst for ikke-beskæftigede"
E_N_Emp    "Antal beskæftigede"

E_C_Emp    "Beskæftigedes forbrugsefterspørgsel"
E_VV       "Beskæftigedes efterspørgsel efter fritid"
E_PU       "Definition af prisindeks PU"
E_YZ       "Fritidskorrigeret indkomst"
E_hour     "Arbejdsudbudsligning"
E_hourMUL  "Arbejdsudbudsligning ved multiplikativ nyttefunktion" 

E_C_NotEmp "Ikke-beskæftigedes forbrugsefterspørgsel" 
E_Ctot     "Samlet forbrug"
E_CHc      "Samlet forbrug"

E_C(i)      "Forbrugsefterspørgsel fordelt på varer"
E_CH(dc,dco) "Forbrugsefterspørgsel fordelt på forbrugsgrupper"
E_cD(i)     "Forbrugsefterspørgsel fordelt på varer (indenlandsk)"
E_cF(i)     "Forbrugsefterspørgsel fordelt på varer (udenlandsk)"
E_PCH(dco)  "Definition af forbrugerprisindeks PCH for dco"
E_PCH_i(dci)  "Definition af forbrugerprisindeks PCH for dci"
E_PC(i)     "Definition af forbrugerprisindeks PC for i"
E_Wealth    "Forbrugernes formue"

E_Ex(j)    "Eksport inkl. import til reeksport"
E_ExD(j)   "Eksport ekskl. import til reeksport"
E_ExF(j)   "Import til reeksport"
E_P_Ex(j)  "Eksportpris inkl. import til reeksport"

E_DG       "Offentlig gæld"
E_PSaldo   "Offentlig primær saldo"

E_Trans    "Satsregulering"

E_w        "Ligevægt på arbejdsmarkedet"
E_Y(j)     "Ligevægt på varemarkedet"

E_GD(j)    "Forbrug af indenlandsk producerede offentlige goder"
E_GF(j)    "Forbrug af udenlandsk producerede offentlige goder"  
E_PG(j)    "Prisaggregat for offentlige goder"

E_P_udl(j) "Udlandspris"

E_tMarg_cD(j) "Marginal skat på indenlandske forbrugsgoder"
E_tMarg_cF(j) "Marginal skat på udenlandske forbrugsgoder"

E_BoP      "Betalingsbalance - skal være nul!"

E_Ltot     "Summen af branchernes arbejdskraftsaggregater"

E_G(i)     "Det offentlige forbrug"

E_TaxEU    "Nettoskatter til EU"

E_UTILITY "Nytte"

;

*------------------------------------------------------------
* Variable
*------------------------------------------------------------
* gamX-kommando: Definerer gruppen af endogene variable
group ENDO "Endogene variable"

Ktot       "Samlet kapitalapparat"

GDP        "BNP"
GDPf0      "BNP i faste priser"
BVT(j)     "BVT"
BVTtot     "Samlet BVT"
BVTf0(j)   "BVT i faste priser"
BVTf0tot   "Samlet BVT i faste priser"
NVTf0(j)   "NVT i faste priser"
NVTf0tot   "Samlet NVT i faste priser"
M(j)       "Materiale-aggregat"
H(j)       "BLKE-aggregat"
LKE(j)     "LKE-aggregat"
KE(j)      "KE-aggregat"
E(j)       "Energi-aggregat"
PO(j)      "Optimeringspris"
p(j)       "Output-priser"  
L(j)       "Beskæftigelse"
KB(j)      "Bygningsapitalapparat"
KM(j)      "Maskinkapitalapparat"
KBbook(j)  "Bygningskapitalapparats bogførte værdi"
KMbook(j)  "Maskinkapitalapparats bogførte værdi"
ucB(j)     "Usercost rate for bygninger"
ucM(j)     "Usercost rate for maskiner"
PH(j)      "Prisindeks PH"
PLKE(j)    "Prisindeks PLKE"
PKE(j)     "Prisindeks PKE"
x(j,i)     "Materialeinput"
xm(j,dm)   "Materialeinput - ikke-energi"
xe(j,dme)  "Materialeinput - energi"
PM(j)      "Materiale-prisindeks for ikke-energi PM"
PE(j)      "Materiale-prisindeks for energi PE"
xD(j,i)    "Materialeinput (indenlandsk)"
xF(j,i)    "Materialeinput (udenlandsk)"
Px(j,i)    "Materiale-prisindeks Px"
Pxm(j,dm)  "Materiale-prisindeks Pxm"
Pxe(j,dme) "Materiale-prisindeks Pxe"
InvB(j)    "Investerings-aggregat for bygninger"
InvM(j)    "Investerings-aggregat for maskiner"
IBI(j,i)   "Bygningsinvesteringer fordelt på varer"
IB(j,dib)  "Bygningsinvesteringer fordelt på aggregater"
IMI(j,i)   "Maskininvesteringer fordelt på varer"
IM(j,dim)  "Maskininvesteringer fordelt på aggregater"
PInvB(j)   "Investerings-Prisindeks PInvB"
PInvM(j)   "Investerings-Prisindeks PInvM"
IBID(j,i)  "Investeringer i bygninger (indenlandsk)"
IMID(j,i)  "Investeringer i maskiner (indenlandsk)"
IBIF(j,i)  "Investeringer i bygninger (udenlandsk)" 
IMIF(j,i)  "Investeringer i maskiner (udenlandsk)" 
PIBI(j,i)  "Investerings-Prisindeks PIBI" 
PIB(j,dib) "Investerings-Prisindeks PIB" 
PIMI(j,i)  "Investerings-Prisindeks PIMI" 
PIM(j,dim) "Investerings-Prisindeks PIM" 
DIV(j)     "Dividender"
V(j)       "Virksomheders værdi"

IL(j)      "Lagerinvesteringer aggregat"
ILD(j)     "Lagerinvesteringer (indenlandsk)"
ILF(j)     "Lagerinvesteringer (udenlandsk)"
PIL(j)     "Lagerinvesteringer prisindeks"

YEmp       "Beskæftigedes disponible indkomst"
YNotEmp    "Ikke-beskæftigede disponible indkomst"
N_Emp      "Antal beskæftigede"

C_Emp      "Beskæftigedes forbrug"
VV         "Fritid"
PU         "Prisindeks PU"
YZ         "Fritidskorrigeret indkomst"
hour       "Arbejdstid"
C_NotEmp   "Ikke-beskæftigedes forbrug"
CTot       "Samlet privat forbrug"
CH(dc)     "Privat forbrug fordelt på forbrugsgrupper"
C(i)       "Privat forbrug fordelt på varer"
PCH(d)     "Forbrugerprisindeks PCH"
PC(i)      "Forbrugerprisindeks PC"
cD(i)      "Forbrug branchefordelt (indenlandsk)"
cF(i)      "Forbrug branchefordelt (udenlandsk)"
Wealth     "Forbrugernes formue"

Ex(j)      "Eksport inkl. import til reeksport"
ExD(j)     "Eksport ekskl. import til reeksport"
ExF(j)     "Import til reeksport"
P_Ex(j)    "Eksportpris inkl. import til reeskport"

gD(j)      "Forbrug af indenlandsk producerede offentlige goder"
gF(j)      "Forbrug af udenlandsk producerede offentlige goder"
PG(j)      "Prisaggregat for offentlige goder"
Trans      "Transfereringer fra staten til ikke-beskæftigede forbrugere"
lumpsum    "Lumpsum betalt til hvert individ"

Y(j)       "Produktion"
w          "Løn"

P_udl(j)      "pris for udland (eksport)"

PSaldo     "Offentlig primær saldo"

DP(j) "Virksomhedernes gæld"

tMarg_cD(j) "Marginal skat på indenlandske forbrugsgoder"
tMarg_cF(j) "Marginal skat på udenlandske forbrugsgoder"

BoP      "Betalingsbalance - skal være nul!"
Ltot     "Summen af branchernes arbejdskraftsaggregater"

G(i)     "Offentligt forbrug"

TaxEU    "Nettoskatter til EU"

UTILITY "Nytte"

;

*---------------------------------------
group EXO  "Eksogene variable"

DG         "Offentlig gæld"

Wealth_F   "Forbrugernes formue i udenlandske aktiver"

Trans0     "Niveau-parameter i satsregulering" 
share_D(j) "Andel af indenlandske aktier ejet af indenlandske forbrugere"

PF(j)       "Udenlandsk priser"
PF0(j)      "Udenlandsk priser i basisåret"
p0(j)       "Output-priser i basisår"
PInvB0(j)   "Bygningsinvesterings-priser i basisår"
PInvM0(j)   "Maskininvesterings-priser i basisår"
KB0(j)      "Bygningsapitalapparat i basisår"
KM0(j)      "Maskinkapitalapparat i basisår" 
ucB0(j)     "Usercost rate for bygninger"
ucM0(j)     "Usercost rate for maskiner"

r           "International rente"
infl        "Inflationsrate"
deltaKB(j)  "Afskrivningsrate for bygninger"
deltaKM(j)  "Afskrivningsrate for maskiner"
deltaKBBook(j) "Skattemæssig afskrivningsrate for bygninger"
deltaKMBook(j) "Skattemæssig afskrivningsrate for maskiner"
grow        "Vækstrate"

m_YM(j)    "CES-fordelingsparameter"
m_YH(j)    "CES-fordelingsparameter"
m_HB(j)    "CES-fordelingsparameter"
m_HLKE(j)  "CES-fordelingsparameter"
m_LKEL(j)  "CES-fordelingsparameter"
m_LKEKE(j) "CES-fordelingsparameter"
m_KEK(j)   "CES-fordelingsparameter"
m_KEE(j)   "CES-fordelingsparameter"
m_xe(j,dme) "CES-fordelingsparameter"
m_xm(j,dm) "CES-fordelingsparameter"
m_xD(j,i)  "CES-fordelingsparameter"
m_xF(j,i)  "CES-fordelingsparameter"
m_IB(j,dib) "CES-fordelingsparameter"
m_IM(j,dim) "CES-fordelingsparameter"
m_IBD(j,i) "CES-fordelingsparameter"
m_IMD(j,i) "CES-fordelingsparameter"
m_IBF(j,i) "CES-fordelingsparameter"
m_IMF(j,i) "CES-fordelingsparameter"
m_UC       "CES-fordelingsparameter"
m_UV       "CES-fordelingsparameter"
m_ch(dc)   "CES-fordelingsparameter"
m_cD(i)    "CES-fordelingsparameter"
m_cF(i)    "CES-fordelingsparameter"
m_ExD(i)   "CES-fordelingsparameter"
m_ExF(i)   "CES-fordelingsparameter"
m_GD(i)    "CES-fordelingsparameter"
m_GF(i)    "CES-fordelingsparameter"
m_ILD(j)   "CES-fordelingsparameter"
m_ILF(j)   "CES-fordelingsparameter"

tCus_x(j,i)   "Told på materialeinput (udenlandsk)"
tCus_IB(j,i)  "Told på bygningsinvesteringsinput (udenlandsk)"
tCus_IM(j,i)  "Told på maskininvesteringsinput (udenlandsk)"
tCus_c(i)     "Told på forbrugsvarer (udenlandsk)"
tCus_Ex(i)    "Told på eksportsvarer (udenlandsk)"
tCus_IL(i)    "Told på lagerinvesteringer (udenlandsk)"
tCus_G(i)     "Told på off forbrug (udenlandsk)"
tCus_x0(j,i)  "Told på materialeinput i basisåret (udenlandsk)"
tCus_IB0(j,i) "Told på bygningsinvesteringsinput i basisåret (udenlandsk)"
tCus_IM0(j,i) "Told på maskininvesteringsinput i basisåret (udenlandsk)"
tCus_c0(i)    "Told på forbrugsvarer i basisåret (udenlandsk)"
tCus_Ex0(i)   "Told på eksportsvarer i basisåret (udenlandsk)"
tCus_IL0(i)   "Told på lagerinvesteringer i basisåret (udenlandsk)"
tCus_G0(i)    "Told på off forbrug i basisåret (udenlandsk)"

tDuty_xD(j,i,tax)   "Produktskatter på materialeinput (indenlandsk)"
tDuty_xF(j,i,tax)   "Produktskatter på materialeinput (udenlandsk)"
tDuty_IBD(j,i,tax)  "Produktskatter på bygningsinvesteringsinput (indenlandsk)"
tDuty_IMD(j,i,tax)  "Produktskatter på maskininvesteringsinput (indenlandsk)"
tDuty_IBF(j,i,tax)  "Produktskatter på bygningsinvesteringsinput (udenlandsk)"
tDuty_IMF(j,i,tax)  "Produktskatter på maskininvesteringsinput (udenlandsk)"
tDuty_cD(i,tax)     "Produktskatter på forbrugsvarer (indenlandsk)"
tDuty_cF(i,tax)     "Produktskatter på forbrugsvarer (udenlandsk)"
tDuty_ExD(i,tax)    "Produktskatter på eksportvarer (indenlandsk)"
tDuty_ExF(i,tax)    "Produktskatter på eksportsvarer (udenlandsk)"
tDuty_ILD(i,tax)    "Produktskatter på lagerinvesteringer (indenlandsk)"
tDuty_ILF(i,tax)    "Produktskatter på lagerinvesteringer (udenlandsk)"
tDuty_GD(i,tax)     "Produktskatter på off forbrug (indenlandsk)"
tDuty_GF(i,tax)     "Produktskatter på off forbrug (udenlandsk)"
tDuty_xD0(j,i,tax)  "Produktskatter på materialeinput i basisåret (indenlandsk)"
tDuty_xF0(j,i,tax)  "Produktskatter på materialeinput i basisåret (udenlandsk)"
tDuty_IBD0(j,i,tax) "Produktskatter på bygningsinvesteringsinput i basisåret (indenlandsk)"
tDuty_IMD0(j,i,tax) "Produktskatter på maskininvesteringsinput i basisåret (indenlandsk)"
tDuty_IBF0(j,i,tax) "Produktskatter på bygningsinvesteringsinput i basisåret (udenlandsk)"
tDuty_IMF0(j,i,tax) "Produktskatter på maskininvesteringsinput i basisåret (udenlandsk)"
tDuty_cD0(i,tax)    "Produktskatter på forbrugsvarer i basisåret (indenlandsk)"
tDuty_cF0(i,tax)    "Produktskatter på forbrugsvarer i basisåret (udenlandsk)"
tDuty_ExD0(i,tax)   "Produktskatter på eksportvarer i basisåret (indenlandsk)"
tDuty_ExF0(i,tax)   "Produktskatter på eksportsvarer i basisåret (udenlandsk)"
tDuty_ILD0(i,tax)   "Produktskatter på lagerinvesteringer i basisåret (indenlandsk)"
tDuty_ILF0(i,tax)   "Produktskatter på lagerinvesteringer i basisåret (udenlandsk)"
tDuty_GD0(i,tax)    "Produktskatter på off forbrug i basisåret (indenlandsk)"
tDuty_GF0(i,tax)    "Produktskatter på off forbrug i basisåret (udenlandsk)"

tVAT_xD(j,i)   "Moms på materialeinput (indenlandsk)"
tVAT_xF(j,i)   "Moms på materialeinput (udenlandsk)"
tVAT_IBD(j,i)  "Moms på bygningsinvesteringsinput (indenlandsk)"
tVAT_IMD(j,i)  "Moms på maskininvesteringsinput (indenlandsk)"
tVAT_IBF(j,i)  "Moms på bygningsinvesteringsinput (udenlandsk)"
tVAT_IMF(j,i)  "Moms på maskininvesteringsinput (udenlandsk)"
tVAT_cD(i)     "Moms på forbrugsvarer (indenlandsk)"
tVAT_cF(i)     "Moms på forbrugsvarer (udenlandsk)"
tVAT_ILD(i)    "Moms på lagerinvesteringer (indenlandsk)"
tVAT_ILF(i)    "Moms på lagerinvesteringer (udenlandsk)"
tVAT_GD(i)     "Moms på off forbrug (indenlandsk)"
tVAT_GF(i)     "Moms på off forbrug (udenlandsk)"
tVAT_xD0(j,i)  "Moms på materialeinput i basisåret (indenlandsk)"
tVAT_xF0(j,i)  "Moms på materialeinput i basisåret (udenlandsk)"
tVAT_IBD0(j,i) "Moms på bygningsinvesteringsinput i basisåret (indenlandsk)"
tVAT_IMD0(j,i) "Moms på maskininvesteringsinput i basisåret (indenlandsk)"
tVAT_IBF0(j,i) "Moms på bygningsinvesteringsinput i basisåret (udenlandsk)"
tVAT_IMF0(j,i) "Moms på maskininvesteringsinput i basisåret (udenlandsk)"
tVAT_cD0(i)    "Moms på forbrugsvarer i basisåret (indenlandsk)"
tVAT_cF0(i)    "Moms på forbrugsvarer i basisåret (udenlandsk)"
tVAT_ILD0(i)   "Moms på lagerinvesteringer i basisåret (indenlandsk)"
tVAT_ILF0(i)   "Moms på lagerinvesteringer i basisåret (udenlandsk)"
tVAT_GD0(i)    "Moms på off forbrug i basisåret (indenlandsk)"
tVAT_GF0(i)    "Moms på off forbrug i basisåret (udenlandsk)"

tDiff_cD(j) "Forskel på gennemsnitlig og marginal skat på indenlandske forbrugsgoder"
tDiff_cF(j) "Forskel på gennemsnitlig og marginal skat på udenlandske forbrugsgoder"

t_w        "Skat på løn"
t_r        "Skat på kapitalindkomst"
t_cor(j)   "Selskabsskat"

tFak_B(i)   "Produktionsskat på bygningskapital"
tFak_M(i)   "Produktionsskat på maskinkapital"
tFak_w(i)   "Produktionsskat på arbejdskraft"
Fak_rest(i) "Faktorafgift, residual"

EY(j)       "Substitutionselasticitet"
EH(j)       "Substitutionselasticitet"
ELKE(j)     "Substitutionselasticitet"
EKE(j)      "Substitutionselasticitet"
EM(j,dmo)   "Substitutionselasticitet"
EE(j,dmeo)  "Substitutionselasticitet"
Exx(j)      "Substitutionselasticitet"
EIB(j,dibo) "Substitutionselasticitet"
EIM(j,dimo) "Substitutionselasticitet"
EIBI(j)     "Substitutionselasticitet"
EIMI(j)     "Substitutionselasticitet"
EU          "Substitutionselasticitet"
ECC(j)      "Substitutionselasticitet"
ECH(dco)    "Substitutionselasticitet"
EEx(j)      "Substitutionselasticitet"
EG          "Substitutionselasticitet"
EIL(j)      "Substitutionselasticitet"
Elas_hour   "Substitutionselasticitet"

Elas_Ex(j) "Eksportelasticitet"

dummyShare "Dummysektors størrelse relativt til oprindelig qzi-sektor (mellem 0 og 1)"

X0(j)      "Niveau-parameter i eksportrelation"

thetaL(j)  "Arbejdsproduktivitet"
thetaK(j)  "Effektivitetsindeks for maskiner"
thetaB(j)  "Effektivitetsindeks for bygninger"
thetaM(j)  "Effektivitetsindeks for materialer ekskl. energi"
thetaE(j)  "Effektivitetsindeks for energi"
tfp(j)     "TFP"

markup(j)  "Markup"

N_Pop      "Samlet befolkning"
N_LabForce "Arbejdsstyrke"
unemp      "Strukturel arbejdsløshedsprocent"

rateComp   "Kompensationsgrad"

h_bar      "Maksimal arbejdstid"

c_lager(j) "Definerer lagerinvesteringer"
labForceShare "Arbejdsstyrkens andel af den samlede befolkning"
kvote_DP(j) "Virksomhedernes gældskvote"
dummy_ucB(j) "dummy i usercostudtryk for bygninger"
dummy_ucM(j) "dummy i usercostudtryk for maskiner"

share_G(i) "Offentligt forbrugs andel af BNP - fordelt på brancher"
SUBEU(j)   "Subsidier fra EU"
X_h        "Niveau-parameter i arbejdsudbudsligning"
;

*---------------------------------------
group J_LED "J-led. Bruges til at slå ligninger til og fra og til at test modellen"
J_GDP       "Definition af BNP"
J_GDPf0     "Definition af BNP i faste priser"
J_BVT(j)    "Definition af BVT"
J_BVTtot    "Definition af samlet BVT"
J_BVTf0(j)  "Definition af BVT i faste priser"
J_BVTf0tot  "Definition af samlet BVT i faste priser"
J_NVTf0(j)  "Definition af NVT i faste priser"
J_NVTf0tot  "Definition af samlet NVT i faste priser"
J_M(j)      "Efterspørgsel efter materialer for ikke-energi"
J_E(j)      "Efterspørgsel efter materialer for energi"
J_H(j)      "Efterspørgsel efter H-aggregat"
J_LKE(j)    "Efterspørgsel efter LKE-aggregat"
J_KE(j)     "Efterspørgsel efter KE-aggregat"
J_PO(j)     "Nulprofitbetingelse: Bestemmer optimeringspris PO"
J_P(j)      "Markup-prisdannelse"
J_KB(j)     "Efterspørgsel efter KB"
J_KM(j)     "Efterspørgsel efter KM"
J_KBbook(j) "Bygningskapitalapparatets bogførte værdi"
J_KMbook(j) "Maskinkapitalapparatets bogførte værdi"
J_ucB(j)   "Usercost rate for bygninger"
J_ucM(j)   "Usercost rate for maskiner"
J_L(j)      "Efterspørgsel efter L"
J_PH(j)     "Nulprofitbetingelse: Bestemmer prisen PH" 
J_PLKE(j)   "Nulprofitbetingelse: Bestemmer prisen PLKE" 
J_PKE(j)    "Nulprofitbetingelse: Bestemmer prisen PKE" 
J_xmm(j)    "Fastlæggelse af overordnet ikke-energi materialeaggregat"
J_xeme(j)   "Fastlæggelse af overordnet energi materialeaggregat"
J_xm(j,dm,dmo) "Efterspørgsel efter xm"
J_xe(j,dme,dmeo) "Efterspørgsel efter xe"
J_x(j,i)    "Efterspørgsel efter x"
J_PM(j)     "Nulprofitbetingelse: Bestemmer prisen PM" 
J_PE(j)     "Nulprofitbetingelse: Bestemmer prisen PM" 
J_xD(j,i)   "Efterspørgsel efter xD (indenlandske materialer)"
J_xF(j,i)   "Efterspørgsel efter xF (udenlandske materialer)" 
J_Px(j,i)   "Nulprofitbetingelse: Bestemmer prisen Px" 
J_Pxm(j,dmo) "Nulprofitbetingelse: Bestemmer prisen Pxm" 
J_Pxe(j,dmeo)   "Nulprofitbetingelse: Bestemmer prisen Pxe" 
J_Pxm_i(j,dmi) "Bestemmer prisen Pxm for dmi" 
J_Pxe_i(j,dmei) "Bestemmer prisen Pxe for dmei" 
J_InvB(j)   "Efterspørgsel efter Investeringsaggegat for bygninger" 
J_InvM(j)   "Efterspørgsel efter Investeringsaggegat for maskiner" 
J_IBI(j,i)  "Efterspørgsel efter Investeringsinput af bygninger"
J_IBib(j)   "Efterspørgsel efter Investeringsinput af bygninger samlet"
J_IB(j,dib,dibo) "Efterspørgsel efter Investeringsinput af bygninger"
J_IMI(j,i)  "Efterspørgsel efter Investeringsinput af maskiner"
J_IMim(j)   "Efterspørgsel efter Investeringsinput af maskiner samlet"
J_IM(j,dim,dimo) "Efterspørgsel efter Investeringsinput af maskiner"
J_PInvB(j)  "Nulprofitbetingelse: Bestemmer prisen PInvB" 
J_PInvM(j)  "Nulprofitbetingelse: Bestemmer prisen PInvM" 
 
J_IBD(j,i)  "Efterspørgsel efter Investeringsinput af bygninger (indenlandsk)"
J_IMD(j,i)  "Efterspørgsel efter Investeringsinput af maskiner (indenlandsk)"
J_IBF(j,i)  "Efterspørgsel efter Investeringsinput af bygninger (udenlandsk)" 
J_IMF(j,i)  "Efterspørgsel efter Investeringsinput af maskiner (udenlandsk)" 
J_PIBI(j,i) "Nulprofitbetingelse: Bestemmer prisen PIBI"
J_PIB(j,dibo) "Nulprofitbetingelse: Bestemmer prisen PIB for dibo"
J_PIB_i(j,dibi) "Nulprofitbetingelse: Bestemmer prisen PIB for dibi"
J_PIMI(j,i) "Nulprofitbetingelse: Bestemmer prisen PIMI"
J_PIM(j,dimo) "Nulprofitbetingelse: Bestemmer prisen PIM for dimo"
J_PIM_i(j,dimi) "Nulprofitbetingelse: Bestemmer prisen PIM for dimi"

J_IL(j)    "Lagerinvesteringer"
J_ILD(j)   "Lagerinvesteringer fra indenlandsk produktion"
J_ILF(j)   "Lagerinvesteringer fra import"
J_PIL(j)   "Lagerinvesteringernes prisaggregat"

J_DIV(j)   "Dividender"
J_V(j)     "Virksomhedens værdi"
J_DP(j)    "Virksomhedernes gæld"

J_YEmp     "Disponibel indkomst for beskæftigede"
J_YNotEmp  "Disponibel indkomst for ikke-beskæftigede"
J_N_Emp    "Antal beskæftigede"

J_C_Emp    "Beskæftigedes forbrugsefterspørgsel"
J_VV       "Beskæftigedes efterspørgsel efter fritid"
J_PU       "Definition af prisindeks PU"
J_YZ       "Fritidskorrigeret indkomst"
J_hour     "Fritid"


J_C_NotEmp "Ikke-beskæftigedes forbrugsefterspørgsel" 
J_Ctot     "Samlet forbrug"

J_cD(i)    "Forbrugsefterspørgsel fordelt på varer (indenlandsk)"
J_cF(i)    "Forbrugsefterspørgsel fordelt på varer (udenlandsk)"
J_PC(i)    "Definition af forbrugerprisindeks Pc"
J_PCH(dco) "Definition af forbrugerprisindeks PCH"
J_PCH_i(dci) "Definition af forbrugerprisindeks PCH"


J_CHc
J_CH(dc,dco)
J_C(i)

J_Wealth   "Forbrugernes formue"
J_Ex(j)    "Eksport inkl. import til reeksport"
J_ExD(j)   "Eksport ekskl. import til reeksport"
J_ExF(j)   "Import til reeksport"
J_P_Ex(j)  "Eksportpris inkl. import til reeksport"
J_PSaldo   "Offentlig primær saldo"
J_DG       "Offentlig gæld"

J_Trans    "Satsregulering"

J_w        "Ligevægt på arbejdsmarkedet"
J_Y(j)     "Ligevægt på varemarkedet"

J_GD(j)    "Forbrug af indenlandsk producerede offentlige goder"
J_GF(j)    "Forbrug af udenlandsk producerede offentlige goder"  
J_PG(j)    "Prisaggregat for offentlige goder"

J_DP(j)    "Virksomhedernes gæld"

J_P_udl(j) "udlands pris"
J_Ktot     "samlet kapitalapparat"

J_tMarg_cD(j) "Marginal skat på indenlandske forbrugsgoder"
J_tMarg_cF(j) "Marginal skat på udenlandske forbrugsgoder"

J_BoP      "Betalingsbalance - skal være nul!"

J_Ltot     "Summen af branchernes arbejdskraftsaggregater"

J_G(i)     "Offentligt forbrug"

J_TaxEU    "Nettoskatter til EU"
J_UTILITY  "Nytte"
J_hourMUL  "Arbejdsudbudsligning ved multiplikativ nyttefunktion"
;

parameters 
d1xm(j,dm),
d1xe(j,dme),
d1IM(j,dim),
d1IB(j,dib),
d1IMI(j,i),
d1IBI(j,i),
d1x(j,i),
d1Ex(i),
d1IL(j),
d1G(i),
d1C(i),
d1CH(dc),
d1KE(j),
d1L(j),
d1Lv(j)
Besk(j);

*------------------------------------------------------------
* Ligninger
*------------------------------------------------------------
* Definitioner
E_Ktot..      Ktot =e= J_Ktot + sum(j,KM(j)+KB(j)); 

E_GDP..     GDP =e= J_GDP + sum(j, p(j)*Y(j)) - sum(j,sum(i, p(i)*xD(j,i) + PF(i)*xF(j,i)))
                          + sum(i, ((1+tVAT_CD(i))*(p(i)+sum(taxd,tDuty_CD(i,taxd)))-p(i))*cD(i) + ((1+tVAT_CF(i))*(pF(i)+sum(taxd,tDuty_CF(i,taxd)))*(1+tCus_C(i))-pF(i))*cF(i))
                          + sum(i, ((1+tVAT_GD(i))*(p(i)+sum(taxd,tDuty_GD(i,taxd)))-p(i))*gD(i) + ((1+tVAT_GF(i))*(pF(i)+sum(taxd,tDuty_GF(i,taxd)))*(1+tCus_G(i))-pF(i))*gF(i))
                          + sum(i, ((1+tVAT_ILD(i))*(p(i)+sum(taxd,tDuty_ILD(i,taxd)))-p(i))*ILD(i) + ((1+tVAT_ILF(i))*(pF(i)+sum(taxd,tDuty_ILF(i,taxd)))*(1+tCus_IL(i))-pF(i))*ILF(i))
                          + sum(i, ((p(i)+sum(taxd,tDuty_ExD(i,taxd)))-p(i))*ExD(i) + ((pF(i)+sum(taxd,tDuty_ExF(i,taxd)))*(1+tCus_Ex(i))-pF(i))*ExF(i))   
                          + sum(j, sum(i, ((1+tVAT_IMD(j,i))*(p(i)+sum(taxd,tDuty_IMD(j,i,taxd)))-p(i))*IMID(j,i) + ((1+tVAT_IMF(j,i))*(pF(i)+sum(taxd,tDuty_IMF(j,i,taxd)))*(1+tCus_IM(j,i))-pF(i))*IMIF(j,i)))
                          + sum(j, sum(i, ((1+tVAT_IBD(j,i))*(p(i)+sum(taxd,tDuty_IBD(j,i,taxd)))-p(i))*IBID(j,i) + ((1+tVAT_IBF(j,i))*(pF(i)+sum(taxd,tDuty_IBF(j,i,taxd)))*(1+tCus_IB(j,i))-pF(i))*IBIF(j,i)));
                                                   

* Fastbase BNP (Det er vækstkorrigeret - andet giver ikke mening, når vi mangler tidsdimension) (Når vi ikke har nogen tidsdimension er kædede værdier og fastbase-værdier sammenfaldende)(EV-mål)
E_GDPf0..     GDPf0 =e= J_GDPf0 + sum(j, p0(j)*Y(j)) - sum(j,sum(i, p0(i)*xD(j,i) + PF0(i)*xF(j,i)))
                          + sum(i, ((1+tVAT_CD0(i))*(p0(i)+sum(taxd,tDuty_CD0(i,taxd)))-1)*cD(i) + ((1+tVAT_CF0(i))*(pF0(i)+sum(taxd,tDuty_CF0(i,taxd)))*(1+tCus_C0(i))-1)*cF(i))
                          + sum(i, ((1+tVAT_GD0(i))*(p0(i)+sum(taxd,tDuty_GD0(i,taxd)))-1)*gD(i) + ((1+tVAT_GF0(i))*(pF0(i)+sum(taxd,tDuty_GF0(i,taxd)))*(1+tCus_G0(i))-1)*gF(i))
                          + sum(i, ((1+tVAT_ILD0(i))*(p0(i)+sum(taxd,tDuty_ILD0(i,taxd)))-1)*ILD(i) + ((1+tVAT_ILF0(i))*(pF0(i)+sum(taxd,tDuty_ILF0(i,taxd)))*(1+tCus_IL0(i))-1)*ILF(i))
                          + sum(i, ((p0(i)+sum(taxd,tDuty_ExD0(i,taxd)))-1)*ExD(i) + ((pF0(i)+sum(taxd,tDuty_ExF0(i,taxd)))*(1+tCus_Ex0(i))-1)*ExF(i))   
                          + sum(j, sum(i, ((1+tVAT_IMD0(j,i))*(p0(i)+sum(taxd,tDuty_IMD0(j,i,taxd)))-1)*IMID(j,i) + ((1+tVAT_IMF0(j,i))*(pF0(i)+sum(taxd,tDuty_IMF0(j,i,taxd)))*(1+tCus_IM0(j,i))-1)*IMIF(j,i)))
                          + sum(j, sum(i, ((1+tVAT_IBD0(j,i))*(p0(i)+sum(taxd,tDuty_IBD0(j,i,taxd)))-1)*IBID(j,i) + ((1+tVAT_IBF0(j,i))*(pF0(i)+sum(taxd,tDuty_IBF0(j,i,taxd)))*(1+tCus_IB0(j,i))-1)*IBIF(j,i)));

* Definitioner
E_BVT(j)..    BVT(j) =e= J_BVT(j) + p(j)*Y(j) - sum(i, (1+tVAT_xD(j,i))*(p(i)+sum(taxd,tDuty_xD(j,i,taxd)))*xD(j,i) + (1+tVAT_xF(j,i))*(1+tCus_x(j,i))*(PF(i)+sum(taxd,tDuty_xF(j,i,taxd)))*xF(j,i)); 
E_BVTtot..    BVTtot =e= J_BVTtot + sum(j,BVT(j)); 
E_BVTf0(j)..  BVTf0(j) =e= J_BVTf0(j) + p0(j)*Y(j) - sum(i, (1+tVAT_xD0(j,i))*(p0(i)+sum(taxd,tDuty_xD0(j,i,taxd)))*xD(j,i) 
                                                          + (1+tVAT_xF0(j,i))*(1+tCus_x0(j,i))*(PF0(i)+sum(taxd,tDuty_xF0(j,i,taxd)))*xF(j,i)); 
E_BVTf0tot..  BVTf0tot =e= J_BVTf0tot + sum(j,BVTf0(j)); 
E_NVTf0(j)..  NVTf0(j) =e= J_NVTf0(j) + p0(j)*Y(j) - sum(i, (1+tVAT_xD0(j,i))*(p0(i)+sum(taxd,tDuty_xD0(j,i,taxd)))*xD(j,i)
                                                          + (1+tVAT_xF0(j,i))*(1+tCus_x0(j,i))*(PF0(i)+sum(taxd,tDuty_xF0(j,i,taxd)))*xF(j,i)) 
                                                          -(deltaKB(j)*PInvB0(j)*KB(j)+deltaKM(j)*PInvM0(j)*KM(j))/(1+grow); 
E_NVTf0tot..  NVTf0tot =e= J_NVTf0tot + sum(j,NVTf0(j)); 

* Virksomhederne
* Øverste aggregater
E_M(j) $ d1xm(j,'m')..      thetaM(j)*M(j) =e= J_M(j) + m_YM(j) * (@pos((PM(j)/(thetaM(j)*PO(j)))))**(-EY(j))*Y(j);

E_H(j)..      H(j) =e= J_H(j) + m_YH(j) * (PH(j)/(PO(j)))**(-EY(j))*Y(j);

E_PO(j)..     PO(j)*Y(j) =e= J_PO(j) + PM(j)*M(j) + PH(j)*H(j);

E_P(j)..      P(j) =e= J_P(j) + (1 + markup(j))*PO(j);

E_KB(j)..     tfp(j)*thetaB(j)*KB(j)/(1+grow) =e= J_KB(j) + m_HB(j) * (((1+tFak_B(j))*ucB(j)*PInvB(j))/(tfp(j)*thetaB(j)*PH(j)))**(-EH(j))*H(j);
             
E_LKE(j)..    LKE(j) =e= J_LKE(j) + m_HLKE(j) * (PLKE(j)/PH(j))**(-EH(j))*H(j);

E_ucB(j)..    ucB(j) =e= J_ucB(j) + dummy_ucB(j) + 1/(1-t_cor(j))*(r+deltaKB(j)-t_cor(j)*kvote_DP(j)*(r+infl/(1+infl))-t_cor(j)*deltaKBBook(j)/(1+infl)*(r+deltaKB(j))/(r+infl/(1+infl)+deltaKBBook(j)/(1+infl)));

E_PH(j)..     PH(j)*H(j) =e= J_PH(j) + pLKE(j)*LKE(j) + (1+tFak_B(j))*ucB(j)*PInvB(j)*KB(j)/(1+grow);

E_L(j)..      tfp(j)*thetaL(j)*L(j) =e= J_L(j) + m_LKEL(j) * (((1+tFak_w(j))*w)/ (tfp(j)*thetaL(j)*PLKE(j)))**(-ELKE(j))*LKE(j);

E_Ltot..      Ltot =e= J_Ltot + sum(j, L(j));

E_KE(j)..     KE(j) =e= J_KE(j) + m_LKEKE(j) * (PKE(j)/PLKE(j))**(-ELKE(j))*LKE(j);

E_PLKE(j)..   PLKE(j)*LKE(j) =e= J_PLKE(j) + (1+tFak_w(j))*w*L(j) + PKE(j)*KE(j);

E_KM(j)..     tfp(j)*thetaK(j)*KM(j)/(1+grow) =e= J_KM(j) + m_KEK(j) * (((1+tFak_M(j))*ucM(j)*PInvM(j))/(tfp(j)*thetaK(j)*PKE(j)))**(-EKE(j))*KE(j);

E_E(j) $ d1xe(j,'me')..      thetaE(j)*E(j) =e= J_E(j) + m_KEE(j) * (PE(j)/(thetaE(j)*PKE(j)))**(-EKE(j))*KE(j);

E_ucM(j)..    ucM(j) =e= J_ucM(j) + dummy_ucM(j) + 1/(1-t_cor(j))*(r+deltaKM(j)-t_cor(j)*kvote_DP(j)*(r+infl/(1+infl))-t_cor(j)*deltaKMBook(j)/(1+infl)*(r+deltaKM(j))/(r+infl/(1+infl)+deltaKMBook(j)/(1+infl)));

E_PKE(j) $ d1KE(j)..    PKE(j)*KE(j) =e= J_PKE(j) + ((1+tFak_M(j))*ucM(j)*PInvM(j)*KM(j))/(1+grow) + PE(j)*E(j);

* Disaggregeret materialeforbrug
E_xmm(j) $ d1xm(j,'m')..    xm(j,'m') =e= J_xmm(j) + M(j);

E_xm(j,dm,dmo) $ (mapdm2dmo(dmo,dm) AND d1xm(j,dm))..  xm(j,dm) =e=  J_xm(j,dm,dmo) + m_xm(j,dm) * (@pos((Pxm(j,dm)/Pxm(j,dmo))))**(-EM(j,dmo))*xm(j,dmo);

E_Pxm(j,dmo) $ d1xm(j,dmo).. Pxm(j,dmo)*xm(j,dmo) =e= j_Pxm(j,dmo) + sum(dm $ mapdm2dmo(dmo,dm), Pxm(j,dm)*xm(j,dm));

E_Pxm_i(j,dmi) $ d1xm(j,dmi).. Pxm(j,dmi) =e= j_Pxm_i(j,dmi) + sum(i $ mapdm2i(i,dmi), Px(j,i));

E_PM(j)$ d1xm(j,'m')..     PM(j)*M(j) =e= J_PM(j) + sum(dmi, Pxm(j,dmi)*xm(j,dmi));

E_xeme(j) $ d1xe(j,'me')..   xe(j,'me') =e= J_xeme(j) + E(j);

E_xe(j,dme,dmeo) $ (mapdme2dmeo(dmeo,dme) AND d1xe(j,dme))..  xe(j,dme) =e=  J_xe(j,dme,dmeo) + m_xe(j,dme) * (@pos((Pxe(j,dme)/Pxe(j,dmeo))))**(-EE(j,dmeo))*xe(j,dmeo);

E_Pxe(j,dmeo) $ d1xe(j,dmeo).. Pxe(j,dmeo)*xe(j,dmeo) =e= j_Pxe(j,dmeo) + sum(dme $ mapdme2dmeo(dmeo,dme), Pxe(j,dme)*xe(j,dme));

E_Pxe_i(j,dmei) $ d1xe(j,dmei).. Pxe(j,dmei) =e= j_Pxe_i(j,dmei) + sum(i $ mapdme2i(i,dmei), Px(j,i));

E_PE(j) $ d1xe(j,'me')..     PE(j)*E(j) =e= J_PE(j) + sum(dmei, Pxe(j,dmei)*xe(j,dmei));

E_x(j,i) $ d1x(j,i)..    x(j,i) =e= J_x(j,i) + sum(dmi $ mapdm2i(i,dmi), xm(j,dmi)) + sum(dmei $ mapdme2i(i,dmei), xe(j,dmei));

E_xD(j,i) $ d1x(j,i)..   xD(j,i) =e= J_xD(j,i) + m_xD(j,i) * (@Pos(((1+tVAT_xD(j,i))*(P(i)+sum(taxd,tDuty_xD(j,i,taxd)))/Px(j,i))))**(-Exx(j)) * x(j,i);

E_xF(j,i) $ d1x(j,i)..   xF(j,i) =e= J_xF(j,i) + m_xF(j,i) * (@Pos(((1+tVAT_xF(j,i))*(PF(i)+sum(taxd,tDuty_xF(j,i,taxd)))*(1+tCus_x(j,i))/Px(j,i))))**(-Exx(j)) * x(j,i);

E_Px(j,i) $ d1x(j,i)..   Px(j,i)*x(j,i) =e= J_Px(j,i) + (1+tVAT_xD(j,i))*(P(i)+sum(taxd,tDuty_xD(j,i,taxd)))*xD(j,i) + (1+tVAT_xF(j,i))*(PF(i)+sum(taxd,tDuty_xF(j,i,taxd)))*(1+tCus_x(j,i))*xF(j,i);

* Maskininvesteringer
E_InvM(j) $ d1IM(j,'im')..   InvM(j) =e= J_InvM(j) + (grow + deltaKM(j))*KM(j)/(1+grow);

E_IMim(j) $ d1IM(j,'im')..   IM(j,'im') =e= J_IMim(j) + InvM(j);

E_IM(j,dim,dimo) $ (mapdim2dimo(dimo,dim) AND d1IM(j,dim))..  IM(j,dim) =e=  J_IM(j,dim,dimo) + m_IM(j,dim) * (@pos((PIM(j,dim)/PIM(j,dimo))))**(-EIM(j,dimo))*IM(j,dimo);

E_PIM(j,dimo) $ d1IM(j,dimo).. PIM(j,dimo)*IM(j,dimo) =e= j_PIM(j,dimo) + sum(dim $ mapdim2dimo(dimo,dim), PIM(j,dim)*IM(j,dim));

E_PIM_i(j,dimi) $ d1IM(j,dimi).. PIM(j,dimi) =e= j_PIM_i(j,dimi) + sum(i $ mapdim2i(i,dimi), PIMI(j,i));

E_PInvM(j) $ d1IM(j,'im')..  PInvM(j)*InvM(j) =e= J_PInvM(j) + sum(dimi, PIM(j,dimi)*IM(j,dimi));

E_IMI(j,i) $ d1IMI(j,i)..  IMI(j,i) =e= J_IMI(j,i) + sum(dimi $ mapdim2i(i,dimi), IM(j,dimi));

E_IMD(j,i) $ d1IMI(j,i)..  IMID(j,i) =e= J_IMD(j,i) + m_IMD(j,i) * (@pos(((1+tVAT_IMD(j,i))*(P(i)+sum(taxd,tDuty_IMD(j,i,taxd)))/PIMI(j,i))))**(-EIMI(j)) * IMI(j,i);

E_IMF(j,i) $ d1IMI(j,i)..  IMIF(j,i) =e= J_IMF(j,i) + m_IMF(j,i) * (@pos(((1+tVAT_IMF(j,i))*(1+tCus_IM(j,i))*(PF(i)+sum(taxd,tDuty_IMF(j,i,taxd)))/PIMI(j,i))))**(-EIMI(j)) * IMI(j,i);
                                                                         
E_PIMI(j,i) $ d1IMI(j,i).. PIMI(j,i)*IMI(j,i) =e= J_PIMI(j,i) + (1+tVAT_IMD(j,i))*(P(i)+sum(taxd,tDuty_IMD(j,i,taxd)))*IMID(j,i) + (1+tVAT_IMF(j,i))*(1+tCus_IM(j,i))*(PF(i)+sum(taxd,tDuty_IMF(j,i,taxd)))*IMIF(j,i);

* Bygningsinvesteringer
E_InvB(j) $ d1IB(j,'ib')..      InvB(j) =e= J_InvB(j) + (grow + deltaKB(j))*KB(j)/(1+grow);

E_IBib(j) $ d1IB(j,'ib')..   IB(j,'ib') =e= J_IBib(j) + InvB(j);

E_IB(j,dib,dibo) $ (mapdib2dibo(dibo,dib) AND d1IB(j,dib))..  IB(j,dib) =e=  J_IB(j,dib,dibo) + m_IB(j,dib) * (@pos((PIB(j,dib)/PIB(j,dibo))))**(-EIB(j,dibo))*IB(j,dibo);

E_PIB(j,dibo) $ d1IB(j,dibo).. PIB(j,dibo)*IB(j,dibo) =e= j_PIB(j,dibo) + sum(dib $ mapdib2dibo(dibo,dib), PIB(j,dib)*IB(j,dib));

E_PIB_i(j,dibi) $ d1IB(j,dibi)..  PIB(j,dibi) =e= j_PIB_i(j,dibi) + sum(i $ mapdib2i(i,dibi), PIBI(j,i));

E_PInvB(j) $ d1IB(j,'ib')..  PInvB(j)*InvB(j) =e= J_PInvB(j) + sum(dibi, PIB(j,dibi)*IB(j,dibi));

E_IBI(j,i) $ d1IBI(j,i)..    IBI(j,i) =e= J_IBI(j,i) + sum(dibi $ mapdib2i(i,dibi), IB(j,dibi));

E_IBD(j,i) $ d1IBI(j,i)..   IBID(j,i) =e= J_IBD(j,i) + m_IBD(j,i) * (@pos(((1+tVAT_IBD(j,i))*(P(i)+sum(taxd,tDuty_IBD(j,i,taxd)))/PIBI(j,i))))**(-EIBI(j)) * IBI(j,i);
                                                                         
E_IBF(j,i) $ d1IBI(j,i)..   IBIF(j,i) =e= J_IBF(j,i) + m_IBF(j,i) * (@pos(((1+tVAT_IBF(j,i))*(1+tCus_IB(j,i))*(PF(i)+sum(taxd,tDuty_IBF(j,i,taxd)))/PIBI(j,i))))**(-EIBI(j)) * IBI(j,i);
                                                                         
E_PIBI(j,i) $ d1IBI(j,i).. PIBI(j,i)*IBI(j,i) =e= J_PIBI(j,i) + (1+tVAT_IBD(j,i))*(P(i)+sum(taxd,tDuty_IBD(j,i,taxd)))*IBID(j,i) + (1+tVAT_IBF(j,i))*(1+tCus_IB(j,i))*(PF(i)+sum(taxd,tDuty_IBF(j,i,taxd)))*IBIF(j,i);

* Virksomhedernes gæld, bogførte kapitalbeholdning, dividender og værdi
E_DP(j)..     DP(j) =e= J_DP(j) + kvote_DP(j) * (PInvB(j) * KB(j) + PInvM(j) * KM(j));

E_KMbook(j).. (grow+infl/(1+infl)+deltaKMBook(j)/(1+infl))*KMbook(j)/(1+grow) =e= J_KMbook(j) + PInvM(j)*InvM(j);

E_KBbook(j).. (grow+infl/(1+infl)+deltaKBBook(j)/(1+infl))*KBbook(j)/(1+grow) =e= J_KBbook(j) + PInvB(j)*InvB(j);

E_DIV(j)..    DIV(j) =e= J_DIV(j) + (1-t_cor(j))*(p(j)*Y(j) - PM(j)*M(j) - PE(j)*E(j) - (1+tFak_w(j))*w*L(j) - tFak_B(j)*ucB(j)*PInvB(j)*KB(j)/(1+grow) - tFak_M(j)*ucM(j)*PInvM(j)*KM(j)/(1+grow) - Fak_rest(j)
                                  - (r*(1+infl)+infl)*DP(j)/((1+infl)*(1+grow))) - PInvB(j)*InvB(j) - PInvM(j)*InvM(j) - PIL(j)*IL(j) 
                                  - SUBEU(j) 
                                  + t_cor(j)*(deltaKBBook(j)*KBBook(j)+deltaKMBook(j)*KMBook(j))/((1+grow)*(1+infl)) + (1-1/((1+grow)*(1+infl)))*DP(j);

E_V(j)..           V(j)/(1+grow) =e= J_V(j) + DIV(j)/(r-grow);     

* Lagerinvesteringer
E_IL(j) $ d1IL(j)..        IL(j) =e= J_IL(j) + c_lager(j)*Y(j);

E_ILD(i) $ d1IL(i)..      ILD(i) =e= J_ILD(i) + m_ILD(i) * (@pos(((1+tVAT_ILD(i))*(p(i)+sum(taxd,tDuty_ILD(i,taxd)))/PIL(i))))**(-EIL(i)) * IL(i);
                                                               
E_ILF(i) $ d1IL(i)..      ILF(i) =e= J_ILF(i) + m_ILF(i) * (@pos(((1+tVAT_ILF(i))*(1+tCus_IL(i))*(PF(i)+sum(taxd,tDuty_ILF(i,taxd)))/PIL(i))))**(-EIL(i)) * IL(i);
                                                                 
E_PIL(i) $ d1IL(i)..    PIL(i)*IL(i) =e= J_PIL(i) + (1+tVAT_ILD(i))*(p(i)+sum(taxd,tDuty_ILD(i,taxd)))*ILD(i) + (1+tVAT_ILF(i))*(1+tCus_IL(i))*(PF(i)+sum(taxd,tDuty_ILF(i,taxd)))*ILF(i);

* Husholdningerne
E_YEmp..       J_YEmp =e= (YEmp - ((1 - t_w)*w*hour*N_Emp + (1 - t_r)*N_Emp*((r-grow)*Wealth/(1+grow))/N_Pop + lumpsum*N_Emp
                          + sum(i,(tMarg_cD(i)-((1+tVAT_cD(i))*(p(i)+sum(taxd,tDuty_cD(i,taxd)))-p(i)))*cD(i) + (tMarg_cF(i)-((1+tVAT_cF(i))*(PF(i)+sum(taxd,tDuty_cF(i,taxd)))*(1+tCus_c(i))-pF(i)))*cF(i))*N_Emp/N_Pop))$(%NAF%)
                          + 
                         (YEmp - ((1 - t_w)*w*hour*N_Emp + (1 - t_r)*N_Emp*((r-grow)*Wealth/(1+grow))/N_Pop + lumpsum*N_Emp))$(%NOTNAF%);

E_YNotEmp.. J_YNotEmp =e= (YNotEmp - ((1 - t_w)*rateComp*w*(N_LabForce-N_Emp) + (1 - t_r)*(N_Pop-N_Emp)*((r-grow)*Wealth/(1+grow))/N_Pop + (1-t_w)*Trans+lumpsum*(N_Pop-N_Emp)
                           + sum(i,(tMarg_cD(i)-((1+tVAT_cD(i))*(p(i)+sum(taxd,tDuty_cD(i,taxd)))-p(i)))*cD(i) + (tMarg_cF(i)-((1+tVAT_cF(i))*(PF(i)+sum(taxd,tDuty_cF(i,taxd)))*(1+tCus_c(i))-pF(i)))*cF(i))*(N_Pop-N_Emp)/N_Pop))$(%NAF%)                 
                          +  
                         (YNotEmp - ((1 - t_w)*rateComp*w*(N_LabForce-N_Emp) + (1 - t_r)*(N_Pop-N_Emp)*((r-grow)*Wealth/(1+grow))/N_Pop + (1-t_w)*Trans+lumpsum*(N_Pop-N_Emp)))$(%NOTNAF%);

E_YZ..           J_YZ =e=   (YZ - ((1 - t_w)*w*hour*N_Emp + (1 - t_r)*N_Emp*((r-grow)*Wealth/(1+grow))/N_Pop + lumpsum*N_Emp
                            + sum(i,(tMarg_cD(i)-(1+tVAT_cD(i))*(p(i)+sum(taxd,tDuty_cD(i,taxd)))-p(i))*cD(i) + (tMarg_cF(i)-(1+tVAT_cF(i))*(PF(i)+sum(taxd,tDuty_cF(i,taxd)))*(1+tCus_c(i))-pF(i))*cF(i))*N_Emp/N_Pop))$(%NAF% and %NYTMUL%)                       
                            +
                            (YZ - ((1 - t_w)*w*hour*N_Emp + (1 - t_r)*N_Emp*((r-grow)*Wealth/(1+grow))/N_Pop + lumpsum*N_Emp))$(%NOTNAF% and %NYTMUL%);
                                          
E_N_Emp..       N_Emp =e= J_N_Emp + (1 - unemp) * N_LabForce;


E_C_Emp..     J_C_Emp =e= (C_Emp - YEmp /PCH('c'))$(%NYTADD%) + (C_Emp - m_UC * ((PU*PU)/(PCH('c')*PCH('c')))**(EU/2) * YZ / PU)$(%NYTMUL%);

*------------------------------------------------------------------------------------
*Ligning til version med multiplikativ nyttefunktion
E_hourMUL..      VV =e= J_hourMUL + (h_bar - hour) * N_Emp;
*Ligning til version med multiplikativ nyttefunktion
E_VV..           VV =e= J_VV + m_UV * ((PU*PU)/((1-t_w)*w*(1-t_w)*w))**(EU/2) * YZ / PU;
*Ligning til version med multiplikativ nyttefunktion
E_PU..           YZ =e= J_PU + PCH('c')*C_Emp + (1-t_w)*w*VV;
*------------------------------------------------------------------------------------

E_hour..          hour =e= J_hour + X_h*( (1 - t_w)*( w/PCH('c') ) )**(Elas_hour)*h_bar;

E_C_NotEmp..  C_NotEmp =e= J_C_NotEmp + YNotEmp / PCH('c');

E_CTot..          CTot =e= J_Ctot + C_Emp + C_NotEmp;

E_CHc..        CH('c') =e= J_CHc + CTot;

E_CH(dc,dco) $ (mapdc2dco(dco,dc) AND d1CH(dc)).. 
                CH(dc) =e= J_CH(dc,dco) + m_CH(dc)*(@pos((PCH(dc)/PCH(dco))))**(-ECH(dco))*CH(dco);

E_C(i) $ d1C(i)..                     C(i) =e= J_C(i) + sum(dc $ mapdc2i(i,dc), CH(dc));

E_PCH(dco) $ d1CH(dco)..  PCH(dco)*CH(dco) =e= j_PCH(dco) + sum(dc $ mapdc2dco(dco,dc), PCH(dc)*CH(dc));

E_PCH_i(dci) $ d1CH(dci)..        PCH(dci) =e= j_PCH_i(dci) + sum(i $ mapdc2i(i,dci), PC(i));

E_CD(i) $ d1C(i)..     J_CD(i) =e= (CD(i) - m_CD(i) * (@pos(((1+tMarg_CD(i))*p(i)/PC(i))))**(-ECC(i)) * C(i))$(%NAF%)
                                   +
                                   (CD(i) - m_CD(i) * (@pos(((1+tVAT_cD(i))*(p(i) + sum(taxd,tDuty_cD(i,taxd)))/PC(i))))**(-ECC(i)) * C(i))$(%NOTNAF%);
                                                               
E_CF(i) $ d1C(i)..     J_CF(i) =e= (CF(i) - m_CF(i) * (@pos(((1+tMarg_CF(i))*PF(i)/PC(i))))**(-ECC(i)) * C(i))$(%NAF%)
                                   +
                                   (CF(i) - m_CF(i) * (@pos(((1+tVAT_cF(i))*(1 + tCus_c(i))*(PF(i) + sum(taxd,tDuty_cF(i,taxd)))/PC(i))))**(-ECC(i)) * C(i))$(%NOTNAF%);
                                                                 
E_PC(i) $ d1C(i)..     J_PC(i) =e= (PC(i)*C(i) - ((1+tMarg_CD(i))*P(i)*CD(i) + (1+tMarg_CF(i))*PF(i)*CF(i)))$(%NAF%)
                                   +
                                   (PC(i)*C(i) - ((1+tVAT_cD(i))*(P(i) + sum(taxd,tDuty_cD(i,taxd)))*CD(i) + (1+tVAT_cF(i))*(1 + tCus_c(i))*(PF(i) + sum(taxd,tDuty_cF(i,taxd)))*CF(i)))$(%NOTNAF%);

E_tMarg_cD(j)..    tMarg_cD(j) =e= J_tMarg_cD(j) + (1+ tVAT_cD(j))*(p(j) + sum(taxd,tDuty_cD(j,taxd)))-p(j) - tDiff_cD(j);
E_tMarg_cF(j)..    tMarg_cF(j) =e= J_tMarg_cF(j) + (1+ tVAT_cF(j))*(1+ tCus_c(j))*(pF(j) + sum(taxd,tDuty_cF(j,taxd)))-pF(j) - tDiff_cF(j);

E_P_udl(j)..          P_udl(j) =e= J_P_udl(j) + (p(j)+sum(taxd,tDuty_ExD(j,taxd)));

*-------------------------------------------------
E_Wealth..               Wealth =e= J_Wealth + Wealth_F + sum(j,share_D(j) * V(j) );

* Udland
E_Ex(i) $ d1Ex(i)..       Ex(i) =e= J_Ex(i) + X0(i) * (p(i)/PF(i))**(-Elas_Ex(i));

E_ExD(i) $ d1Ex(i)..     ExD(i) =e= J_ExD(i) + m_ExD(i) * (@pos((p(i)+sum(taxd,tDuty_ExD(i,taxd)))/P_Ex(i)))**(-EEx(i)) * Ex(i);

E_ExF(i) $ d1Ex(i)..     ExF(i) =e= J_ExF(i) + m_ExF(i) * (@pos((1+tCus_Ex(i))*(PF(i)+sum(taxd,tDuty_ExF(i,taxd)))/P_Ex(i)))**(-EEx(i)) * Ex(i);

E_P_Ex(i) $ d1Ex(i)..  P_Ex(i)*Ex(i) =e= J_P_Ex(i) + (p(i)+sum(taxd,tDuty_ExD(i,taxd)))*ExD(i) + (1+tCus_Ex(i))*(PF(i)+sum(taxd,tDuty_ExF(i,taxd)))*ExF(i);

* Offentlig sektor
E_PSaldo..   PSaldo =e=  J_PSaldo 
                          + sum(j, sum(i, ((1+tVAT_xD(j,i))*(p(i)+sum(taxd,tDuty_xD(j,i,taxd)))-p(i))*xD(j,i) + ((1+tVAT_xF(j,i))*(pF(i)+sum(taxd,tDuty_xF(j,i,taxd)))*(1+tCus_x(j,i))-pF(i))*xF(j,i)))
                          + sum(i, ((1+tVAT_CD(i))*(p(i)+sum(taxd,tDuty_CD(i,taxd)))-p(i))*cD(i) + ((1+tVAT_CF(i))*(pF(i)+sum(taxd,tDuty_CF(i,taxd)))*(1+tCus_C(i))-pF(i))*cF(i))
                          + sum(i, ((1+tVAT_GD(i))*(p(i)+sum(taxd,tDuty_GD(i,taxd)))-p(i))*gD(i) + ((1+tVAT_GF(i))*(pF(i)+sum(taxd,tDuty_GF(i,taxd)))*(1+tCus_G(i))-pF(i))*gF(i))
                          + sum(i, ((1+tVAT_ILD(i))*(p(i)+sum(taxd,tDuty_ILD(i,taxd)))-p(i))*ILD(i) + ((1+tVAT_ILF(i))*(pF(i)+sum(taxd,tDuty_ILF(i,taxd)))*(1+tCus_IL(i))-pF(i))*ILF(i))
                          + sum(i, ((p(i)+sum(taxd,tDuty_ExD(i,taxd)))-p(i))*ExD(i) + ((pF(i)+sum(taxd,tDuty_ExF(i,taxd)))*(1+tCus_Ex(i))-pF(i))*ExF(i))   
                          + sum(j, sum(i, ((1+tVAT_IMD(j,i))*(p(i)+sum(taxd,tDuty_IMD(j,i,taxd)))-p(i))*IMID(j,i) + ((1+tVAT_IMF(j,i))*(pF(i)+sum(taxd,tDuty_IMF(j,i,taxd)))*(1+tCus_IM(j,i))-pF(i))*IMIF(j,i)))
                          + sum(j, sum(i, ((1+tVAT_IBD(j,i))*(p(i)+sum(taxd,tDuty_IBD(j,i,taxd)))-p(i))*IBID(j,i) + ((1+tVAT_IBF(j,i))*(pF(i)+sum(taxd,tDuty_IBF(j,i,taxd)))*(1+tCus_IB(j,i))-pF(i))*IBIF(j,i)))
                         + t_w * (w*hour*N_Emp + (N_LabForce-N_Emp)*rateComp*w + Trans)
                         + t_r * (r-grow) * Wealth/(1+grow)
                         + sum(j, t_cor(j)*(p(j)*Y(j) - PM(j)*M(j)- PE(j)*E(j) - (1+tFak_w(j))*w*L(j) - tFak_B(j)*ucB(j)*PInvB(j)*KB(j)/(1+grow) - tFak_M(j)*ucM(j)*PInvM(j)*KM(j)/(1+grow) 
                                       - Fak_rest(j) - (r*(1+infl)+infl)*DP(j)/((1+infl)*(1+grow)) - (deltaKBBook(j)*KBBook(j)+deltaKMBook(j)*KMBook(j))/((1+grow)*(1+infl)) ))
                         - Trans - sum(j, PG(j)*g(j)) -(N_LabForce-N_Emp)*rateComp*w
                         - lumpsum*N_Pop
                         + sum(j, tFak_w(j)*w*L(j) + tFak_B(j)*ucB(j)*PInvB(j)*KB(j)/(1+grow) + tFak_M(j)*ucM(j)*PInvM(j)*KM(j)/(1+grow) + Fak_rest(j))                         
* Fratrækker told da dette går til EU og ikke staten
                         -(sum(i,sum(j,tCus_x(j,i)*PF(i)*xF(j,i))) 
                         + sum(i,sum(j,tCus_IM(j,i)*PF(i)*IMIF(j,i)+ tCus_IB(j,i)*PF(i)*IBIF(j,i)))
                         + sum(i,tCus_c(i)*PF(i)*cF(i)) 
                         + sum(i,tCus_Ex(i)*PF(i)*ExF(i)) 
                         + sum(i,tCus_g(i)*PF(i)*gF(i)) 
                         + sum(i,tCus_IL(i)*PF(i)*ILF(i)));

E_DG..                 PSaldo =e=  J_DG + (r-grow)*DG/(1+grow);

E_Trans..               Trans =e= J_Trans + Trans0 * w * (N_Pop - N_Emp);

E_GD(i) $ d1G(i)..      gD(i) =e= J_GD(i) + m_GD(i) * ((1+tVAT_GD(i))*(p(i)+sum(taxd,tDuty_GD(i,taxd)))/PG(i))**(-EG) * g(i);
                                                      
E_GF(i) $ d1G(i)..      gF(i) =e= J_GF(i) + m_GF(i) * ((1+tVAT_GF(i))*(1+tCus_G(i))*(PF(i)+sum(taxd,tDuty_GF(i,taxd)))/PG(i))**(-EG) * g(i);
                                                 
E_PG(i) $ d1G(i).. PG(i)*g(i) =e= J_PG(i) + (1+tVAT_GD(i))*(p(i)+sum(taxd,tDuty_GD(i,taxd)))*gD(i) + (1+tVAT_GF(i))*(1+tCus_G(i))*(PF(i)+sum(taxd,tDuty_GF(i,taxd)))*gF(i);
                                                                                                      
* Man kan vælge at lade offentligt forbrug følge BVT ved følgende ligning
E_G(i) $ d1G(i)..        G(i) =e= J_G(i) + share_G(i) * sum(j,BVT(j))/PG(i);

* BoP beregnes som endogen variabel. Kan ikke indføres som en ligevægtsbetingelse i den forstand at BoP sættes eksogent til 0 (Walras' lov)
E_BoP..                   BoP =e= J_BoP + sum(i,P_Ex(i)*Ex(i) - PF(i)*(sum(j, xF(j,i)) + ExF(i) + cF(i) + sum(j, IBIF(j,i) + IMIF(j,i)) + ILF(i) + gF(i)))
                                 + (r-grow)*(Wealth_F - sum(j,(1-share_D(j)) * V(j)) - sum(j,DP(j)) - DG)/(1+grow) - TaxEU   ;


* Alle toldafgifter går til EU, da DK er medlem af EU's toldunion
E_TaxEU..   TaxEU  =e=  J_TaxEU + sum(i,sum(j,tCus_x(j,i)*PF(i)*xF(j,i))) 
                                + sum(i,sum(j,tCus_IM(j,i)*PF(i)*IMIF(j,i) 
                                +             tCus_IB(j,i)*PF(i)*IBIF(j,i)))
                                + sum(i,tCus_c(i)*PF(i)*cF(i)) 
                                + sum(i,tCus_g(i)*PF(i)*gF(i)) 
                                + sum(i,tCus_Ex(i)*PF(i)*ExF(i))
                                + sum(i,tCus_IL(i)*PF(i)*ILF(i))
                                + sum(j,SUBEU(j));
                         
* Ligevægte
E_w..           sum(j, L(j)) =e= J_w + hour * N_Emp;

E_Y(i)..                Y(i) =e= J_Y(i) + sum(j, xD(j,i)) + cD(i) + sum(j, IBID(j,i)+IMID(j,i)) + ILD(i) + gD(i) + ExD(i);

* Funktion som kan maskimeres
E_UTILITY..          UTILITY =e= J_UTILITY + CTot + sum(i, G(i));

*------------------------------------------------------------
* Modeller
*------------------------------------------------------------
model static
/
E_BoP
E_Ktot
E_GDP
E_GDPf0
E_BVT
E_BVTtot
E_BVTf0
E_BVTf0tot
E_NVTf0
E_NVTf0tot
E_M
E_E
E_H
E_LKE
E_KE
E_PO
E_P
E_L
E_KB
E_KM
E_KBBook
E_KMBook
E_ucB
E_ucM
E_PH
E_PLKE
E_PKE
E_xmm
E_xeme
E_xm
E_xe
E_x
E_PM
E_PE
E_Pxm
E_Pxe
E_Pxm_i
E_Pxe_i
E_xD
E_xF
E_Px
E_InvB
E_InvM
E_IBI
E_IBIB
E_IB
E_IMI
E_IMIM
E_IM
E_PInvB
E_PInvM
E_IBD
E_IMD
E_IBF
E_IMF
E_PIBI
E_PIB
E_PIB_I
E_PIMI
E_PIM
E_PIM_I
E_DIV
E_V
E_IL
E_ILD
E_ILF
E_PIL
E_YEmp
E_YNotEmp
E_N_Emp
E_C_Emp
E_C_NotEmp
E_CTot
E_cD 
E_cF 
E_PC
E_CHC
E_CH
E_C
E_PCH
E_PCH_i
E_Wealth
E_Ex
E_ExD
E_ExF
E_P_Ex
E_GD
E_GF
E_PG
E_PSaldo
E_DG
E_DP
E_Trans
E_w
E_Y
E_P_udl
E_Ltot
E_G
E_UTILITY
E_TaxEU
E_tMarg_cD
E_tMarg_cF
$IF NOT %NYTADD% == 1  $GOTO SKIP
E_hour
$LABEL SKIP
$IF NOT %NYTMUL% == 1  $GOTO SKIPa
E_YZ
E_hourMUL
E_VV
E_PU
$LABEL SKIPa
/
;
*------------------------------------------------------------
* Data
*------------------------------------------------------------

* Antal sektorer
parameter N;
N = card(j);


* Indlæs eksogene variable
include eksovarFM.gms

* Her indlæses data og kalibrering foretages
include realdata_16.gms


*------------------------------------------------------------
* Test baseret på J_LED (Husk J_Led i alle nye ligninger)
*------------------------------------------------------------
fix ALL;
unfix J_LED;

save;

solve static using cns;

* gamX-kommando (udskriver %-vis afvigelse i.f.t. sidste 'save' for alle variable i gruppen ENDO)
dispdif |J_LED| > 0.00001;


*$exit

*------------------------------------------------------------
* Kørsel
*------------------------------------------------------------
fix ALL;
unfix ENDO;
* Nuller.gms fixer variable med leverancer som er nul, da de er fjernet i ligningerne
include Nuller.gms
save;

solve static using cns;
*$exit


*execute_unload "gekko\gdx_work\base.gdx";
