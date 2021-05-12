###########################################################################
################## Script til at lave figurer #############################
###########################################################################



dataframes = list(df_h, df_1, df_2, df_3, df_4, df_5, df_6, df_7, df_8, df_9, df_10)
dataframes_kvint= list(kvint_1,kvint_2,kvint_3, kvint_3, kvint_4)

##################### select data ########################
dataframe = kvint_5 ### <<<<<<===============
##########################################################

#Tomme vektorer
bic_matrice = data.frame(BIC=integer())




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
b_start <- 0.5*apply(x, 2, min) # b skal fortolkes som 10.000 2015-kroner.

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

habit=rep(0.7,n)
AR = rep(0.5,n)
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


## Maksimerer likelihood -----
startvals = list(start_1,start_2,start_3, start_4, start_5, start_6, start_7, start_8)

aic_mat <- NA
for (j in 1:length(startvals) ) {
  
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
  ac_const <- sol$par[((2*(n) + (n-1)*((n-1)+1)/2))]
  
  if (j==1){sol_b_mat_1 <- matrix(rep(bstar_sol,(T-1)),nrow=(T-1),ncol=n, byrow=TRUE)}
  if (j==2){sol_b_mat_2 <- matrix(rep(bstar_sol,(T-1)),nrow=(T-1),ncol=n, byrow=TRUE)}
  if (j==3){sol_b_mat_3 <- matrix(rep(bstar_sol,(T-1)),nrow=(T-1),ncol=n, byrow=TRUE) + 10000*matrix(rep(c(2:26),n),nrow=(T-1),ncol=n, byrow=FALSE) %*%diag(beta_sol)}
  if (j==4){sol_b_mat_4 <- matrix(rep(bstar_sol,(T-1)),nrow=(T-1),ncol=n, byrow=TRUE) + 10000*matrix(rep(c(2:26),n),nrow=(T-1),ncol=n, byrow=FALSE) %*%diag(beta_sol)}
  if (j==5){sol_b_mat_5 <- matrix(rep(bstar_sol,(T-1)),nrow=(T-1),ncol=n, byrow=TRUE) + 10000*x[1:(T-1),]%*%diag(beta_sol)}
  if (j==6){sol_b_mat_6 <- matrix(rep(bstar_sol,(T-1)),nrow=(T-1),ncol=n, byrow=TRUE) + 10000*x[1:(T-1),]%*%diag(beta_sol)}
  if (j==7){
    beta2_sol_7 = sol$par[n:(2*n-1)]
    sol_b_mat_7 = matrix(rep(0,25),nrow=25,ncol=n)
    sol_b_mat_7[1,] = c(rep(NA,n))
    sol_b_mat_7[2,] =  (x[2,]*10000)%*%diag(beta_sol) + (x[1,]*10000)%*%diag(AR_p_start)%*%diag(beta2_sol_7)
    for (tal in c(3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25)) {
      sol_b_mat_7[tal,] = (x[tal-1,]*10000)%*%diag(beta_sol) + sol_b_mat_7[tal-1,]%*%diag(beta2_sol_7)}
  }
  if (j==8){
    beta2_sol_8 = sol$par[n:(2*n-1)]
    sol_b_mat_8 = matrix(rep(0,25),nrow=25,ncol=n)
    sol_b_mat_8[1,] = c(rep(NA,n))
    sol_b_mat_8[2,] =  (x[2,]*10000)%*%diag(beta_sol) + (x[1,]*10000)%*%diag(AR_p_start)%*%diag(beta2_sol_8)
    for (tal in c(3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25)) {
      sol_b_mat_8[tal,] = (x[tal-1,]*10000)%*%diag(beta_sol) + sol_b_mat_8[tal-1,]%*%diag(beta2_sol_8)}
  }}



##Laver figurer for b'erne ------
vareagg = c("Meat and diary","Other foods","Housing","Energy for housing","Energy for transport","Transport","Other goods","Other services")
#Model==1: Standard uden autocorrelation
#Model==2: Standard med autocorrelation
#Model==3: Time trend uden autocorrelation
#Model==4: Time trend med autocorrelation
#Model==5: Habit-formation uden autocorrelation
#Model==6: Habit-formation med autocorrelation
for (i in 1:8) {
  v=data.frame(Year=c(1995:2019),Consumption=x[-1,i]*10000,Const=sol_b_mat_1[,i],ConstAC=sol_b_mat_2[,i],
               Trend=sol_b_mat_3[,i], TrendAC=sol_b_mat_4[,i], Habit=sol_b_mat_5[,i], HabitAC=sol_b_mat_6[,i], HabitAR=sol_b_mat_7[,i], HabitARAC=sol_b_mat_8[,i])
}



v <- v %>%
  select(Year, Consumption, Const, ConstAC,Trend,TrendAC,Habit,HabitAC, HabitAR, HabitARAC) %>%
  gather(key = "variable", value = "value", -Year)
head(v)
#If you want a legend:
ggplot(v, aes(x = Year, y = value)) + ggtitle(vareagg[i])+
  geom_line(aes(color = variable, linetype = variable)) + 
  scale_color_manual(values = c("steelblue", "steelblue","darkred","darkorange3","darkorange3","bisque4","bisque4","green","darkgreen"))


colors = c("Actual consumption" = "darkred", "Constant b" = "steelblue", "Constant b, AC" = "steelblue","Trend" = "darkorange3","Trend AC"= "darkorange3","Habit"= "bisque4","Habit, AC" = "bisque4", "Habit and AR" = "darkgreen", "Habit and AR, AC" = "darkgreen")
p <- list()
for (i in 1:8) {
  v=data.frame(Year=c(1995:2019),Consumption=x[-1,i]*10000,Const=sol_b_mat_1[,i],ConstAC=sol_b_mat_2[,i],
               Trend=sol_b_mat_3[,i], TrendAC=sol_b_mat_4[,i], Habit=sol_b_mat_5[,i], HabitAC=sol_b_mat_6[,i], HabitAR=sol_b_mat_7[,i], HabitARAC=sol_b_mat_8[,i])
  p[[i]] <- ggplot(v, aes(x=Year,) ) + ggtitle(vareagg[i])  + theme(plot.title = element_text(size=10)) +
    geom_line(aes(y = Consumption), color = "darkred") + 
    geom_line(aes(y = Const), color="steelblue", linetype="twodash")+
    geom_line(aes(y = ConstAC), color="steelblue")+
    geom_line(aes(y = Trend), color="darkorange3", linetype="twodash")+
    geom_line(aes(y = TrendAC), color="darkorange3")+
    geom_line(aes(y = Habit), color="bisque4", linetype="twodash")+
    geom_line(aes(y = HabitAC), color="bisque4")+
    geom_line(aes(y = HabitARAC), color="darkgreen", linetype="twodash")+
    geom_line(aes(y = HabitAR), color="darkgreen")+ 
    labs(x = "Year",
         y = "Consumption",
         color = "Legend") +
    scale_color_manual(values = colors)
}



do.call(grid.arrange,p)


