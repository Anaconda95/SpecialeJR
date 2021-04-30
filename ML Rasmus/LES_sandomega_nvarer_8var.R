#clear workspace
rm(list=ls())
library(mvtnorm)
setwd("~/Documents/GitHub/SpecialeJR /ML Rasmus")
#no scientific numbers
options(scipen=999)

# Indlæs data
df<-read.csv("simpeldata8grup.csv",sep=';')
df<-read.csv("C:/specialeJR/ML Rasmus/simpeldata8grup.csv",sep=';')

#make prices and shares
df     <- transform( df,
                     p1 = FOEDEVARER.OG.IKKE.ALKOHOLISKE.DRIKKEVARER/Faste.FOEDEVARER,
                     p2 = ALKOHOLISKE.DRIKKEVARER.OG.TOBAK/Faste.ALKOHOL,
                     p3 = BEKLAEDNING.OG.FODTOEJ/Faste.BEKLAEDNING,
                     p4 = BOLIGBENYTTELSE..ELEKTRICITET.OG.OPVARMNING/Faste.BOLIG.EL.OG.OPVARMNING,
                     p5 = MOEBLER/Faste.MOEBLER,
                     p6 = SUNDHED/Faste.SUNDHED,
                     p7 = TRANSPORT/Faste.TRANSPORT,
                     p8 = RESTAURANTER.OG.HOTELLER/Faste.RESTAURANTER.OG.HOTELLER
) 
#shares findes som forbrug i løbende priser/samlet forbrug af de otte varer.
df     <- transform( df,
                     w1 = FOEDEVARER.OG.IKKE.ALKOHOLISKE.DRIKKEVARER/Sumloeb,
                     w2 = ALKOHOLISKE.DRIKKEVARER.OG.TOBAK/Sumloeb,
                     w3 = BEKLAEDNING.OG.FODTOEJ/Sumloeb,
                     w4 = BOLIGBENYTTELSE..ELEKTRICITET.OG.OPVARMNING/Sumloeb,
                     w5 = MOEBLER/Sumloeb,
                     w6 = SUNDHED/Sumloeb,
                     w7 = TRANSPORT/Sumloeb,
                     w8 = RESTAURANTER.OG.HOTELLER/Sumloeb
) 

#phat findes som priser divideret med samlet forbrug
df     <- transform( df,
                     phat1=p1/Sumloeb,
                     phat2=p2/Sumloeb,
                     phat3=p3/Sumloeb,
                     phat4=p4/Sumloeb,
                     phat5=p5/Sumloeb,
                     phat6=p6/Sumloeb,
                     phat7=p7/Sumloeb,
                     phat8=p8/Sumloeb
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

#Løser ligningssystem, så gamma'erne afspejler de ønskede alphaer startværdier
#Sæt ønskede alpha fx lig budgetandele i sidste periode.
#gamma_n er lig 0.
gammafn <- function(par,alpha_goal) {
  return(  sum((alpha_goal - exp(par)/(1+sum(exp(par))) )^2)    )
}
gammasol <- optim(par=rep(0,(n-1)),fn=gammafn, alpha_goal=w[T,1:(n-1)], method="BFGS", 
                  control=list(maxit=5000))
print(gammasol)
gamma_start <- c(gammasol$par,0)
alpha_start <- exp(gamma_start)/sum(exp(gamma_start))

#tjekker at det passer.
print(w[T,1:(n)])
print(alpha_start)

#sætter startværdier for bstar: her z pct. af det mindste forbrug over årene af en given vare i fastepriser
b_start <- 0.4*apply(x, 2, min) # b skal fortolkes som 10.000 2015-kroner.

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
print(start)

#sætter startværdier for habit formation og autocorr
habit=rep(0.4,n)
autocorr <- 0.6
start_habit = c(gamma_start[1:(n-1)], b_start, habit, covar_start, autocorr)
print(start_habit)
par=start_habit

# S?tter startv?rdier for uden habit formation 
start_uhabit = c(gamma_start[1:(n-1)], b_start,covar_start)
print(start_uhabit)

#funktion til at lave symmetrisk matrix
makeSymm <- function(m) {
  m[upper.tri(m)] <- t(m)[upper.tri(m)]
  return(m)
}

#definerer funktionen - vigtigt
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
    uhat <- u[ ,1:(n-1)]
    #find omega matrix()
    omega <- matrix(NA,(n-1),(n-1))
    omega[lower.tri(omega,diag=TRUE)] <- par[(2*n) : ((2*(n) + (n-1)*((n-1)+1)/2) - 1) ]
    omega<-makeSymm(omega)
    #omegainv <- solve(omega)
    #udregn u_t'Au_t for at kunne tage summen
    uhatomegainvuhat <- apply(uhat,1,function(x) x %*% omegainv %*% x)
    #likelihood funktionen
    l1 = dmvnorm(x=uhat, mean=rep(0,n-1), sigma=omega, log=TRUE)
    return(   -sum(l1) )
    #return(   -(- (n-1)/2*T*log(2*pi) -  T/2*(log(det(omega))) - 1/2*sum(uhatomegainvuhat) )     )
  } else
    print("Set habitform = 1 or =0 ")
}

