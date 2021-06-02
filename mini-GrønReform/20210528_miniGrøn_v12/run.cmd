rem Set GAMS="C:\GAMS28.2\gams.exe"
Set GAMS="C:\GAMS28.2\gams.exe"
rem Set GAMX="C:\GAMS28.2\gamx.exe"
Set GAMX="C:\GAMS28.2\gamx.exe"

REM gamX func.gms
timer start

Rem hvis NAF lig 1 benyttes marginalsats (nettoafgiftsfaktor) fra FM, hvis NOTNAF lig 1 benyttes afgiftssatser fra data
Rem Den ene parameter skal være sat lig 1 og den anden skal være sat lig 0
REM Bemærk at beregningen af EV-målet ændres når der skiftes mellem de to valgmuligheder
set "NAF=0"
set "NOTNAF=1"

REM Når forbrugeren har additiv nyttefunktion medfører det endogent arbejdsudbud i modellen
REM Bemærk at beregningen af EV-målet ændres når der skiftes mellem de to valgmuligheder
set "NYTADD=1"
set "NYTMUL=0"

goto start
:start
gamx model.gms --NAF=%NAF% --NOTNAF=%NOTNAF% --NYTADD=%NYTADD% --NYTMUL=%NYTMUL% s=model

gamX model_energi.gms --NAF=%NAF% --NOTNAF=%NOTNAF% --NYTADD=%NYTADD% --NYTMUL=%NYTMUL% r=model s=m_e

gamX model_transport.gms --NAF=%NAF% --NOTNAF=%NOTNAF% --NYTADD=%NYTADD% --NYTMUL=%NYTMUL% r=m_e s=m_t

gamX model_KB.gms --NAF=%NAF% --NOTNAF=%NOTNAF% --NYTADD=%NYTADD% --NYTMUL=%NYTMUL% r=m_t s=m_KB


gamX model_C.gms --NAF=%NAF% --NOTNAF=%NOTNAF% --NYTADD=%NYTADD% --NYTMUL=%NYTMUL% r=m_KB s=m_C

gamX model_tilskud.gms --NAF=%NAF% --NOTNAF=%NOTNAF% --NYTADD=%NYTADD% --NYTMUL=%NYTMUL% r=m_C s=m_ti

goto end

gamX model_fremskriv.gms --NAF=%NAF% --NOTNAF=%NOTNAF% --NYTADD=%NYTADD% --NYTMUL=%NYTMUL% r=m_ti s=m_frem




REM - - - Fremskrivning til 2030 - - - -

rem - Fremskrivning af Nordsøproduktion og energipriser
gamX fremEksoEnergi.gms r=m_frem s=fremEksoEnergi

rem - Fremskrivning af befolkning og arbejdsstyrke
gamX fremStruk1.gms r=fremEksoEnergi s=fremstruk1 

rem - Fremskrivning af BNP, dividender, markup, TFP, beskæftigelse, produktionsværdi mm
gamX fremStruk2.gms r=fremstruk1 s=fremstruk2 


rem - Indførelse af ETS-kvoter
gamX fremskriv_ETS2030.gms r=fremstruk2 s=Base2030_ETS

rem - Fremskrivning af udledninger og energiforbrug
gamX Pre_frem2030endo.gms r=Base2030_ETS s=Pre2030endo


gamX frem2030endo.gms r=Pre2030endo s=Base2030endo


rem - Indførelse af aftaler
gamX frem_aftaler1_2030.gms --filnavn=2030grund r=Base2030endo s=Base2030_aftaler


rem - Offentlig sektor
gamX offsektor.gms r=Base2030_aftaler s=offsektor

rem goto tilskud

rem - Kalibrering til MAC-kurver
rem MACpartiel.gms --luk=0 r=offsektor

rem gamX Eafgift_provenu.gms r=Base2030_aftaler 
rem gamX Eafgift_provenu.gms r=m_frem

