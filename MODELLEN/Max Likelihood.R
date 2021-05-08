#############################################################################################################
#############################################################################################################
################### This piece of fine script codes the likelihood function #################################
##############################    ��� of our 8 models ���    ################################################
#############################################################################################################
#############################################################################################################






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



############################## Laver modellen ##############################################################

#En beskrivelse af modellerne:

#Model==1: Standard uden autocorrelation
#Model==2: Standard med autocorrelation
#Model==3: Time trend uden autocorrelation
#Model==4: Time trend med autocorrelation
#Model==5: Habit-formation uden autocorrelation
#Model==6: Habit-formation med autocorrelation
#Model==7: Habit-formation med AR(1) med frie parametre uden autokorrelation
#Model==8: Habit-formation med AR(1) med frie parametre med autokorrelation


#funktion til at lave symmetrisk matrix
makeSymm <- function(m) {
  m[upper.tri(m)] <- t(m)[upper.tri(m)]
  return(m)
}

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
  }else if (model==8){          ############ Pr�ver at lave en 7ende model, hvor b er smoothet - da mister vi vel en observation mere.
    ########## Vi bliver vel n�dt til at have en startv�rdi for b baseret p� bstar og x, og s� derefter en proces for b. 
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