#Maksimererlikelihood.
#virker med BFGS, og konvergerer for forskellige startværdier.
# og B'erne er sindssygt afhængige af startværdier.

sol_uhabit <-  optim(  par = start_uhabit, fn = loglik, habitform=0,
                phat=phat, w=w, x=x, method="BFGS",
 #                             lower = lower ,  upper= upper , 
                control=list(maxit=5000,
                             trace=99,
                             ndeps = rep(1e-10,length(start_uhabit)))    )

sol_gamma <- c(sol_uhabit$par[1:(n-1)],0)
sol_b <- sol_uhabit$par[n:(2*n-1)]*10000
sol_alpha <- exp(sol_gamma)/sum(exp(sol_gamma))
print(sol_alpha)
print(sol_b)
sol_b_mat <- matrix(rep(sol_b,(T-1)),nrow=(T-1),ncol=n, byrow=TRUE) 
matrix(c(sol_b_mat,10000*x[2:(T),]),nrow=25,ncol=8, byrow=FALSE)


sol_habit <-  optim(  par = start_habit, fn = loglik, habitform=1,
                       phat=phat, w=w, x=x, method="BFGS",
#                                                    lower = lower ,  upper= upper , 
                       control=list(maxit=5000,
                                    trace=6,
                                    ndeps = rep(1e-10,length(start_habit)))    )

#Problem: den kan ikke l?se med L-BFGS-B. Lidt irriterende.

sol_gamma <- c(sol_habit$par[1:(n-1)],0)
sol_b <- sol_habit$par[n:(2*n-1)]*10000
sol_alpha <- exp(sol_gamma)/sum(exp(sol_gamma))
sol_beta <- sol_habit$par[(2*n):(3*n-1)]
print(sol_alpha)
print(sol_b)
print(sol_beta)
sol_b_mat <- matrix(rep(sol_b,(T-1)),nrow=(T-1),ncol=n, byrow=TRUE) + 10000*x[1:(T-1),]%*%diag(sol_beta)
matrix(c(sol_b_mat,10000*x[2:(T),]),nrow=25,ncol=8, byrow=FALSE)

supernum <- 1-rowSums(phat[3:T,] * sol_b_mat/10000) #supernumerary income i hver periode sættes
supernummat <- matrix(rep(supernum,n),ncol=n) 

#umiddelbart temmeligt meget autocorrelation i error-terms:
uhat <- w[2:T,] - phat[2:T,]*sol_b_mat/10000 - supernummat%*%diag(sol_alpha)