REM  - - - Fjernelse af eksisterende afgifter på brændsel enkeltvis
rem gamX eksisterende.gms --luk=0  --filnavn=2030_X --tax_n=tax1  r=offsektor s=Base2030x
rem gamX eksisterende.gms --luk=0  --filnavn=2030_X --tax_n=tax8  r=offsektor s=Base2030x
rem gamX eksisterende.gms --luk=0  --filnavn=2030_X --tax_n=tax9  r=offsektor s=Base2030x
rem gamX eksisterende.gms --luk=0  --filnavn=2030_X --tax_n=tax10  r=offsektor s=Base2030x
rem gamX eksisterende.gms --luk=0  --filnavn=2030_X --tax_n=tax15  r=offsektor s=Base2030x




REM - - - Marginaleksperimenter - - - - Marginaleksperimenter - - - - Marginaleksperimenter - - - - Marginaleksperimenter - - - -

Rem  - - - LUKNING AF DE OFFENTLIGE FINANSER
Rem - Hvis luk=0 lukkes de offentlige finanser via lumpsum
Rem - Hvis luk=1 lukkes de offentlige finanser via arbejdsindkomstbeskatning


REM - - - Grundberegning med ensartet drivhusgasbeskatning - - - - Grundberegning med ensartet drivhusgasbeskatning - - - -
REM  - - - CO2e-afgiften sættes ens for alle brancher
gamX CO2eafg.gms --luk=0 r=offsektor s=CO2eafg

REM - - - CO2e-afgiften hæves for at opnå 70 pct. reduktion
gamX CO2eafg2.gms --luk=0 --fradrag=0 --leakage=0 --anvafgift=0 --kvotetax=0 --kvote2xfradrag=0 --filnavn=1_ensartet r=CO2eafg

rem gamX CO2eafg2slow.gms --luk=0 --fradrag=0 --leakage=0 --anvafgift=0 --kvotetax=0 --kvote2xfradrag=0 --filnavn=ensartet_slow r=CO2eafg

REM - - - Lukning via skat
gamX CO2eafg.gms --luk=1 r=offsektor s=CO2eafg
gamX CO2eafg2.gms --luk=1 --fradrag=0 --leakage=0 --anvafgift=0 --kvotetax=0 --kvote2xfradrag=0 --filnavn=3_ensartet_skat r=CO2eafg


REM - - - Fjernelse af energiafgifter : (1) eksl. benzinafgifter (2) eksl. benzinafgifter, skattefinansieret (3) inkl. benzinafgift
rem (1)
gamX Eafgifter_ekslB.gms --luk=0  --filnavn=2030_X r=offsektor s=Base2030x

gamX CO2eafg.gms --luk=0 r=Base2030x s=CO2eafg


gamX CO2eafg2.gms --luk=0 --fradrag=0 --leakage=0 --anvafgift=0 --kvotetax=0 --kvote2xfradrag=0 --land=0 --fisk=0 --filnavn=2_ensartet_xE r=CO2eafg s=ensartet_xE



rem - følsomhed med jordrente
gamX jordrente.gms  --luk=0 --land=1 --fisk=0   r=offsektor s=jordrente
gamX Eafgifter_ekslB.gms --luk=0 --filnavn=2030_X r=jordrente s=Base2030x
gamX CO2eafg.gms --luk=0 r=Base2030x s=CO2eafg
gamX CO2eafg2.gms --luk=0 --fradrag=0  --leakage=0 --anvafgift=0 --kvotetax=0 --kvote2xfradrag=0  --filnavn=2_4_jord r=CO2eafg

gamX jordrente.gms  --luk=0 --land=1 --fisk=1  r=offsektor s=jordrente
gamX Eafgifter_ekslB.gms --luk=0 --filnavn=2030_X r=jordrente s=Base2030x
gamX CO2eafg.gms --luk=0 r=Base2030x s=CO2eafg
gamX CO2eafg2.gms --luk=0 --fradrag=0  --leakage=0 --anvafgift=0 --kvotetax=0 --kvote2xfradrag=0  --filnavn=2_5_fisk r=CO2eafg
goto end

rem (1200 ekstra reduktioner) gamX CO2eafg2_plus.gms --luk=0 --fradrag=0 --leakage=0 --anvafgift=0 --kvotetax=0 --kvote2xfradrag=0 --filnavn=ensartet_xE_plus r=CO2eafg


rem (2)
gamX Eafgifter_ekslB.gms --luk=1  --filnavn=2030_X_skat r=offsektor s=Base2030x

