#######################################################################################
#######################################################################################
########### This awesome script will determine the validation of our.. ################
######################################################## MODELS #######################
#######################################################################################



###### Regner med at vi har defineret modellerne i et andet program ###################

df_h <-read.csv("C:/specialeJR/Prisdata DST/v8_decil_h.csv",sep=',')
df <- df_h


################ Laver databehandling for gennemsnitshusstanden #######################

df     <- transform( df,
                     p1 = priser$Pris.kod_fisk_mej,
                     p2 = priser$Pris.ovr_fode,
                     p3 = priser$Pris.bol,
                     p4 = priser$Pris.ene_hje,
                     p5 = priser$Pris.ene_tra,
                     p6 = priser$Pris.tra,
                     p7 = priser$Pris.ovr_var,
                     p8 = priser$Pris.tra
) 
#shares findes som forbrug i lÃ¸bende priser/samlet forbrug af de otte varer.
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

#phat findes som priser divideret med samlet forbrug
df     <- transform( df,
                     phat1=p1/df$ialt,
                     phat2=p2/df$ialt,
                     phat3=p3/df$ialt,
                     phat4=p4/df$ialt,
                     phat5=p5/df$ialt,
                     phat6=p6/df$ialt,
                     phat7=p7/df$ialt,
                     phat8=p8/df$ialt
) 

#faste priser (2015-priser)
df     <- transform( df,
                     x1 = df$kod_fisk_mej /priser$Pris.kod_fisk_mej,
                     x2 = df$ovr_fode     /priser$Pris.ovr_fode,
                     x3 = df$bol          /priser$Pris.bol,
                     x4 = df$ene_hje      /priser$Pris.ene_hje,
                     x5 = df$ene_tra      /priser$Pris.ene_tra,
                     x6 = df$tra          /priser$Pris.tra,
                     x7 = df$ovr_var      /priser$Pris.ovr_var,
                     x8 = df$ovr_tje      /priser$Pris.tra 
)

#DatasÃ¦ttet sÃ¦ttes op i 'pÃ¦ne' matricer.
w = matrix(c(df$w1,df$w2,df$w3,df$w4,df$w5,df$w6,df$w7,df$w8),  nrow=26, ncol=8)
phat = matrix(c(df$phat1,df$phat2,df$phat3,df$phat4,df$phat5,df$phat6,df$phat7,df$phat8), nrow=26, ncol=8)
x = matrix(c(df$x1,df$x2,df$x3,df$x4,df$x5,df$x6,df$x7,df$x8), nrow=26, ncol=8)

#x og phat skaleres. X er forbrug i faste priser. Det er for at fÃ¥ bedre konvergens nÃ¥r der optimeres. Uklart
# om det stadig er et problem
x <- x/10000
phat <- phat*10000

dims=dim(w)
T=dims[1]
n=dims[2]


############################ Finder startværdier for optimeringsproblemet ##################################

#LÃ¸ser ligningssystem, sÃ¥ gamma'erne afspejler de Ã¸nskede alphaer startvÃ¦rdier
#SÃ¦t Ã¸nskede alpha fx lig budgetandele i sidste periode. gamma_n er lig 0.
# Her har vi valgt startværdier på 0.5 for AR, bstar og habit, samt en lav startværdi for timetrend og en høj startvrdi for autocorrelation. 
gammafn <- function(par,alpha_goal) {
  return(  sum((alpha_goal - exp(par)/(1+sum(exp(par))) )^2)    )
}
gammasol <- optim(par=rep(0,(n-1)),fn=gammafn, alpha_goal=w[T,1:(n-1)], method="BFGS", 
                  control=list(maxit=5000))
gamma_start <- c(gammasol$par,0)

#sÃ¦tter startvÃ¦rdier for bstar: her z pct. af det mindste forbrug over Ã¥rene af en given vare i fastepriser

b_start <- 0.5*apply(x, 2, min) # b skal fortolkes som 10.000 2015-kroner.

