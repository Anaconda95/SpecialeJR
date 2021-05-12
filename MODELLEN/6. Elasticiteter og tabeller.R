####################################################################################
############################# Script til at lave elasticiteter #####################
############################... og andre resultater ################################
####################################################################################



########################### FORMLER ###############################
## E_p = b(1-alpha)/C -1

## E_ex = alpha*C_total/(p*C)


############## Går ud fra vi vil regne E ud for 2019? #####################

### Udtrækker faktisk forbrug i 2019 

C1 = kvint_1[26,3:10]
C2 = kvint_2[26,3:10]
C3 = kvint_3[26,3:10]
C4= kvint_4[26,3:10]
C5 = kvint_5[26,3:10]

C_tot1 = kvint_1[26,11]
C_tot2 = kvint_2[26,11]
C_tot3 = kvint_3[26,11]
C_tot4 = kvint_4[26,11]
C_tot5 = kvint_5[26,11]

p = priser[26,2:9]

############## Minimumsforbruget i 2019 #############


b1 <- bstar_sol_1+beta_sol_1*x[25,]
b2 <- bstar_sol_2+beta_sol_2*x[25,]
b3 <- bstar_sol_3+beta_sol_3*x[25,]
b4 <- bstar_sol_4+beta_sol_4*x[25,]
b5 <- bstar_sol_5+beta_sol_5*x[25,]

alpha1 <- alpha_sol_1
alpha2 <- alpha_sol_2
alpha3 <- alpha_sol_3
alpha4 <- alpha_sol_4
alpha5 <- alpha_sol_5


#### Elasticiteter 

E_pris1 <- b1*(1-alpha1)/C1-1
E_ex1 <- alpha1*C_tot1/(p*C1)

E_pris2 <- b2*(1-alpha2)/C2-1
E_ex2 <- alpha2*C_tot2/(p*C2)

E_pris3 <- b3*(1-alpha3)/C3-1
E_ex3 <- alpha3*C_tot3/(p*C3)

E_pris4 <- b4*(1-alpha4)/C1-1
E_ex4 <- alpha4*C_tot4/(p*C4)

E_pris5 <- b5*(1-alpha5)/C5-1
E_ex5 <- alpha5*C_tot5/(p*C5)

Priselas = data.frame(V1=integer(),V2=integer(),V3=integer(),V4=integer(),V5=integer(),V6=integer(),V7=integer(),V8=integer())
Priselas = rbind(Priselas,E_pris1)
Priselas = rbind(Priselas,E_pris2)
Priselas = rbind(Priselas,E_pris3)
Priselas = rbind(Priselas,E_pris4)
Priselas = rbind(Priselas,E_pris5)

Exelas = data.frame(V1=integer(),V2=integer(),V3=integer(),V4=integer(),V5=integer(),V6=integer(),V7=integer(),V8=integer())
Exelas = rbind(Exelas,E_ex1)
Exelas = rbind(Exelas,E_ex2)
Exelas = rbind(Exelas,E_ex3)
Exelas = rbind(Exelas,E_ex4)
Exelas = rbind(Exelas,E_ex5)



