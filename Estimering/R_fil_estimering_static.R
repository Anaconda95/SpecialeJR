library(devtools)
library(tidyverse)
library(CESKalman)
rm(list=ls())


Data_u250 = read.csv("C:/specialeJR/Estimering/data_u250.csv")
Data_250_450 = read.csv("C:/specialeJR/Estimering/data_250_450.csv")
Data_450_700 = read.csv("C:/specialeJR/Estimering/data_450_700.csv")
Data_700_1mio = read.csv("C:/specialeJR/Estimering/data_700_1mio.csv")
Data_o1mio = read.csv("C:/specialeJR/Estimering/data_o1mio.csv")
Data_gns = read.csv("C:/specialeJR/Estimering/data_gns.csv")

Data_u250 <- subset(Data_u250, select = -c(X))
Data_250_450 <- subset(Data_250_450, select = -c(X))
Data_450_700 <- subset(Data_450_700, select = -c(X))
Data_700_1mio <- subset(Data_700_1mio, select = -c(X))
Data_o1mio <- subset(Data_o1mio, select = -c(X))
Data_gns <- subset(Data_gns, select = -c(X))





max_nlags         = 3 ## Maksimalt antal autoregressive lags (tilf�jes kun hvis autokorrelation)
grid.lambda       = c(100,1000,100) ## Grid af st�j-signal forhold, 50 er laveste, 150 er h�jeste og 10 er step size
#grid.alpha_init   = c(-0.9,-0.1,0.5) # Grid af alpha, laveste, h�jeste og step size
grid.sigma_init   = c(0,1.5,0.2) ## Grid af sigma, laveste, h�jeste, step size
print_results     = T ## Skal resultater printes undervejs?
lambda_est_freely = T ## skal der startes med en initial fri estimatering af lambda?


#lambda fra 1 til 100.000
# m�ske skal vi pr�ve 10 som stepsize i lambda ??

# Make loop for estimating 
# OBS vi mangler lige at f� det sidste output ud, gamma, NIV test og en tredje, fordi listen er l�nger end 1.
output_u250_static <- data.frame(sigma=1, LV=1, est.lambda=1, BG_test=1, JB_test=1, BP_test=1, nlags=1)[0,]
for (nest in c(1,3,5,7)) {
  temp_data_u250 <- subset(Data_u250, select = c(nest, nest+1, nest+8, nest+9))
  max_nlags         = 3 ## Maksimalt antal autoregressive lags (tilf�jes kun hvis autokorrelation)
  grid.lambda       = c(100,1000,100) ## Grid af st�j-signal forhold, 50 er laveste, 150 er h�jeste og 10 er step size
  #grid.alpha_init   = c(-0.9,-0.1,0.5) # Grid af alpha, laveste, h�jeste og step size
  grid.sigma_init   = c(0,1.5,0.2) ## Grid af sigma, laveste, h�jeste, step size
  print_results     = T ## Skal resultater printes undervejs?
  lambda_est_freely = T ## skal der startes med en initial fri estimatering af lambda?
  
  Kalman = CESKalman_Static(data=temp_data_u250,max_nlags=max_nlags, grid.lambda=grid.lambda,
                            grid.sigma_init = grid.sigma_init,print_results=print_results,lambda_est_freely = lambda_est_freely)
  
  list <- list(sigma=Kalman[5], LV=Kalman[6], est.lambda=Kalman[7], BG_test=Kalman[9], JB_test=Kalman[10], BP_test=Kalman[11][[1]], nlags=Kalman[14])
  
  output_u250_static <- rbind(output_u250_static, list)
}

output_u250_static <- apply(output_u250_static,2,as.character)
#write.csv(output_u250_static,"C:/specialeJR/Estimering/sigma_output_static.csv", row.names = FALSE)
write.table(output_u250_static,"C:/specialeJR/Estimering/sigma_output_static.csv", row.names = FALSE, sep=",")



