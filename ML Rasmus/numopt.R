
library(matlib)
#Step1: Load Data set

df<-read.csv("simpeldata4grup.csv",sep=';')
attach(df)
names(df)
dim(df)
View(df)

#make prices and shares
df     <- transform( df,
                     p1 = FØDEVARER.OG.IKKE.ALKOHOLISKE.DRIKKEVARER/Faste.FØDEVARER,
                     p2 = ALKOHOLISKE.DRIKKEVARER.OG.TOBAK/Faste.ALKOHOL,
                     p3 = BEKLÆDNING.OG.FODTØJ/Faste.BEKLÆDNING,
                     p4 = BOLIGBENYTTELSE..ELEKTRICITET.OG.OPVARMNING/Faste.BOLIG.EL.OG.OPVARMNING
) 
df     <- transform( df,
                     w1 = FØDEVARER.OG.IKKE.ALKOHOLISKE.DRIKKEVARER/Sumloeb,
                     w2 = ALKOHOLISKE.DRIKKEVARER.OG.TOBAK/Sumloeb,
                     w3 = BEKLÆDNING.OG.FODTØJ/Sumloeb,
                     w4 = BOLIGBENYTTELSE..ELEKTRICITET.OG.OPVARMNING/Sumloeb
) 
df     <- transform( df,
                     phat1=p1/Sumloeb,
                     phat2=p2/Sumloeb,
                     phat3=p3/Sumloeb,
                     phat4=p4/Sumloeb
) 
View(df)

#make the relevant data
w = matrix(c(df$w1,df$w2,df$w3,df$w4),
           nrow=26, ncol=4)
phat = matrix(c(df$phat1,df$phat2,df$phat3,df$phat4),
              nrow=26, ncol=4)

a = c(0.23,0.05,0.07,0.65)
b= c(30000,5000,8000,80000)

loglik <- function(w, phat, theta) {
  a <- c(theta[1],theta[2],theta[3],theta[4])
  b <- c(theta[5],theta[6],theta[7],theta[8])
  supernum <- 1-rowSums(phat %*% diag(b))
  supernummat <- matrix(rep(supernum,4),ncol=4)
  u <- w - phat %*% diag(b) - supernummat%*%diag(a)
  
  return(-sum(L1 + L2 + L3 + L4))
}

(result <- optim(theta = c(0, 1), fn = min.RSS, data = dat))

lm(y ~ x, data = dat)