#nu med autocorrelation - simpel udgave.
ehat <- uhat[2:25,]- sol_habit$par[((3*(n) + (n-1)*((n-1)+1)/2))]*uhat[1:24,]

#bottomline: det virker med mvtnorm - men ikke ved at skrive den op i hånden. Umiddelbart
#umiddelbart har det noget at gøre med at log(det(omega)) bliver NAN.

#Tjek for forskellige startværdier.
gamma_start
b_start
#  Uden habitformation 
min(x[,3])
gstart_1 = c(-1,-2)        
gstart_2 = c(-2,-1)


bstart_1 = c(1,2.5)         
bstart_2 = c(0.2,0.8)
bstart_3 = c(3,5)


Solution_uhabit <- data.frame(Likeli=1,a1=1,a2=1,a3=1,b1=1,b2=1,b3=1,o1=1,o2=1,o3=1)
Start_uhabit <- data.frame(a1=1,a2=1,a3=1,b1=1,b2=1,b3=1)

for (i in bstart_1) {
  for (j in bstart_2) {
    for (k in bstart_3) {
      for (l in gstart_1) {
        for (q in gstart_2) {
         tryCatch({sol <- optim(par = c(l,q,i,j,k,covar_start), fn = loglik, habitform=0,
                                phat=phat, w=w, x=x, method="BFGS",
                                #                             lower = lower ,  upper= upper , 
                                control=list(maxit=5000,
                                             trace=99,
                                             ndeps = rep(1e-10,8))    )
         print(sol)
         sol_gamma <- c(sol$par[1:2],0)
         sol_b <- sol$par[3:5]*10000
         sol_alpha <- exp(sol_gamma)/sum(exp(sol_gamma)) 
         list <- list(Likeli=sol$value,a1=sol_alpha[1],
                      a2=sol_alpha[2],a3=sol_alpha[3],
                      b1=sol_b[1],b2=sol_b[2],
                      b3=sol_b[3],o1=sol$par[6],o2=sol$par[7],o3=sol$par[8])
         gamma_ini <- c(l,q,0)
         alpha_ini <- exp(gamma_ini)/sum(exp(gamma_ini)) 
         b_ini <- c(i,j,k)
         list1 <- list(a1=alpha_ini[1],
                      a2=alpha_ini[2],a3=alpha_ini[3],
                      b1=b_ini[1],b2=b_ini[2],
                      b3=b_ini[3])
         Solution_uhabit <- rbind(Solution_uhabit, list)
         Start_uhabit <- rbind(Start_uhabit, list1)}, error=function(e){cat("ERROR :",conditionMessage(e), "\n")})
        }
      }
    }
  }
}

### Med habit formation
Solution_habit <- data.frame(Likeli=1,a1=1,a2=1,a3=1,b1=1,b2=1,b3=1,h1=1, h2=1, h3=1,o1=1,o2=1,o3=1)
Start_habit <- data.frame(a1=1,a2=1,a3=1,b1=1,b2=1,b3=1)

for (i in bstart_1) {
  for (j in bstart_2) {
    for (k in bstart_3) {
      for (l in gstart_1) {
        for (q in gstart_2) {
          tryCatch({sol <- optim(par = c(l,q,i,j,k,0.2,0.2,0.2,covar_start),  fn = loglik, habitform=1,
                                 phat=phat, w=w, x=x, method="BFGS",
                                                           # lower = lower , upper= upper , 
                                 control=list(maxit=5000,
                                              trace=99,
                                              ndeps = rep(1e-10,11))    )
          print(sol)
          sol_gamma <- c(sol$par[1:2],0)
          sol_b <- sol$par[3:5]*10000
          sol_alpha <- exp(sol_gamma)/sum(exp(sol_gamma)) 
          
          list <- list(Likeli=sol$value,a1=sol_alpha[1],
                       a2=sol_alpha[2],a3=sol_alpha[3],
                       b1=sol_b[1],b2=sol_b[2],
                       b3=sol_b[3], h1=sol$par[6], h2=sol$par[7], h3=sol$par[8], o1=sol$par[9],o2=sol$par[10],o3=sol$par[11])
          
          gamma_ini <- c(l,q,0)
          alpha_ini <- exp(gamma_ini)/sum(exp(gamma_ini)) 
          b_ini <- c(i,j,k)
          list1 <- list(a1=alpha_ini[1],
                        a2=alpha_ini[2],a3=alpha_ini[3],
                        b1=b_ini[1],b2=b_ini[2],
                        b3=b_ini[3])
          Solution_habit <- rbind(Solution_habit, list)
          Start_habit <- rbind(Start_habit, list1)}, error=function(e){cat("ERROR :",conditionMessage(e), "\n")})
        }
      }
    }
  }
}

