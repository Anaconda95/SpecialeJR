#clear workspace
rm(list=ls())
library(mvtnorm)
library("xlsx")

#no scientific numbers
options(scipen=999)
options(digits=3)
#Definerer funktioner -------

#funktion til at lave symmetrisk matrix
makeSymm <- function(m) {
  m[upper.tri(m)] <- t(m)[upper.tri(m)]
  return(m)
}


# Indlæs data-------
priser<-read.csv("PRISINDEKS.csv",sep=',')
df_h <-read.csv("v8_decil_h.csv",sep=',')
df_1 <-read.csv("v8_decil_1.csv",sep=',')
df_2 <-read.csv("v8_decil_2.csv",sep=',')
df_3 <-read.csv("v8_decil_3.csv",sep=',')
df_4 <-read.csv("v8_decil_4.csv",sep=',')
df_5 <-read.csv("v8_decil_5.csv",sep=',')
df_6 <-read.csv("v8_decil_6.csv",sep=',')
df_7 <-read.csv("v8_decil_7.csv",sep=',')
df_8 <-read.csv("v8_decil_8.csv",sep=',')
df_9 <-read.csv("v8_decil_9.csv",sep=',')
df_10<-read.csv("v8_decil_10.csv",sep=',')



write.xlsx(df_10,"8var.xlsx", sheetName="10 decil",col.names = TRUE, row.names = TRUE, append = FALSE)
write.xlsx(df_1,"8var.xlsx", sheetName="1 decil",col.names = TRUE, row.names = TRUE, append = TRUE)
write.xlsx(df_h,"8var.xlsx", sheetName="Gennemsnit",col.names = TRUE, row.names = TRUE, append = TRUE)
#Skal køres samtidig
dataframes = list(df_h, df_1, df_2, df_3, df_4, df_5, df_6, df_7, df_8, df_9, df_10)

#definerer funktionen - vigtigt-----------------------
loglik <- function(par,w,phat,x,habitform) {
  #sætter dimensioner
  dims=dim(w)
  T=dims[1]
  n=dims[2]
  #med habitformation
  if (habitform==1){
    gamma <- c(par[1:(n-1)],0) #gamma definereres - kun for de første n-1 parametre. gamma_n=0.
    a <- exp(gamma)/sum(exp(gamma))  # a som en logit (sikrer mellem 0 og 1)
    bstar <- c(par[n:(2*n-1)]) # bstar: n parametre
    beta <- c(par[(2*n):(3*n-1)]) #beta: n parametre
    #  beta <- exp(beta)/(1+exp(beta)) #prøver at gøre det til logit
    #Med habit formation må ét år fjernes fra estimeringen.
    b <- matrix(rep(bstar,(T-1)),nrow=(T-1),ncol=n, byrow=TRUE) + x[1:(T-1),]%*%diag(beta) #b defineres som matrix.
    supernum <- 1-rowSums(phat[2:T,] * b) #supernumerary income i hver periode sættes
    supernummat <- matrix(rep(supernum,n),ncol=n) # for at lette beregningen af u replikeres n gange til en matrixe
    u <- w[2:T,] - phat[2:T,]*b - supernummat%*%diag(a) #u beregnes ud fra modellen
    #En kolonne u'er smides ud, da matricen ellers er singulær
    uhat <- u[ , 1:(n-1)]
    #vi prøver lige at fixe noget autocorrelation
    ehat <- uhat[2:(T-1),]- par[((3*(n) + (n-1)*((n-1)+1)/2))]*uhat[1:(T-2),]
    # omega skal være covariansmatricen for den normalfordeling
    # omega skal også estimeres som parameter.
    #find omega matrix()
    omega <- matrix(NA,(n-1),(n-1))
    omega[lower.tri(omega,diag=TRUE)] <- par[(3*n) : ((3*(n) + (n-1)*((n-1)+1)/2) - 1) ]
    omega<-makeSymm(omega)
    #omegainv <- solve(omega)
    #udregn u_t'Au_t for at kunne tage summen
    #uhatomegainvuhat <- apply(uhat,1,function(x) x %*% omegainv %*% x)
    #likelihood funktionen
    l1 = dmvnorm(x=ehat, mean=rep(0,n-1), sigma=omega, log=TRUE)
    return(   -sum(l1) )
    #umiddelbart regner følgende rigtigt ud, men det går helt galt, når den skal optimere
    #return(   -( -(n-1)*(T-1)*log(2*pi)/2   -(T-1)/2*(det(omega, log=TRUE)) -1/2*sum(uhatomegainvuhat) )     )  
  }else if (habitform == 0) {  #uden habit formation
    gamma <- c(par[1:(n-1)],0)  
    a <- exp(gamma)/sum(exp(gamma))  #igen, a er en logit
    b <- c(par[n:(2*n-1)])           # b er time-invariant
    supernum <- 1-rowSums(phat %*% diag(b))
    supernummat <- matrix(rep(supernum,n),ncol=n)
    u <- w - phat %*% diag(b) - supernummat%*%diag(a)
    #smid en variabel ud
    uhat <- u[ (2:T),1:(n-1)]
    #autocorrelation
    ehat <- uhat[2:(T-1),]- par[((2*(n) + (n-1)*((n-1)+1)/2))]*uhat[1:(T-2),]
    #find omega matrix()
    omega <- matrix(NA,(n-1),(n-1))
    omega[lower.tri(omega,diag=TRUE)] <- par[(2*n) : ((2*(n) + (n-1)*((n-1)+1)/2) - 1) ]
    omega<-makeSymm(omega)
    #omegainv <- solve(omega)
    #udregn u_t'Au_t for at kunne tage summen
    # uhatomegainvuhat <- apply(uhat,1,function(x) x %*% omegainv %*% x)
    #likelihood funktionen
    l1 = dmvnorm(x=ehat, mean=rep(0,n-1), sigma=omega, log=TRUE)
    return(   -sum(l1) )
    #return(   -(- (n-1)/2*T*log(2*pi) -  T/2*(log(det(omega))) - 1/2*sum(uhatomegainvuhat) )     )
  } else
    print("Set habitform = 1 or =0 ")
}

