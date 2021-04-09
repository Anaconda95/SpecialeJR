#clear workspace
rm(list=ls())

#no scientific numbers
options(scipen=999)

# Indlæs data
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
w = matrix(c(df$w1,df$w2,df$w3,df$w4,df$w5,df$w6,df$w7,df$w8),
           nrow=26, ncol=8)
phat = matrix(c(df$phat1,df$phat2,df$phat3,df$phat4,df$phat5,df$phat6,df$phat7,df$phat8),
              nrow=26, ncol=8)
x = matrix(c(df$Faste.FOEDEVARER,df$Faste.ALKOHOL,df$Faste.BEKLAEDNING,df$Faste.BOLIG.EL.OG.OPVARMNING,
             df$Faste.MOEBLER, df$Faste.SUNDHED, df$Faste.TRANSPORT, df$Faste.TRANSPORT)
           ,nrow=26, ncol=8)

#x og phat skaleres. X er forbrug i faste priser. Det er for at få bedre konvergens når der optimeres
x <- x/10000
phat <- phat*10000

#loglikelihood, der skal maksimeres, findes i følgende funktion
# der er to muligheder: med og uden habitformation.
#Habit formation: minimums forbrug b_t er defineret ved
# b_t= b* + \beta x_{t-1}
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
    A <- solve(cov(uhat))
    #udregn u_t'Au_t for at kunne tage summen i Likelihood
    uhatAuhat <- apply(uhat,1,function(x) x %*% A %*% t(t(x)))
    #Opskriver likelihood-fuktionen:
    return(   +(n-1)/2*T*log(2*pi) - T/2*log(det(A)) + 1/2*sum(uhatAuhat)     )
  }else if (habitform == 0) {  #uden habit formation
    gamma <- c(par[1:(n-1)],0)  
    a <- exp(gamma)/sum(exp(gamma))  #igen, a er en logit
    b <- c(par[n:(2*n-1)])           # b er time-invariant
    supernum <- 1-rowSums(phat %*% diag(b))
    supernummat <- matrix(rep(supernum,n),ncol=n)
    u <- w - phat %*% diag(b) - supernummat%*%diag(a)
    #smid en variabel ud
    uhat <- u[ ,1:(n-1)]
    #find invers af cov(uhat) - jf. Peters note
    A <- solve(cov(uhat))
    #udregn u_t'Au_t for at kunne tage summen
    uhatAuhat <- apply(uhat,1,function(x) x %*% A %*% t(t(x)))
    #likelihood funktionen
    return(   +(n-1)/2*T*log(2*pi) - T/2*log(det(A)) + 1/2*sum(uhatAuhat)     )
  } else
    print("Set habitform = 1 or =0 ")
}

#startværdier betyder meget og skal vælges med omhu - eller prøve mange af.

#Startværdier til gamma(alpha) findes. I første omgang sættes startværdierne
#lig andelene i den sidste periode.
alpha_goal=w[26,]

#Løser ligningssystem, så gamma'erne afspejler de ønskede alphaer.
#gamma_n er lig 0.
gammafn <- function(par,alpha_goal) {
  return(  sum((alpha_goal - exp(par)/(1+sum(exp(par))) )^2)    )
}
gammasol <- optim(par=c(1,1,1,1,1,1,1),fn=gammafn, alpha_goal=w[26,1:7], method="BFGS", 
                  control=list(maxit=5000))
print(gammasol)
gamma_start <- c(gammasol$par,0)
alpha_start <- exp(gamma_start)/sum(exp(gamma_start))

#tjekker at det passer.
print(w[26,1:8])
print(alpha_start)

#sætter startværdier for bstar: her 70 pct. af det mindste forbrug over årene af en given vare i fastepriser
bstar_start <- 0.25*apply(x, 2, min) # b skal fortolkes som 10.000 2015-kroner.
beta_start <- c(rep(0.5,8))  #beta sættes til 0.5
start = c(gamma_start[1:7],  bstar_start, beta_start)
print(start)

# Sætter upper og lower bounds (ellers kan den godt stikke af)
# gammaerne er (så godt som) frie, b'erne skal være >0 og beta'erne mellem 0 og 1.
# bemærk at b skal fortolkes som
lower = c(rep(-100,7),rep(0,8),rep(0,8))
upper =c(rep(100,7),rep(12,8),rep(1,8))

#Optimerer likelihood.
sol <-  optim(par = start, fn = loglik, 
        phat=phat, w=w, x=x, habitform=1, method="L-BFGS-B", 
        lower = lower , 
        upper= upper , 
        control=list(maxit=5000))
print(sol)

sol_gamma <- c(sol$par[1:7],0)
sol_bstar <- sol$par[8:15]
sol_beta <-  c(sol$par[16:23])
sol_alpha <- exp(sol_gamma)/sum(exp(sol_gamma)) 
sol_b <- c(w[,1]*sol_beta[1] + sol_bstar[1], w[,2]*sol_beta[2] + sol_bstar[2], w[,3]*sol_beta[3] + sol_bstar[3], w[,4]*sol_beta[4] + sol_bstar[4]
           ,w[,5]*sol_beta[5] + sol_bstar[5],w[,6]*sol_beta[6] + sol_bstar[6],w[,7]*sol_beta[7] + sol_bstar[7],w[,8]*sol_beta[8] + sol_bstar[8])
#print(sol_b)
print(sol_alpha)
print(sol_bstar)
print(sol_beta)

#sammenligner med data
print(maxb)
print(alpha_start)

