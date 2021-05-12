#clear workspace
rm(list=ls())
library(mvtnorm)
library("xlsx")

#no scientific numbers
options(scipen=999)
options(digits=3)
#Definerer funktioner -------

#Indlæser data.
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

#Lav kvintiler
kvint_1 <- (df_1+df_2)/2
kvint_2 <- (df_3+df_4)/2
kvint_3 <- (df_5+df_6)/2
kvint_4 <- (df_7+df_8)/2
kvint_5 <- (df_9+df_10)/2


## Laver modellen ----

#funktion til at lave symmetrisk matrix
makeSymm <- function(m) {
  m[upper.tri(m)] <- t(m)[upper.tri(m)]
  return(m)
}

#Model==1: Standard uden autocorrelation
#Model==2: Standard med autocorrelation
#Model==3: Time trend uden autocorrelation
#Model==4: Time trend med autocorrelation
#Model==5: Habit-formation uden autocorrelation
#Model==6: Habit-formation med autocorrelation
#Model==7: Habit-formation med AR(1) med frie parametre uden autokorrelation
#Model==8: Habit-formation med AR(1) med frie parametre med autokorrelation

loglik <- function(par,w,phat,x,model) {
  #sætter dimensioner
  dims=dim(w)
  T=dims[1]
  n=dims[2]
  if (model == 1) { 
    gamma <- c(par[1:(n-1)],0)  
    a <- exp(gamma)/sum(exp(gamma))  #igen, a er en logit
    b <- c(par[n:(2*n-1)])           # b er time-invariant
    supernum <- 1-rowSums(phat %*% diag(b))
    supernummat <- matrix(rep(supernum,n),ncol=n)
    u <- w - phat %*% diag(b) - supernummat%*%diag(a)
    #smid en variabel ud og to observationer
    uhat <- u[-(1:2),1:(n-1)]
    #find omega matrix()
    omega <- matrix(NA,(n-1),(n-1))
    omega[lower.tri(omega,diag=TRUE)] <- par[(2*n) : ((2*(n) + (n-1)*((n-1)+1)/2) - 1) ]
    omega<-makeSymm(omega)
    #likelihood funktionen
    l1 = dmvnorm(x=uhat, mean=rep(0,n-1), sigma=omega, log=TRUE)
    return(   -sum(l1) )
  } else if (model == 2) {  #uden habit formation
    gamma <- c(par[1:(n-1)],0)  
    a <- exp(gamma)/sum(exp(gamma))  #igen, a er en logit
    b <- c(par[n:(2*n-1)])           # b er time-invariant
    supernum <- 1-rowSums(phat %*% diag(b))
    supernummat <- matrix(rep(supernum,n),ncol=n)
    u <- w - phat %*% diag(b) - supernummat%*%diag(a)
    #smid en variabel ud og en observation
    uhat <- u[-1,1:(n-1)]
    #autocorrelation - -> smid en observation til
    ehat <- uhat[-1,]- par[((2*(n) + (n-1)*((n-1)+1)/2))]*uhat[1:(T-2),]
    #find omega matrix()
    omega <- matrix(NA,(n-1),(n-1))
    omega[lower.tri(omega,diag=TRUE)] <- par[(2*n) : ((2*(n) + (n-1)*((n-1)+1)/2) - 1) ]
    omega<-makeSymm(omega)
    #likelihood funktionen
    l1 = dmvnorm(x=ehat, mean=rep(0,n-1), sigma=omega, log=TRUE)
    return(   -sum(l1) )
  }
  else if (model==3){
    gamma <- c(par[1:(n-1)],0) #gamma definereres - kun for de første n-1 parametre. gamma_n=0.
    a <- exp(gamma)/sum(exp(gamma))  # a som en logit (sikrer mellem 0 og 1)
    bstar <- c(par[n:(2*n-1)]) # bstar: n parametre
    beta <- c(par[(2*n):(3*n-1)]) #beta: n parametre
    #Med man må lave en tidsvariabel
    tid <- c(1:T)
    b <- matrix(rep(bstar,(T)),nrow=(T),ncol=n, byrow=TRUE) + matrix(rep(tid,n),nrow=T, ncol=n)%*%diag(beta) #b defineres som matrix.
    supernum <- 1-rowSums(phat[1:T,] * b) #supernumerary income i hver periode sættes
    supernummat <- matrix(rep(supernum,n),ncol=n) # for at lette beregningen af u replikeres n gange til en matrix
    u <- w - phat*b - supernummat%*%diag(a) #u beregnes ud fra modellen
    #En kolonne u'er smides ud, da matricen ellers er singulær, samt to observationer
    uhat <- u[-(1:2) , -n] #T-2 observation for sammenlignelighed.
    #find omega matrix()
    omega <- matrix(NA,(n-1),(n-1))
    omega[lower.tri(omega,diag=TRUE)] <- par[(3*n) : ((3*(n) + (n-1)*((n-1)+1)/2) - 1) ]
    omega<-makeSymm(omega)
    #likelihood funktionen
    l1 = dmvnorm(x=uhat, mean=rep(0,n-1), sigma=omega, log=TRUE)
    return(   -sum(l1) )
  }else if (model==4){
    gamma <- c(par[1:(n-1)],0) #gamma definereres - kun for de første n-1 parametre. gamma_n=0.
    a <- exp(gamma)/sum(exp(gamma))  # a som en logit (sikrer mellem 0 og 1)
    bstar <- c(par[n:(2*n-1)]) # bstar: n parametre
    beta <- c(par[(2*n):(3*n-1)]) #beta: n parametre
    #Med man må lave en tidsvariabel
    tid <- c(1:T)
    b <- matrix(rep(bstar,(T)),nrow=(T), ncol=n, byrow=TRUE) + matrix(rep(tid,n),nrow=T, ncol=n)%*%diag(beta) #b defineres som matrix.
    supernum <- 1-rowSums(phat * b) #supernumerary income i hver periode sættes
    supernummat <- matrix(rep(supernum,n),ncol=n) # for at lette beregningen af u replikeres n gange til en matrix
    u <- w - phat*b - supernummat%*%diag(a) #u beregnes ud fra modellen
    #En kolonne u'er smides ud, da matricen ellers er singulær, og en observation
    uhat <- u[-1 , -n]
    ehat <- uhat[-1,]- par[((3*(n) + (n-1)*((n-1)+1)/2))]*uhat[1:(T-2),] #Korrigerer for autocorrelation, en observation ryger
    #find omega matrix()
    omega <- matrix(NA,(n-1),(n-1))
    omega[lower.tri(omega,diag=TRUE)] <- par[(3*n) : ((3*(n) + (n-1)*((n-1)+1)/2) - 1) ]
    omega<-makeSymm(omega)
    #likelihood funktionen
    l1 = dmvnorm(x=ehat, mean=rep(0,n-1), sigma=omega, log=TRUE)
    return(   -sum(l1) )
  }
  else if (model==5){
    gamma <- c(par[1:(n-1)],0) #gamma definereres - kun for de første n-1 parametre. gamma_n=0.
    a <- exp(gamma)/sum(exp(gamma))  # a som en logit (sikrer mellem 0 og 1)
    bstar <- c(par[n:(2*n-1)]) # bstar: n parametre
    beta <- c(par[(2*n):(3*n-1)]) #beta: n parametre
    #Med habit formation må ét år fjernes fra estimeringen.
    b <- matrix(rep(bstar,(T-1)),nrow=(T-1),ncol=n, byrow=TRUE) + x[1:(T-1),]%*%diag(beta) #b defineres som matrix.
    supernum <- 1-rowSums(phat[2:T,] * b) #supernumerary income i hver periode sættes
    supernummat <- matrix(rep(supernum,n),ncol=n) # for at lette beregningen af u replikeres n gange til en matrixe
    u <- w[2:T,] - phat[2:T,]*b - supernummat%*%diag(a) #u beregnes ud fra modellen
    #En kolonne u'er smides ud, da matricen ellers er singulær
    uhat <- u[-1 , 1:(n-1)] #T-2 observation for sammenlignelighed.
    #find omega matrix()
    omega <- matrix(NA,(n-1),(n-1))
    omega[lower.tri(omega,diag=TRUE)] <- par[(3*n) : ((3*(n) + (n-1)*((n-1)+1)/2) - 1) ]
    omega<-makeSymm(omega)
    #likelihood funktionen
    l1 = dmvnorm(x=uhat, mean=rep(0,n-1), sigma=omega, log=TRUE)
    return(   -sum(l1) )
  }else if (model==6){
    gamma <- c(par[1:(n-1)],0) #gamma definereres - kun for de første n-1 parametre. gamma_n=0.
    a <- exp(gamma)/sum(exp(gamma))  # a som en logit (sikrer mellem 0 og 1)
    bstar <- c(par[n:(2*n-1)]) # bstar: n parametre
    beta <- c(par[(2*n):(3*n-1)]) #beta: n parametre
    #Med habit formation må ét år fjernes fra estimeringen.
    b <- matrix(rep(bstar,(T-1)),nrow=(T-1),ncol=n, byrow=TRUE) + x[1:(T-1),]%*%diag(beta) #b defineres som matrix.
    supernum <- 1-rowSums(phat[2:T,] * b) #supernumerary income i hver periode sættes
    supernummat <- matrix(rep(supernum,n),ncol=n) # for at lette beregningen af u replikeres n gange til en matrixe
    u <- w[2:T,] - phat[2:T,]*b - supernummat%*%diag(a) #u beregnes ud fra modellen
    #En kolonne u'er smides ud, da matricen ellers er singulær
    uhat <- u[ , 1:(n-1)]
    ehat <- uhat[-1,]- par[((3*(n) + (n-1)*((n-1)+1)/2))]*uhat[1:(T-2),] #Korrigerer for autocorrelation
    #find omega matrix()
    omega <- matrix(NA,(n-1),(n-1))
    omega[lower.tri(omega,diag=TRUE)] <- par[(3*n) : ((3*(n) + (n-1)*((n-1)+1)/2) - 1) ]
    omega<-makeSymm(omega)
    #likelihood funktionen
    l1 = dmvnorm(x=ehat, mean=rep(0,n-1), sigma=omega, log=TRUE)
    return(   -sum(l1) )
  }else if (model==7){
    gamma <- c(par[1:(n-1)],0) #gamma definereres - kun for de første n-1 parametre. gamma_n=0.
    a <- exp(gamma)/sum(exp(gamma))  # a som en logit (sikrer mellem 0 og 1)
    beta2 <- c(par[n:(2*n-1)]) # bstar: n parametre
    beta <- c(par[(2*n):(3*n-1)]) #beta: n parametre
    #Med habit formation må ét år fjernes fra estimeringen.
    
    ############ i denne model er de to parametre ikke restrikteret til at give 1. 
    
    b <- matrix(rep(0,(T-2)),nrow=(T-2),ncol=n, byrow=TRUE)
    #bb <- x[1:(T-(T-1)),]%*%diag(0.6)
    b[(T-(T-1)),] <- x[2:(T-(T-2)),]%*%diag(beta) + (x[1,]%*%diag(c(0.6,0.5,0.7,0.7,0.7,0.7,0.6,0.6)))%*%diag(beta2)
    b[(T-(T-2)),] <- x[3:(T-(T-3)),]%*%diag(beta) + b[(T-(T-1)),]%*%diag(beta2)
    b[(T-(T-3)),] <- x[4:(T-(T-4)),]%*%diag(beta) + b[(T-(T-2)),]%*%diag(beta2)
    b[(T-(T-4)),] <- x[5:(T-(T-5)),]%*%diag(beta) + b[(T-(T-3)),]%*%diag(beta2)
    b[(T-(T-5)),] <- x[6:(T-(T-6)),]%*%diag(beta) + b[(T-(T-4)),]%*%diag(beta2)
    b[(T-(T-6)),] <- x[7:(T-(T-7)),]%*%diag(beta) + b[(T-(T-5)),]%*%diag(beta2)
    b[(T-(T-7)),] <- x[8:(T-(T-8)),]%*%diag(beta) + b[(T-(T-6)),]%*%diag(beta2)
    b[(T-(T-8)),] <- x[9:(T-(T-9)),]%*%diag(beta) + b[(T-(T-7)),]%*%diag(beta2)
    b[(T-(T-9)),] <- x[10:(T-(T-10)),]%*%diag(beta) + b[(T-(T-8)),]%*%diag(beta2)
    b[(T-(T-10)),] <- x[11:(T-(T-11)),]%*%diag(beta) + b[(T-(T-9)),]%*%diag(beta2)
    b[(T-(T-11)),] <- x[12:(T-(T-12)),]%*%diag(beta) + b[(T-(T-10)),]%*%diag(beta2)
    b[(T-(T-12)),] <- x[13:(T-(T-13)),]%*%diag(beta) + b[(T-(T-11)),]%*%diag(beta2)
    b[(T-(T-13)),] <- x[14:(T-(T-14)),]%*%diag(beta) + b[(T-(T-12)),]%*%diag(beta2)
    b[(T-(T-14)),] <- x[15:(T-(T-15)),]%*%diag(beta) + b[(T-(T-13)),]%*%diag(beta2)
    b[(T-(T-15)),] <- x[16:(T-(T-16)),]%*%diag(beta) + b[(T-(T-14)),]%*%diag(beta2)
    b[(T-(T-16)),] <- x[17:(T-(T-17)),]%*%diag(beta) + b[(T-(T-15)),]%*%diag(beta2)
    b[(T-(T-17)),] <- x[18:(T-(T-18)),]%*%diag(beta) + b[(T-(T-16)),]%*%diag(beta2)
    b[(T-(T-18)),] <- x[19:(T-(T-19)),]%*%diag(beta) + b[(T-(T-17)),]%*%diag(beta2)
    b[(T-(T-19)),] <- x[20:(T-(T-20)),]%*%diag(beta) + b[(T-(T-18)),]%*%diag(beta2)
    b[(T-(T-20)),] <- x[21:(T-(T-21)),]%*%diag(beta) + b[(T-(T-19)),]%*%diag(beta2)
    b[(T-(T-21)),] <- x[22:(T-(T-22)),]%*%diag(beta) + b[(T-(T-20)),]%*%diag(beta2)
    b[(T-(T-22)),] <- x[23:(T-(T-23)),]%*%diag(beta) + b[(T-(T-21)),]%*%diag(beta2)
    b[(T-(T-23)),] <- x[24:(T-(T-24)),]%*%diag(beta) + b[(T-(T-22)),]%*%diag(beta2)
    b[(T-(T-24)),] <- x[25:(T-(T-25)),]%*%diag(beta) + b[(T-(T-23)),]%*%diag(beta2)
    
    supernum <- 1-rowSums(phat[3:T,] * b) #supernumerary income i hver periode sættes
    supernummat <- matrix(rep(supernum,n),ncol=n) # for at lette beregningen af u replikeres n gange til en matrixe
    u <- w[3:T,] - phat[3:T,]*b - supernummat%*%diag(a) #u beregnes ud fra modellen
    #En kolonne u'er smides ud, da matricen ellers er singulær
    uhat <- u[ , 1:(n-1)]
    #find omega matrix()
    omega <- matrix(NA,(n-1),(n-1))
    omega[lower.tri(omega,diag=TRUE)] <- par[(3*n) : ((3*(n) + (n-1)*((n-1)+1)/2) - 1) ]
    omega<-makeSymm(omega)
    #likelihood funktionen
    l1 = dmvnorm(x=uhat, mean=rep(0,n-1), sigma=omega, log=TRUE)
    return(   -sum(l1) )
  }else if (model==8){          ############ Pr?ver at lave en 7ende model, hvor b er smoothet - da mister vi vel en observation mere.
    ########## Vi bliver vel n?dt til at have en startv?rdi for b baseret p? bstar og x, og s? derefter en proces for b. 
    gamma <- c(par[1:(n-1)],0) #gamma definereres - kun for de første n-1 parametre. gamma_n=0.
    a <- exp(gamma)/sum(exp(gamma))  # a som en logit (sikrer mellem 0 og 1)
    beta2 <- c(par[n:(2*n-1)]) # bstar: n parametre
    beta <- c(par[(2*n):(3*n-1)]) #beta: n parametre
    #Med habit formation må ét år fjernes fra estimeringen.
    
    ############ i denne model er de to parametre ikke restrikteret til at give 1. 
    
    b <- matrix(rep(0,(T-2)),nrow=(T-2),ncol=n, byrow=TRUE)
    #bb <- x[1:(T-(T-1)),]%*%diag(0.6)
    b[(T-(T-1)),] <- x[2:(T-(T-2)),]%*%diag(beta) + (x[1,]%*%diag(c(0.6,0.5,0.7,0.7,0.7,0.7,0.6,0.6)))%*%diag(beta2)
    b[(T-(T-2)),] <- x[3:(T-(T-3)),]%*%diag(beta) + b[(T-(T-1)),]%*%diag(beta2)
    b[(T-(T-3)),] <- x[4:(T-(T-4)),]%*%diag(beta) + b[(T-(T-2)),]%*%diag(beta2)
    b[(T-(T-4)),] <- x[5:(T-(T-5)),]%*%diag(beta) + b[(T-(T-3)),]%*%diag(beta2)
    b[(T-(T-5)),] <- x[6:(T-(T-6)),]%*%diag(beta) + b[(T-(T-4)),]%*%diag(beta2)
    b[(T-(T-6)),] <- x[7:(T-(T-7)),]%*%diag(beta) + b[(T-(T-5)),]%*%diag(beta2)
    b[(T-(T-7)),] <- x[8:(T-(T-8)),]%*%diag(beta) + b[(T-(T-6)),]%*%diag(beta2)
    b[(T-(T-8)),] <- x[9:(T-(T-9)),]%*%diag(beta) + b[(T-(T-7)),]%*%diag(beta2)
    b[(T-(T-9)),] <- x[10:(T-(T-10)),]%*%diag(beta) + b[(T-(T-8)),]%*%diag(beta2)
    b[(T-(T-10)),] <- x[11:(T-(T-11)),]%*%diag(beta) + b[(T-(T-9)),]%*%diag(beta2)
    b[(T-(T-11)),] <- x[12:(T-(T-12)),]%*%diag(beta) + b[(T-(T-10)),]%*%diag(beta2)
    b[(T-(T-12)),] <- x[13:(T-(T-13)),]%*%diag(beta) + b[(T-(T-11)),]%*%diag(beta2)
    b[(T-(T-13)),] <- x[14:(T-(T-14)),]%*%diag(beta) + b[(T-(T-12)),]%*%diag(beta2)
    b[(T-(T-14)),] <- x[15:(T-(T-15)),]%*%diag(beta) + b[(T-(T-13)),]%*%diag(beta2)
    b[(T-(T-15)),] <- x[16:(T-(T-16)),]%*%diag(beta) + b[(T-(T-14)),]%*%diag(beta2)
    b[(T-(T-16)),] <- x[17:(T-(T-17)),]%*%diag(beta) + b[(T-(T-15)),]%*%diag(beta2)
    b[(T-(T-17)),] <- x[18:(T-(T-18)),]%*%diag(beta) + b[(T-(T-16)),]%*%diag(beta2)
    b[(T-(T-18)),] <- x[19:(T-(T-19)),]%*%diag(beta) + b[(T-(T-17)),]%*%diag(beta2)
    b[(T-(T-19)),] <- x[20:(T-(T-20)),]%*%diag(beta) + b[(T-(T-18)),]%*%diag(beta2)
    b[(T-(T-20)),] <- x[21:(T-(T-21)),]%*%diag(beta) + b[(T-(T-19)),]%*%diag(beta2)
    b[(T-(T-21)),] <- x[22:(T-(T-22)),]%*%diag(beta) + b[(T-(T-20)),]%*%diag(beta2)
    b[(T-(T-22)),] <- x[23:(T-(T-23)),]%*%diag(beta) + b[(T-(T-21)),]%*%diag(beta2)
    b[(T-(T-23)),] <- x[24:(T-(T-24)),]%*%diag(beta) + b[(T-(T-22)),]%*%diag(beta2)
    b[(T-(T-24)),] <- x[25:(T-(T-25)),]%*%diag(beta) + b[(T-(T-23)),]%*%diag(beta2)
    
    supernum <- 1-rowSums(phat[3:T,] * b) #supernumerary income i hver periode sættes
    supernummat <- matrix(rep(supernum,n),ncol=n) # for at lette beregningen af u replikeres n gange til en matrixe
    u <- w[3:T,] - phat[3:T,]*b - supernummat%*%diag(a) #u beregnes ud fra modellen
    #En kolonne u'er smides ud, da matricen ellers er singulær
    uhat <- u[ , 1:(n-1)]
    ehat <- uhat[-1,]- par[((3*(n) + (n-1)*((n-1)+1)/2))]*uhat[1:(T-3),] #Korrigerer for autocorrelation
    #find omega matrix()
    omega <- matrix(NA,(n-1),(n-1))
    omega[lower.tri(omega,diag=TRUE)] <- par[(3*n) : ((3*(n) + (n-1)*((n-1)+1)/2) - 1) ]
    omega<-makeSymm(omega)
    #likelihood funktionen
    l1 = dmvnorm(x=ehat, mean=rep(0,n-1), sigma=omega, log=TRUE)
    return(   -sum(l1) )
  }else
    print("Choose right model ")
}



