#installer disse pakker
#install.packages("micEcon")
#install.packages("micEconAids")
#install.packages("systemfit")
#install.packages("rio")
rm(list=ls())
library(lmtest)
library(rio)
library(systemfit)
library(micEcon)
library(micEconAids)

# databehandling
Data_gns = read.csv("C:/specialeJR/Estimering/data_gns.csv")
Data_gns <- subset(Data_gns, select = -c(TurTje_pris, TurTjeVar_pris, TurTjeVarEne_pris, TurTje_maengde, TurTjeVar_maengde, TurTjeVarEne_maengde))
Data_gns$Indkomst <- rowSums( Data_gns[,7:11] )

Data_gns[,"Turisme_share"] <- Data_gns[,"Turisme_maengde"]/Data_gns[,"Indkomst"]
Data_gns[,"Tjenester_share"] <- Data_gns[,"Tjenester_maengde"]/Data_gns[,"Indkomst"]
Data_gns[,"Varer_share"] <- Data_gns[,"Varer_maengde"]/Data_gns[,"Indkomst"]
Data_gns[,"Energi_share"] <- Data_gns[,"Energi_maengde"]/Data_gns[,"Indkomst"]
Data_gns[,"Biler_share"] <- Data_gns[,"Biler_maengde"]/Data_gns[,"Indkomst"]

priceNames <- c( "Turisme_pris", "Tjenster_pris", "Varer_pris", "Energi_pris", "Biler_pris" )
shareNames <- c( "Turisme_share", "Tjenester_share", "Varer_share", "Energi_share", "Biler_share" )


# LA-AIDS med Stone prisindeks
laaidsResult <- aidsEst( priceNames, shareNames, "Indkomst", data = Data_gns, priceIndex = "S" )
print( laaidsResult )
summary( laaidsResult )

# LA-AIDS med lagged budget shares i Stone prisindeks

laaidsResultSL <- aidsEst( priceNames, shareNames, "Indkomst", data = Data_gns, priceIndex = "SL" )
print( laaidsResultSL )
summary( laaidsResultSL )


# LA-AIDS med tre forskellige prisindeks
# Paasche prisindkes
laaidsResultP <- aidsEst( priceNames, shareNames, "Indkomst", data = Data_gns, priceIndex = "P" )
print( laaidsResultP )
summary( laaidsResultP )

# Laspreyes 
laaidsResultL <- aidsEst( priceNames, shareNames, "Indkomst", data = Data_gns, priceIndex = "L" )
print( laaidsResultL )
summary( laaidsResultL )

#Tornqvist
laaidsResultT <- aidsEst( priceNames, shareNames, "Indkomst", data = Data_gns, priceIndex = "T" )
print( laaidsResultT )
summary( laaidsResultT )


# ILLE estimation af non-linear AIDS
aidsResult <- aidsEst( priceNames, shareNames, "Indkomst", data = Data_gns, method = "IL" )
print( aidsResult )
summary( aidsResult )

# Der skete noget her 


# Tjek af teoretiske antagelser
# Køres med IL estimations resulater

# Add-up conditions
all.equal( sum( coef( aidsResult )$alpha ), 1 )
all.equal( sum( coef( aidsResult )$beta ), 0 )
all.equal( colSums( coef( aidsResult )$gamma ), rep( 0, 5 ),check.attributes = FALSE )
all.equal( rowSums( coef( aidsResult )$gamma ), rep( 0, 5 ),check.attributes = FALSE )

#Symmetry
isSymmetric( coef( aidsResult )$gamma, tol = 1e-10, check.attributes = FALSE )

# Der er nogle flere ting man kan tjekke omkring symmetri og homgenitet

#Monoticity
aidsMono( priceNames, "Indkomst", coef = coef( aidsResult ),data = Data_gns )
#fulfilled in 26 out of 26

#Concavity
aidsConcav( priceNames, "Indkomst", coef = coef( aidsResult ),data = Data_gns )
# fulfilled in 20 out of 26
# With observed instead of fitted shares:
aidsConcav( priceNames, "Indkomst", coef = coef( aidsResult ), data = Data_gns, shareNames = shareNames )
# fulfilled in 19 out of 26

## Checkin all conditions at the same time ##
aidsConsist( priceNames, "Indkomst", coef = coef( aidsResult ), data = Data_gns )


### Calculating the demand elasticity evaluated at the mean ###
pMeans <- colMeans( Data_gns[ , priceNames ] )
wMeans <- colMeans( Data_gns[ , shareNames ] )
aidsResultElas <- aidsElas( coef( aidsResult ), prices = pMeans,shares = wMeans )
print( aidsResultElas )

#observed instead of fitted values
xtMean <- mean( Data_gns[ , "Indkomst" ] )
aidsResultElas2 <- aidsElas( coef( aidsResult ), prices = pMeans,totExp = xtMean )
all.equal( aidsResultElas, aidsResultElas2 )

