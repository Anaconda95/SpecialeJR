#Packages
install.packages("nnet")
install.packages("lmtest")
install.packages("mgcv")
install.packages("quantreg")
install.packages("systemfit")
install.packages("foreign")
install.packages("car")
install.packages("Rcpp")
install.packages("Hmisc")
install.packages("dyn")
library(systemfit)
library(Hmisc)
library(dyn)

#no scientific numbers
options(scipen=999)

#Step1: Load Data set
#Data is in millions of dollars
df<-read.csv("simpeldata4grup.csv",sep=';')
attach(df)
names(df)
dim(df)
View(df)

#create a lagged variable
df$lagSumloeb <- Lag(df$Sumloeb, +1)

#Step2: Estimate of essential expenditure by obtaining fitted values over time
aconsumption<-lm(Sumloeb~Time)
acon<-fitted(aconsumption)

#other lag
aconsumptionl<-lm(Sumloeb~lag(Sumloeb))
aconl<-fitted(aconsumption)

#Or estimate it with a lag instead of time trend
ts<-zoo(df)
aconsumptionlag<- dyn$lm(ts$Sumloeb ~ lag(ts$Sumloeb, -1))
summary(aconsumptionlag)
aconlag<-fitted(aconsumptionlag)

#delete first row of df
df<-df[-c(1), ]

#Step3: Identify system of equations to estimate.
foodr<-df$FØDEVARER.OG.IKKE.ALKOHOLISKE.DRIKKEVARER~I(df$Sumloeb-aconlag)
alkor<-df$ALKOHOLISKE.DRIKKEVARER.OG.TOBAK~I(df$Sumloeb-aconlag)
beklr<-df$BEKLÆDNING.OG.FODTØJ~I(df$Sumloeb-aconlag)
boligelr<-df$BOLIGBENYTTELSE..ELEKTRICITET.OG.OPVARMNING~I(df$Sumloeb-aconlag)

#Step 4: Estimate linear expenditure system:
LES<-systemfit(list(foodreg=foodr, alkoreg=alkor, beklreg=beklr, boligelreg=boligelr),method="SUR")
summary(LES)