dims=dim(w)
T=dims[1]
n=dims[2]



dataframes = list(df_h, df_1, df_2, df_3, df_4, df_5, df_6, df_7, df_8, df_9, df_10)
dataframes_kvint= list(kvint_1,kvint_2,kvint_3,kvint_4,kvint_5)
aic_matstor = c(0:6)

for (dfdf in 1:length(dataframes_kvint) ) {
# Dataindlæsning  ---------
df <- dataframes_kvint[[dfdf]]
df<-df_h
# Datamanipulation -----
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
b_start <- 0.5*apply(x, 2, min) # b skal fortolkes som 10.000 2015-kroner.

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

habit=rep(0.1,n)
AR = rep(0.9,n)
timetrend=rep(0.05,n)
autocorr <- 0.5

start_1 = c(gamma_start[1:(n-1)], b_start, covar_start)
start_2 = c(gamma_start[1:(n-1)], b_start, covar_start, autocorr)
start_3 = c(gamma_start[1:(n-1)], b_start, timetrend, covar_start)
start_4 = c(gamma_start[1:(n-1)], b_start, timetrend, covar_start, autocorr)
start_5 = c(gamma_start[1:(n-1)], b_start, habit, covar_start)
start_6 = c(gamma_start[1:(n-1)], b_start, habit, covar_start, autocorr)
start_7 = c(gamma_start[1:(n-1)], AR, habit, covar_start, autocorr)
start_8 = c(gamma_start[1:(n-1)], AR, habit, covar_start, autocorr)
start_9 = c(gamma_start[1:(n-1)], habit, covar_start, autocorr)

## Maksimerer likelihood -----
startvals = list(start_1,start_2,start_3, start_4, start_5, start_6, start_7, start_8)
aic_mat <- NA
for (j in 1:length(startvals) ) {
  
startval <- startvals[[j]]  
  
sol <-  optim(par = startval, fn = loglik, model=j, 
                      phat=phat, w=w, x=x, method="BFGS",
                      control=list(maxit=5000,
                                   trace=6,
                                   ndeps = rep(1e-10,length(startval))) )

AIC = 2*length(sol$par) + 2*sol$value
aic_mat <- rbind(aic_mat,AIC)

#Udregner minimumsforbruget for alle perioder.
sol_gamma <- c(sol$par[1:(n-1)],0)
bstar_sol <- sol$par[n:(2*n-1)]*10000
alpha_sol <- exp(sol_gamma)/sum(exp(sol_gamma))
beta_sol <- sol$par[(2*n):(3*n-1)]
ac_const <- sol$par[((2*(n) + (n-1)*((n-1)+1)/2))]

if (j==1){sol_b_mat_1 <- matrix(rep(bstar_sol,(T-1)),nrow=(T-1),ncol=n, byrow=TRUE)}
if (j==2){sol_b_mat_2 <- matrix(rep(bstar_sol,(T-1)),nrow=(T-1),ncol=n, byrow=TRUE)}
if (j==3){sol_b_mat_3 <- matrix(rep(bstar_sol,(T-1)),nrow=(T-1),ncol=n, byrow=TRUE) + 10000*matrix(rep(c(2:26),n),nrow=(T-1),ncol=n, byrow=FALSE) %*%diag(beta_sol)}
if (j==4){sol_b_mat_4 <- matrix(rep(bstar_sol,(T-1)),nrow=(T-1),ncol=n, byrow=TRUE) + 10000*matrix(rep(c(2:26),n),nrow=(T-1),ncol=n, byrow=FALSE) %*%diag(beta_sol)}
if (j==5){sol_b_mat_5 <- matrix(rep(bstar_sol,(T-1)),nrow=(T-1),ncol=n, byrow=TRUE) + 10000*x[1:(T-1),]%*%diag(beta_sol)}
if (j==6){sol_b_mat_6 <- matrix(rep(bstar_sol,(T-1)),nrow=(T-1),ncol=n, byrow=TRUE) + 10000*x[1:(T-1),]%*%diag(beta_sol)}
if (j==7){
  beta2_sol_7 = sol$par[n:(2*n-1)]
  sol_b_mat_7 = matrix(rep(0,25),nrow=25,ncol=n)
  sol_b_mat_7[1,] = c(rep(NA,n))
  sol_b_mat_7[2,] =  (x[2,]*10000)%*%diag(beta_sol) + (x[1,]*10000)%*%diag(c(0.6,0.5,0.7,0.7,0.7,0.7,0.6,0.6))%*%diag(beta2_sol_7)
  for (tal in c(3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25)) {
    sol_b_mat_7[tal,] = (x[tal-1,]*10000)%*%diag(beta_sol) + sol_b_mat_7[tal-1,]%*%diag(beta2_sol_7)}
}
if (j==8){
  beta2_sol_8 = sol$par[n:(2*n-1)]
  sol_b_mat_8 = matrix(rep(0,25),nrow=25,ncol=n)
  sol_b_mat_8[1,] = c(rep(NA,n))
  sol_b_mat_8[2,] =  (x[2,]*10000)%*%diag(beta_sol) + (x[1,]*10000)%*%diag(c(0.6,0.5,0.7,0.7,0.7,0.7,0.6,0.6))%*%diag(beta2_sol_8)
  for (tal in c(3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25)) {
    sol_b_mat_8[tal,] = (x[tal-1,]*10000)%*%diag(beta_sol) + sol_b_mat_8[tal-1,]%*%diag(beta2_sol_8)}
}

}

#Sammenligning på tværs af deciler loop
aic_matstor <- cbind(aic_matstor,aic_mat)
}



