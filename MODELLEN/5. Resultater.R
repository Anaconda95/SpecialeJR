#######################################################################################
#######################################################################################
               ########### The script to get results !! .. ################
#####################################################################################
#######################################################################################

#####################################################################################
######   ###############


################ �ndre datas�ttet #############################
df_kvintiler <- list(kvint_1,kvint_2,kvint_3,kvint_4,kvint_5)  ###
###############################################################
b_min <- c()
forbrug <- c()
solutions <- list()


for (dfdf in 1:length(df_kvintiler) ) {
  
  # Dataindlæsning  ---------
  df <- df_kvintiler[[dfdf]]
    

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
  #shares findes som forbrug i løbende priser/samlet forbrug af de otte varer.
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
  
  #Datasættet sættes op i 'pæne' matricer.
  w = matrix(c(df$w1,df$w2,df$w3,df$w4,df$w5,df$w6,df$w7,df$w8),  nrow=26, ncol=8)
  phat = matrix(c(df$phat1,df$phat2,df$phat3,df$phat4,df$phat5,df$phat6,df$phat7,df$phat8), nrow=26, ncol=8)
  x = matrix(c(df$x1,df$x2,df$x3,df$x4,df$x5,df$x6,df$x7,df$x8), nrow=26, ncol=8)
  
  #x og phat skaleres. X er forbrug i faste priser. Det er for at få bedre konvergens når der optimeres. Uklart
  # om det stadig er et problem
  x <- x/10000
  phat <- phat*10000
  
  dims=dim(w)
  T=dims[1]
  n=dims[2]
  
  
  ############################ Finder startv�rdier for optimeringsproblemet ##################################
  
  #Løser ligningssystem, så gamma'erne afspejler de ønskede alphaer startværdier
  #Sæt ønskede alpha fx lig budgetandele i sidste periode. gamma_n er lig 0.
  # Her har vi valgt startv�rdier p� 0.5 for AR, bstar og habit, samt en lav startv�rdi for timetrend og en h�j startvrdi for autocorrelation. 
  gammafn <- function(par,alpha_goal) {
    return(  sum((alpha_goal - exp(par)/(1+sum(exp(par))) )^2)    )
  }
  gammasol <- optim(par=rep(0,(n-1)),fn=gammafn, alpha_goal=w[T,1:(n-1)], method="BFGS", 
                    control=list(maxit=5000))
  gamma_start <- c(gammasol$par,0)
  
  #sætter startværdier for bstar: her z pct. af det mindste forbrug over årene af en given vare i fastepriser
  
  b_start <- 0.7*apply(x, 2, min) # b skal fortolkes som 10.000 2015-kroner.
  
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
  timetrend=rep(0.01,n)
  autocorr <- 0.9
  
  start_1 = c(gamma_start[1:(n-1)], b_start, covar_start)
  start_2 = c(gamma_start[1:(n-1)], b_start, covar_start, autocorr)
  start_3 = c(gamma_start[1:(n-1)], b_start, timetrend, covar_start)
  start_4 = c(gamma_start[1:(n-1)], b_start, timetrend, covar_start, autocorr)
  start_5 = c(gamma_start[1:(n-1)], b_start, habit, covar_start)
  start_6 = c(gamma_start[1:(n-1)], b_start, habit, covar_start, autocorr)
  start_7 = c(gamma_start[1:(n-1)], AR, habit, covar_start, autocorr)
  start_8 = c(gamma_start[1:(n-1)], AR, habit, covar_start, autocorr)
  
  
  
  
  ##############  K�r den foretrukne model ##########
  sol <-  optim(par = start_7, fn = loglik, model=7, 
                 phat=phat, w=w, x=x, method="BFGS",
                 control=list(maxit=5000,
                              trace=6,
                              ndeps = rep(1e-10,length(start_7))) )
  
  ######## gemmer solution ########
  
  solutions = rbind(solutions,sol)
  
  
  ######
  beta1_sol7 = sol$par[(2*n):(3*n-1)]**2
  beta2_sol7 = sol$par[n:(2*n-1)]
  sol_b_mat_7 = matrix(rep(0,26),nrow=26,ncol=n)
  #sol_b_mat_7[1,] = c(rep(NA,n))
  #sol_b_mat_7[2,] = c(rep(NA,n))
  sol_b_mat_7[3,] =  (10000*x[2,])%*%diag(beta1_sol7) + (10000*x[1,])%*%diag(AR_p_start)%*%diag(beta2_sol7)
  sol_b_mat_7[4,] =  10000*x[3,]%*%diag(beta1_sol7) + sol_b_mat_7[3,]%*%diag(beta2_sol7)
  sol_b_mat_7[5,] =  10000*x[4,]%*%diag(beta1_sol7) + sol_b_mat_7[4,]%*%diag(beta2_sol7)
  sol_b_mat_7[6,] =  10000*x[5,]%*%diag(beta1_sol7) + sol_b_mat_7[5,]%*%diag(beta2_sol7)
  sol_b_mat_7[7,] =  10000*x[6,]%*%diag(beta1_sol7) + sol_b_mat_7[6,]%*%diag(beta2_sol7)
  sol_b_mat_7[8,] =  10000*x[7,]%*%diag(beta1_sol7) + sol_b_mat_7[7,]%*%diag(beta2_sol7)
  sol_b_mat_7[9,] =  10000*x[8,]%*%diag(beta1_sol7) + sol_b_mat_7[8,]%*%diag(beta2_sol7)
  sol_b_mat_7[10,] = 10000*x[9,]%*%diag(beta1_sol7) + sol_b_mat_7[9,]%*%diag(beta2_sol7)
  sol_b_mat_7[11,] = 10000*x[10,]%*%diag(beta1_sol7) + sol_b_mat_7[10,]%*%diag(beta2_sol7)
  sol_b_mat_7[12,] = 10000*x[11,]%*%diag(beta1_sol7) + sol_b_mat_7[11,]%*%diag(beta2_sol7)
  sol_b_mat_7[13,] = 10000*x[12,]%*%diag(beta1_sol7) + sol_b_mat_7[12,]%*%diag(beta2_sol7)
  sol_b_mat_7[14,] = 10000*x[13,]%*%diag(beta1_sol7) + sol_b_mat_7[13,]%*%diag(beta2_sol7)
  sol_b_mat_7[15,] = 10000*x[14,]%*%diag(beta1_sol7) + sol_b_mat_7[14,]%*%diag(beta2_sol7)
  sol_b_mat_7[16,] = 10000*x[15,]%*%diag(beta1_sol7) + sol_b_mat_7[15,]%*%diag(beta2_sol7)
  sol_b_mat_7[17,] = 10000*x[16,]%*%diag(beta1_sol7) + sol_b_mat_7[16,]%*%diag(beta2_sol7)
  sol_b_mat_7[18,] = 10000*x[17,]%*%diag(beta1_sol7) + sol_b_mat_7[17,]%*%diag(beta2_sol7)
  sol_b_mat_7[19,] = 10000*x[18,]%*%diag(beta1_sol7) + sol_b_mat_7[18,]%*%diag(beta2_sol7)
  sol_b_mat_7[20,] = 10000*x[19,]%*%diag(beta1_sol7) + sol_b_mat_7[19,]%*%diag(beta2_sol7)
  sol_b_mat_7[21,] = 10000*x[20,]%*%diag(beta1_sol7) + sol_b_mat_7[20,]%*%diag(beta2_sol7)
  sol_b_mat_7[22,] = 10000*x[21,]%*%diag(beta1_sol7) + sol_b_mat_7[21,]%*%diag(beta2_sol7)
  sol_b_mat_7[23,] = 10000*x[22,]%*%diag(beta1_sol7) + sol_b_mat_7[22,]%*%diag(beta2_sol7)
  sol_b_mat_7[24,] = 10000*x[23,]%*%diag(beta1_sol7) + sol_b_mat_7[23,]%*%diag(beta2_sol7)
  sol_b_mat_7[25,] = 10000*x[24,]%*%diag(beta1_sol7) + sol_b_mat_7[24,]%*%diag(beta2_sol7)
  sol_b_mat_7[26,] = 10000*x[25,]%*%diag(beta1_sol7) + sol_b_mat_7[25,]%*%diag(beta2_sol7)
  
  b_min[[dfdf]] = sol_b_mat_7
  forbrug[[dfdf]] =x*10000

}

