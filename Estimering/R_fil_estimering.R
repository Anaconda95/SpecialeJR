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


# måske skal vi prøve 10 som stepsize i lambda ??

# Make loop for estimating 
# OBS vi mangler lige at få det sidste output ud, gamma, NIV test og en tredje, fordi listen er længer end 1.
output_u250 <- data.frame(sigma=1, alpha=1, LV=1, est.lambda=1, BG_test=1, JB_test=1, BP_test=1, nlags=1)[0,]
for (nest in c(1,3,5,7)) {
  temp_data_u250 <- subset(Data_u250, select = c(nest, nest+1, nest+8, nest+9))
  max_nlags         = 2 ## Maksimalt antal autoregressive lags (tilføjes kun hvis autokorrelation)
  grid.lambda       = c(100,1000,100) ## Grid af støj-signal forhold, 50 er laveste, 150 er højeste og 10 er step size
  grid.alpha_init   = c(-0.9,-0.1,0.5) # Grid af alpha, laveste, højeste og step size
  grid.sigma_init   = c(0,1.5,0.5) ## Grid af sigma, laveste, højeste, step size
  print_results     = T ## Skal resultater printes undervejs?
  lambda_est_freely = T ## skal der startes med en initial fri estimatering af lambda?
  
  Kalman = CESKalman(data=temp_data_u250,max_nlags=max_nlags, grid.lambda=grid.lambda,grid.alpha_init = grid.alpha_init,
                     grid.sigma_init = grid.sigma_init,print_results=print_results,lambda_est_freely = lambda_est_freely)

  list <- list(sigma=Kalman[4], alpha=Kalman[5], LV=Kalman[6], est.lambda=Kalman[7], BG_test=Kalman[8], JB_test=Kalman[9], BP_test=Kalman[10][[1]], nlags=Kalman[15])
 
  output_u250 <- rbind(output_u250, list)
}

output_u250 <- apply(output_u250,2,as.character)
write.csv(output_u250,"C:/specialeJR/Estimering/sigma_output.csv", row.names = FALSE)
write.table(output_u250,"C:/specialeJR/Estimering/sigma_output.csv", row.names = FALSE, sep=",")

output_250_450 <- data.frame(sigma=1, alpha=1, LV=1, est.lambda=1, BG_test=1, JB_test=1, BP_test=1, nlags=1)[0,]

for (nest in c(1,3,5,7)) {
  temp_data_250_450 <- subset(Data_250_450, select = c(nest, nest+1, nest+8, nest+9))
  max_nlags         = 2 ## Maksimalt antal autoregressive lags (tilføjes kun hvis autokorrelation)
  grid.lambda       = c(100,1000,100) ## Grid af støj-signal forhold, 50 er laveste, 150 er højeste og 10 er step size
  grid.alpha_init   = c(-0.9,-0.1,0.5) # Grid af alpha, laveste, højeste og step size
  grid.sigma_init   = c(0,1.5,0.5) ## Grid af sigma, laveste, højeste, step size
  print_results     = T ## Skal resultater printes undervejs?
  lambda_est_freely = T ## skal der startes med en initial fri estimatering af lambda?
  
  Kalman = CESKalman(data=temp_data_250_450,max_nlags=max_nlags, grid.lambda=grid.lambda,grid.alpha_init = grid.alpha_init,
                     grid.sigma_init = grid.sigma_init,print_results=print_results,lambda_est_freely = lambda_est_freely)
  list <- list(sigma=Kalman[4], alpha=Kalman[5], LV=Kalman[6], est.lambda=Kalman[7], BG_test=Kalman[8], JB_test=Kalman[9], BP_test=Kalman[10][[1]], nlags=Kalman[15])
  
  output_250_450 <- rbind(output_250_450, list) 
}

output_250_450 <- apply(output_250_450,2,as.character)
write.table(output_250_450,"C:/specialeJR/Estimering/sigma_output.csv", row.names = FALSE, col.names = FALSE, sep=",", append=TRUE)

output_450_700 <- data.frame(sigma=1, alpha=1, LV=1, est.lambda=1, BG_test=1, JB_test=1, BP_test=1, nlags=1)[0,]
for (nest in c(1,3,5,7)) {
  temp_data_450_700 <- subset(Data_450_700, select = c(nest, nest+1, nest+8, nest+9))
  max_nlags         = 2 ## Maksimalt antal autoregressive lags (tilføjes kun hvis autokorrelation)
  grid.lambda       = c(100,1000,100) ## Grid af støj-signal forhold, 50 er laveste, 150 er højeste og 10 er step size
  grid.alpha_init   = c(-0.9,-0.1,0.5) # Grid af alpha, laveste, højeste og step size
  grid.sigma_init   = c(0,1.5,0.5) ## Grid af sigma, laveste, højeste, step size
  print_results     = T ## Skal resultater printes undervejs?
  lambda_est_freely = T ## skal der startes med en initial fri estimatering af lambda?
  
  Kalman = CESKalman(data=temp_data_450_700,max_nlags=max_nlags, grid.lambda=grid.lambda,grid.alpha_init = grid.alpha_init,
                     grid.sigma_init = grid.sigma_init,print_results=print_results,lambda_est_freely = lambda_est_freely)
  list <- list(sigma=Kalman[4], alpha=Kalman[5], LV=Kalman[6], est.lambda=Kalman[7], BG_test=Kalman[8], JB_test=Kalman[9], BP_test=Kalman[10][[1]], nlags=Kalman[15])
  output_450_700 <- rbind(output_450_700, list) 
}
output_450_700 <- apply(output_450_700,2,as.character)
write.table(output_450_700,"C:/specialeJR/Estimering/sigma_output.csv", row.names = FALSE, col.names = FALSE, sep=",", append=TRUE)