n=8
vareagg = c("kod_fisk_mej","ovr_fode","bol","ene_hje","ene_tra","tra","ovr_var","ovr_tje")

# Med habitform og autocorr -------------

resul <- rep(NA,n)
resul_el <- rep(NA,n)
aic_mat <- NA
for (j in 1:length(dataframes) ) {

# Dataindlæsning  ---------
df <- dataframes[[j]]  

#make prices and shares
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

# Startværdier ----------------    
#Løser ligningssystem, så gamma'erne afspejler de ønskede alphaer startværdier
#Sæt ønskede alpha fx lig budgetandele i sidste periode.
#gamma_n er lig 0.
gammafn <- function(par,alpha_goal) {
  return(  sum((alpha_goal - exp(par)/(1+sum(exp(par))) )^2)    )
}
gammasol <- optim(par=rep(0,(n-1)),fn=gammafn, alpha_goal=w[T,1:(n-1)], method="BFGS", 
                  control=list(maxit=5000))
#print(gammasol)
gamma_start <- c(gammasol$par,0)
alpha_start <- exp(gamma_start)/sum(exp(gamma_start))

#tjekker at det passer.
#print(w[T,1:(n)])
#print(alpha_start)

#sætter startværdier for bstar: her z pct. af det mindste forbrug over årene af en given vare i fastepriser
b_start <- 0.25*apply(x, 2, min) # b skal fortolkes som 10.000 2015-kroner.

#finder startværdier for kovariansmatricen

a <- alpha_start  #igen, a er en logit
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

start_uhabit = c(gamma_start[1:(n-1)], b_start, covar_start)
#print(start)

#sætter startværdier for habit formation og autocorr
habit=rep(0.5,n)
autocorr <- 0.5
start_habit = c(gamma_start[1:(n-1)], b_start, habit, covar_start, autocorr)
#print(start_habit)
#par=start_habit

# S?tter startv?rdier for uden habit formation 
start_uhabit = c(gamma_start[1:(n-1)], b_start,covar_start,autocorr)
#print(start_uhabit)

# Maksimerer likelihood---------------
#virker med BFGS, og konvergerer for forskellige startværdier.
# og B'erne er sindssygt afhængige af startværdier.

sol_habit <-  optim(  par = start_habit, fn = loglik, habitform=1,
                      phat=phat, w=w, x=x, method="BFGS",
                      #                                                    lower = lower ,  upper= upper , 
                      control=list(maxit=5000,
                                   trace=6,
                                   ndeps = rep(1e-10,length(start_habit)))    )

# Printer resultater --------
sol_gamma <- c(sol_habit$par[1:(n-1)],0)
bstar_sol <- sol_habit$par[n:(2*n-1)]*10000
alpha_sol <- exp(sol_gamma)/sum(exp(sol_gamma))
beta_sol <- sol_habit$par[(2*n):(3*n-1)]
acorr <- sol_habit$par[((3*(n) + (n-1)*((n-1)+1)/2))]
#print(sol_alpha)
#print(sol_b)
#print(sol_beta)
sol_b_mat <- matrix(rep(bstar_sol,(T-1)),nrow=(T-1),ncol=n, byrow=TRUE) + 10000*x[1:(T-1),]%*%diag(beta_sol)
b_sol <- colMeans(sol_b_mat)
#supernum <- 1-rowSums(phat[2:T,] * sol_b_mat/10000) 
acorr <- rep(acorr,n)
ownp_el <- b_sol*(1-alpha_sol)/(colMeans(x)*10000)-1 #should be mean of x
inc_el <-  alpha_sol*mean(rowSums(x))/(colMeans(priser[,2:9])*colMeans(x))

decil <- rep(j-1,n)
resul <- rbind(resul, decil, alpha_sol, bstar_sol, beta_sol, acorr,ownp_el,inc_el)
resul_el <- rbind(resul_el,decil,ownp_el,inc_el)

#Information criteria - from Wikipedia page on akaike information criteria.
AIC = 2*length(sol_habit$par) + 2*sol_habit$value
aic_mat <- rbind(aic_mat,AIC)

}
#Udskriver resultater til excel ---------
resul_2 <- resul[-1,]
colnames(resul_2) <- vareagg
write.xlsx(resul_2, "8var_est_res.xlsx", sheetName = "Habitform, acorr", 
           col.names = TRUE, row.names = TRUE, append = FALSE)

