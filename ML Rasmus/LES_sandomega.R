#clear workspace
rm(list=ls())
library(mvtnorm)

#no scientific numbers
options(scipen=999)

# Indlæs data
df<-read.csv("simpeldata8grup.csv",sep=';')

#make prices and shares
df     <- transform( df,
                     p1 = FOEDEVARER.OG.IKKE.ALKOHOLISKE.DRIKKEVARER/Faste.FOEDEVARER,
                     p2 = BEKLAEDNING.OG.FODTOEJ/Faste.BEKLAEDNING,
                     p3 = BOLIGBENYTTELSE..ELEKTRICITET.OG.OPVARMNING/Faste.BOLIG.EL.OG.OPVARMNING
) 

df     <- transform( df,
                     TotalForb = FOEDEVARER.OG.IKKE.ALKOHOLISKE.DRIKKEVARER +BEKLAEDNING.OG.FODTOEJ + BOLIGBENYTTELSE..ELEKTRICITET.OG.OPVARMNING 
                     
) 
#shares findes som forbrug i løbende priser/samlet forbrug af de otte varer.
df     <- transform( df,
                     w1 = FOEDEVARER.OG.IKKE.ALKOHOLISKE.DRIKKEVARER/TotalForb,
                     w2 = BEKLAEDNING.OG.FODTOEJ/TotalForb,
                     w3 = BOLIGBENYTTELSE..ELEKTRICITET.OG.OPVARMNING/TotalForb
) 

#phat findes som priser divideret med samlet forbrug
df     <- transform( df,
                     phat1=p1/TotalForb,
                     phat2=p2/TotalForb,
                     phat3=p3/TotalForb
) 

#Datasættet sættes op i 'pæne' matricer.
w = matrix(c(df$w1,df$w2,df$w3),
           nrow=26, ncol=3)
phat = matrix(c(df$phat1,df$phat2,df$phat3),
              nrow=26, ncol=3)
x = matrix(c(df$Faste.FOEDEVARER,df$Faste.BEKLAEDNING,df$Faste.BOLIG.EL.OG.OPVARMNING)
           ,nrow=26, ncol=3)

#x og phat skaleres. X er forbrug i faste priser. Det er for at få bedre konvergens når der optimeres
x <- x/10000
phat <- phat*10000

dims=dim(w)
T=dims[1]
n=dims[2]

#Løser ligningssystem, så gamma'erne afspejler de ønskede alphaer.
#gamma_n er lig 0.
gammafn <- function(par,alpha_goal) {
  return(  sum((alpha_goal - exp(par)/(1+sum(exp(par))) )^2)    )
}
gammasol <- optim(par=rep(0,(n-1)),fn=gammafn, alpha_goal=w[10,1:(n-1)], method="BFGS", 
                  control=list(maxit=5000))
print(gammasol)
gamma_start <- c(gammasol$par,0)
alpha_start <- exp(gamma_start)/sum(exp(gamma_start))

#tjekker at det passer.
print(w[10,1:(n)])
print(alpha_start)

#sætter startværdier for bstar: her 70 pct. af det mindste forbrug over årene af en given vare i fastepriser
b_start <- 0.8*apply(x, 2, min) # b skal fortolkes som 10.000 2015-kroner.

#finder startværdier for kovariansmatricen
par <- start
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
covar_start <- c(covar[1,1],covar[2,2],covar[1,2])

start = c(gamma_start[1:(n-1)], b_start, covar_start)
print(start)

#sætter startværdier for habit formation
habit=rep(0.2,3)
starthabit = c(gamma_start[1:(n-1)], b_start, habit, covar_start)
print(starthabit)
par=starthabit
loglik <- function(par,w,phat,x,habitform) {
  #sætter dimensioner
  dims=dim(w)
  T=dims[1]
  n=dims[2]
  #med habitformation
  if (habitform==1){
    gamma <- c(par[1:(n-1)],0) #gamma definereres - kun for de første n-1 parametre. gamma_n=0.
    a <- exp(gamma)/sum(exp(gamma))  # a som en logit (sikrer mellem 0 og 1)
    bstar <- c(par[n:(2*n-1)]) # bstar: 8 parametre
    beta <- c(par[(2*n):(3*n-1)]) #beta: 8 parametre
    #Med habit formation må ét år fjernes fra estimeringen.
    b <- matrix(rep(bstar,(T-1)),nrow=(T-1),ncol=n, byrow=TRUE) + x[1:(T-1),]%*%diag(beta) #b defineres som matrix.
    supernum <- 1-rowSums(phat[2:T,] * b) #supernumerary income i hver periode sættes
    supernummat <- matrix(rep(supernum,n),ncol=n) # for at lette beregningen af u replikeres n gange til en matrixe
    u <- w[2:T,] - phat[2:T,]*b - supernummat%*%diag(a) #u beregnes ud fra modellen
    #En kolonne u'er smides ud, da matricen ellers er singulær
    uhat <- u[ , 1:(n-1)]
    #Følger Peters note og sætter A som inv(cov(uhat))
    # omega skal være covariansmatricen for den normalfordeling
    # omega skal også estimeres som parameter.
    #find omega matrix()
    omega <- matrix(c(par[9],par[11],par[11],par[10]), nrow=2, ncol=2)
    omegainv <- solve(omega)
    #udregn u_t'Au_t for at kunne tage summen
    uhatomegainvuhat <- apply(uhat,1,function(x) x %*% omegainv %*% x)
    #likelihood funktionen
#    l1 = dmvnorm(x=uhat, mean=rep(0,n-1), sigma=omega, log=TRUE)
#    return(   -sum(l1) )
    return(   -( -(n-1)*(T-1)*log(2*pi)/2   -(T-1)/2*log(det(omega)) -1/2*sum(uhatomegainvuhat) )     )
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
    omega <- matrix(c(par[6],par[8],par[8],par[7]), nrow=2, ncol=2)
    omegainv <- solve(omega)
    #udregn u_t'Au_t for at kunne tage summen
    uhatomegainvuhat <- apply(uhat,1,function(x) x %*% omegainv %*% x)
    #likelihood funktionen
    return(   -(- (n-1)/2*T*log(2*pi) -  T/2*log(det(omega)) - 1/2*sum(uhatomegainvuhat) )     )
  } else
    print("Set habitform = 1 or =0 ")
}

lower = c(rep(-100,3),rep(0,3),rep(-100,3))
upper =c(rep(100,3),rep(12,3),rep(100,3))

#Maksimererlikelihood.
#virker med BFGS
# og B'erne er sindssygt afhængige af startværdier.

sol <-  optim(  par = starthabit, fn = loglik, gr=NULL, habitform=1,
                phat=phat, w=w, x=x, method="BFGS", hessian=FALSE, 
 #                             lower = lower ,  upper= upper , 
                control=list(maxit=5000,
                             trace=99,
                             ndeps = rep(1e-8,11))    ) #ndeps=rep(1e-8,11))  )

sol8<-sol$par
starthabit8 <- starthabit

sol4
sol6
sol7