##Laver figurer for b'erne ------
vareagg = c("kod_fisk_mej","ovr_fode","bol","ene_hje","ene_tra","tra","ovr_var","ovr_tje")
#Model==1: Standard uden autocorrelation
#Model==2: Standard med autocorrelation
#Model==3: Time trend uden autocorrelation
#Model==4: Time trend med autocorrelation
#Model==5: Habit-formation uden autocorrelation
#Model==6: Habit-formation med autocorrelation
v=data.frame(Year=c(1995:2019),Consumption=x[-1,i]*10000,Const=sol_b_mat_1[,i],ConstAC=sol_b_mat_2[,i],
           Trend=sol_b_mat_3[,i], TrendAC=sol_b_mat_4[,i], Habit=sol_b_mat_5[,i], HabitAC=sol_b_mat_6[,i])

v <- v %>%
  select(Year, Consumption, Const, ConstAC,Trend,TrendAC,Habit,HabitAC) %>%
  gather(key = "variable", value = "value", -Year)
head(v)
#If you want a legend:
ggplot(v, aes(x = Year, y = value)) + ggtitle(vareagg[i])+
  geom_line(aes(color = variable, linetype = variable)) + 
  scale_color_manual(values = c("steelblue", "steelblue","darkred","darkorange3","darkorange3","bisque4","bisque4"))