a <- w[T,1:(n)]  #igen, a er en logit
b <- b_start         # b er time-invariant
supernum <- 1-rowSums(phat %*% diag(b))
supernummat <- matrix(rep(supernum,n),ncol=n)
u <- w - phat %*% diag(b) - supernummat%*%diag(a)
#smid en variabel ud
uhat <- u[ ,1:(n-1)]
#find invers af cov(uhat) - jf. Peters note
covar <- cov(uhat)
#covar=t(chol(covar))%*%chol(covar)
#cholcovar <- chol(covar)
#covar_start <- c(cholcovar)
covar_start <- covar[lower.tri(covar,diag=TRUE)]

habit=rep(0.5,n)
AR = rep(0.5,n)
timetrend=rep(0.05,n)
autocorr <- 0.9

start_1 = c(gamma_start[1:(n-1)], b_start, covar_start)
start_2 = c(gamma_start[1:(n-1)], b_start, covar_start, autocorr)
start_3 = c(gamma_start[1:(n-1)], b_start, timetrend, covar_start)
start_4 = c(gamma_start[1:(n-1)], b_start, timetrend, covar_start, autocorr)
start_5 = c(gamma_start[1:(n-1)], b_start, habit, covar_start)
start_6 = c(gamma_start[1:(n-1)], b_start, habit, covar_start, autocorr)
start_7 = c(gamma_start[1:(n-1)], AR, habit, covar_start, autocorr)
start_8 = c(gamma_start[1:(n-1)], AR, habit, covar_start, autocorr)



############################ Cross validation #####################################

##OBS: skal jeg fitte dem på en anden måde med autocorrelation ?? 


### Baseret på BIC har model 2, 4, 5, 6 og 7 de mindste værdier, hvorfor de er de bedste modeller.