colnames(resul_el) <- vareagg
resul_el <- resul_el[-1,]
write.xlsx(resul_el, "8var_elast.xlsx", sheetName = "Habitform, acorr", 
           col.names = TRUE, row.names = TRUE, append = FALSE)






# Uden habitform acorr -------------------------------------------------------------------------------------------------
resul <- rep(NA,n)
resul_el <- rep(NA,n)
for (j in 1:length(dataframes) ) {
##Dataindlæsning ----------
  df <- dataframes[[j]]  
  
  #make prices and shares
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
  ##Startværdier ----------
  #Løser ligningssystem, så gamma'erne afspejler de ønskede alphaer startværdier
  #Sæt ønskede alpha fx lig budgetandele i sidste periode.
  #gamma_n er lig 0.
  gammafn <- function(par,alpha_goal) {
    return(  sum((alpha_goal - exp(par)/(1+sum(exp(par))) )^2)    )
  }
  gammasol <- optim(par=rep(0,(n-1)),fn=gammafn, alpha_goal=w[T,1:(n-1)], method="BFGS", 
                    control=list(maxit=5000))
  #print(gammasol)
  gamma_start <- c(gammasol$par,0)
  alpha_start <- exp(gamma_start)/sum(exp(gamma_start))
  
  #tjekker at det passer.
  #print(w[T,1:(n)])
  #print(alpha_start)
  
  #sætter startværdier for bstar: her z pct. af det mindste forbrug over årene af en given vare i fastepriser
  b_start <- 0.25*apply(x, 2, min) # b skal fortolkes som 10.000 2015-kroner.
  
  #finder startværdier for kovariansmatricen
  
  a <- alpha_start  #igen, a er en logit
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
  
  start_uhabit = c(gamma_start[1:(n-1)], b_start, covar_start)
  #print(start)
  
  #sætter startværdier for habit formation og autocorr
  habit=rep(0.5,n)
  autocorr <- 0.5
  start_habit = c(gamma_start[1:(n-1)], b_start, habit, covar_start, autocorr)
  #print(start_habit)
  #par=start_habit
  
  # S?tter startv?rdier for uden habit formation 
  start_uhabit = c(gamma_start[1:(n-1)], b_start,covar_start,autocorr)
  #print(start_uhabit)
  
  #Maksimererlikelihood----------------
  
  # Uden habit formation
   sol_uhabit <-  optim(  par = start_uhabit, fn = loglik, habitform=0,
                          phat=phat, w=w, x=x, method="BFGS",
                          #                             lower = lower ,  upper= upper ,
                          control=list(maxit=5000,
                                       trace=99,
                                       ndeps = rep(1e-10,length(start_uhabit)))    )
  ##Printer resultater ----------
   sol_gamma <- c(sol_uhabit$par[1:(n-1)],0)
   b_sol <- sol_uhabit$par[n:(2*n-1)]*10000
   alpha_sol <- exp(sol_gamma)/sum(exp(sol_gamma))
   #print(sol_alpha)
   # print(sol_b)
   #sol_b_mat <- matrix(rep(sol_b,(T-1)),nrow=(T-1),ncol=n, byrow=TRUE)
   #matrix(c(sol_b_mat,10000*x[2:(T),]),nrow=25,ncol=8, byrow=FALSE)
   acorr <- rep(sol_uhabit$par[((2*(n) + (n-1)*((n-1)+1)/2))],n)
   ownp_el <- b_sol*(1-alpha_sol)/(colMeans(x)*10000)-1 #should be mean of x
   inc_el <-  alpha_sol*mean(rowSums(x))/(colMeans(priser[,2:9])*colMeans(x))
   
  
  decil <- rep(j-1,n)
  resul <- rbind(resul, decil, alpha_sol, b_sol, acorr,ownp_el,inc_el)
  resul_el <- rbind(resul_el,decil,ownp_el,inc_el)
  #calculating AIC
  AIC = 2*length(sol_uhabit$par) + 2*sol_uhabit$value
  aic_mat <- rbind(aic_mat,AIC)
  
}
#udskriver til excel-------
colnames(resul) <- vareagg
resul_2 <- resul[-1,]
write.xlsx(resul_2, "8var_est_res.xlsx", sheetName = "Uden habitform, acorr", 
           col.names = TRUE, row.names = TRUE, append = TRUE)

