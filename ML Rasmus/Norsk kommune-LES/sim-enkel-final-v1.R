rm(list=ls())
library(tidyverse)
library(matrixStats)
library(xlsx)
library(Hmisc)
library(foreign)
library(readstata13)
library(systemfit)
library(beepr)
#setwd('C:/Simultan modell/')

data <- read.csv('data-enkel.csv')

##Fjerne observasjoner
data <- data[!data$komnr==301,]
#data <- data[!data$komnr==941,]
data <- data[!data$komnr==1151,]
#data <- data[!data$komnr==1252,]

data1 <- data

##F?rste ?r
s <- 2014

## Antall ?r
t <- 2019-s

pars <- mat.or.vec(38,t)
pval <- mat.or.vec(38,t)
adjr2 <- mat.or.vec(8,t)
r2    <- mat.or.vec(8,t)
suma <- c(18,19,23,4.5,40)
ptm <- proc.time()

for (i in 1:t) {
  
  data <- data1[data1$year==s-1+i,]
  print(dim(data))
  data <- data[data$sone_snitt/data$bef<=20,]






  ##Alpha: Basis, sone, ettersp?rsel
  
data$z_basis   <- 1000/data$bef
#data$z_sone    <- log(data$sone_snitt/data$bef)
data$z_sone    <- data$sone_snitt/data$bef
data$z_landb   <- (0.679*data$driftsenheter+0.2763*data$landbrukseiendom+0.0447*data$areal_total)/data$bef
data$z_6_15    <- data$bef_6_15/data$bef
data$z_hoy_utd <- data$innb_hoyere_utd/data$bef
data$z_int     <- data$int_til/data$bef/10000
data$z_1_5     <- data$bef1_5/data$bef
data$z_67_     <- data$bef_67_/data$bef
data$z_opph    <- data$opphopning/data$bef*10000
data$z_ufor    <- data$ufor_18_49/data$bef
data$z_alene   <- data$aleneboende/data$bef
data$z_flykt   <- data$flyktninger/data$bef
data$z_b_enslig<- data$barn_enslig/data$bef
data$z_fattige <- data$fattige/data$bef
  
data$z_67_79   <- data$bef67_79/data$bef
data$z_80_89   <- data$bef80_89/data$bef
data$z_90_     <- data$bef90_/data$bef
data$z_80_     <- (data$bef80_89+data$bef90_)/data$bef
data$z_pu_o16  <- data$pu_o16/data$bef
data$z_ig      <- data$ikke_gifte_67_/data$bef
data$z_vk      <- data$vertskom_ant/data$bef
data$z_kv      <- data$kommunaleveierkm/data$bef
data$z_rk      <- data$rensekap/data$bef
data$z_sno_cm  <- (data$snomengde*data$kommunaleveierkm)/data$bef
data$z_sno_dag <- data$snodager/data$bef 
data$z_ph_17   <- data$psyk_17/data$bef
data$z_ph_18_66<- data$psyk18_66/data$bef
data$z_rkb     <- data$rkb_utg_selv/data$bef
data$z_b_komm  <- data$barn_k_bh/data$bef
data$z_frie    <- data$frie/data$bef

df <- with(data,(data.frame(u_adm, u_gs, u_bh, u_hs, u_sos, u_bv, u_plo, u_ann,
                 z_basis, z_sone, z_landb, z_6_15, z_int, z_1_5, z_opph, z_ufor, z_fattige,
                 z_67_79, z_80_, z_pu_o16, z_vk, z_ph_17, z_rk, z_rkb, z_b_komm, z_frie, y)))
df <- df[complete.cases(df),]
df <- df[!(df$u_bv <=0 | df$u_sos <=0),]
print(dim(df))
#print(summary(df))


eq_ui_adm.formula <- u_adm ~ a01 + a11*z_basis + a31*z_landb +
  b11*(y - a11*z_basis - a31*z_landb - a12*z_basis - a22*z_sone - a32*z_6_15 - 
           a14*z_basis - a34*z_1_5 - a44*z_b_komm - a15*z_basis - a36*z_opph - a66*z_int -
           a47*z_fattige - a57*z_ph_17 - a18*z_basis - a38*z_67_79 - 
           a48*z_80_ - a68*z_pu_o16 - a88*z_vk - a98*z_rkb - a19*z_basis - a79*z_rk - a310*z_frie)
  
eq_ui_gs.formula  <- u_gs  ~ a02 + a12*z_basis + a22*z_sone + a32*z_6_15 +
  b12*(y - a11*z_basis - a31*z_landb - a12*z_basis - a22*z_sone - a32*z_6_15 - 
         a14*z_basis - a34*z_1_5 - a44*z_b_komm - a15*z_basis - a36*z_opph - a66*z_int -
         a47*z_fattige - a57*z_ph_17 - a18*z_basis - a38*z_67_79 - 
         a48*z_80_ - a68*z_pu_o16 - a88*z_vk - a98*z_rkb - a19*z_basis - a79*z_rk - a310*z_frie)

eq_ui_bh.formula  <- u_bh  ~ a04 + a14*z_basis + a34*z_1_5 + a44*z_b_komm +
  b14*(y - a11*z_basis - a31*z_landb - a12*z_basis - a22*z_sone - a32*z_6_15 - 
         a14*z_basis - a34*z_1_5 - a44*z_b_komm - a15*z_basis - a36*z_opph - a66*z_int -
         a47*z_fattige - a57*z_ph_17 - a18*z_basis - a38*z_67_79 - 
         a48*z_80_ - a68*z_pu_o16 - a88*z_vk - a98*z_rkb - a19*z_basis - a79*z_rk - a310*z_frie)

eq_ui_hs.formula  <- u_hs  ~ a05 + a15*z_basis + 
  b15*(y - a11*z_basis - a31*z_landb - a12*z_basis - a22*z_sone - a32*z_6_15 - 
         a14*z_basis - a34*z_1_5 - a44*z_b_komm - a15*z_basis - a36*z_opph - a66*z_int -
         a47*z_fattige - a57*z_ph_17 - a18*z_basis - a38*z_67_79 - 
         a48*z_80_ - a68*z_pu_o16 - a88*z_vk - a98*z_rkb - a19*z_basis - a79*z_rk - a310*z_frie)

eq_ui_sos.formula <- u_sos ~ a06 + a36*z_opph + a66*z_int +
  b16*(y - a11*z_basis - a31*z_landb - a12*z_basis - a22*z_sone - a32*z_6_15 - 
         a14*z_basis - a34*z_1_5 - a44*z_b_komm - a15*z_basis - a36*z_opph - a66*z_int -
         a47*z_fattige - a57*z_ph_17 - a18*z_basis - a38*z_67_79 - 
         a48*z_80_ - a68*z_pu_o16 - a88*z_vk - a98*z_rkb - a19*z_basis - a79*z_rk - a310*z_frie)


eq_ui_bv.formula  <- u_bv ~ a07 + a47*z_fattige + a57*z_ph_17 + 
  b17*(y - a11*z_basis - a31*z_landb - a12*z_basis - a22*z_sone - a32*z_6_15 - 
          a14*z_basis - a34*z_1_5 - a44*z_b_komm - a15*z_basis - a36*z_opph - a66*z_int -
          a47*z_fattige - a57*z_ph_17 - a18*z_basis - a38*z_67_79 - 
          a48*z_80_ - a68*z_pu_o16 - a88*z_vk - a98*z_rkb - a19*z_basis - a79*z_rk - a310*z_frie)


eq_ui_plo.formula <- u_plo ~ a08 + a18*z_basis + a38*z_67_79 + a48*z_80_ + a68*z_pu_o16 + a88*z_vk + a98*z_rkb +
  b18*(y - a11*z_basis - a31*z_landb - a12*z_basis - a22*z_sone - a32*z_6_15 - 
         a14*z_basis - a34*z_1_5 - a44*z_b_komm - a15*z_basis - a36*z_opph - a66*z_int -
         a47*z_fattige - a57*z_ph_17 - a18*z_basis - a38*z_67_79 - 
         a48*z_80_ - a68*z_pu_o16 - a88*z_vk - a98*z_rkb - a19*z_basis - a79*z_rk - a310*z_frie)

eq_ui_ann.formula <- u_ann ~ a09 + a19*z_basis + a79*z_rk +
  b19*(y - a11*z_basis - a31*z_landb - a12*z_basis - a22*z_sone - a32*z_6_15 - 
         a14*z_basis - a34*z_1_5 - a44*z_b_komm - a15*z_basis - a36*z_opph - a66*z_int -
         a47*z_fattige - a57*z_ph_17 - a18*z_basis - a38*z_67_79 - 
         a48*z_80_ - a68*z_pu_o16 - a88*z_vk - a98*z_rkb - a19*z_basis - a79*z_rk - a310*z_frie)




start.values <- c(a01=0, a11=9, a31=12, 
                  a02=0, a12=6, a22=0.1, a32=75, 
                  a04=0, a14=1, a34=140, a44=10,
                  a05=0, a15=3, 
                  a06=0, a36=2, a66=7,
                  a07=0, a47=30, a57=100,
                  a08=0, a18=8, a38=40, a48=120, a68=400, a88=1200, a98=1,
                  a09=0, a19=10, a79=5,
                  a310=0.5,
                  b11=0.05, b12=0.1, b14=0.1, b15=0.1, b16=0.1, b17=0.1, b18=0.2, b19=0.2)



model <- list(eq_ui_adm.formula, eq_ui_gs.formula, eq_ui_bh.formula, eq_ui_hs.formula, eq_ui_sos.formula,
              eq_ui_bv.formula, eq_ui_plo.formula, eq_ui_ann.formula)
 
model.sur <- nlsystemfit(method='SUR',model, start.values, data=df,solvtol=.Machine$double.xmin, maxiter=1000)
pars[,i] <- model.sur$b
pval[,i] <- model.sur$p
df$bk  <- model.sur$eq[[1]]$predicted+model.sur$eq[[2]]$predicted+model.sur$eq[[3]]$predicted+
          model.sur$eq[[4]]$predicted+model.sur$eq[[5]]$predicted+model.sur$eq[[6]]$predicted+model.sur$eq[[7]]$predicted+
         (0-model.sur$b[[1]]-model.sur$b[[4]]-model.sur$b[[8]]-model.sur$b[[12]]-model.sur$b[[14]]-model.sur$b[[17]]-model.sur$b[[20]])+
          model.sur$b[[27]]*df$z_basis+model.sur$b[[28]]*df$z_rk
        
df$ybk <- df$y - df$bk
print(summary(df$ybk))
for (j in 1:8) {
adjr2[j,i] <- model.sur$eq[[j]]$adjr2
r2[j,i]    <- model.sur$eq[[j]]$r2

}
}

pars <- cbind(pars,pval)
rownames(pars) <- names(model.sur$b)

proc.time() - ptm

write.csv(pars,'enkel/pars-enkel-fv1.csv',row.names=TRUE)


write.csv(r2,'enkel/r2-enkel-fv1.csv')
write.csv(adjr2,'enkel/adjr2-enkel-fv1.csv')



# 
# b15 <- 1-pars[16]-pars[17]-pars[18]-pars[19]
# a05 <- -pars[1]-pars[3]-pars[5]-pars[10]
# pars <- c(pars,b15,a05)
# pars <- pars[c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,21,16,17,18,19,20)]
# pars
# 