p <- list()
for (i in 1:8) {
  v=data.frame(Year=c(1995:2019),Consumption=x[-1,i]*10000,Const=sol_b_mat_1[,i],ConstAC=sol_b_mat_2[,i],
               Trend=sol_b_mat_3[,i], TrendAC=sol_b_mat_4[,i], Habit=sol_b_mat_5[,i], HabitAC=sol_b_mat_6[,i],
               Smooth=sol_b_mat_7[,i],SmoothAC=sol_b_mat_8[,i])
  p[[i]] <- ggplot(v, aes(x=Year,) ) + ggtitle(vareagg[i]) +
    geom_line(aes(y = Consumption), color = "darkred") + 
    geom_line(aes(y = Const), color="steelblue", linetype="twodash")+
    geom_line(aes(y = ConstAC), color="steelblue")+
    geom_line(aes(y = Trend), color="darkorange3", linetype="twodash")+
    geom_line(aes(y = TrendAC), color="darkorange3")+
    geom_line(aes(y = Habit), color="bisque4", linetype="twodash")+
    geom_line(aes(y = HabitAC), color="bisque4")+
    geom_line(aes(y = Smooth), color="green", linetype="twodash")
    #+geom_line(aes(y = SmoothAC), color="green")
}

do.call(grid.arrange,p)


write.xlsx(aic_matstor, "aic_samlign.xlsx", sheetName = "AIC_kvintiler", 
           col.names = TRUE, row.names = TRUE, append = TRUE)