colnames(resul_el) <- vareagg
resul_el <- resul_el[-1,]
write.xlsx(resul_el, "8var_elast.xlsx", sheetName = "Uden habitform, acorr", 
           col.names = TRUE, row.names = TRUE, append = TRUE)



####################### UDEN AUTOCORRELATION #######################################


#definerer funktionen - vigtigt----
loglikNEJ <- function(par,w,phat,x,habitform) {
  #sætter dimensioner
  dims=dim(w)
  T=dims[1]
  n=dims[2]
  #med habitformation
  if (habitform==1){
    gamma <- c(par[1:(n-1)],0) #gamma definereres - kun for de første n-1 parametre. gamma_n=0.
    a <- exp(gamma)/sum(exp(gamma))  # a som en logit (sikrer mellem 0 og 1)
    bstar <- c(par[n:(2*n-1)]) # bstar: n parametre
    beta <- c(par[(2*n):(3*n-1)]) #beta: n parametre
    #  beta <- exp(beta)/(1+exp(beta)) #prøver at gøre det til logit
    #Med habit formation må ét år fjernes fra estimeringen.
    b <- matrix(rep(bstar,(T-1)),nrow=(T-1),ncol=n, byrow=TRUE) + x[1:(T-1),]%*%diag(beta) #b defineres som matrix.
    supernum <- 1-rowSums(phat[2:T,] * b) #supernumerary income i hver periode sættes
    supernummat <- matrix(rep(supernum,n),ncol=n) # for at lette beregningen af u replikeres n gange til en matrixe
    u <- w[2:T,] - phat[2:T,]*b - supernummat%*%diag(a) #u beregnes ud fra modellen
    #En kolonne u'er smides ud, da matricen ellers er singulær
    uhat <- u[ , 1:(n-1)]
    #vi prøver lige at fixe noget autocorrelation
    #ehat <- uhat[2:(T-1),]- par[((3*(n) + (n-1)*((n-1)+1)/2))]*uhat[1:(T-2),]
    # omega skal være covariansmatricen for den normalfordeling
    # omega skal også estimeres som parameter.
    #find omega matrix()
    omega <- matrix(NA,(n-1),(n-1))
    omega[lower.tri(omega,diag=TRUE)] <- par[(3*n) : ((3*(n) + (n-1)*((n-1)+1)/2) - 1) ]
    omega<-makeSymm(omega)
    #omegainv <- solve(omega)
    #udregn u_t'Au_t for at kunne tage summen
    #uhatomegainvuhat <- apply(uhat,1,function(x) x %*% omegainv %*% x)
    #likelihood funktionen
    l1 = dmvnorm(x=uhat, mean=rep(0,n-1), sigma=omega, log=TRUE)
    return(   -sum(l1) )
    #umiddelbart regner følgende rigtigt ud, men det går helt galt, når den skal optimere
    #return(   -( -(n-1)*(T-1)*log(2*pi)/2   -(T-1)/2*(det(omega, log=TRUE)) -1/2*sum(uhatomegainvuhat) )     )  
  }else if (habitform == 0) {  #uden habit formation
    gamma <- c(par[1:(n-1)],0)  
    a <- exp(gamma)/sum(exp(gamma))  #igen, a er en logit
    b <- c(par[n:(2*n-1)])           # b er time-invariant
    supernum <- 1-rowSums(phat %*% diag(b))
    supernummat <- matrix(rep(supernum,n),ncol=n)
    u <- w - phat %*% diag(b) - supernummat%*%diag(a)
    #smid en variabel ud
    uhat <- u[ ,1:(n-1)]
    #autocorrelation
    #ehat <- uhat[2:(T),]- par[((2*(n) + (n-1)*((n-1)+1)/2))]*uhat[1:(T-1),]
    #find omega matrix()
    omega <- matrix(NA,(n-1),(n-1))
    omega[lower.tri(omega,diag=TRUE)] <- par[(2*n) : ((2*(n) + (n-1)*((n-1)+1)/2) - 1) ]
    omega<-makeSymm(omega)
    #omegainv <- solve(omega)
    #udregn u_t'Au_t for at kunne tage summen
    # uhatomegainvuhat <- apply(uhat,1,function(x) x %*% omegainv %*% x)
    #likelihood funktionen
    l1 = dmvnorm(x=uhat, mean=rep(0,n-1), sigma=omega, log=TRUE)
    return(   -sum(l1) )
    #return(   -(- (n-1)/2*T*log(2*pi) -  T/2*(log(det(omega))) - 1/2*sum(uhatomegainvuhat) )     )
  } else
    print("Set habitform = 1 or =0 ")
}

