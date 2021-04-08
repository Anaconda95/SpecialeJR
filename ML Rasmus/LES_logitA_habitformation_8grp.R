
# Indlæs data
#no scientific numbers
options(scipen=999)

df<-read.csv("simpeldata8grup.csv",sep=';')
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

#make the relevant data
w = matrix(c(df$w1,df$w2,df$w3,df$w4,df$w5,df$w6,df$w7,df$w8),
           nrow=26, ncol=8)
phat = matrix(c(df$phat1,df$phat2,df$phat3,df$phat4,df$phat5,df$phat6,df$phat7,df$phat8),
              nrow=26, ncol=8)
x = matrix(c(df$Faste.FOEDEVARER,df$Faste.ALKOHOL,df$Faste.BEKLAEDNING,df$Faste.BOLIG.EL.OG.OPVARMNING,
             df$Faste.MOEBLER, df$Faste.SUNDHED, df$Faste.TRANSPORT, df$Faste.TRANSPORT)
           ,nrow=26, ncol=8)
#scaling
x <- x/10000
phat <- phat*10000

#making alpha start values
alpha_start=w[26,]


par=c(-1,-2,-2,1,0.1,0.2,1,0.6,0.6,0.6,0.6)

loglik <- function(par,w,phat,x,habitform) {
  dims=dim(w)
  T=dims[1]
  n=dims[2]
  if (habitform==1){
    gamma <- c(par[1:(n-1)],0) 
    a <- exp(gamma)/sum(exp(gamma))  
    bstar <- c(par[n:(2*n-1)])
    beta <- c(par[(2*n):(3*n-1)])
    b <- matrix(rep(bstar,(T-1)),nrow=(T-1),ncol=n, byrow=TRUE) + x[1:(T-1),]%*%diag(beta)
    supernum <- 1-rowSums(phat[2:T,] * b)
    supernummat <- matrix(rep(supernum,n),ncol=n)
    u <- w[2:T,] - phat[2:T,]*b - supernummat%*%diag(a)
    #smid en variabel ud
    uhat <- u[ , 1:(n-1)]
    #find invers af cov(uhat) - jf. Peters note
    A <- solve(cov(uhat))
    #udregn u_t'Au_t for at kunne tage summen
    uhatAuhat <- apply(uhat,1,function(x) x %*% A %*% t(t(x)))
    #likelihood fnctn
    return(   +(n-1)/2*T*log(2*pi) - T/2*log(det(A)) + 1/2*sum(uhatAuhat)     )
  }else if (habitform == 0) {
    gamma <- c(par[1:(n-1)],0)  
    a <- exp(gamma)/sum(exp(gamma))  
    b <- c(par[n:(2*n-1)])
    supernum <- 1-rowSums(phat %*% diag(b))
    supernummat <- matrix(rep(supernum,n),ncol=n)
    u <- w - phat %*% diag(b) - supernummat%*%diag(a)
    #smid en variabel ud
    uhat <- u[ ,1:(n-1)]
    #find invers af cov(uhat) - jf. Peters note
    A <- solve(cov(uhat))
    #udregn u_t'Au_t for at kunne tage summen
    uhatAuhat <- apply(uhat,1,function(x) x %*% A %*% t(t(x)))
    #likelihood fnctn
    return(   +(n-1)/2*T*log(2*pi) - T/2*log(det(A)) + 1/2*sum(uhatAuhat)     )
  } else
    print("Set habitform = 1 or =0 ")
}

#startværdier betyder meget. Fx kunne man bruge følgende
# a'erne er defineret ved logitfunktionen) par[1:3]
# siden vi definerede a'erne ved logit har neldor-mead
# ikke kunne løse, da matricen bliver singulær
# bstar'erne er defineret ved nødvendigt forbrug, fx:
# bstar=c(10000,1000,2000,30000)
# betaerne er habitformation-parametre
# beta = c(0.6,0.6,0.6,0.6)

# Starting values for gamma based on shares of total consumption
s

sol <-  optim(par = c(-1,-2,-2,   1, 0.1, 0.2, 1,   0.6,0.6,0.6,0.6), fn = loglik, 
        phat=phat, w=w, x=x, habitform=1, method="L-BFGS-B", 
        lower = c(-100,-100,-100,0,0,0,0,0,0,0,0), 
        upper=c(100,100,100,100,100,100,100,1,1,1,1), 
        control=list(maxit=5000))
print(sol)

sol_gamma <- c(sol$par[1:3],0)
sol_bstar <- sol$par[4:7]
sol_beta <-  sol$par[8:11]
sol_alpha <- exp(sol_gamma)/sum(exp(sol_gamma)) 
print(sol_alpha)
print(sol_bstar)
print(sol_beta)

#finder nogle plausible intervaller for minimumsværdierne
maxb = c(min(Faste.FOEDEVARER),
         min(Faste.ALKOHOL),
         min(Faste.BEKLAEDNING), 
         min(Faste.BOLIG.EL.OG.OPVARMNING),
         min(Faste.MOEBLER),
         min(Faste.SUNDHED),
         min(Faste.TRANSPORT),
         min(Faste.RESTAURANTER.OG.HOTELLER))

minb = c(0,0,0,0,0,0,0,0)

bstart1 = seq(minb[1],maxb[1],by=8000)         
bstart2 = seq(minb[2],maxb[2],by=2000)
bstart3 = seq(minb[3],maxb[3],by=2500)
bstart4 = seq(minb[4],maxb[4],by=20000)

Sol_table <- data.frame(Likeli=1,a1=1,a2=1,a3=1,a4=1,b1=1,b2=1,b3=1,b4=1)
#j <- 5000
#k <- 8000
#l <- 70000
for (i in bstart1) {
  for (j in bstart2) {
    for (k in bstart3) {
      for (l in bstart4) {
        tryCatch({sol <- optim(par = c(-1,-2,-2,i,j,k,l), fn = loglik, 
                     phat=phat, w=w, method="BFGS", control=list(maxit=5000))
        print(sol)
        sol_gamma <- c(sol$par[1:3],0)
        sol_b <- sol$par[4:7]
        sol_alpha <- exp(sol_gamma)/sum(exp(sol_gamma)) 
        print(sol_alpha)
        print(sol_b)
        list <- list(Likeli=sol$value,a1=sol_alpha[1],
                     a2=sol_alpha[2],a3=sol_alpha[3],
                     a4=sol_alpha[4],b1=sol_b[1],b2=sol_b[2],
                     b3=sol_b[3],b4=sol_b[4])
        Sol_table <- rbind(Sol_table, list)}, error=function(e){cat("ERROR :",conditionMessage(e), "\n")})
      }
    }
  }
}

Sol_over260 = Sol_table[Sol_table$Likeli < -260.000,]

bstart1 = seq(minb[1],maxb[1],by=8000)         
bstart2 = seq(minb[2],maxb[2],by=2000)
bstart3 = seq(minb[3],maxb[3],by=2500)
bstart4 = seq(minb[4],maxb[4],by=20000)
