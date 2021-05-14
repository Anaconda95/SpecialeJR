#######################################################################################
#######################################################################################
########### This awesome script will BOOTSTRAP our parameters          ################
######################################################## EAHHHH #######################
#######################################################################################

dataframe = df_h


############## Datamanipulation #############
df <- dataframe
df     <- transform( df,
                     p1 = priser$Pris.kod_fisk_mej,
                     p2 = priser$Pris.ovr_fode,
                     p3 = priser$Pris.bol,
                     p4 = priser$Pris.ene_hje,
                     p5 = priser$Pris.ene_tra,
                     p6 = priser$Pris.tra,
                     p7 = priser$Pris.ovr_var,
                     p8 = priser$Pris.tra
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
                     x8 = df$ovr_tje      /priser$Pris.tra 
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

#sætter startværdier for bstar: her z pct. af det mindste forbrug over årene af en given vare i fastepriser
b_start <- 0.7*apply(x, 2, min) # b skal fortolkes som 10.000 2015-kroner.

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

habit=rep(0.5,n)
AR = rep(0.4,n)
timetrend=rep(0.01,n)
autocorr <- 0.9

start_1 = c(gamma_start[1:(n-1)], b_start, covar_start)
start_2 = c(gamma_start[1:(n-1)], b_start, covar_start, autocorr)
start_3 = c(gamma_start[1:(n-1)], b_start, timetrend, covar_start)
start_4 = c(gamma_start[1:(n-1)], b_start, timetrend, covar_start, autocorr)
start_5 = c(gamma_start[1:(n-1)], b_start, habit, covar_start)
start_6 = c(gamma_start[1:(n-1)], b_start, habit, covar_start, autocorr)
start_7 = c(gamma_start[1:(n-1)], AR, habit, covar_start, autocorr)
start_8 = c(gamma_start[1:(n-1)], AR, habit, covar_start, autocorr)


## Maksimerer likelihood -----
startvals = list(start_1,start_2,start_3, start_4, start_5, start_6, start_7, start_8)

#Set model
j=6;
  
  startval <- startvals[[j]]  
  
  sol <-  optim(par = startval, fn = loglik, model=j, 
                phat=phat, w=w, x=x, method="BFGS",
                control=list(maxit=5000,
                             trace=6,
                             ndeps = rep(1e-10,length(startval))) )
  
  if (j==1) {BIC = length(sol$par)*log(T)+2*sol$value}
  if (j==2) {BIC = length(sol$par)*log(T)+2*sol$value}
  if (j==3) {BIC = length(sol$par)*log(T)+2*sol$value}
  if (j==4) {BIC = length(sol$par)*log(T)+2*sol$value}
  if (j==5) {BIC = length(sol$par)*log(T-1)+2*sol$value}
  if (j==6) {BIC = length(sol$par)*log(T-1)+2*sol$value}
  if (j==7) {BIC = length(sol$par)*log(T-2)+2*sol$value}
  if (j==8) {BIC = length(sol$par)*log(T-2)+2*sol$value}
  
  bic_matrice <- rbind(bic_matrice,BIC)
  
  #Udregner minimumsforbruget for alle perioder.
  sol_gamma <- c(sol$par[1:(n-1)],0)
  bstar_sol <- sol$par[n:(2*n-1)]*10000
  alpha_sol <- exp(sol_gamma)/sum(exp(sol_gamma))
  z_sol <- sol$par[(2*n):(3*n-1)]
  beta_sol = z_sol**2
  ac_const <- sol$par[((3*(n) + (n-1)*((n-1)+1)/2))]
  
  if (j==1){sol_b_mat <- matrix(rep(bstar_sol,(T-1)),nrow=(T-1),ncol=n, byrow=TRUE)}
  if (j==2){sol_b_mat <- matrix(rep(bstar_sol,(T-1)),nrow=(T-1),ncol=n, byrow=TRUE)}
  if (j==3){sol_b_mat <- matrix(rep(bstar_sol,(T-1)),nrow=(T-1),ncol=n, byrow=TRUE) + 10000*matrix(rep(c(2:26),n),nrow=(T-1),ncol=n, byrow=FALSE) %*%diag(beta_sol)}
  if (j==4){sol_b_mat <- matrix(rep(bstar_sol,(T-1)),nrow=(T-1),ncol=n, byrow=TRUE) + 10000*matrix(rep(c(2:26),n),nrow=(T-1),ncol=n, byrow=FALSE) %*%diag(beta_sol)}
  if (j==5){sol_b_mat <- matrix(rep(bstar_sol,(T-1)),nrow=(T-1),ncol=n, byrow=TRUE) + 10000*x[1:(T-1),]%*%diag(beta_sol)}
  if (j==6){sol_b_mat <- matrix(rep(bstar_sol,(T-1)),nrow=(T-1),ncol=n, byrow=TRUE) + 10000*x[1:(T-1),]%*%diag(beta_sol)}
  if (j==7){
    beta2_sol = sol$par[n:(2*n-1)]
    sol_b_mat = matrix(rep(0,25),nrow=25,ncol=n)
    sol_b_mat[1,] = c(rep(NA,n))
    sol_b_mat[2,] =  (x[2,]*10000)%*%diag(beta_sol) + (x[1,]*10000)%*%diag(AR_p_start)%*%diag(beta2_sol)
    for (tal in c(3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25)) {
      sol_b_mat[tal,] = (x[tal-1,]*10000)%*%diag(beta_sol) + sol_b_mat[tal-1,]%*%diag(beta2_sol)}
  }
  if (j==8){
    beta2_sol = sol$par[n:(2*n-1)]
    sol_b_mat = matrix(rep(0,25),nrow=25,ncol=n)
    sol_b_mat[1,] = c(rep(NA,n))
    sol_b_mat[2,] =  (x[2,]*10000)%*%diag(beta_sol) + (x[1,]*10000)%*%diag(AR_p_start)%*%diag(beta2_sol)
    for (tal in c(3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25)) {
      sol_b_mat[tal,] = (x[tal-1,]*10000)%*%diag(beta_sol) + sol_b_mat[tal-1,]%*%diag(beta2_sol)}
  }


## Laver nogle figurer -----
vareagg = c("Meat and dairy","Other foods","Housing","Energy for housing","Energy for transport","Transport","Other goods","Other services")
  
p <- list()
  for (i in 1:8) {
    v=data.frame(Year=c(1994:2019),Share=w[,i],Phat=phat[,i],Sharepredict=w_pred_26[,i],Shareboot=w_boot[,i])
    v <- v %>%
      select(Year, Share, Phat, Sharepredict, Shareboot) %>%
      gather(key = "Model", value = "value", -Year)
    #If you want a legend:
    p[[i]] <- ggplot(v, aes(x = Year, y = value)) + ggtitle(vareagg[i])+
      geom_line(aes(color = Model)) + 
      #scale_color_manual(values = c("darkred","steelblue", "steelblue","darkorange3","darkorange3","deeppink1","deeppink1","darkgreen","darkgreen"),)+
      #scale_linetype_manual(values = c("solid","twodash", "solid", "twodash","solid","twodash","solid","twodash","solid"))+
      #scale_size_manual(values=c(0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5))+
      labs(y = "DKK (2015 Prices)")
  }

ggarrange(plotlist=p, ncol=2, nrow=4, common.legend = TRUE, legend="right")

w_pred_26 = rep(NA,n)
w_pred <- (phat[-1,]*sol_b_mat/10000) +  matrix(rep((1-rowSums(phat[-1,]*sol_b_mat/10000)), n), ncol = n)%*%diag(alpha_sol)
w_pred_26 = matrix(rbind(w_pred_26,w_pred),ncol = n)
w[-1,]-w_pred
u_6 = w[-1,] - w_pred
#tjek at det er den rigtige ac_const
e_6 = u_6[-1,] - ac_const*u_6[-25,] 

#Okay såå bootstraps skal være iid. Så er vi ude i, at det er e, der er iid her. S
#Og det gælder, at der er kun er 7 uafhængige fejlled. Så den 8. skal være residualen. Okay
#eller også tager man bare alle fejlledene fra hvert år. Så er det nok ligemeget.
bstar_sol
bstar=bstar_sol/10000
beta_sol
alpha_sol
ac_const
mu=df$ialt/10000
phat
w_boot = w
u=matrix(NA,nrow=T, ncol=n)
u
u[2,]= u_6[1,] 
  for (i in 3:26){
    random <- sample(1:24, 1)
    u[i,]= ac_const*u[(i-1),] + e_6[random,]
    supernum = sum((bstar+(w[(i-1),]*mu[(i-1)])%*%diag(beta_sol))*phat[i])
    w_boot[i,] = (bstar+(w[(i-1),]*mu[(i-1)])%*%diag(beta_sol))*phat[i] + alpha_sol*(1-supernum) + u[i,]
  }
w_boot-w
sum(w_boot[3,])