#definerer funktionen for T-2 for sammenlignelighed i AIC-kriterier
loglik <- function(par,w,phat,x,habitform) {
  #sætter dimensioner
  dims=dim(w)
  T=dims[1]
  n=dims[2]
  #med habitformation
  if (habitform==1){
    gamma <- c(par[1:(n-1)],0) #gamma definereres - kun for de første n-1 parametre. gamma_n=0.
    a <- exp(gamma)/sum(exp(gamma))  # a som en logit (sikrer mellem 0 og 1)
    bstar <- c(par[n:(2*n-1)]) # bstar: n parametre
    beta <- c(par[(2*n):(3*n-1)]) #beta: n parametre
    #  beta <- exp(beta)/(1+exp(beta)) #prøver at gøre det til logit
    #Med habit formation må ét år fjernes fra estimeringen.
    b <- matrix(rep(bstar,(T-1)),nrow=(T-1),ncol=n, byrow=TRUE) + x[1:(T-1),]%*%diag(beta) #b defineres som matrix.
    supernum <- 1-rowSums(phat[2:T,] * b) #supernumerary income i hver periode sættes
    supernummat <- matrix(rep(supernum,n),ncol=n) # for at lette beregningen af u replikeres n gange til en matrixe
    u <- w[2:T,] - phat[2:T,]*b - supernummat%*%diag(a) #u beregnes ud fra modellen
    #En kolonne u'er smides ud, da matricen ellers er singulær
    #her smider vi en observation til for at kunne sammenligne med autocorr
    uhat <- u[ 2:(T-1), 1:(n-1)]
    #vi prøver lige at fixe noget autocorrelation
    #ehat <- uhat[2:(T-1),]- par[((3*(n) + (n-1)*((n-1)+1)/2))]*uhat[1:(T-2),]
    # omega skal være covariansmatricen for den normalfordeling
    # omega skal også estimeres som parameter.
    #find omega matrix()
    omega <- matrix(NA,(n-1),(n-1))
    omega[lower.tri(omega,diag=TRUE)] <- par[(3*n) : ((3*(n) + (n-1)*((n-1)+1)/2) - 1) ]
    omega<-makeSymm(omega)
    #omegainv <- solve(omega)
    #udregn u_t'Au_t for at kunne tage summen
    #uhatomegainvuhat <- apply(uhat,1,function(x) x %*% omegainv %*% x)
    #likelihood funktionen
    l1 = dmvnorm(x=uhat, mean=rep(0,n-1), sigma=omega, log=TRUE)
    return(   -sum(l1) )
    #umiddelbart regner følgende rigtigt ud, men det går helt galt, når den skal optimere
    #return(   -( -(n-1)*(T-1)*log(2*pi)/2   -(T-1)/2*(det(omega, log=TRUE)) -1/2*sum(uhatomegainvuhat) )     )  
  }else if (habitform == 0) {  #uden habit formation
    gamma <- c(par[1:(n-1)],0)  
    a <- exp(gamma)/sum(exp(gamma))  #igen, a er en logit
    b <- c(par[n:(2*n-1)])           # b er time-invariant
    supernum <- 1-rowSums(phat %*% diag(b))
    supernummat <- matrix(rep(supernum,n),ncol=n)
    u <- w - phat %*% diag(b) - supernummat%*%diag(a)
    #smid en variabel ud
    uhat <- u[ 2:(T),1:(n-1)]
    #autocorrelation
    #ehat <- uhat[2:(T),]- par[((2*(n) + (n-1)*((n-1)+1)/2))]*uhat[1:(T-1),]
    #find omega matrix()
    omega <- matrix(NA,(n-1),(n-1))
    omega[lower.tri(omega,diag=TRUE)] <- par[(2*n) : ((2*(n) + (n-1)*((n-1)+1)/2) - 1) ]
    omega<-makeSymm(omega)
    #omegainv <- solve(omega)
    #udregn u_t'Au_t for at kunne tage summen
    # uhatomegainvuhat <- apply(uhat,1,function(x) x %*% omegainv %*% x)
    #likelihood funktionen
    l1 = dmvnorm(x=uhat, mean=rep(0,n-1), sigma=omega, log=TRUE)
    return(   -sum(l1) )
    #return(   -(- (n-1)/2*T*log(2*pi) -  T/2*(log(det(omega))) - 1/2*sum(uhatomegainvuhat) )     )
  } else
    print("Set habitform = 1 or =0 ")
}

