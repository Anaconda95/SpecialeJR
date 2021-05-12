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

p = p[26,]

############## Minimumsforbruget i 2019 #############

b1 <- b6_kvint1
b2 <- b6_kvint2
b3 <- b6_kvint3
b4 <- b6_kvint4
b5 <- b6_kvint5

alpha1 <- alpha_sol6_kvint1
alpha2 <- alpha_sol6_kvint2
alpha3 <- alpha_sol6_kvint3
alpha4 <- alpha_sol6_kvint4
alpha5 <- alpha_sol6_kvint5


#### Elasticiteter 

E_pris1 = b1*(1-alpa1)/C1-1
E_ex1 = alpha1*C_tot1/(p*C1)