output_700_1mio <- data.frame(sigma=1, alpha=1, LV=1, est.lambda=1, BG_test=1, JB_test=1, BP_test=1, nlags=1)[0,]
for (nest in c(1,3,5,7)) {
  temp_data_700_1mio <- subset(Data_700_1mio, select = c(nest, nest+1, nest+8, nest+9))
  max_nlags         = 2 ## Maksimalt antal autoregressive lags (tilføjes kun hvis autokorrelation)
  grid.lambda       = c(100,1000,100) ## Grid af støj-signal forhold, 50 er laveste, 150 er højeste og 10 er step size
  grid.alpha_init   = c(-0.9,-0.1,0.5) # Grid af alpha, laveste, højeste og step size
  grid.sigma_init   = c(0,1.5,0.5) ## Grid af sigma, laveste, højeste, step size
  print_results     = T ## Skal resultater printes undervejs?
  lambda_est_freely = T ## skal der startes med en initial fri estimatering af lambda?
  
  Kalman = CESKalman(data=temp_data_700_1mio,max_nlags=max_nlags, grid.lambda=grid.lambda,grid.alpha_init = grid.alpha_init,
                     grid.sigma_init = grid.sigma_init,print_results=print_results,lambda_est_freely = lambda_est_freely)
  list <- list(sigma=Kalman[4], alpha=Kalman[5], LV=Kalman[6], est.lambda=Kalman[7], BG_test=Kalman[8], JB_test=Kalman[9], BP_test=Kalman[10][[1]], nlags=Kalman[15])
  output_700_1mio <- rbind(output_700_1mio, list) 
}
output_700_1mio <- apply(output_700_1mio,2,as.character)
write.table(output_700_1mio,"C:/specialeJR/Estimering/sigma_output.csv", row.names = FALSE, col.names = FALSE, sep=",", append=TRUE)


output_o1mio <- data.frame(sigma=1, alpha=1, LV=1, est.lambda=1, BG_test=1, JB_test=1, BP_test=1, nlags=1)[0,]
for (nest in c(1,3,5,7)) {
  temp_data_o1mio <- subset(Data_o1mio, select = c(nest, nest+1, nest+8, nest+9))
  max_nlags         = 2 ## Maksimalt antal autoregressive lags (tilføjes kun hvis autokorrelation)
  grid.lambda       = c(100,1000,100) ## Grid af støj-signal forhold, 50 er laveste, 150 er højeste og 10 er step size
  grid.alpha_init   = c(-0.9,-0.1,0.5) # Grid af alpha, laveste, højeste og step size
  grid.sigma_init   = c(0,1.5,0.5) ## Grid af sigma, laveste, højeste, step size
  print_results     = T ## Skal resultater printes undervejs?
  lambda_est_freely = T ## skal der startes med en initial fri estimatering af lambda?
  
  Kalman = CESKalman(data=temp_data_o1mio,max_nlags=max_nlags, grid.lambda=grid.lambda,grid.alpha_init = grid.alpha_init,
                     grid.sigma_init = grid.sigma_init,print_results=print_results,lambda_est_freely = lambda_est_freely)
  list <- list(sigma=Kalman[4], alpha=Kalman[5], LV=Kalman[6], est.lambda=Kalman[7], BG_test=Kalman[8], JB_test=Kalman[9], BP_test=Kalman[10][[1]], nlags=Kalman[15])
  output_o1mio <- rbind(output_o1mio, list) 
}
output_o1mio <- apply(output_o1mio,2,as.character)
write.table(output_o1mio,"C:/specialeJR/Estimering/sigma_output.csv", row.names = FALSE, col.names = FALSE, sep=",", append=TRUE)


output_gns <- data.frame(sigma=1, alpha=1, LV=1, est.lambda=1, BG_test=1, JB_test=1, BP_test=1, nlags=1)[0,]
for (nest in c(1,3,5,7)) {
  temp_data_gns <- subset(Data_gns, select = c(nest, nest+1, nest+8, nest+9))
  max_nlags         = 2 ## Maksimalt antal autoregressive lags (tilføjes kun hvis autokorrelation)
  grid.lambda       = c(100,1000,100) ## Grid af støj-signal forhold, 50 er laveste, 150 er højeste og 10 er step size
  grid.alpha_init   = c(-0.9,-0.1,0.5) # Grid af alpha, laveste, højeste og step size
  grid.sigma_init   = c(0,1.5,0.5) ## Grid af sigma, laveste, højeste, step size
  print_results     = T ## Skal resultater printes undervejs?
  lambda_est_freely = T ## skal der startes med en initial fri estimatering af lambda?
  
  Kalman = CESKalman(data=temp_data_gns,max_nlags=max_nlags, grid.lambda=grid.lambda,grid.alpha_init = grid.alpha_init,
                     grid.sigma_init = grid.sigma_init,print_results=print_results,lambda_est_freely = lambda_est_freely)
  list <- list(sigma=Kalman[4], alpha=Kalman[5], LV=Kalman[6], est.lambda=Kalman[7], BG_test=Kalman[8], JB_test=Kalman[9], BP_test=Kalman[10][[1]], nlags=Kalman[15])
  output_gns <- rbind(output_gns, list)
}
output_gns <- apply(output_gns,2,as.character)
write.table(output_gns,"C:/specialeJR/Estimering/sigma_output.csv", row.names = FALSE, col.names = FALSE, sep=",", append=TRUE)
