#######################################################################################
#######################################################################################
               ########### The script to get results !! .. ################
#####################################################################################
#######################################################################################

#####################################################################################
######   ###############


################ ?ndre datas?ttet #############################
df_kvintiler <- list(kvint_1,kvint_2,kvint_3,kvint_4,kvint_5, df_h)  ###
###############################################################
rnams_kvinttab <- c("Meat and dairy","Other foods","Housing","Energy for housing",
                    "Energy for transport","Transport","Other goods","Other services")
cnams_kvinttab <- c("1", "2", "3", "4", "5", "Avg.")

n=8

kvinttab_alpha  = matrix(nrow=n,ncol=6) #5+1 kvintiler
rownames(kvinttab_alpha) <- rnams_kvinttab
colnames(kvinttab_alpha) <- cnams_kvinttab
kvinttab_b2019   = kvinttab_alpha
kvinttab_beta1   = kvinttab_alpha
kvinttab_beta2   = kvinttab_alpha
kvinttab_actual2019   = kvinttab_alpha
kvinttab_pred2019= kvinttab_alpha

solutions = NA
bmin= NA

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
                       p8 = priser$Pris.ovr_tje
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
                       x8 = df$ovr_tje      /priser$Pris.ovr_tje 
  )
  
  #Datasættet sættes op i 'pæne' matricer.
  w = matrix(c(df$w1,df$w2,df$w3,df$w4,df$w5,df$w6,df$w7,df$w8),  nrow=26, ncol=8)
  phat = matrix(c(df$phat1,df$phat2,df$phat3,df$phat4,df$phat5,df$phat6,df$phat7,df$phat8), nrow=26, ncol=8)
  x = matrix(c(df$x1,df$x2,df$x3,df$x4,df$x5,df$x6,df$x7,df$x8), nrow=26, ncol=8)
  p = matrix(c(df$p1,df$p2,df$p3,df$p4,df$p5,df$p6,df$p7,df$p8), nrow=26, ncol=8)
  
  #x og phat skaleres. X er forbrug i faste priser. Det er for at få bedre konvergens når der optimeres. Uklart
  # om det stadig er et problem
  x <- x/10000
  phat <- phat*10000
  
  dims=dim(w)
  T=dims[1]
  n=dims[2]
  
  
  # Startværdier ----------------    
  #Løser ligningssystem, så gamma'erne afspejler de ønskede alphaer startværdier
  #Sæt ønskede alpha fx lig budgetandele i sidste periode. gamma_n er lig 0.
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
  covar_start <- covar[lower.tri(covar,diag=TRUE)]
  
  habit=rep(0.5,n)
  AR = rep(0.5,n)
  timetrend=rep(0.01,n)
  autocorr <- 0.9

  start_7 = c(gamma_start[1:(n-1)], AR, sqrt(habit), covar_start)
  ##############  K?r den foretrukne model ##########
  sol <-  optim(par = start_7, fn = loglik, model=7, 
                 phat=phat, w=w, x=x, method="BFGS",
                 control=list(maxit=5000,
                              trace=6,
                              ndeps = rep(1e-10,length(start_7))) )
  
  ######## gemmer solution ########

  solutions = rbind(solutions,sol)
  
  #Udregner minimumsforbruget for alle perioder.
  sol_gamma <- c(sol$par[1:(n-1)],0)
  alpha_sol <- exp(sol_gamma)/sum(exp(sol_gamma))
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
  mu=df$ialt
  supernum=mu-rowSums(p*sol_b_mat_7)
  
  for (g in 1:n){
    kvinttab_alpha[(g),dfdf]               =alpha_sol[g]
    kvinttab_b2019[(g),dfdf]               = p[26,g]*sol_b_mat_7[26,g]
    kvinttab_beta1[(g),dfdf]               = beta1_sol7[g]
    kvinttab_beta2[(g),dfdf]               = beta2_sol7[g] 
    kvinttab_actual2019[(g),dfdf]          = p[26,g]*x[26,g]*10000
    kvinttab_pred2019[(g),dfdf]            = p[26,g]*sol_b_mat_7[26,g] + alpha_sol[g]*(supernum[26])
  }

}

kvinttab_alpha
kvinttab_b2019
kvinttab_actual2019
kvinttab_pred2019
alphanam<-rep("alpha",6)
output <- rbind(kvinttab_alpha,kvinttab_b2019,kvinttab_beta1,kvinttab_beta2,kvinttab_actual2019,kvinttab_pred2019)

write.xlsx(output, "/Users/rasmuskaslund/Documents/GitHub/SpecialeJR /Partiel analyse/Output.xlsx", sheetName = "Output", 
           col.names = TRUE, row.names = TRUE, append = FALSE)