b_min1 = b_min[[1]]
b_min2 = b_min[[2]]
b_min3 = b_min[[3]]
b_min4 = b_min[[4]]
b_min5 = b_min[[5]]

forbrug1 = forbrug[[1]]
forbrug2 = forbrug[[2]]
forbrug3 = forbrug[[3]]
forbrug4 = forbrug[[4]]
forbrug5 = forbrug[[5]]

b_min2019 <- b_min1[26,]
b_min2019 <- rbind(b_min2019, b_min2[26,])
b_min2019 <- rbind(b_min2019, b_min3[26,])
b_min2019 <- rbind(b_min2019, b_min4[26,])
b_min2019 <- rbind(b_min2019, b_min5[26,])

forbrug2019 <- forbrug1[26,]
forbrug2019 <- rbind(forbrug2019,forbrug2[26,])
forbrug2019 <- rbind(forbrug2019,forbrug3[26,])
forbrug2019 <- rbind(forbrug2019,forbrug4[26,])
forbrug2019 <- rbind(forbrug2019,forbrug5[26,])

write.csv(b_min2019, "C:/specialeJR/MODELLEN/b_min2019.csv" )
write.csv(forbrug2019, "C:/specialeJR/MODELLEN/forbrug2019.csv" )

write.csv(b_min1, "C:/specialeJR/MODELLEN/b_min1" )
write.csv(b_min2, "C:/specialeJR/MODELLEN/b_min2" )
write.csv(b_min3, "C:/specialeJR/MODELLEN/b_min3" )
write.csv(b_min4, "C:/specialeJR/MODELLEN/b_min4" )
write.csv(b_min5, "C:/specialeJR/MODELLEN/b_min5" )

