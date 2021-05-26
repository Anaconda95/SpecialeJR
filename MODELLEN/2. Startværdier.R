######################################################################################
######################## Script til at finde gode startv�rdier og ####################
######################## plotte BIC og LV ############################################
######################################################################################



############# V�lg dataframe ########################
dataframe <- kvint_5  ### <<<<<<<<<<<<<==============
#####################################################

##### S�tter startv�rdier
startbstar = c(0.4,0.5,0.7)
starthabit = c(0.4,0.5,0.7)
startar = c(0.4,0.5,0.7)

#### Defin�r tomme vektorer
# For LV, startv�rdier og BIC
likelihood = data.frame(V0= integer(),V1=integer(),V2=integer(),V3=integer(),V4=integer(),V5=integer(),V6=integer(),V7=integer(),V8=integer())
likelihood1 = data.frame(V0= integer(),V1=integer(),V2=integer(),V3=integer(),V4=integer(),V5=integer(),V6=integer(),V7=integer(),V8=integer())
likelihood2 = data.frame(V0= integer(),V1=integer(),V2=integer(),V3=integer(),V4=integer(),V5=integer(),V6=integer(),V7=integer(),V8=integer())
start_matstor = c(0:27)
start_matstor1 = c(0:27)
bic_mat1 = data.frame(V0= integer(),V1=integer(),V2=integer(),V3=integer(),V4=integer(),V5=integer(),V6=integer(),V7=integer(),V8=integer())
bic_mat2 = data.frame(V0= integer(),V1=integer(),V2=integer(),V3=integer(),V4=integer(),V5=integer(),V6=integer(),V7=integer(),V8=integer())

################## Datamanipulation #################


df <- dataframe
df     <- transform( df,
                     p1 = priser$Pris.kod_fisk_mej,
                     p2 = priser$Pris.ovr_fode,
                     p3 = priser$Pris.bol,
                     p4 = priser$Pris.ene_hje,
                     p5 = priser$Pris.ene_tra,
                     p6 = priser$Pris.tra,
                     p7 = priser$Pris.ovr_var,
                     p8 = priser$Pris.ovr_tje
) 
#shares findes som forbrug i løbende priser/samlet forbrug af de otte varer.
df     <- transform( df,
                     w1 = df$kod_fisk_mej /df$ialt,
                     w2 = df$ovr_fode/df$ialt,
                     w3 = df$bol/df$ialt,
                     w4 = df$ene_hje/df$ialt,
                     w5 = df$ene_tra/df$ialt,
                     w6 = df$tra/df$ialt,
                     w7 = df$ovr_var/df$ialt,
                     w8 = df$ovr_tje/df$ialt
) 

#phat findes som priser divideret med samlet forbrug
df     <- transform( df,
                     phat1=p1/df$ialt,
                     phat2=p2/df$ialt,
                     phat3=p3/df$ialt,
                     phat4=p4/df$ialt,
                     phat5=p5/df$ialt,
                     phat6=p6/df$ialt,
                     phat7=p7/df$ialt,
                     phat8=p8/df$ialt
) 

