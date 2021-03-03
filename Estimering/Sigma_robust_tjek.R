##########################################################################################
######## Script til at illustrere, at sigma varierer, hvis lambda restrikteres ###########
##########################################################################################

library(devtools)
library(tidyverse)
library(CESKalman)
rm(list=ls())

##hent data
Data_gns = read.csv("P:/jmn/Estimering/data_gns.csv")
Data_gns <- subset(Data_gns, select = -c(X))

## estimerer for Turisme og tjenester
#Settings
temp_data_gns <- subset(Data_gns, select = c(1, 2, 9, 10))
max_nlags         = 2 
grid.lambda       = c(100,1000,100) 
grid.alpha_init   = c(-0.9,-0.1,0.5) 
grid.sigma_init   = c(0,1.5,0.5) 
print_results     = T
lambda_est_freely = F 


#estimerer over grid
Kalman = CESKalman_Static(data=temp_data_gns,max_nlags=max_nlags, grid.lambda=grid.lambda,
                            grid.sigma_init = grid.sigma_init,print_results=print_results,lambda_est_freely = lambda_est_freely)

#estimerer hvor lambda er restrikteret
for (lambda in c(100,200,300,400,500,600,700,800,900,1000)) {
 temp_data_gns <- subset(Data_gns, select = c(1, 2, 9, 10))
 grid.lambda       = c(lambda,lambda,lambda)
 
 Kalman = CESKalman_Static(data=temp_data_gns,max_nlags=max_nlags, grid.lambda=grid.lambda,
                           grid.sigma_init = grid.sigma_init,print_results=print_results,lambda_est_freely = lambda_est_freely)
}
    

# Jeg får forskellige værdier for LV og sigma, når jeg kører dette...