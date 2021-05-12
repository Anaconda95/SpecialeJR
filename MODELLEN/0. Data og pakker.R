################################################################################
##################### Script til at indlæse data og pakker #####################
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
library("ggplot")
library("dplyr")
library("tidyr")
library("ggplot2")
#install.packages("gridExtra")
library(gridExtra)
library(grid)
library(ggplot2)
library(lattice)
#no scientific numbers
options(scipen=999)
options(digits=3)


###### Indlæs data ###################

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