write.csv(forbrug1, "C:/specialeJR/MODELLEN/forbrug1" )
write.csv(forbrug2, "C:/specialeJR/MODELLEN/forbrug2" )
write.csv(forbrug3, "C:/specialeJR/MODELLEN/forbrug3" )
write.csv(forbrug4, "C:/specialeJR/MODELLEN/forbrug4" )
write.csv(forbrug5, "C:/specialeJR/MODELLEN/forbrug5" )

x*10000
sol_kvint1 = solutions[[1]]
sol_kvint2 = solutions[[2]]
sol_kvint3 = solutions[[3]]
sol_kvint4 = solutions[[4]]
sol_kvint5 = solutions[[5]]

sol_gamma_1 <- c(sol_kvint1[1:(n-1)],0)
sol_gamma_2 <- c(sol_kvint2[1:(n-1)],0)
sol_gamma_3 <- c(sol_kvint3[1:(n-1)],0)
sol_gamma_4 <- c(sol_kvint4[1:(n-1)],0)
sol_gamma_5 <- c(sol_kvint5[1:(n-1)],0)

beta2_sol_1 <- sol_kvint1[n:(2*n-1)]
beta2_sol_2 <- sol_kvint2[n:(2*n-1)]
beta2_sol_3 <- sol_kvint3[n:(2*n-1)]
beta2_sol_4 <- sol_kvint4[n:(2*n-1)]
beta2_sol_5 <- sol_kvint5[n:(2*n-1)]
  
alpha_sol_1 <- exp(sol_gamma_1)/sum(exp(sol_gamma_1))
alpha_sol_2 <- exp(sol_gamma_1)/sum(exp(sol_gamma_2))
alpha_sol_3 <- exp(sol_gamma_1)/sum(exp(sol_gamma_3))
alpha_sol_4 <- exp(sol_gamma_1)/sum(exp(sol_gamma_4))
alpha_sol_5 <- exp(sol_gamma_1)/sum(exp(sol_gamma_5))

beta_sol_1 <- sol_kvint1[(2*n):(3*n-1)]**2
beta_sol_2 <- sol_kvint2[(2*n):(3*n-1)]**2
beta_sol_3 <- sol_kvint3[(2*n):(3*n-1)]**2
beta_sol_4 <- sol_kvint4[(2*n):(3*n-1)]**2
beta_sol_5 <- sol_kvint5[(2*n):(3*n-1)]**2