# Med habitform uden acorr -------------
resul <- rep(NA,n)
resul_el <- rep(NA,n)
for (j in 1:length(dataframes) ) {
  ### dataindlæsning --------
  df <- dataframes[[j]]  
  
  #make prices and shares
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
  
  #Startværdier -----------------
  #Løser ligningssystem, så gamma'erne afspejler de ønskede alphaer startværdier
  #Sæt ønskede alpha fx lig budgetandele i sidste periode.
  #gamma_n er lig 0.
  gammafn <- function(par,alpha_goal) {
    return(  sum((alpha_goal - exp(par)/(1+sum(exp(par))) )^2)    )
  }
  gammasol <- optim(par=rep(0,(n-1)),fn=gammafn, alpha_goal=w[T,1:(n-1)], method="BFGS", 
                    control=list(maxit=5000))
  #print(gammasol)
  gamma_start <- c(gammasol$par,0)
  alpha_start <- exp(gamma_start)/sum(exp(gamma_start))
  
  #tjekker at det passer.
  #print(w[T,1:(n)])
  #print(alpha_start)
  
  #sætter startværdier for bstar: her z pct. af det mindste forbrug over årene af en given vare i fastepriser
  b_start <- 0.25*apply(x, 2, min) # b skal fortolkes som 10.000 2015-kroner.
  
  #finder startværdier for kovariansmatricen
  
  a <- alpha_start     #igen, a er en logit
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
  
  start_uhabit = c(gamma_start[1:(n-1)], b_start, covar_start)
  #print(start)
  
  #sætter startværdier for habit formation og autocorr
  habit=rep(0.5,n)
  #autocorr <- 0.5
  start_habit = c(gamma_start[1:(n-1)], b_start, habit, covar_start)
  #print(start_habit)
  #par=start_habit
  
  # S?tter startv?rdier for uden habit formation 
  start_uhabit = c(gamma_start[1:(n-1)], b_start,covar_start)
  #print(start_uhabit)
  #Maksimerer likelihood -----------
  sol_habit <-  optim(  par = start_habit, fn = loglik, habitform=1,
                        phat=phat, w=w, x=x, method="BFGS",
                        #                                                    lower = lower ,  upper= upper , 
                        control=list(maxit=5000,
                                     trace=6,
                                     ndeps = rep(1e-10,length(start_habit)))    )
  
  #Printer resultater----------
  sol_gamma <- c(sol_habit$par[1:(n-1)],0)
  bstar_sol <- sol_habit$par[n:(2*n-1)]*10000
  alpha_sol <- exp(sol_gamma)/sum(exp(sol_gamma))
  beta_sol <- sol_habit$par[(2*n):(3*n-1)]
  #print(sol_alpha)
  #print(sol_b)
  sol_b_mat <- matrix(rep(bstar_sol,(T-1)),nrow=(T-1),ncol=n, byrow=TRUE) + 10000*x[1:(T-1),]%*%diag(beta_sol)
  b_sol <- colMeans(sol_b_mat)
  #supernum <- 1-rowSums(phat[2:T,] * sol_b_mat/10000) 
  ownp_el <- b_sol*(1-alpha_sol)/(colMeans(x)*10000)-1 #should be mean of x
  inc_el <-  alpha_sol*mean(rowSums(x))/(colMeans(priser[,2:9])*colMeans(x))
  
  decil <- rep(j-1,n)
  resul <- rbind(resul, decil, alpha_sol, bstar_sol, beta_sol,ownp_el,inc_el)
  resul_el <- rbind(resul_el,decil,ownp_el,inc_el)
  
  #calculating AIC
  AIC = 2*length(sol_habit$par) + 2*sol_habit$value
  aic_mat <- rbind(aic_mat,AIC)
}
#Printer til excel -------
vareagg = c("kod_fisk_mej","ovr_fode","bol","ene_hje","ene_tra","tra","ovr_var","ovr_tje")

