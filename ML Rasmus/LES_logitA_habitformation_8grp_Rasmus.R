rm(list=ls())
# Indlæs data
#no scientific numbers
options(scipen=999)
options(digits=7)
df<-read.csv("simpeldata8grup.csv",sep=';')
# Julie: df<-read.csv("C:/specialeJR/ML Rasmus/simpeldata8grup.csv",sep=';')
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
#startværdier betyder meget.
#making alpha start values
# Starting values for gamma based on shares of total consumption

alpha_goal=w[26,]
gammafn <- function(par,alpha_goal) {
  return(  sum((alpha_goal - exp(par)/(1+sum(exp(par))) )^2)    )
}
gammasol <- optim(par=c(1,1,1,1,1,1,1),fn=gammafn, alpha_goal=w[26,1:7], method="BFGS", 
                  control=list(maxit=5000))
print(gammasol)
gamma_start <- c(gammasol$par,0)
alpha_start <- exp(gamma_start)/sum(exp(gamma_start))
print(w[26,1:8])
print(alpha_start)

#making other starting values. b_star should probably be less than minimum consumption
bstar_start <- 0.7*apply(x, 2, min)
beta_start <- c(rep(0.2,8))
start = c(gamma_start[1:7],  bstar_start, beta_start)
print(start)

lower <- c(rep(-100,7),rep(0,8),rep(0,8))
upper <- c(rep(100,7),rep(100,8),rep(1,8))

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
#sol_b <- c(w[,1]*sol_beta[1] + sol_bstar[1], w[,2]*sol_beta[2] + sol_bstar[2], w[,3]*sol_beta[3] + sol_bstar[3], w[,4]*sol_beta[4] + sol_bstar[4]
#           ,w[,5]*sol_beta[5] + sol_bstar[5],w[,6]*sol_beta[6] + sol_bstar[6],w[,7]*sol_beta[7] + sol_bstar[7],w[,8]*sol_beta[8] + sol_bstar[8])
#print(sol_b

results <- matrix(c(sol_alpha,sol_bstar,sol_beta),ncol=8,byrow=TRUE)
colnames(results) <- c("Foedev","Alko","Beklaed","Boligel","Moebler","Sundhed","Transport", "RestogHotel")
rownames(results) <- c("alpha","b_star","Beta")
results <- as.table(results)
results

#sammenligner med data
print(maxb)
print(alpha_start)

#finder nogle plausible intervaller for minimumsværdierne
maxb = c(min(Faste.f)/10000,
         min(Faste.ALKOHOL)/10000,
         min(Faste.BEKLAEDNING)/10000, 
         min(Faste.BOLIG.EL.OG.OPVARMNING)/10000,
         min(Faste.MOEBLER)/10000,
         min(Faste.SUNDHED)/10000,
         min(Faste.TRANSPORT)/10000,
         min(Faste.RESTAURANTER.OG.HOTELLER)/10000)

bstart1 = seq(1000,maxb[1],by=10000)         
bstart2 = seq(1000,maxb[2],by=2000)
bstart3 = seq(1000,maxb[3],by=3000)
bstart4 = seq(1000,maxb[4],by=20000)
bstart5 = seq(1000,maxb[5],by=40000)         
bstart6 = seq(1000,maxb[6],by=1500)
bstart7 = seq(1000,maxb[7],by=10000)
bstart8 = seq(1000,maxb[8],by=3000)

Sol_table <- data.frame(Likeli=1,a1=1,a2=1,a3=1,a4=1, a5=1,a6=1,a7=1,a8=1,b1=1,b2=1,b3=1,b4=1,b5=1,b6=1,b7=1,b8=1)

for (i in bstart1) {
  for (j in bstart2) {
    for (k in bstart3) {
      for (l in bstart4) {
        for (w in bstart5) {
          for (u in bstart6) {
            for (h in bstart7) {
              for (b in bstart8) {
                tryCatch({sol <-  optim(par = start, fn = loglik, 
                                        phat=phat, w=w, x=x, habitform=0, method="L-BFGS-B", 
                                        lower = lower , 
                                        upper= upper , 
                                        control=list(maxit=5000)))
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