# Calculating the covariance matrix (with t-tests)
aidsResultElasCov <- aidsElas( coef( aidsResult ), prices = pMeans,totExp = xtMean, coefCov = vcov( aidsResult ),df = df.residual( aidsResult ) )
summary( aidsResultElasCov )

#tjek om de matcher med elasticiteterne 
aidsResultElasCov2 <- elas( aidsResult )
print(aidsResultElasCov2)
all.equal( aidsResultElasCov, aidsResultElasCov2 )

#kan også bruge observerede værdier
aidsResultElasCovObs <- elas( aidsResult, observedShares = TRUE )
print(aidsResultElasCovObs)



########## Nu vil vi gerne tjekke om elasticiterne er forskellige på tværs af indkomstgrupper! ############
########### Esimerer nl AIDS for hver indkomstgrupper og printe relasticiterer ############################


Data_u250 = read.csv("C:/specialeJR/Estimering/data_u250.csv")
Data_250_450 = read.csv("C:/specialeJR/Estimering/data_250_450.csv")
Data_450_700 = read.csv("C:/specialeJR/Estimering/data_450_700.csv")
Data_700_1mio = read.csv("C:/specialeJR/Estimering/data_700_1mio.csv")
Data_o1mio = read.csv("C:/specialeJR/Estimering/data_o1mio.csv")

Data_u250 <- subset(Data_u250, select = -c(TurTje_pris, TurTjeVar_pris, TurTjeVarEne_pris, TurTje_maengde, TurTjeVar_maengde, TurTjeVarEne_maengde))
Data_u250$Indkomst <- rowSums( Data_u250[,7:11] )

Data_u250[,"Turisme_share"] <- Data_u250[,"Turisme_maengde"]/Data_u250[,"Indkomst"]
Data_u250[,"Tjenester_share"] <- Data_u250[,"Tjenester_maengde"]/Data_u250[,"Indkomst"]
Data_u250[,"Varer_share"] <- Data_u250[,"Varer_maengde"]/Data_u250[,"Indkomst"]
Data_u250[,"Energi_share"] <- Data_u250[,"Energi_maengde"]/Data_u250[,"Indkomst"]
Data_u250[,"Biler_share"] <- Data_u250[,"Biler_maengde"]/Data_u250[,"Indkomst"]

Data_250_450 <- subset(Data_250_450, select = -c(TurTje_pris, TurTjeVar_pris, TurTjeVarEne_pris, TurTje_maengde, TurTjeVar_maengde, TurTjeVarEne_maengde))
Data_250_450$Indkomst <- rowSums( Data_250_450[,7:11] )

Data_250_450[,"Turisme_share"] <- Data_250_450[,"Turisme_maengde"]/Data_250_450[,"Indkomst"]
Data_250_450[,"Tjenester_share"] <- Data_250_450[,"Tjenester_maengde"]/Data_250_450[,"Indkomst"]
Data_250_450[,"Varer_share"] <- Data_250_450[,"Varer_maengde"]/Data_250_450[,"Indkomst"]
Data_250_450[,"Energi_share"] <- Data_250_450[,"Energi_maengde"]/Data_250_450[,"Indkomst"]
Data_250_450[,"Biler_share"] <- Data_250_450[,"Biler_maengde"]/Data_250_450[,"Indkomst"]

Data_450_700 <- subset(Data_450_700, select = -c(TurTje_pris, TurTjeVar_pris, TurTjeVarEne_pris, TurTje_maengde, TurTjeVar_maengde, TurTjeVarEne_maengde))
Data_450_700$Indkomst <- rowSums( Data_450_700[,7:11] )

Data_450_700[,"Turisme_share"] <- Data_450_700[,"Turisme_maengde"]/Data_450_700[,"Indkomst"]
Data_450_700[,"Tjenester_share"] <- Data_450_700[,"Tjenester_maengde"]/Data_450_700[,"Indkomst"]
Data_450_700[,"Varer_share"] <- Data_450_700[,"Varer_maengde"]/Data_450_700[,"Indkomst"]
Data_450_700[,"Energi_share"] <- Data_450_700[,"Energi_maengde"]/Data_450_700[,"Indkomst"]
Data_450_700[,"Biler_share"] <- Data_450_700[,"Biler_maengde"]/Data_450_700[,"Indkomst"]

Data_700_1mio <- subset(Data_700_1mio, select = -c(TurTje_pris, TurTjeVar_pris, TurTjeVarEne_pris, TurTje_maengde, TurTjeVar_maengde, TurTjeVarEne_maengde))
Data_700_1mio$Indkomst <- rowSums( Data_700_1mio[,7:11] )