### Vi tager 20 obs med, derefter 21, derefter 22, derefter 23, 24 og så 25 
endperiod1_4 = 26
endperiod5_6 = 25
endperiod7_8 = 24
endtrain = 19
error5 = data.frame(V1=integer(),V2=integer(),V3=integer(),V4=integer(),V5=integer(),V6=integer(),V7=integer(),V8=integer())
error6 = error5
error2 = error5
error4 = error5
error7 = error5
error1 = error5
error3 = error5
error8=error5
################################## Model 1 til 4 ###############################################
for(i in 1:(endperiod1_4-endtrain)){
  # Først definere vi train-data og test-obs
  wtrain <- window(w, end=endtrain-1 + i) 
  wnext <- window(w, start=endtrain + i, end=endtrain + i) 
  xtrain <- window(x, end=endtrain-1 + i)
  xnext <- window(x, start=endtrain-1 + i, end=endtrain-1 + i) 
  phattrain <- window(phat, end=endtrain-1 + i)
  phatnext <- window(phat, start=endtrain + i, end=endtrain + i)
  
  # Fitter modellen
  
  sol1 <-  optim(par = start_1, fn = loglik, model=1, 
                 phat=phattrain, w=wtrain, x=xtrain, method="BFGS",
                 control=list(maxit=5000,
                              trace=6,
                              ndeps = rep(1e-10,length(start_1))) )
  sol2 <-  optim(par = start_2, fn = loglik, model=2, 
                 phat=phattrain, w=wtrain, x=xtrain, method="BFGS",
                 control=list(maxit=5000,
                              trace=6,
                              ndeps = rep(1e-10,length(start_2))) )
  sol3 <-  optim(par = start_3, fn = loglik, model=3, 
                 phat=phattrain, w=wtrain, x=xtrain, method="BFGS",
                 control=list(maxit=5000,
                              trace=6,
                              ndeps = rep(1e-10,length(start_3))) )
  sol4 <-  optim(par = start_4, fn = loglik, model=4, 
                 phat=phattrain, w=wtrain, x=xtrain, method="BFGS",
                 control=list(maxit=5000,
                              trace=6,
                              ndeps = rep(1e-10,length(start_4))) )
  
  sol_gamma1 <- c(sol1$par[1:(n-1)],0)
  bstar_sol1 <- sol1$par[n:(2*n-1)]
  alpha_sol1 <- exp(sol_gamma1)/sum(exp(sol_gamma1))
  
  sol_gamma2 <- c(sol2$par[1:(n-1)],0)
  bstar_sol2 <- sol2$par[n:(2*n-1)]
  alpha_sol2 <- exp(sol_gamma2)/sum(exp(sol_gamma2))
  
  sol_gamma3 <- c(sol3$par[1:(n-1)],0)
  bstar_sol3 <- sol3$par[n:(2*n-1)]
  alpha_sol3 <- exp(sol_gamma3)/sum(exp(sol_gamma3))
  time_sol3 <- sol3$par[2*n]
  
  sol_gamma4 <- c(sol4$par[1:(n-1)],0)
  bstar_sol4 <- sol4$par[n:(2*n-1)]
  alpha_sol4 <- exp(sol_gamma4)/sum(exp(sol_gamma4))
  time_sol4 <- sol4$par[2*n]
  
  ## Predicter næste obs af w
  b1 <- c(bstar_sol1)   
  supernum1 <- 1-rowSums(phatnext %*% diag(b1))
  supernummat1 <- matrix(rep(supernum1,n),ncol=n)
  fejl1 <- list(phatnext[,]*b1 + supernummat1%*%diag(alpha_sol1)-wnext[,])
  error1 <- rbind(error1,fejl1[[1]])
  
  b2 <- c(bstar_sol2)   
  supernum2 <- 1-rowSums(phatnext %*% diag(b2))
  supernummat2 <- matrix(rep(supernum2,n),ncol=n)
  fejl2 <- list(phatnext[,]*b2 + supernummat2%*%diag(alpha_sol2)-wnext[,])
  error2 <- rbind(error2,fejl2[[1]])
  
  tid <- c(1)
  b3 <- matrix(rep(bstar_sol3,1),nrow=(1),ncol=n, byrow=TRUE) + matrix(rep(tid,n),nrow=1, ncol=n)*time_sol3 #b defineres som matrix.
  supernum3 <- 1-rowSums(phatnext[,] * b3) #supernumerary income i hver periode sÃ¦ttes
  supernummat3 <- matrix(rep(supernum3,n),ncol=n)
  fejl3 <- list(phatnext[,]*b3 + supernummat3%*%diag(alpha_sol3)-wnext[,])
  error3 <- rbind(error3,fejl3[[1]])
  
  b4 <- matrix(rep(bstar_sol4,1),nrow=(1),ncol=n, byrow=TRUE) + matrix(rep(tid,n),nrow=1, ncol=n)*(time_sol4) #b defineres som matrix.
  supernum4 <- 1-rowSums(phatnext[,] * b4) #supernumerary income i hver periode sÃ¦ttes
  supernummat4 <- matrix(rep(supernum4,n),ncol=n)
  fejl4 <- list(phatnext[,]*b4 + supernummat4%*%diag(alpha_sol4)-wnext[,])
  error4 <- rbind(error4,fejl4[[1]])

  
}



