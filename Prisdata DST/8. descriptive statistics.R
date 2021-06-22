#Kør først data og pakker.

#install.packages("reshape2")
#install.packages("gdxrrw_1.0.8.tgz",repos=NULL)
#install.packages("RColorBrewer")
library(gdxrrw)
library("RColorBrewer")
#install.packages("viridis")  # Install
library("viridis")           # Load
#install.packages("ggsci")  # Install
library("ggsci")           # Load
#install.packages("wesanderson")  # Install
library(wesanderson)

df_kvintiler= list(kvint_1,kvint_2,kvint_3, kvint_3, kvint_4)
w= list()
for (dfdf in 1:length(df_kvintiler) ) {
  
  # Dataindlæsning  ---------
  df <- df_kvintiler[[dfdf]]
 
  df     <- transform( df,
                       w1 = df$kod_fisk_mej /df$ialt,
                       w2 = df$ovr_fode/df$ialt,
                       w3 = df$bol/df$ialt,
                       w4 = df$ene_hje/df$ialt,
                       w5 = df$ene_tra/df$ialt,
                       w6 = df$tra/df$ialt,
                       w7 = df$ovr_var/df$ialt,
                       w8 = df$ovr_tje/df$ialt
  ) 
 
  w[[dfdf]] = matrix(c(df$w1,df$w2,df$w3,df$w4,df$w5,df$w6,df$w7,df$w8),  nrow=26, ncol=8)
}

T=26
n=8