gamX CO2eafg.gms --luk=1 r=Base2030x s=CO2eafg
gamX CO2eafg2.gms --luk=1 --fradrag=0 --leakage=0 --anvafgift=0 --kvotetax=0 --kvote2xfradrag=0 --filnavn=4_ensartet_xE_skat r=CO2eafg

rem (3)
rem gamX Eafgifter_inklB.gms --luk=0  --filnavn=2030_Xb r=offsektor s=Base2030xB

rem gamX CO2eafg.gms --luk=0 r=Base2030xB s=CO2eafg
rem gamX CO2eafg2.gms --luk=0 --fradrag=0 --leakage=0 --anvafgift=0 --kvotetax=0 --kvote2xfradrag=0 --filnavn=ensartet_xb r=CO2eafg




REM - - - - - Fradragsberegning - - - - - Fradragsberegning - - - - - Fradragsberegning - - - - - Fradragsberegning - - - - - 
REM  - - - CO2e-afgiften sættes ens for alle brancher
gamX Eafgifter_ekslB.gms --luk=0  --filnavn=2030_X r=offsektor s=Base2030x
gamX CO2eafg.gms --luk=0 r=Base2030x s=CO2eafg


REM - - - CO2e-afgift samt fradrag i CO2e-beskatningen hæves for at opnå 70 pct. reduktion
rem gamX CO2eafg2.gms --luk=0 --fradrag=1  --leakage=0 --anvafgift=0 --kvotetax=0 --kvote2xfradrag=0  --filnavn=9_fradrag r=CO2eafg


REM - - - CO2e-afgift samt fradrag i CO2e-beskatningen for udvalgte brancher
gamX CO2eafg2.gms --luk=0 --fradrag=1  --leakage=1 --anvafgift=0 --kvotetax=0 --kvote2xfradrag=0  --filnavn=5_fradrag_udvalgte r=CO2eafg


REM - - - CO2e-afgift samt fradrag i CO2e-beskatningen og dertilhørende anvendelsesafgift for udvalgte brancher
gamX CO2eafg2.gms --luk=0 --fradrag=1  --leakage=1 --anvafgift=1 --kvotetax=0 --kvote2xfradrag=0  --filnavn=6_fradrag_anvafgift r=CO2eafg
goto end


Rem ---- skattefinansieret
gamX Eafgifter_ekslB.gms --luk=1  --filnavn=2030_X r=offsektor s=Base2030x
gamX CO2eafg.gms --luk=1 r=Base2030x s=CO2eafg
gamX CO2eafg2.gms --luk=1 --fradrag=1  --leakage=0 --anvafgift=0 --kvotetax=0 --kvote2xfradrag=0  --filnavn=10_fradrag_skat r=CO2eafg

goto end
REM - - - - - Kun CO2 - - - - - Kun CO2 - - - - - Kun CO2 - - - - - Kun CO2 - - - - - 

REM  - - - CO2-afgiften (altså kun CO2, ikke øvrige drivhusgasser) sættes ens for alle brancher
gamX CO2_afg.gms --luk=0 r=Base2030x s=CO2_afg
goto end

REM - - - CO2-afgiften hæves for at opnå 70 pct. reduktion
gamX CO2eafg2.gms --luk=0 --fradrag=0  --leakage=0 --anvafgift=0 --kvotetax=0 --kvote2xfradrag=0  --filnavn=7_kunCO2 r=CO2_afg
goto end

REM - - - Følsomhed ift. jordrente

gamX jordrente.gms  --luk=0 --land=1 --fisk=0   r=offsektor s=jordrente
gamX Eafgifter_ekslB.gms --luk=0 --filnavn=2030_X r=jordrente s=Base2030x
gamX CO2_afg.gms --luk=0 r=Base2030x s=CO2_afg
gamX CO2eafg2.gms --luk=0 --fradrag=0  --leakage=0 --anvafgift=0 --kvotetax=0 --kvote2xfradrag=0  --filnavn=7_4_jord r=CO2_afg

