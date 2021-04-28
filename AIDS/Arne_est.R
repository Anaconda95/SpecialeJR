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

library("readxl")
library("dplyr")
library("rlang")


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

########## indlæser data ###############
# IndlÃ¦s data-------
priser<-read.csv("C:/specialeJR/Prisdata DST/PRISINDEKS.csv",sep=',')
df_h <-read.csv("C:/specialeJR/Prisdata DST/v8_decil_h.csv",sep=',')
df_1 <-read.csv("C:/specialeJR/Prisdata DST/v8_decil_1.csv",sep=',')
df_2 <-read.csv("C:/specialeJR/Prisdata DST/v8_decil_2.csv",sep=',')
df_3 <-read.csv("C:/specialeJR/Prisdata DST/v8_decil_3.csv",sep=',')
df_4 <-read.csv("C:/specialeJR/Prisdata DST/v8_decil_4.csv",sep=',')
df_5 <-read.csv("C:/specialeJR/Prisdata DST/v8_decil_5.csv",sep=',')
df_6 <-read.csv("C:/specialeJR/Prisdata DST/v8_decil_6.csv",sep=',')
df_7 <-read.csv("C:/specialeJR/Prisdata DST/v8_decil_7.csv",sep=',')
df_8 <-read.csv("C:/specialeJR/Prisdata DST/v8_decil_8.csv",sep=',')
df_9 <-read.csv("C:/specialeJR/Prisdata DST/v8_decil_9.csv",sep=',')
df_10<-read.csv("C:/specialeJR/Prisdata DST/v8_decil_10.csv",sep=',')


df_1 = df_1 %>%
  mutate(
    across(c(3:10),
           .fns = ~./ialt))
df_2 = df_2 %>%
  mutate(
    across(c(3:10),
           .fns = ~./ialt))
df_3 = df_3 %>%
  mutate(
    across(c(3:10),
           .fns = ~./ialt))
df_4 = df_4 %>%
  mutate(
    across(c(3:10),
           .fns = ~./ialt))

df_5 = df_5 %>%
  mutate(
    across(c(3:10),
           .fns = ~./ialt))
df_6 = df_6 %>%
  mutate(
    across(c(3:10),
           .fns = ~./ialt))
df_7 = df_7 %>%
  mutate(
    across(c(3:10),
           .fns = ~./ialt))
df_8 = df_8 %>%
  mutate(
    across(c(3:10),
           .fns = ~./ialt))

df_9 = df_9 %>%
  mutate(
    across(c(3:10),
           .fns = ~./ialt))
df_10 = df_10 %>%
  mutate(
    across(c(3:10),
           .fns = ~./ialt))

df_1 = subset(df_1, select = -c(X,aar))
df_2 = subset(df_2, select = -c(X,aar))
df_3 = subset(df_3, select = -c(X,aar))
df_4 = subset(df_4, select = -c(X,aar))
df_5 = subset(df_5, select = -c(X,aar))
df_6 = subset(df_6, select = -c(X,aar))
df_7 = subset(df_7, select = -c(X,aar))
df_8 = subset(df_8, select = -c(X,aar))
df_9 = subset(df_9, select = -c(X,aar))

df_10 = subset(df_10, select = -c(X,aar))

shareNames <- names(subset(df_1,select= -c(ialt)))

pris_sub = subset(priser, select = -c(Aar))

d1 = cbind(pris_sub,df_1)
d2 = cbind(pris_sub,df_2)
d3 = cbind(pris_sub,df_3)
d4 = cbind(pris_sub,df_4)
d5 = cbind(pris_sub,df_5)
d6 = cbind(pris_sub,df_6)
d7 = cbind(pris_sub,df_7)
d8 = cbind(pris_sub,df_8)
d9 = cbind(pris_sub,df_9)
d10 = cbind(pris_sub,df_10)


priceNames <- names(subset(priser,select=-c(Aar)))


# Estimerer med ILLE (non-linear)

