rm(list=ls())
# Indlæs data
#no scientific numbers
options(scipen=999)

df<-read.csv("C:/specialeJR/ML Rasmus/simpeldata8grup.csv",sep=';')
attach(df)
names(df)
dim(df)
View(df)

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
View(df)

#make the relevant data
w = matrix(c(df$w1,df$w2,df$w3,df$w4,df$w5,df$w6,df$w7,df$w8),
           nrow=26, ncol=8)
phat = matrix(c(df$phat1,df$phat2,df$phat3,df$phat4,df$phat5,df$phat6,df$phat7,df$phat8),
              nrow=26, ncol=8)

a = c(0.23,0.05,0.07,0.65)
b= c(30000,5000,8000,80000)

dims=dim(w)
T=dims[1]
n=dims[2]

loglik <- function(par,w, phat) {
  gamma <- c(par[1],par[2],par[3],par[4],par[5],par[6],par[7],0) 
  a <- exp(gamma)/sum(exp(gamma))  
  b <- c(par[8],par[9],par[10],par[11],par[12],par[13],par[14],par[15])
  supernum <- 1-rowSums(phat %*% diag(b))
  supernummat <- matrix(rep(supernum,8),ncol=8)
  u <- w - phat %*% diag(b) - supernummat%*%diag(a)
  #smid en variabel ud
  uhat <- u[ ,1:7]
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
#finder nogle plausible intervaller for minimumsværdierne
maxb = c(min(Faste.FOEDEVARER),
         min(Faste.ALKOHOL),
         min(Faste.BEKLAEDNING), 
         min(Faste.BOLIG.EL.OG.OPVARMNING),
         min(Faste.MOEBLER),
         min(Faste.SUNDHED),
         min(Faste.TRANSPORT),
         min(Faste.RESTAURANTER.OG.HOTELLER))


sol <- optim(par = c(-1,-2,-1,-2,-1,-2,-2,18000,1000,3000,30000,5000,1000,10000,5000), fn = loglik, 
             phat=phat, w=w, method="L-BFGS-B", lower=c(0,0,0,0,0,0,0,0,0,0,0), upper=c(1,1,1,1,1,1,1,maxb[1],maxb[2],maxb[3],maxb[4],maxb[5],maxb[6],maxb[7],maxb[8]), 
              control=list(maxit=5000))
print(sol)
sol_gamma <- c(sol$par[1:7],0)
sol_b <- sol$par[8:15]
sol_alpha <- exp(sol_gamma)/sum(exp(sol_gamma)) 
print(sol_alpha)
print(sol_b)





bstart1 = seq(1000,maxb[1],by=10000)         
bstart2 = seq(1000,maxb[2],by=2000)
bstart3 = seq(1000,maxb[3],by=3000)
bstart4 = seq(1000,maxb[4],by=20000)
bstart5 = seq(1000,maxb[5],by=40000)         
bstart6 = seq(1000,maxb[6],by=1500)
bstart7 = seq(1000,maxb[7],by=10000)
bstart8 = seq(1000,maxb[8],by=3000)

Sol_table <- data.frame(Likeli=1,a1=1,a2=1,a3=1,a4=1, a5=1,a6=1,a7=1,a8=1,b1=1,b2=1,b3=1,b4=1,b5=1,b6=1,b7=1,b8=1)
#j <- 5000
#k <- 8000
#l <- 70000
for (i in bstart1) {
  for (j in bstart2) {
    for (k in bstart3) {
      for (l in bstart4) {
        for (w in bstart5) {
          for (u in bstart6) {
            for (h in bstart7) {
              for (b in bstart8) {
                tryCatch({sol <- optim(par = c(-1,-2,-1,-2,-1,-2,-2,i,j,k,l,w,u,h,b), fn = loglik, 
                                       phat=phat, w=w, method="L-BFGS-B", lower=c(0,0,0,0,0,0,0,0,0,0,0), upper=c(1,1,1,1,1,1,1,maxb[1],maxb[2],maxb[3],maxb[4],maxb[5],maxb[6],maxb[7],maxb[8]), 
                                       control=list(maxit=5000))
                  print(sol)
                  sol_gamma <- c(sol$par[1:7],0)
                  sol_b <- sol$par[8:15]
                  sol_alpha <- exp(sol_gamma)/sum(exp(sol_gamma)) 
                  print(sol_alpha)
                  print(sol_b)
                  list <- list(Likeli=sol$value,a1=sol_alpha[1],
                             a2=sol_alpha[2],a3=sol_alpha[3],
                             a4=sol_alpha[4],a5=sol_aplha[5],a6=sol_aplha[6],a7=sol_aplha[7],
                             a8=sol_aplha[8],b1=sol_b[1],b2=sol_b[2],
                             b3=sol_b[3],b4=sol_b[4],b4=sol_b[5],b4=sol_b[6],b4=sol_b[7],b4=sol_b[8])
                  Sol_table <- rbind(Sol_table, list)}, error=function(e){cat("ERROR :",conditionMessage(e), "\n")})
              
              }
            }
          }
        }  
      }
    }
  }
}

Sol_over260 = Sol_table[Sol_table$Likeli < -260.000,]