gamX jordrente.gms  --luk=0 --land=1 --fisk=1  r=offsektor s=jordrente
gamX Eafgifter_ekslB.gms --luk=0 --filnavn=2030_X r=jordrente s=Base2030x
gamX CO2_afg.gms --luk=0 r=Base2030x s=CO2_afg
gamX CO2eafg2.gms --luk=0 --fradrag=0  --leakage=0 --anvafgift=0 --kvotetax=0 --kvote2xfradrag=0  --filnavn=7_5_fisk r=CO2_afg

goto end

REM  - - - Skattefinansieret
gamX Eafgifter_ekslB.gms --luk=1  --filnavn=2030_X_skat r=offsektor s=Base2030x
gamX CO2_afg.gms --luk=1 r=Base2030x s=CO2_afg
gamX CO2eafg2.gms --luk=1 --fradrag=0  --leakage=0 --anvafgift=0 --kvotetax=0 --kvote2xfradrag=0  --filnavn=8_kunCO2_skat r=CO2_afg


goto end


REM - - - - - Tilskudsvejen - - - - - Tilskudsvejen - - - - - Tilskudsvejen - - - - - Tilskudsvejen - - - - - 
:tilskud

rem - Fastsættelse af "stien"
gamX CO2eafg.gms --luk=0 r=offsektor s=CO2eafg
gamX CO2eafg2.gms --luk=0 --fradrag=0 --leakage=0 --anvafgift=0 --kvotetax=0 --kvote2xfradrag=0 --filnavn=tom r=CO2eafg s=CO2eafg2

rem - Selve tilskudsberegningen

rem CO2-afgiften i ikke-kvote-sektoren sættes lig kvoteprisen
gamX CO2_afg.gms --luk=0 r=offsektor s=CO2_afg

gamX tilskudsvejen.gms --antal=299 --filnavn=tilskud r=CO2_afg
goto end

rem - gentagelse med skattefinansiering

rem - Fastsættelse af "stien"
gamX CO2eafg.gms --luk=1 r=offsektor s=CO2eafg
gamX CO2eafg2.gms --luk=1 --fradrag=0 --leakage=0 --anvafgift=0 --kvotetax=0 --kvote2xfradrag=0 --filnavn=tom r=CO2eafg s=CO2eafg2

rem - Selve tilskudsberegningen

rem CO2-afgiften i ikke-kvote-sektoren sættes lig kvoteprisen
gamX CO2_afg.gms --luk=1 r=offsektor s=CO2_afg

gamX tilskudsvejen.gms --antal=299 --filnavn=tilskud_skat r=CO2_afg
goto end


REM - - - - - Følsomhed ift CCS - - - - - 
:CCS

gamX Eafgifter_ekslB.gms --luk=0  --filnavn=2030_X r=offsektor s=Base2030x

gamX CO2eafg.gms --luk=0 r=Base2030x s=CO2eafg
goto end

rem gamX CO2eafg2slow.gms --luk=0 --fradrag=0 --leakage=0 --anvafgift=0 --kvotetax=0 --kvote2xfradrag=0 --filnavn=ensartet_xe_slow r=CO2eafg


gamX lavereCCSp.gms r=CO2eafg s=CCS
rem gamX CO2eafg2slow.gms --luk=0 --fradrag=0 --leakage=0 --anvafgift=0 --kvotetax=0 --kvote2xfradrag=0 --filnavn=lavereCCSp_slow r=CCS

gamX CO2eafg2slow.gms --luk=0 --fradrag=0 --leakage=0 --anvafgift=0 --kvotetax=0 --kvote2xfradrag=0 --filnavn=2_1_lavereCCSp r=CCS

goto end
gamX mindreCCS.gms r=CO2eafg s=CCS
gamX CO2eafg2slow.gms --luk=0 --fradrag=0 --leakage=0 --anvafgift=0 --kvotetax=0 --kvote2xfradrag=0 --filnavn=mindreCCS_slow r=CCS
gamX CO2eafg2.gms --luk=0 --fradrag=0 --leakage=0 --anvafgift=0 --kvotetax=0 --kvote2xfradrag=0 --filnavn=2_2_mindreCCS r=CCS


