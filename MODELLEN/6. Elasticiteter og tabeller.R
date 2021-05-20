####################################################################################
############################# Script til at lave elasticiteter #####################
############################... og andre resultater ################################
####################################################################################



########################### FORMLER ###############################
###### Fra Annabi #######
## E_p = b(1-alpha)/C -1

## E_ex = alpha*C_total/(p*C)

#### Fra Pollak and Wales 
### E_p = p*b(1-alpha)/(pb+alpha(supernumm))-1
### E_ex = alpha*ialt/(pb+alpha*supernumm)-1


############## Går ud fra vi vil regne E ud for 2019? #####################

### Udtrækker faktisk forbrug i 2019 

C1 = kvint_1[26,3:10]
C2 = kvint_2[26,3:10]
C3 = kvint_3[26,3:10]
C4=  kvint_4[26,3:10]
C5 = kvint_5[26,3:10]

C_tot1 = kvint_1[26,11]
C_tot2 = kvint_2[26,11]
C_tot3 = kvint_3[26,11]
C_tot4 = kvint_4[26,11]
C_tot5 = kvint_5[26,11]

p = priser[26,2:9]

############## Minimumsforbruget i 2019 #############



bmin1 <- b_min1[26,]
bmin2 <- b_min1[26,]
bmin3 <- b_min1[26,]
bmin4 <- b_min1[26,]
bmin5 <- b_min1[26,]

alpha1 <- alpha_sol_1
alpha2 <- alpha_sol_2
alpha3 <- alpha_sol_3
alpha4 <- alpha_sol_4
alpha5 <- alpha_sol_5


#### Elasticiteter 

#### Fra Pollak and Wales 
### E_p = p*b(1-alpha)/(pb+alpha(supernumm))-1
### E_ex = alpha*ialt/(pb+alpha*supernumm)-1
  
E_pris1 <- p*bmin1*(1-alpha1)/(p*bmin1+alpha1*(C_tot1-sum(bmin1)))-1.0000

E_ex1 <- alpha1*C_tot1/(p*bmin1+alpha1*(C_tot1-sum(bmin1)))-1

E_pris2 <- p*bmin2*(1-alpha2)/(p*bmin2+alpha2*(C_tot2-sum(bmin2)))-1

E_ex2 <- alpha2*C_tot2/(p*bmin2+alpha2*(C_tot2-sum(bmin2)))-1

E_pris3 <- p*bmin3*(1-alpha3)/(p*bmin3+alpha3*(C_tot3-sum(bmin3)))-1

E_ex3 <- alpha3*C_tot3/(p*bmin3+alpha3*(C_tot3-sum(bmin3)))-1

E_pris4 <- p*bmin4*(1-alpha4)/(p*bmin4+alpha4*(C_tot4-sum(bmin4)))-1

E_ex4 <- alpha4*C_tot4/(p*bmin4+alpha4*(C_tot4-sum(bmin4)))-1

E_pris5 <- p*bmin5*(1-alpha5)/(p*bmin5+alpha5*(C_tot5-sum(bmin5)))-1

E_ex5 <- alpha5*C_tot5/(p*bmin5+alpha5*(C_tot5-sum(bmin5)))-1







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


write.csv(Priselas, "C:/specialeJR/MODELLEN/Priselasticiteter_model6.csv")
write.csv(Exelas, "C:/specialeJR/MODELLEN/Expenditureelasticiteter_model6.csv")