Data_700_1mio[,"Turisme_share"] <- Data_700_1mio[,"Turisme_maengde"]/Data_700_1mio[,"Indkomst"]
Data_700_1mio[,"Tjenester_share"] <- Data_700_1mio[,"Tjenester_maengde"]/Data_700_1mio[,"Indkomst"]
Data_700_1mio[,"Varer_share"] <- Data_700_1mio[,"Varer_maengde"]/Data_700_1mio[,"Indkomst"]
Data_700_1mio[,"Energi_share"] <- Data_700_1mio[,"Energi_maengde"]/Data_700_1mio[,"Indkomst"]
Data_700_1mio[,"Biler_share"] <- Data_700_1mio[,"Biler_maengde"]/Data_700_1mio[,"Indkomst"]

Data_o1mio <- subset(Data_o1mio, select = -c(TurTje_pris, TurTjeVar_pris, TurTjeVarEne_pris, TurTje_maengde, TurTjeVar_maengde, TurTjeVarEne_maengde))
Data_o1mio$Indkomst <- rowSums( Data_o1mio[,7:11] )

Data_o1mio[,"Turisme_share"] <- Data_o1mio[,"Turisme_maengde"]/Data_o1mio[,"Indkomst"]
Data_o1mio[,"Tjenester_share"] <- Data_o1mio[,"Tjenester_maengde"]/Data_o1mio[,"Indkomst"]
Data_o1mio[,"Varer_share"] <- Data_o1mio[,"Varer_maengde"]/Data_o1mio[,"Indkomst"]
Data_o1mio[,"Energi_share"] <- Data_o1mio[,"Energi_maengde"]/Data_o1mio[,"Indkomst"]
Data_o1mio[,"Biler_share"] <- Data_o1mio[,"Biler_maengde"]/Data_o1mio[,"Indkomst"]


# Estimerer med ILLE (non-linear)

aidsResult_u250 <- aidsEst( priceNames, shareNames, "Indkomst", data = Data_u250, method = "IL" )
aidsResult_250_450 <- aidsEst( priceNames, shareNames, "Indkomst", data = Data_250_450, method = "IL" )
aidsResult_450_700 <- aidsEst( priceNames, shareNames, "Indkomst", data = Data_450_700, method = "IL" )
aidsResult_700_1mio <- aidsEst( priceNames, shareNames, "Indkomst", data = Data_700_1mio, method = "IL" )
aidsResult_o1mio <- aidsEst( priceNames, shareNames, "Indkomst", data = Data_o1mio, method = "IL" )

# Sammenligner resultater
print( aidsResult_u250 )
print( aidsResult_250_450 )
print( aidsResult_450_700 )
print( aidsResult_700_1mio )
print( aidsResult_o1mio )

# udregner elasticiteter
pMeans_gns <- colMeans( Data_gns[ , priceNames ] )
wMeans_gns <- colMeans( Data_gns[ , shareNames ] )
aidsResultElas_gns <- aidsElas( coef( aidsResult ), prices = pMeans_gns,shares = wMeans_gns )

pMeans_u250 <- colMeans( Data_u250[ , priceNames ] )
wMeans_u250 <- colMeans( Data_u250[ , shareNames ] )
aidsResultElas_u250 <- aidsElas( coef( aidsResult_u250 ), prices = pMeans_u250,shares = wMeans_u250 )

pMeans_250_450 <- colMeans( Data_250_450[ , priceNames ] )
wMeans_250_450 <- colMeans( Data_250_450[ , shareNames ] )
aidsResultElas_250_450 <- aidsElas( coef( aidsResult_250_450 ), prices = pMeans_250_450,shares = wMeans_250_450 )

pMeans_450_700 <- colMeans( Data_450_700[ , priceNames ] )
wMeans_450_700 <- colMeans( Data_450_700[ , shareNames ] )
aidsResultElas_450_700 <- aidsElas( coef( aidsResult_450_700 ), prices = pMeans_450_700,shares = wMeans_450_700 )

pMeans_700_1mio <- colMeans( Data_700_1mio[ , priceNames ] )
wMeans_700_1mio <- colMeans( Data_700_1mio[ , shareNames ] )
aidsResultElas_700_1mio <- aidsElas( coef( aidsResult_700_1mio ), prices = pMeans_700_1mio,shares = wMeans_700_1mio )

pMeans_o1mio <- colMeans( Data_o1mio[ , priceNames ] )
wMeans_o1mio <- colMeans( Data_o1mio[ , shareNames ] )
aidsResultElas_o1mio <- aidsElas( coef( aidsResult_o1mio ), prices = pMeans_o1mio,shares = wMeans_o1mio )

# Sammenligner elasticiteter
print( aidsResultElas_gns )
print( aidsResultElas_u250 )
print( aidsResultElas_250_450 )
print( aidsResultElas_450_700 )
print( aidsResultElas_700_1mio )
print( aidsResultElas_o1mio )