output_250_450_static <- data.frame(sigma=1, LV=1, est.lambda=1, BG_test=1, JB_test=1, BP_test=1, nlags=1)[0,]
for (nest in c(1,3,5,7)) {
  temp_data_250_450 <- subset(Data_250_450, select = c(nest, nest+1, nest+8, nest+9))
  max_nlags         = 2 ## Maksimalt antal autoregressive lags (tilf�jes kun hvis autokorrelation)
  grid.lambda       = c(100,1000,100) ## Grid af st�j-signal forhold, 50 er laveste, 150 er h�jeste og 10 er step size
  grid.alpha_init   = c(-0.9,-0.1,0.5) # Grid af alpha, laveste, h�jeste og step size
  grid.sigma_init   = c(0,1.5,0.5) ## Grid af sigma, laveste, h�jeste, step size
  print_results     = T ## Skal resultater printes undervejs?
  lambda_est_freely = T ## skal der startes med en initial fri estimatering af lambda?
  
  Kalman = CESKalman_Static(data=temp_data_250_450,max_nlags=max_nlags, grid.lambda=grid.lambda,
                     grid.sigma_init = grid.sigma_init,print_results=print_results,lambda_est_freely = lambda_est_freely)
  list <- list(sigma=Kalman[5], LV=Kalman[6], est.lambda=Kalman[7], BG_test=Kalman[9], JB_test=Kalman[10], BP_test=Kalman[11][[1]], nlags=Kalman[14])
  
  output_250_450_static <- rbind(output_250_450_static, list) 
}

output_250_450_static <- apply(output_250_450_static,2,as.character)
write.table(output_250_450_static,"C:/specialeJR/Estimering/sigma_output_static.csv", row.names = FALSE, col.names = FALSE, sep=",", append=TRUE)

output_450_700_static <- data.frame(sigma=1, LV=1, est.lambda=1, BG_test=1, JB_test=1, BP_test=1, nlags=1)[0,]
for (nest in c(1,3,5,7)) {
  temp_data_450_700 <- subset(Data_450_700, select = c(nest, nest+1, nest+8, nest+9))
  max_nlags         = 2 ## Maksimalt antal autoregressive lags (tilf�jes kun hvis autokorrelation)
  grid.lambda       = c(100,1000,100) ## Grid af st�j-signal forhold, 50 er laveste, 150 er h�jeste og 10 er step size
  grid.alpha_init   = c(-0.9,-0.1,0.5) # Grid af alpha, laveste, h�jeste og step size
  grid.sigma_init   = c(0,1.5,0.5) ## Grid af sigma, laveste, h�jeste, step size
  print_results     = T ## Skal resultater printes undervejs?
  lambda_est_freely = T ## skal der startes med en initial fri estimatering af lambda?
  
  Kalman = CESKalman_Static(data=temp_data_450_700,max_nlags=max_nlags, grid.lambda=grid.lambda,
                     grid.sigma_init = grid.sigma_init,print_results=print_results,lambda_est_freely = lambda_est_freely)
  list <- list(sigma=Kalman[5], LV=Kalman[6], est.lambda=Kalman[7], BG_test=Kalman[9], JB_test=Kalman[10], BP_test=Kalman[11][[1]], nlags=Kalman[14])
  output_450_700_static <- rbind(output_450_700_static, list) 
}
output_450_700_static <- apply(output_450_700_static,2,as.character)
write.table(output_450_700_static,"C:/specialeJR/Estimering/sigma_output_static.csv", row.names = FALSE, col.names = FALSE, sep=",", append=TRUE)


output_700_1mio_static <- data.frame(sigma=1, LV=1, est.lambda=1, BG_test=1, JB_test=1, BP_test=1, nlags=1)[0,]
for (nest in c(1,3,5,7)) {
  temp_data_700_1mio <- subset(Data_700_1mio, select = c(nest, nest+1, nest+8, nest+9))
  max_nlags         = 2 ## Maksimalt antal autoregressive lags (tilf�jes kun hvis autokorrelation)
  grid.lambda       = c(100,1000,100) ## Grid af st�j-signal forhold, 50 er laveste, 150 er h�jeste og 10 er step size
  grid.alpha_init   = c(-0.9,-0.1,0.5) # Grid af alpha, laveste, h�jeste og step size
  grid.sigma_init   = c(0,1.5,0.5) ## Grid af sigma, laveste, h�jeste, step size
  print_results     = T ## Skal resultater printes undervejs?
  lambda_est_freely = T ## skal der startes med en initial fri estimatering af lambda?
  
  Kalman = CESKalman_Static(data=temp_data_700_1mio,max_nlags=max_nlags, grid.lambda=grid.lambda,
                     grid.sigma_init = grid.sigma_init,print_results=print_results,lambda_est_freely = lambda_est_freely)
  list <- list(sigma=Kalman[5], LV=Kalman[6], est.lambda=Kalman[7], BG_test=Kalman[9], JB_test=Kalman[10], BP_test=Kalman[11][[1]], nlags=Kalman[14])
  output_700_1mio_static <- rbind(output_700_1mio_static, list) 
}
output_700_1mio_static <- apply(output_700_1mio_static,2,as.character)
write.table(output_700_1mio_static,"C:/specialeJR/Estimering/sigma_output_static.csv", row.names = FALSE, col.names = FALSE, sep=",", append=TRUE)

