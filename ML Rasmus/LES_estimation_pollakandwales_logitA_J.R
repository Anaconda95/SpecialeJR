rm(list=ls())
# Indlæs data
#no scientific numbers
options(scipen=999)

df<-read.csv("C:/specialeJR/ML Rasmus/simpeldata4grup.csv",sep=';')
attach(df)
names(df)
dim(df)
View(df)

#make prices and shares
df     <- transform( df,
                     p1 = FOEDEVARER.OG.IKKE.ALKOHOLISKE.DRIKKEVARER/Faste.FOEDEVARER,
                     p2 = ALKOHOLISKE.DRIKKEVARER.OG.TOBAK/Faste.ALKOHOL,
                     p3 = BEKLAEDNING.OG.FODTOEJ/Faste.BEKLAEDNING,
                     p4 = BOLIGBENYTTELSE..ELEKTRICITET.OG.OPVARMNING/Faste.BOLIG.EL.OG.OPVARMNING
) 
df     <- transform( df,
                     w1 = FOEDEVARER.OG.IKKE.ALKOHOLISKE.DRIKKEVARER/Sumloeb,
                     w2 = ALKOHOLISKE.DRIKKEVARER.OG.TOBAK/Sumloeb,
                     w3 = BEKLAEDNING.OG.FODTOEJ/Sumloeb,
                     w4 = BOLIGBENYTTELSE..ELEKTRICITET.OG.OPVARMNING/Sumloeb
) 
df     <- transform( df,
                     phat1=(p1/Sumloeb)*10000,
                     phat2=(p2/Sumloeb)*10000,
                     phat3=(p3/Sumloeb)*10000,
                     phat4=(p4/Sumloeb)*10000
) 
View(df)

#make the relevant data
w = matrix(c(df$w1,df$w2,df$w3,df$w4),
           nrow=26, ncol=4)
phat = matrix(c(df$phat1,df$phat2,df$phat3,df$phat4),
              nrow=26, ncol=4)

a = c(0.23,0.05,0.07,0.65)
b= c(30000,5000,8000,80000)

dims=dim(w)
T=dims[1]
n=dims[2]

loglik <- function(par,w, phat) {
  gamma <- c(par[1],par[2],par[3],0) 
  a <- exp(gamma)/sum(exp(gamma))  
  b <- c(par[4],par[5],par[6],par[7])
  supernum <- 1-rowSums(phat %*% diag(b))
  supernummat <- matrix(rep(supernum,4),ncol=4)
  u <- w - phat %*% diag(b) - supernummat%*%diag(a)
  #smid en variabel ud
  uhat <- u[ ,1:3]
  #find invers af cov(uhat) - jf. Peters note
  A <- solve(cov(uhat))
  #udregn u_t'Au_t for at kunne tage summen
  uhatAuhat <- apply(uhat,1,function(x) x %*% A %*% t(t(x)))
  #likelihood fnctn
  return(   +(n-1)/2*T*log(2*pi) - T/2*log(det(A)) + 1/2*sum(uhatAuhat)     )
}

#startværdier betyder meget. Fx kunne man bruge følgende
# bemærk én af a'erne er defineret ved de øvrige
#a = c(0.23,0.05,0.07,0.65)
# b= c(30000,5000,8000,80000)
sol <- optim(par = c(-1,-2,-2,30000/10000,6000/10000,7000/10000,70000/10000), fn = loglik, 
                 phat=phat, w=w, method="BFGS", control=list(maxit=5000))
print(sol)
sol_gamma <- c(sol$par[1:3],0)
sol_b <- sol$par[4:7]
sol_alpha <- exp(sol_gamma)/sum(exp(sol_gamma)) 
print(sol_alpha)
print(sol_b)

#finder nogle plausible intervaller for minimumsværdierne
maxb = c(min(Faste.FOEDEVARER)/10000,
         min(Faste.ALKOHOL)/10000,
         min(Faste.BEKLAEDNING)/10000, 
         min(Faste.BOLIG.EL.OG.OPVARMNING)/10000)
minb = c(0,0,0,0)

bstart1 = seq(2.0000,maxb[1],by=0.1)         
bstart2 = seq(0.1500,maxb[2],by=0.05)
bstart3 = seq(0.3000,maxb[3],by=0.05)
bstart4 = seq(5.0000,maxb[4],by=0.5)

Sol_table <- data.frame(Likeli=1,a1=1,a2=1,a3=1,a4=1,b1=1,b2=1,b3=1,b4=1)
#j <- 5000
#k <- 8000
#l <- 70000
for (i in bstart1) {
  for (j in bstart2) {
    for (k in bstart3) {
      for (l in bstart4) {
        tryCatch({sol <- optim(par = c(-1,-2,-2,i,j,k,l), fn = loglik,
                     phat=phat, w=w, method="L-BFGS-B", lower=c(0,0,0,20000/10000,0,0,50000/10000)
                     ,upper=c(1,1,1,36010/10000,6540/10000,11200/10000,85470/10000), control=list(maxit=5000))
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

Sol_over260 = Sol_table[Sol_table$Likeli < -240.000,]