################################## Model 5 og 6 ################################################
for(i in 1:(endperiod5_6-endtrain)){
  # Først definere vi train-data og test-obs
  wtrain <- window(w, end=endtrain-1 + i) 
  wnext <- window(w, start=endtrain + i, end=endtrain + i) 
  xtrain <- window(x, end=endtrain-1 + i)
  xnext <- window(x, start=endtrain-1 + i, end=endtrain-1 + i) 
  phattrain <- window(phat, end=endtrain-1 + i)
  phatnext <- window(phat, start=endtrain + i, end=endtrain + i)
  
  # Fitter modellen
  
  sol5 <-  optim(par = start_5, fn = loglik, model=5, 
                phat=phattrain, w=wtrain, x=xtrain, method="BFGS",
                control=list(maxit=5000,
                             trace=6,
                             ndeps = rep(1e-10,length(start_5))) )
  sol6 <-  optim(par = start_6, fn = loglik, model=5, 
                 phat=phattrain, w=wtrain, x=xtrain, method="BFGS",
                 control=list(maxit=5000,
                              trace=6,
                              ndeps = rep(1e-10,length(start_6))) )
  sol_gamma5 <- c(sol5$par[1:(n-1)],0)
  bstar_sol5 <- sol5$par[n:(2*n-1)]
  alpha_sol5 <- exp(sol_gamma5)/sum(exp(sol_gamma5))
  beta_sol5 <- sol6$par[(2*n):(3*n-1)]
  sol_gamma6 <- c(sol6$par[1:(n-1)],0)
  bstar_sol6 <- sol6$par[n:(2*n-1)]
  alpha_sol6 <- exp(sol_gamma6)/sum(exp(sol_gamma6))
  beta_sol6 <- sol6$par[(2*n):(3*n-1)]
  ac_const6 <- sol6$par[((2*(n) + (n-1)*((n-1)+1)/2))]
  
  # Predicter næste observation af w
  ## For model 5
  b5 <- matrix(rep(bstar_sol5,(1)),nrow=(1),ncol=n, byrow=TRUE) + xnext[,]%*%diag(beta_sol5)
  supernum5 <- 1-rowSums(phatnext[,]*b5) 
  supernummat5 <- matrix(rep(supernum5,n),ncol=n)
  fejl5 <- list( phatnext[,]*b5 + supernummat5%*%diag(alpha_sol5)-wnext[,])
  error5 <- rbind(error5,fejl5[[1]])
  
  ## For model 6
  b6 <- matrix(rep(bstar_sol6,(1)),nrow=(1),ncol=n, byrow=TRUE) + xnext[,]%*%diag(beta_sol6)
  supernum6 <- 1-rowSums(phatnext[,]*b6) #supernumerary income i hver periode sÃ¦ttes
  supernummat6 <- matrix(rep(supernum6,n),ncol=n)
  fejl6 <- list( phatnext[,]*b6 + supernummat6%*%diag(alpha_sol6)-wnext[,])
  error6 <- rbind(error6,fejl6[[1]])
  
}