#faste priser (2015-priser)
df     <- transform( df,
                     x1 = df$kod_fisk_mej /priser$Pris.kod_fisk_mej,
                     x2 = df$ovr_fode     /priser$Pris.ovr_fode,
                     x3 = df$bol          /priser$Pris.bol,
                     x4 = df$ene_hje      /priser$Pris.ene_hje,
                     x5 = df$ene_tra      /priser$Pris.ene_tra,
                     x6 = df$tra          /priser$Pris.tra,
                     x7 = df$ovr_var      /priser$Pris.ovr_var,
                     x8 = df$ovr_tje      /priser$Pris.ovr_tje
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


# Startværdier ----------------    
#Løser ligningssystem, så gamma'erne afspejler de ønskede alphaer startværdier
#Sæt ønskede alpha fx lig budgetandele i sidste periode. gamma_n er lig 0.
gammafn <- function(par,alpha_goal) {
  return(  sum((alpha_goal - exp(par)/(1+sum(exp(par))) )^2)    )
}
gammasol <- optim(par=rep(0,(n-1)),fn=gammafn, alpha_goal=w[T,1:(n-1)], method="BFGS", 
                  control=list(maxit=5000))
gamma_start <- c(gammasol$par,0)



################### Looper over forskellige startv�rdier #######################


for ( l in startbstar) {
  for (k in starthabit){
    for (m in startar) {

                                  ############# Startv�rdier #####################
#sætter startværdier for bstar: her z pct. af det mindste forbrug over årene af en given vare i fastepriser
b_start <- l*apply(x, 2, min) # b skal fortolkes som 10.000 2015-kroner.

a <- w[T,1:(n)]  #igen, a er en logit
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

habit=rep(k,n)
AR = rep(m,n)
timetrend=rep(0.05,n)
autocorr <- 0.9

start_1 = c(gamma_start[1:(n-1)], b_start, covar_start)
start_2 = c(gamma_start[1:(n-1)], b_start, covar_start, autocorr)
start_3 = c(gamma_start[1:(n-1)], b_start, timetrend, covar_start)
start_4 = c(gamma_start[1:(n-1)], b_start, timetrend, covar_start, autocorr)
start_5 = c(gamma_start[1:(n-1)], b_start, habit, covar_start)
start_6 = c(gamma_start[1:(n-1)], b_start, habit, covar_start, autocorr)
start_7 = c(gamma_start[1:(n-1)], AR, habit, covar_start, autocorr)
start_8 = c(gamma_start[1:(n-1)], AR, habit, covar_start, autocorr)

startvals = list(start_1,start_2,start_3, start_4, start_5, start_6, start_7, start_8)
      
aic_mat <- NA
bic_mat <- NA
LI <- NA
start_mat <- c(l,k,m)


########################## L�ser modeller ####################################
for (j in 1:length(startvals) ) {
  
startval <- startvals[[j]]  
  
sol <-  optim(par = startval, fn = loglik, model=j, 
                      phat=phat, w=w, x=x, method="BFGS",
                      control=list(maxit=5000,
                                   trace=6,
                                   ndeps = rep(1e-10,length(startval))) )

AIC = 2*length(sol$par) + 2*sol$value
if (j==1) {BIC = length(sol$par)*log(T)+2*sol$value}
if (j==2) {BIC = length(sol$par)*log(T)+2*sol$value}
if (j==3) {BIC = length(sol$par)*log(T)+2*sol$value}
if (j==4) {BIC = length(sol$par)*log(T)+2*sol$value}
if (j==5) {BIC = length(sol$par)*log(T-1)+2*sol$value}
if (j==6) {BIC = length(sol$par)*log(T-1)+2*sol$value}
if (j==7) {BIC = length(sol$par)*log(T-2)+2*sol$value}
if (j==8) {BIC = length(sol$par)*log(T-2)+2*sol$value}

bic_mat <- cbind(bic_mat,BIC)
LI <- cbind(LI,sol$value)


}
   likelihood1 <- rbind(likelihood1,LI)
   start_matstor <-rbind(start_matstor,start_mat)
   bic_mat1 <- rbind(bic_mat1, bic_mat)}
    
  likelihood2 <- rbind(likelihood2,likelihood1)
  start_matstor1 <-rbind(start_matstor1,start_matstor)
  bic_mat2 <- rbind(bic_mat2, bic_mat1)}
}



######## Min write excel virker ikke :// 



write.csv(likelihood2, "C:/specialeJR/Model Fit/LV_startv�rdier_kvint5.csv")
#write.csv(start_matstor1, "C:/specialeJR/Model Fit/startv�rdier_kvint2.csv")
write.csv(bic_mat2, "C:/specialeJR/Model Fit/bic_startv�rdier_kvint5.csv")