#finder nogle plausible intervaller for minimumsværdierne
maxb = c(min(Faste.FOEDEVARER)/10000,
         min(Faste.ALKOHOL)/10000,
         min(Faste.BEKLAEDNING)/10000, 
         min(Faste.BOLIG.EL.OG.OPVARMNING)/10000,
         min(Faste.MOEBLER)/10000,
         min(Faste.SUNDHED)/10000,
         min(Faste.TRANSPORT)/10000,
         min(Faste.RESTAURANTER.OG.HOTELLER)/10000)

bstart1 = seq(start_bstar[1],start_bstar[1]*2,by=0.5)         
bstart2 = seq(start_bstar[2],start_bstar[2]*2,by=0.1) 
bstart3 = seq(start_bstar[3],start_bstar[3]*2,by=0.1) 
bstart4 = seq(start_bstar[4],start_bstar[4]*2,by=0.8) 
bstart5 = seq(start_bstar[5],start_bstar[5]*2,by=0.1)        
bstart6 = seq(start_bstar[6],start_bstar[6]*2,by=0.1) 
bstart7 = seq(start_bstar[7],start_bstar[7]*2,by=0.5) 
bstart8 = seq(start_bstar[8],start_bstar[8]*2,by=0.1) 

print(bstart1)
print(bstart2)
print(bstart3)
print(bstart4)
print(bstart5)
print(bstart6)
print(bstart7)
print(bstart8)



Sol_table <- data.frame(Likeli=1,a1=1,a2=1,a3=1,a4=1, a5=1,a6=1,a7=1,a8=1,b1=1,b2=1,b3=1,b4=1,b5=1,b6=1,b7=1,b8=1, bet1=1, bet2=1, bet3=1, bet4=1, bet5=1, bet6=1, bet7=1, bet8=1)
for (i in bstart1) {
  for (j in bstart2) {
    for (k in bstart3) {
      for (l in bstart4) {
        for (y in bstart5) {
          for (u in bstart6) {
            for (h in bstart7) {
              for (b in bstart8) {
                tryCatch({sol <-  optim(par = c(gammasol$par[1:7],i,j,k,l,y,u,h,b, start_beta), fn = loglik, 
                                        phat=phat, w=w, x=x, habitform=1, method="L-BFGS-B", 
                                        lower = lower , 
                                        upper= upper , 
                                        control=list(maxit=5000))
                
                
                print(sol)
                
                sol_gamma <- c(sol$par[1:7],0)
                sol_bstar <- sol$par[8:15]
                sol_beta <-  c(sol$par[16:23])
                sol_alpha <- exp(sol_gamma)/sum(exp(sol_gamma)) 
                
                list <- list(Likeli=sol$value,a1=sol_alpha[1],
                             a2=sol_alpha[2],a3=sol_alpha[3],
                             a4=sol_alpha[4],a5=sol_alpha[5],a6=sol_alpha[6],a7=sol_alpha[7],
                             a8=sol_alpha[8],b1=sol_bstar[1],b2=sol_bstar[2],
                             b3=sol_bstar[3],b4=sol_bstar[4],b5=sol_bstar[5],b6=sol_bstar[6],b7=sol_bstar[7],b8=sol_bstar[8],
                             bet1=sol_beta[1],bet2=sol_beta[2],bet3=sol_beta[3],bet4=sol_beta[4]
                             , bet5=sol_beta[5],bet6=sol_beta[6],bet7=sol_beta[7],bet8=sol_beta[8])
                Sol_table <- rbind(Sol_table, list)}, error=function(e){cat("ERROR :",conditionMessage(e), "\n")})
                
              }
            }
          }
        }  
      }
    }
  }
}

Sol_over849 = Sol_table[Sol_table$Likeli < -849.000,]

Sol_max = Sol_table[Sol_table$Likeli == min(Sol_table$Likeli),]
a_max <- Sol_max[1,2:9]
lik_max <- c(Sol_max[,1],Sol_max[,1],Sol_max[,1],Sol_max[,1],Sol_max[,1],Sol_max[,1],Sol_max[,1],Sol_max[,1])
bstar_max <- Sol_max[,10:17]*10000
beta_max <- Sol_max[,18:25]

colnames(a_max) = c("Mad","Alko","Bekl", "Bolig", "Moebler", "Sundhed", "Transport", "Rest")
colnames(lik_max) = c("Mad","Alko","Bekl", "Bolig", "Moebler", "Sundhed", "Transport", "Rest")
colnames(bstar_max) = c("Mad","Alko","Bekl", "Bolig", "Moebler", "Sundhed", "Transport", "Rest")
colnames(beta_max) = c("Mad","Alko","Bekl", "Bolig", "Moebler", "Sundhed", "Transport", "Rest")

df1 <- data.frame()
df1 <- rbind(a_max,bstar_max)
df1 <- rbind(df1,beta_max)
df1 <- rbind(df1,lik_max)


sol_b <- c(w[,1]*sol_beta[1] + sol_bstar[1], w[,2]*sol_beta[2] + sol_bstar[2], w[,3]*sol_beta[3] + sol_bstar[3], w[,4]*sol_beta[4] + sol_bstar[4]
           ,w[,5]*sol_beta[5] + sol_bstar[5],w[,6]*sol_beta[6] + sol_bstar[6],w[,7]*sol_beta[7] + sol_bstar[7],w[,8]*sol_beta[8] + sol_bstar[8])
write.table(df1,"C:/specialeJR/ML Rasmus/tabel_ML.csv", row.names = c("alpha","bstar","beta","Likeli"), col.names = TRUE, sep=",")

results <- matrix(c(a_max,bstar_max*10000,beta_max,lik_max),ncol=8,byrow=TRUE)
colnames(results) <- c("Foedev","Alko","Beklaed","Boligel","Moebler","Sundhed","Transport", "RestogHotel")
rownames(results) <- c("alpha","b_star","Beta", "Likeli")
results <- as.table(results)
results

print(sol_alpha)
print(a_max)
print(a_max[1,])