################################## Model 7 og 8 ################################################
for(i in 1:(endperiod7_8-endtrain)){
  # Først definere vi train-data og test-obs
  wtrain <- window(w, end=endtrain-1 + i) 
  wnext <- window(w, start=endtrain + i, end=endtrain + i) 
  xtrain <- window(x, end=endtrain-1 + i)
  xnext <- window(x, start=endtrain-1 + i, end=endtrain-1 + i) 
  phattrain <- window(phat, end=endtrain-1 + i)
  phatnext <- window(phat, start=endtrain + i, end=endtrain + i)
  
  # Fitter modellen
  
  sol7 <-  optim(par = start_7, fn = loglik, model=7, 
                 phat=phattrain, w=wtrain, x=xtrain, method="BFGS",
                 control=list(maxit=5000,
                              trace=6,
                              ndeps = rep(1e-10,length(start_7))) )
  
  sol8 <-  optim(par = start_8, fn = loglik, model=8, 
                 phat=phattrain, w=wtrain, x=xtrain, method="BFGS",
                 control=list(maxit=5000,
                              trace=6,
                              ndeps = rep(1e-10,length(start_8))) )
  
  sol_gamma7 <- c(sol7$par[1:(n-1)],0)
  beta2_sol7 <- sol7$par[n:(2*n-1)]
  alpha_sol7 <- exp(sol_gamma7)/sum(exp(sol_gamma7))
  beta1_sol7 <- sol7$par[(2*n):(3*n-1)]
  
  sol_gamma8 <- c(sol8$par[1:(n-1)],0)
  beta2_sol8 <- sol8$par[n:(2*n-1)]
  alpha_sol8 <- exp(sol_gamma8)/sum(exp(sol_gamma8))
  beta1_sol8 <- sol8$par[(2*n):(3*n-1)]
  
  
  
  # Predicter næste observation af w
  # For model 7
  ## Hvad er b- end of sample? 
  sol_b_mat_7 = matrix(rep(0,endtrain-1 + i),nrow=endtrain-1 + i,ncol=n)
  sol_b_mat_7[1,] = c(rep(NA,n))
  sol_b_mat_7[2,] =  (x[2,])%*%diag(beta1_sol7) + (x[1,])%*%diag(c(0.6,0.5,0.7,0.7,0.7,0.7,0.6,0.6))%*%diag(beta2_sol_7)
  for (tal in c(3:endtrain-1 + i)) {
    sol_b_mat_7[tal,] = (x[tal-1,])%*%diag(beta1_sol7) + sol_b_mat_7[tal-1,]%*%diag(beta2_sol_7)}
  
  b7 <- xnext[,]%*%diag(beta1_sol7) + sol_b_mat_7[endtrain-1 + i,]%*%diag(beta2_sol_7)
  supernum7 <- 1-rowSums(phatnext[,]*b7) 
  supernummat7 <- matrix(rep(supernum7,n),ncol=n)
  fejl7 <- list( phatnext[,]*b7 + supernummat7%*%diag(alpha_sol7)-wnext[,])
  error7 <- rbind(error7,fejl7[[1]])
  
  sol_b_mat_8 = matrix(rep(0,endtrain-1 + i),nrow=endtrain-1 + i,ncol=n)
  sol_b_mat_8[1,] = c(rep(NA,n))
  sol_b_mat_8[2,] =  (x[2,])%*%diag(beta1_sol8) + (x[1,])%*%diag(c(0.6,0.5,0.7,0.7,0.7,0.7,0.6,0.6))%*%diag(beta2_sol_8)
  for (tal in c(3:endtrain-1 + i)) {
    sol_b_mat_8[tal,] = (x[tal-1,])%*%diag(beta1_sol8) + sol_b_mat_8[tal-1,]%*%diag(beta2_sol_8)}
  
  b8 <- xnext[,]%*%diag(beta1_sol8) + sol_b_mat_8[endtrain-1 + i,]%*%diag(beta2_sol_8)
  supernum8 <- 1-rowSums(phatnext[,]*b8) 
  supernummat8 <- matrix(rep(supernum8,n),ncol=n)
  fejl8 <- list( phatnext[,]*b8 + supernummat8%*%diag(alpha_sol8)-wnext[,])
  error8 <- rbind(error8,fejl8[[1]])
  
  
}


vareagg = c("Meat and diary","Other foods","Housing","Energy for housing","Energy for transport","Transport","Other goods","Other services")

mean_error1_varer = data.frame(sqrt((colSums(error1**2)/5)))
mean_error2_varer = data.frame(sqrt((colSums(error2**2)/5)))
mean_error3_varer = data.frame(sqrt((colSums(error3**2)/5)))
mean_error4_varer = data.frame(sqrt((colSums(error4**2)/5)))
mean_error5_varer = data.frame(sqrt((colSums(error5**2)/5)))
mean_error6_varer = data.frame(sqrt((colSums(error6**2)/5)))
mean_error7_varer = data.frame(sqrt((colSums(error6**2)/5)))
mean_error8_varer = data.frame(sqrt((colSums(error6**2)/5)))

RMSE = data.frame(V1=integer(),V2=integer(),V3=integer(),V4=integer(),V5=integer(),V6=integer(),V7=integer(),V8=integer())
RMSE = rbind(RMSE,mean_error1_varer)
RMSE = cbind(RMSE,mean_error2_varer)
RMSE = cbind(RMSE,mean_error3_varer)
RMSE = cbind(RMSE,mean_error4_varer)
RMSE = cbind(RMSE,mean_error5_varer)
RMSE = cbind(RMSE,mean_error6_varer)


########## Får fejl ved model 7 og 8 i likelihood funktionen #######
# Må se på det søndag #