gamX ingenCCS.gms r=CO2eafg s=CCS
gamX CO2eafg2slow.gms --luk=0 --fradrag=0 --leakage=0 --anvafgift=0 --kvotetax=0 --kvote2xfradrag=0 --filnavn=ingenCCS_slow r=CCS
gamX CO2eafg2.gms --luk=0 --fradrag=0 --leakage=0 --anvafgift=0 --kvotetax=0 --kvote2xfradrag=0 --filnavn=2_3_ingenCCS r=CCS
goto end





REM - - - Lækage - - - Lækage - - - Lækage - - - Lækage - - - Lækage - - - Lækage - - - Lækage - - - Lækage - - - Lækage

REM  - - - Følsomhedsanalyser
gamX foelsomhed.gms r=offsektor s=foelsomhed
goto end


REM  - - - Beregning af lækagerater

gamX foelsomhed_slagt.gms --filnavn=test1 r=offsektor s=slagt
goto end
gamX leakage100landbrug.gms --luk=0 --filnavn=LR100landbrug_test1 r=slagt
goto end

gamX leakage100landbrug.gms --luk=0 --filnavn=leakagerate100landbrug r=offsektor

gamX leakage100landbrug.gms --luk=0 --filnavn=LR100landbrug_fra1200 r=ensartet_xE

goto end
gamX leakage500landbrug.gms --luk=0 --filnavn=leakagerate500landbrug r=offsektor


gamX leakage500.gms --luk=0 --filnavn=leakagerate500 r=offsektor
goto end
gamX leakage.gms --luk=0 --filnavn=leakagerate_Basis r=offsektor
gamX leakage.gms --luk=0 --filnavn=leakagerate_70 r=ensartet_Xe
goto end

gamX leakage1200land.gms --luk=0 --filnavn=leakagerate1200land r=offsektor
goto end


gamX jordrente.gms  --luk=0 --land=1 --fisk=1  r=offsektor s=jordrente
gamX leakage1200land.gms --luk=0 --filnavn=leakagerate1200land_5 r=jordrente
goto end


REM  - - - CO2e-afgiften sættes ens for alle brancher
gamX CO2eafg.gms --luk=0 r=offsektor s=CO2eafg
goto end

REM - - - CO2e-afgift hæves for at opnå 70 pct. reduktion (med varierende antagelser)

gamX CO2eafg2.gms --luk=0 --fradrag=0 --anvafgift=0 --kvotetax=0 --kvote2xfradrag=0 --filnavn=ensartet r=CO2eafg
goto end

REM - - - Teststød med anvendelsesafgift
gamX anvafgift.gms --luk=0 --fradrag=0 --anvafgift=1 --kvotetax=0 --kvote2xfradrag=0 --filnavn=anvafgift r=Base2030_aftaler
goto end




REM - - - 2050 - - - 2050 - - - 2050 - - - 2050 - - - 2050 - - - 2050 - - - 2050 - - - 2050 - - - 2050 - - - 2050 - - - 

gamX frem2050eksoE.gms r=Base2030endo2 s=Base2050endoE
goto end

gamX frem2050eksoY.gms r=Base2050endoE s=Base2050endoY

goto end

rem gamX testbio.gms r=Base2050_ekso
rem gamX test.gms r=Base2050_ekso

gamX fremskriv_ETS2050.gms r=Base2050endoY s=Base2050_ETS


gamX frem2050endo1.gms r=Base2050_ETS s=Base2050endo1


gamX frem2050endo2.gms r=Base2050endo1 s=Base2050endo2
goto end

gamX test.gms r=Base2050_endo


gamX frem_aftaler1_2050.gms r=Base2050endo2 s=Base2050_aftaler


gamX CO2eafg2050.gms r=Base2050_aftaler s=CO2eafg50
goto end

gamX CO2eafg2_2050.gms r=CO2eafg50 s=neutral2050
goto end

rem MAC_CCS.gms r=Base2030_aftaler

gamX fremskriv_aftaler2.gms r=Base2030_aftaler s=Base2030
goto end
gamX fremskriv_aftaler2.gms r=Base2050_aftaler s=Base2050
goto end
gamX problemfix.gms r=Base2030 s=fix

rem eksisterende.gms r=fix s=eksisterende

gamX CO2eafg.gms r=fix s=CO2eafg

gamX CO2eafg2.gms r=CO2eafg s=70pct


:end

timer stop