### Med habit formation og autocorrelation - ret anderledes estimater.
Solution_habit_acorr <- data.frame(Likeli=1,a1=1,a2=1,a3=1,a4=1,
                                   b1=1,b2=1,b3=1,b4=1,
                                   h1=1, h2=1, h3=1, h4=1,
                                   o1=1,o2=1,o3=1,o4=1,o5=1,o6=1,
                                   rho=1)
Start_habit <- data.frame(a1=1,a2=1,a3=1,b1=1,b2=1,b3=1)

for (i in bstart_1) {
  for (j in bstart_2) {
    for (k in bstart_3) {
      for (l in gstart_1) {
        for (q in gstart_2) {
          tryCatch({sol <- optim(par = c(l,l,q,i,j,j,k,0.2,0.2,0.2,0.2,covar_start,autocorr),  fn = loglik, habitform=1,
                                 phat=phat, w=w, x=x, method="BFGS",
                                 # lower = lower , upper= upper , 
                                 control=list(maxit=5000,
                                              trace=99,
                                              ndeps = rep(1e-10,18))    )
          print(sol)
          sol_gamma <- c(sol$par[1:3],0)
          sol_b <- sol$par[4:7]*10000
          sol_alpha <- exp(sol_gamma)/sum(exp(sol_gamma)) 
          
          list <- list(Likeli=sol$value,a1=sol_alpha[1],
                       a2=sol_alpha[2],a3=sol_alpha[3],a4=sol_alpha[4],
                       b1=sol_b[1],b2=sol_b[2],b3=sol_b[3], b4=sol_b[4],
                       h1=sol$par[8], h2=sol$par[9], h3=sol$par[10], h4=sol$par[11],
                       o1=sol$par[12],o2=sol$par[13],o3=sol$par[14], o4=sol$par[15], o5=sol$par[16], o6=sol$par[17],
                       rho=sol$par[18])
          
          #gamma_ini <- c(l,q,0)
         # alpha_ini <- exp(gamma_ini)/sum(exp(gamma_ini)) 
          #b_ini <- c(i,j,k)
          #list1 <- list(a1=alpha_ini[1],
          #              a2=alpha_ini[2],a3=alpha_ini[3],
          #              b1=b_ini[1],b2=b_ini[2],
          #              b3=b_ini[3])
          Solution_habit_acorr <- rbind(Solution_habit_acorr, list)
          #Start_habit <- rbind(Start_habit, list1) 
          }, 
         error=function(e){cat("ERROR :",conditionMessage(e), "\n")})
        }
      }
    }
  }
}


## Problem: b3 bliver negativ
Solution_uhabit <- apply(Solution_uhabit,2,as.character)
Solution_habit <- apply(Solution_habit,2,as.character)
write.csv(Solution_uhabit,"C:/specialeJR/Estimering/Solution_uhabit.csv", row.names = FALSE)
write.csv(Solution_habit,"C:/specialeJR/Estimering/Solution_habit.csv", row.names = FALSE)
write.csv(Solution_habit_acorr,"Solution_habit_acorr.csv", row.names = FALSE)