###
output_o1mio_static <- data.frame(sigma=1, alpha=1, LV=1, est.lambda=1, BG_test=1, JB_test=1, BP_test=1, nlags=1)[0,]
for (nest in c(1,3,5,7)) {
  temp_data_o1mio <- subset(Data_o1mio, select = c(nest, nest+1, nest+8, nest+9))
  max_nlags         = 2 ## Maksimalt antal autoregressive lags (tilf�jes kun hvis autokorrelation)
  grid.lambda       = c(100,1000,100) ## Grid af st�j-signal forhold, 50 er laveste, 150 er h�jeste og 10 er step size
  grid.alpha_init   = c(-0.9,-0.1,0.5) # Grid af alpha, laveste, h�jeste og step size
  grid.sigma_init   = c(0,1.5,0.5) ## Grid af sigma, laveste, h�jeste, step size
  print_results     = T ## Skal resultater printes undervejs?
  lambda_est_freely = T ## skal der startes med en initial fri estimatering af lambda?
  
  Kalman = CESKalman_Static(data=temp_data_o1mio,max_nlags=max_nlags, grid.lambda=grid.lambda,
                     grid.sigma_init = grid.sigma_init,print_results=print_results,lambda_est_freely = lambda_est_freely)
  list <- list(sigma=Kalman[5], LV=Kalman[6], est.lambda=Kalman[7], BG_test=Kalman[9], JB_test=Kalman[10], BP_test=Kalman[11][[1]], nlags=Kalman[14])
  output_o1mio_static <- rbind(output_o1mio_static, list) 
}
output_o1mio_static <- apply(output_o1mio_static,2,as.character)
write.table(output_o1mio_static,"C:/specialeJR/Estimering/sigma_output_static.csv", row.names = FALSE, col.names = FALSE, sep=",", append=TRUE)


output_gns_static <- data.frame(sigma=1,  LV=1, est.lambda=1, BG_test=1, JB_test=1, BP_test=1, nlags=1)[0,]
for (nest in c(1,3,5,7)) {
  temp_data_gns <- subset(Data_gns, select = c(nest, nest+1, nest+8, nest+9))
  max_nlags         = 2 ## Maksimalt antal autoregressive lags (tilf�jes kun hvis autokorrelation)
  grid.lambda       = c(100,1000,100) ## Grid af st�j-signal forhold, 50 er laveste, 150 er h�jeste og 10 er step size
  grid.alpha_init   = c(-0.9,-0.1,0.5) # Grid af alpha, laveste, h�jeste og step size
  grid.sigma_init   = c(0,1.5,0.5) ## Grid af sigma, laveste, h�jeste, step size
  print_results     = T ## Skal resultater printes undervejs?
  lambda_est_freely = T ## skal der startes med en initial fri estimatering af lambda?
  
  Kalman = CESKalman_Static(data=temp_data_gns,max_nlags=max_nlags, grid.lambda=grid.lambda,
                     grid.sigma_init = grid.sigma_init,print_results=print_results,lambda_est_freely = lambda_est_freely)
  list <- list(sigma=Kalman[5], LV=Kalman[6], est.lambda=Kalman[7], BG_test=Kalman[9], JB_test=Kalman[10], BP_test=Kalman[11][[1]], nlags=Kalman[14])
  output_gns_static <- rbind(output_gns_static, list)
}
output_gns_static <- apply(output_gns_static,2,as.character)
write.table(output_gns_static,"C:/specialeJR/Estimering/sigma_output_static.csv", row.names = FALSE, col.names = FALSE, sep=",", append=TRUE)
