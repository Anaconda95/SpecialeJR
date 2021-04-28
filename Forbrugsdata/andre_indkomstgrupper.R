################### Fil til at aggregere indkomstgrupperne ####################
rm(list=ls())
library("dplyr")
## kvintiler:
# læg 2 og 2 sammen
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


kvint1 <- df_1["aar"]
kvint2 <- df_1["aar"]
kvint3 <- df_1["aar"]
kvint4 <- df_1["aar"]
kvint5 <- df_1["aar"]


varergrupper = names(subset(df_1,selec=-c(X,aar)))

for (j in varergrupper) {
  kvint1[j] = df_1[j]+df_2[j]
  kvint2[j] = df_3[j]+df_4[j]
  kvint3[j] = df_5[j]+df_6[j]
  kvint4[j] = df_7[j]+df_8[j]
  kvint5[j] = df_9[j]+df_10[j]
} 


##### 3 indkomstgrupper: lavindkomst, middel og højindkomst, 3, 4, 3

lav <- df_1["aar"]
middel <- df_1["aar"]
hoj <- df_1["aar"]

for (j in varergrupper) {
  lav[j] = df_1[j]+df_2[j]+df_3[j]
  middel[j] = df_4[j]+df_5[j] + df_6[j] + df_7[j]
  hoj[j] = df_8[j]+df_9[j]+df_10[j]
} 

############# Skriv dem ud ################
