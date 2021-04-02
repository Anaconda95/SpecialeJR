
# Indlæs data
#no scientific numbers
options(scipen=999)

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

dims=dim(w)
T=dims[1]
n=dims[2]

loglik <- function(w, phat, par) {
  a <- c(par[1],par[2],par[3],1-par[1]-par[2]-par[3]) #kun tre a'er
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
  return(   -(n-1)/2*T*log(2*pi) - T/2*log(det(A)) + 1/2*sum(uhatAuhat)     )
}

#startværdier betyder meget. Fx kunne man bruge følgende
# bemærk én af a'erne er defineret ved de øvrige
#a = c(0.23,0.05,0.07,0.65)
# b= c(30000,5000,8000,80000)
optim(par = c(0.23,0.1,0.1, 20000,7500,5500,80000), fn = loglik, 
                 phat=phat, w=w, control=list(maxit=5000))


