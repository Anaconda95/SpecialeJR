################################################################################
##################### Script til at indl?se data og pakker #####################
################################################################################



############################ First of all: load usefull packages ###########################################

#clear workspace
rm(list=ls())
library(mvtnorm)
library("xlsx")
#install.packages("grid")
library("grid")
#install.packages("ggplot")
#install.packages("tidyr")
library("dplyr")
library("tidyr")
library("ggplot2")
#install.packages("gridExtra")
library(gridExtra)
library(grid)
library(ggplot2)
#install.packages("ggpubr")
library(ggpubr)
library(lattice)
#install.packages("ggpubr")
library(ggpubr)
#no scientific numbers
options(scipen=999)
options(digits=5)
library(xtable)
options(xtable.floating = FALSE)
options(xtable.timestamp = "")

###### Indl?s data ###################

#Indlæser data: RASMUS
priser<-read.csv("/Users/rasmuskaslund/Documents/GitHub/SpecialeJR /PRISDATA DST/PRISINDEKS.csv",sep=',')
df_h <-read.csv("/Users/rasmuskaslund/Documents/GitHub/SpecialeJR /PRISDATA DST/v8_decil_h.csv",sep=',')
df_1 <-read.csv("/Users/rasmuskaslund/Documents/GitHub/SpecialeJR /PRISDATA DST/v8_decil_1.csv",sep=',')
df_2 <-read.csv("/Users/rasmuskaslund/Documents/GitHub/SpecialeJR /PRISDATA DST/v8_decil_2.csv",sep=',')
df_3 <-read.csv("/Users/rasmuskaslund/Documents/GitHub/SpecialeJR /PRISDATA DST/v8_decil_3.csv",sep=',')
df_4 <-read.csv("/Users/rasmuskaslund/Documents/GitHub/SpecialeJR /PRISDATA DST/v8_decil_4.csv",sep=',')
df_5 <-read.csv("/Users/rasmuskaslund/Documents/GitHub/SpecialeJR /PRISDATA DST/v8_decil_5.csv",sep=',')
df_6 <-read.csv("/Users/rasmuskaslund/Documents/GitHub/SpecialeJR /PRISDATA DST/v8_decil_6.csv",sep=',')
df_7 <-read.csv("/Users/rasmuskaslund/Documents/GitHub/SpecialeJR /PRISDATA DST/v8_decil_7.csv",sep=',')
df_8 <-read.csv("/Users/rasmuskaslund/Documents/GitHub/SpecialeJR /PRISDATA DST/v8_decil_8.csv",sep=',')
df_9 <-read.csv("/Users/rasmuskaslund/Documents/GitHub/SpecialeJR /PRISDATA DST/v8_decil_9.csv",sep=',')
df_10<-read.csv("/Users/rasmuskaslund/Documents/GitHub/SpecialeJR /PRISDATA DST/v8_decil_10.csv",sep=',')
disp_indk <- read.xlsx("/Users/rasmuskaslund/Documents/GitHub/SpecialeJR /Data/Disponibel indkomst tidsserie.xlsx",1)
disp_indk <- disp_indk[order(disp_indk$Aar),] 

#Lav kvintiler
kvint_1 <- (df_1+df_2)/2
kvint_2 <- (df_3+df_4)/2
kvint_3 <- (df_5+df_6)/2
kvint_4 <- (df_7+df_8)/2
kvint_5 <- (df_9+df_10)/2
indk_forb_kvint <- data.frame(Year=c(1994:2019), Dispk1=(disp_indk$X1..decil+disp_indk$X2..decil)/2,
                                                 Dispk2=(disp_indk$X3..decil+disp_indk$X4..decil)/2,
                                                 Dispk3=(disp_indk$X5..decil+disp_indk$X6..decil)/2,
                                                 Dispk4=(disp_indk$X7..decil+disp_indk$X8..decil)/2,
                                                 Dispk5=(disp_indk$X9..decil+disp_indk$X10..decil)/2,
                  Forbk1=kvint_1$ialt, Forbk2=kvint_2$ialt, Forbk3=kvint_3$ialt, Forbk4=kvint_4$ialt, Forbk5=kvint_5$ialt    )

#INDLÆSER DATA: JULIE

df_h <-read.csv("C:/specialeJR/Prisdata DST/v8_decil_h.csv",sep=',')
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

#Lav kvintiler
kvint_1 <- (df_1+df_2)/2
kvint_2 <- (df_3+df_4)/2
kvint_3 <- (df_5+df_6)/2
kvint_4 <- (df_7+df_8)/2
kvint_5 <- (df_9+df_10)/2