aidsResult_d1 <- aidsEst( priceNames, shareNames, "ialt", data = d1, method = "IL" )
aidsResult_d2 <- aidsEst( priceNames, shareNames, "ialt", data = d2, method = "IL" )
aidsResult_d3 <- aidsEst( priceNames, shareNames, "ialt", data = d3, method = "IL" )
aidsResult_d4 <- aidsEst( priceNames, shareNames, "ialt", data = d4, method = "IL" )
aidsResult_d5 <- aidsEst( priceNames, shareNames, "ialt", data = d5, method = "IL" )
aidsResult_d6 <- aidsEst( priceNames, shareNames, "ialt", data = d6, method = "IL" )
aidsResult_d7 <- aidsEst( priceNames, shareNames, "ialt", data = d7, method = "IL" )
aidsResult_d8 <- aidsEst( priceNames, shareNames, "ialt", data = d8, method = "IL" )
aidsResult_d9 <- aidsEst( priceNames, shareNames, "ialt", data = d9, method = "IL" )
aidsResult_d10 <- aidsEst( priceNames, shareNames, "ialt", data = d10, method = "IL" )



# Sammenligner resultater
print( aidsResult_d1 )
print( aidsResult_d2 )
print( aidsResult_d3 )
print( aidsResult_d4 )
print( aidsResult_d5 )
print( aidsResult_d6 )
print( aidsResult_d7 )
print( aidsResult_d8 )
print( aidsResult_d9 )
print( aidsResult_d10 )

# udregner elasticiteter
pMeans_d1 <- colMeans( d1[ , priceNames ] )
wMeans_d1 <- colMeans( d1[ , shareNames ] )
aidsResultElas_d1 <- aidsElas( coef( aidsResult_d1 ), prices = pMeans_d1,shares = wMeans_d1 )
print(aidsResultElas_d1)

pMeans_d2 <- colMeans( d2[ , priceNames ] )
wMeans_d2 <- colMeans( d2[ , shareNames ] )
aidsResultElas_d2 <- aidsElas( coef( aidsResult_d2 ), prices = pMeans_d2,shares = wMeans_d2 )
print(aidsResultElas_d2)


pMeans_d3 <- colMeans( d3[ , priceNames ] )
wMeans_d3 <- colMeans( d3[ , shareNames ] )
aidsResultElas_d3<- aidsElas( coef( aidsResult_d3 ), prices = pMeans_d3,shares = wMeans_d3 )
print(aidsResultElas_d3)

pMeans_d4 <- colMeans( d4[ , priceNames ] )
wMeans_d4 <- colMeans( d4[ , shareNames ] )
aidsResultElas_d4 <- aidsElas( coef( aidsResult_d4 ), prices = pMeans_d4,shares = wMeans_d4 )
print(aidsResultElas_d4)

pMeans_d5 <- colMeans( d5[ , priceNames ] )
wMeans_d5 <- colMeans( d5[ , shareNames ] )
aidsResultElas_d5 <- aidsElas( coef( aidsResult_d5 ), prices = pMeans_d5,shares = wMeans_d5 )
print(aidsResultElas_d5)

pMeans_d5 <- colMeans( d1[ , priceNames ] )
wMeans_d1 <- colMeans( d1[ , shareNames ] )
aidsResultElas_d1 <- aidsElas( coef( aidsResult ), prices = pMeans_d1,shares = wMeans_d1 )


pMeans_d6 <- colMeans( d6[ , priceNames ] )
wMeans_d6 <- colMeans( d6[ , shareNames ] )
aidsResultElas_d6 <- aidsElas( coef( aidsResult_d6 ), prices = pMeans_d6,shares = wMeans_d6 )
print(aidsResultElas_d6)


pMeans_d7 <- colMeans( d7[ , priceNames ] )
wMeans_d7 <- colMeans( d7[ , shareNames ] )
aidsResultElas_d7 <- aidsElas( coef( aidsResult_d7 ), prices = pMeans_d7,shares = wMeans_d7 )
print(aidsResultElas_d7)


pMeans_d8 <- colMeans( d8[ , priceNames ] )
wMeans_d8 <- colMeans( d8[ , shareNames ] )
aidsResultElas_d8 <- aidsElas( coef( aidsResult_d8 ), prices = pMeans_d8,shares = wMeans_d8 )
print(aidsResultElas_d8)

pMeans_d9 <- colMeans( d9[ , priceNames ] )
wMeans_d9 <- colMeans( d9[ , shareNames ] )
aidsResultElas_d9 <- aidsElas( coef( aidsResult_d9 ), prices = pMeans_d9,shares = wMeans_d9 )
print(aidsResultElas_d9)

pMeans_d10 <- colMeans( d10[ , priceNames ] )
wMeans_d10 <- colMeans( d10[ , shareNames ] )
aidsResultElas_d10 <- aidsElas( coef( aidsResult_d10 ), prices = pMeans_d10,shares = wMeans_d10 )
print(aidsResultElas_d10)

##################################################################################################################