resul_2 <- resul[-1,]
colnames(resul_2) <- vareagg
write.xlsx(resul_2, "8var_est_res.xlsx", sheetName = "Habitform, uden acorr", 
           col.names = TRUE, row.names = TRUE, append = TRUE)
colnames(resul_el) <- vareagg
resul_el <- resul_el[-1,]
write.xlsx(resul_el, "8var_elast.xlsx", sheetName = "Habitform, uden acorr", 
           col.names = TRUE, row.names = TRUE, append = TRUE)



# Uden habitform uden acorr -------------
resul <- rep(NA,n)
resul_el <- rep(NA,n)
for (j in 1:length(dataframes) ) {
  
  #Indlæser data------
  
  df <- dataframes[[j]]  
  
  #make prices and shares
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
  
  #Startværdier ------
  #Løser ligningssystem, så gamma'erne afspejler de ønskede alphaer startværdier
  #Sæt ønskede alpha fx lig budgetandele i sidste periode.
  #gamma_n er lig 0.
  gammafn <- function(par,alpha_goal) {
    return(  sum((alpha_goal - exp(par)/(1+sum(exp(par))) )^2)    )
  }
  gammasol <- optim(par=rep(0,(n-1)),fn=gammafn, alpha_goal=w[T,1:(n-1)], method="BFGS", 
                    control=list(maxit=5000))
  #print(gammasol)
  gamma_start <- c(gammasol$par,0)
  alpha_start <- exp(gamma_start)/sum(exp(gamma_start))
  
  #tjekker at det passer.
  #print(w[T,1:(n)])
  #print(alpha_start)
  
  #sætter startværdier for bstar: her z pct. af det mindste forbrug over årene af en given vare i fastepriser
  b_start <- 0.25*apply(x, 2, min) # b skal fortolkes som 10.000 2015-kroner.
  
  #finder startværdier for kovariansmatricen
  
  a <- alpha_start  #igen, a er en logit
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
  
  start_uhabit = c(gamma_start[1:(n-1)], b_start, covar_start)
  #print(start)
  
  #sætter startværdier for habit formation og autocorr
  habit=rep(0.5,n)
  start_habit = c(gamma_start[1:(n-1)], b_start, habit, covar_start)
  #print(start_habit)
  #par=start_habit
  
  # S?tter startv?rdier for uden habit formation 
  start_uhabit = c(gamma_start[1:(n-1)], b_start,covar_start)
  #print(start_uhabit)
  
  #Maksimererlikelihood.
  
  #Maksimerer likelihood ------
  sol_uhabit <-  optim(  par = start_uhabit, fn = loglik, habitform=0,
                         phat=phat, w=w, x=x, method="BFGS",
                         #                             lower = lower ,  upper= upper ,
                         control=list(maxit=5000,
                                      trace=99,
                                      ndeps = rep(1e-10,length(start_uhabit)))    )
  
  #Printer resultater-----
  sol_gamma <- c(sol_uhabit$par[1:(n-1)],0)
  b_sol <- sol_uhabit$par[n:(2*n-1)]*10000
  alpha_sol <- exp(sol_gamma)/sum(exp(sol_gamma))
  #print(sol_alpha)
  #print(sol_b)

  ownp_el <- b_sol*(1-alpha_sol)/(colMeans(x)*10000)-1 #should be mean of x
  inc_el <-  alpha_sol*mean(rowSums(x))/(colMeans(priser[,2:9])*colMeans(x))
  
  decil <- rep(j-1,n)
  resul <- rbind(resul, decil, alpha_sol, b_sol,ownp_el,inc_el)
  resul_el <- rbind(resul_el,decil,ownp_el,inc_el)
  #calculating AIC
  AIC = 2*length(sol_uhabit$par) + 2*sol_uhabit$value
  aic_mat <- rbind(aic_mat,AIC)
  
}
# Printer til excel----
resul_2 <- resul[-1,]
colnames(resul_2) <- vareagg
write.xlsx(resul_2, "8var_est_res.xlsx", sheetName = "Uden habitform, uden acorr", 
           col.names = TRUE, row.names = TRUE, append = TRUE)

colnames(resul_el) <- vareagg
resul_el <- resul_el[-1,]
write.xlsx(resul_el, "8var_elast.xlsx", sheetName = "Uden habitform, uden acorr", 
           col.names = TRUE, row.names = TRUE, append = TRUE)

# Laver AIC-tabel----
aic_mat2 <- aic_mat[-1]
AIC_matrix <- matrix(aic_mat[-1],nrow=11, ncol=4,byrow=FALSE)
#Foreløbig koklusion: Acorr er klart bedre når der ikke er habitformation
#Der er ikke en klar konklusion, når det kommer til habitformation, stort set
#samme AIC.
write.xlsx(AIC_matrix, "AIC.xlsx", sheetName = "AIC", 
           col.names = TRUE, row.names = TRUE, append = TRUE)