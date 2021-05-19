#######################################################################################
#######################################################################################
########### This awesome script will BOOTSTRAP our parameters          ################
######################################################## YEAHHHH ######################
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
p = matrix(c(df$p1,df$p2,df$p3,df$p4,df$p5,df$p6,df$p7,df$p8), nrow=26, ncol=8)

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
  solcentral<- sol
  
  BIC = length(sol$par)*log(T-1)+2*sol$value
  
  #Udregner minimumsforbruget for alle perioder.
  sol_gamma <- c(sol$par[1:(n-1)],0)
  bstar_sol <- sol$par[n:(2*n-1)]*10000
  alpha_sol <- exp(sol_gamma)/sum(exp(sol_gamma))
  z_sol <- sol$par[(2*n):(3*n-1)]
  beta_sol = z_sol**2
  ac_const <- sol$par[((3*(n) + (n-1)*((n-1)+1)/2))]

  sol_b_mat <- matrix(rep(bstar_sol,(T-1)),nrow=(T-1),ncol=n, byrow=TRUE) + 10000*x[1:(T-1),]%*%diag(beta_sol)
  
  #Udregner elasticiteter - sidste periode
  mu=df$ialt/10000
  supernum=mu[-1]*10000-rowSums(sol_b_mat)
  sol_el_op = (p[T,]*sol_b_mat[(T-1),]*(1-alpha_sol))/(p[T,]*sol_b_mat[(T-1),]+alpha_sol*supernum[25])-1
  sol_el_exp = alpha_sol*mu[T]*10000/(p[T,]*sol_b_mat[(T-1),]+alpha_sol*supernum[25])

##SÅ SKAL DER BOOTSTRAPPES ---- 

#Den predictede share
w_pred_26 = rep(NA,n)
w_pred <- (phat[-1,]*sol_b_mat/10000) +  matrix(rep((1-rowSums(phat[-1,]*sol_b_mat/10000)), n), ncol = n)%*%diag(alpha_sol)
w_pred_26 = matrix(rbind(w_pred_26,w_pred),ncol = n)
w[-1,]-w_pred
u_6 = w[-1,] - w_pred
#VIGTIGT tjek at det er den rigtige ac_const
e_6 = u_6[-1,] - ac_const*u_6[-25,] 

#De parametere og data vi skal bruge.
bstar_sol
bstar=bstar_sol/10000
beta_sol
alpha_sol
ac_const
mu=df$ialt/10000
phat

#Initialize bootstrap
B=10
w1_boot_mat       <- matrix(ncol=B,nrow=T)
w3_boot_mat       <- matrix(ncol=B,nrow=T)
alpha_boot_mat    <- matrix(ncol=n,nrow=B)
beta_boot_mat     <- matrix(ncol=n,nrow=B)
bstar_boot_mat    <- matrix(ncol=n,nrow=B)
ac_const_boot_mat <- matrix(ncol=1,nrow=B)
el_op_boot_mat    <- matrix(ncol=n,nrow=B)
el_exp_boot_mat   <- matrix(ncol=n,nrow=B)

b=1
while (b<=B) {
  #Start making a w matrix
  w_boot = w
  # Vi bruger bare rækken af fejlled - de summer altid til 0. Som de skal. Det er det nemmeste.
  u=matrix(NA,nrow=T, ncol=n)
  #Vi er nødt til at starte et sted. Vi start bare i udgangspunktet for det rigtige data:
  #u[1,]=u_6[1,]
  #Vi prøver lige at starte et random sted
  random <- sample(1:24,1)
  u[1,]=u_6[random,]
  #Selve bootstrapdatasættet dannes her:
  for (i in 2:26){
    random <- sample(1:24, 1)
    u[i,]= ac_const*u[(i-1),] + e_6[random,]
    supernum = sum((bstar+(w[(i-1),]*mu[(i-1)])%*%diag(beta_sol))*phat[i])
    w_boot[i,] = (bstar+(w[(i-1),]*mu[(i-1)])%*%diag(beta_sol))*phat[i] + alpha_sol*(1-supernum) + u[i,]
  }
  x_boot = w_boot*mu
  w1_boot_mat[,b] = w_boot[,1]
  w3_boot_mat[,b] = w_boot[,3]  
  
  # Løser modellen
  #startval <- startvals[[6]]  
  startval <- solcentral$par  
  
  sol <-  optim(par = startval, fn = loglik, model=6, 
                phat=phat, w=w_boot, x=x_boot, method="BFGS",
                control=list(maxit=5000,
                             trace=6,
                             ndeps = rep(1e-10,length(startval))) )
  gamma_boot <- c(sol$par[1:(n-1)],0)
  alpha_boot_mat[b,] <- exp(gamma_boot)/sum(exp(gamma_boot))
  bstar_boot_mat[b,] <- sol$par[n:(2*n-1)]*10000
  beta_boot_mat[b,] <- sol$par[(2*n):(3*n-1)]**2
  ac_const_boot_mat[b] <- sol$par[((3*(n) + (n-1)*((n-1)+1)/2))]
  sol_b_mat <- matrix(rep(bstar_boot_mat[b,],(T-1)),nrow=(T-1),ncol=n, byrow=TRUE) + 10000*x[1:(T-1),]%*%diag(beta_boot_mat[b,])
  supernum=mu[-1]*10000-rowSums(sol_b_mat)
  el_op_boot_mat[b,] = (p[T,]*sol_b_mat[(T-1),]*(1-alpha_boot_mat[b,]))/(p[T,]*sol_b_mat[(T-1),]+alpha_boot_mat[b,]*supernum[25])-1
  el_exp_boot_mat[b,] = alpha_boot_mat[b,]*mu[T]*10000/(p[T,]*sol_b_mat[(T-1),]+alpha_boot_mat[b,]*supernum[25])
  if (min(alpha_boot_mat[b,])>0.001 & max(el_op_boot_mat[b,])<0 & max(alpha_boot_mat[b,]-alpha_sol)>0.001)
  {b=b+1} 
  else{print("Failed, restarting iteration")}
}


alpha_boot_mat
alpha_conf    = matrix(nrow=2,ncol = n)
bstar_conf    = matrix(nrow=2,ncol = n)
beta_conf     = matrix(nrow=2,ncol = n)
el_op_conf    = matrix(nrow=2,ncol = n)
el_exp_conf   = matrix(nrow=2,ncol = n)
ac_const_conf = quantile(ac_const_boot[s], c(.05,.95))
for (s in 1:n){
  ci <-quantile(alpha_boot_mat[,s], c(.05,.95))
  alpha_conf[1,s]=ci[1]
  alpha_conf[2,s]=ci[2]
  ci <-quantile(bstar_boot_mat[,s], c(.05,.95))
  bstar_conf[1,s]=ci[1]
  bstar_conf[2,s]=ci[2]
  ci <-quantile(beta_boot_mat[,s], c(.05,.95))
  beta_conf[1,s]=ci[1]
  beta_conf[2,s]=ci[2]
  ci <-quantile(el_op_boot_mat[,s], c(.05,.95))
  el_op_conf[1,s]=ci[1]
  el_op_conf[2,s]=ci[2]
  ci <-quantile(el_exp_boot_mat[,s], c(.05,.95))
  el_exp_conf[1,s]=ci[1]
  el_exp_conf[2,s]=ci[2]
}

alpha_sol
alpha_conf
bstar_sol
bstar_conf
beta_sol
beta_conf
sol_el_op
el_op_conf
sol_el_exp
el_exp_conf

v=data.frame(Year=c(1994:2019),w[,3],w3_boot_mat)
v <- v %>%
  #select(Year, Share, Phat, Sharepredict, Shareboot, Shareboot2) %>%
  gather(key = "Model", value = "value", -Year)
ggplot(v, aes(x = Year, y = value))+geom_line(aes(color = Model))

## Laver nogle figurer -----
vareagg = c("Meat and dairy","Other foods","Housing","Energy for housing","Energy for transport","Transport","Other goods","Other services")
plots <- list()
for (i in 1:8) {
  v=data.frame(Year=c(1994:2019),Share=w[,i],Phat=phat[,i],Sharepredict=w_pred_26[,i],
               Shareboot=w_boot[,i], Shareboot2=w_boot2[,i])
  v <- v %>%
    select(Year, Share, Phat, Sharepredict, Shareboot, Shareboot2) %>%
    gather(key = "Model", value = "value", -Year)
  #If you want a legend:
  plots[[i]] <- ggplot(v, aes(x = Year, y = value)) + ggtitle(vareagg[i])+
    geom_line(aes(color = Model)) + 
    #scale_color_manual(values = c("darkred","steelblue", "steelblue","darkorange3","darkorange3","deeppink1","deeppink1","darkgreen","darkgreen"),)+
    #scale_linetype_manual(values = c("solid","twodash", "solid", "twodash","solid","twodash","solid","twodash","solid"))+
    #scale_size_manual(values=c(0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5))+
    labs(y = "DKK (2015 Prices)")
}

ggarrange(plotlist=plots, ncol=2, nrow=4, common.legend = TRUE, legend="right")

