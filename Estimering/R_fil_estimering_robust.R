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


# Sætter værdier for input til Kalman
max_nlags         = 2 ## Maksimalt antal autoregressive lags (tilføjes kun hvis autokorrelation)
#grid.lambda       = c(100,1000,100) ## Grid af støj-signal forhold, 50 er laveste, 150 er højeste og 10 er step size
grid.alpha_init   = c(-0.9,-0.1,0.5) # Grid af alpha, laveste, højeste og step size
grid.sigma_init   = c(0,1.5,0.5) ## Grid af sigma, laveste, højeste, step size
print_results     = T ## Skal resultater printes undervejs?
lambda_est_freely = F ## skal der startes med en initial fri estimatering af lambda?


#lambda fra 1 til 100.000
# måske skal vi prøve 10 som stepsize i lambda ??

# Make loop for estimating 
# OBS vi mangler lige at få det sidste output ud, gamma, NIV test og en tredje, fordi listen er længer end 1.
output_u250_static <- data.frame(Sigma=1, LV=1, nlags=1, NIS1=1, NIS2=1, NIS3=1, BG=1, lambda=1)[1,]
for (nest in c(1,3,5,7)) {
  for (lambda in c(1,10,50,100,500,1000,10000,100000)) {
    temp_data_u250 <- subset(Data_u250, select = c(nest, nest+1, nest+8, nest+9))
    grid.lambda       = c(lambda,lambda,1) ## Grid af støj-signal forhold, 50 er laveste, 150 er højeste og 10 er step size

    Kalman = CESKalman_Static(data=temp_data_u250,max_nlags=max_nlags, grid.lambda=grid.lambda,
                              grid.sigma_init = grid.sigma_init,print_results=print_results,lambda_est_freely = lambda_est_freely)
    
    Sigma <- as.list(Kalman[5])
    LV <- as.list(Kalman[6])
    nlags <- as.list(Kalman[14])
    NIS1 <- as.list(as.list(Kalman[12][[1]])[[1]])
    NIS2 <- as.list(as.list(Kalman[12][[1]])[[2]])
    NIS3 <- as.list(as.list(Kalman[12][[1]])[[3]])
    BG <- as.list(Kalman[9])
    lambda <- as.list(Kalman[7])
    list1 <- list(Sigma, LV, nlags, NIS1, NIS2, NIS3, BG, lambda)
    output_u250_static <- rbind(output_u250_static, list1)}
  
}

output_250_450_static <- data.frame(Sigma=1, LV=1, nlags=1, NIS1=1, NIS2=1, NIS3=1, BG=1, lambda=1)[1,]
for (nest in c(1,3,5,7)) {
  for (lambda in c(1,10,50,100,500,1000,10000,100000)) {
    temp_data_250_450 <- subset(Data_250_450, select = c(nest, nest+1, nest+8, nest+9))
    grid.lambda       = c(lambda,lambda,1) ## Grid af støj-signal forhold, 50 er laveste, 150 er højeste og 10 er step size
    
    Kalman = CESKalman_Static(data=temp_data_250_450,max_nlags=max_nlags, grid.lambda=grid.lambda,
                              grid.sigma_init = grid.sigma_init,print_results=print_results,lambda_est_freely = lambda_est_freely)
    
    Sigma <- as.list(Kalman[5])
    LV <- as.list(Kalman[6])
    nlags <- as.list(Kalman[14])
    NIS1 <- as.list(as.list(Kalman[12][[1]])[[1]])
    NIS2 <- as.list(as.list(Kalman[12][[1]])[[2]])
    NIS3 <- as.list(as.list(Kalman[12][[1]])[[3]])
    BG <- as.list(Kalman[9])
    lambda <- as.list(Kalman[7])
    list1 <- list(Sigma, LV, nlags, NIS1, NIS2, NIS3, BG, lambda)
    output_250_450_static <- rbind(output_250_450_static, list1)}
  
}

output_450_700_static <- data.frame(Sigma=1, LV=1, nlags=1, NIS1=1, NIS2=1, NIS3=1, BG=1, lambda=1)[1,]
for (nest in c(1,3,5,7)) {
  for (lambda in c(1,10,50,100,500,1000,10000,100000)) {
    temp_data_450_700 <- subset(Data_450_700, select = c(nest, nest+1, nest+8, nest+9))
    grid.lambda       = c(lambda,lambda,1) ## Grid af støj-signal forhold, 50 er laveste, 150 er højeste og 10 er step size
    
    Kalman = CESKalman_Static(data=temp_data_450_700,max_nlags=max_nlags, grid.lambda=grid.lambda,
                              grid.sigma_init = grid.sigma_init,print_results=print_results,lambda_est_freely = lambda_est_freely)
    
    Sigma <- as.list(Kalman[5])
    LV <- as.list(Kalman[6])
    nlags <- as.list(Kalman[14])
    NIS1 <- as.list(as.list(Kalman[12][[1]])[[1]])
    NIS2 <- as.list(as.list(Kalman[12][[1]])[[2]])
    NIS3 <- as.list(as.list(Kalman[12][[1]])[[3]])
    BG <- as.list(Kalman[9])
    lambda <- as.list(Kalman[7])
    list1 <- list(Sigma, LV, nlags, NIS1, NIS2, NIS3, BG, lambda)
    output_450_700_static <- rbind(output_450_700_static, list1)}
  
}

output_700_1mio_static <- data.frame(Sigma=1, LV=1, nlags=1, NIS1=1, NIS2=1, NIS3=1, BG=1, lambda=1)[1,]
for (nest in c(1,3,5,7)) {
  for (lambda in c(1,10,50,100,500,1000,10000,100000)) {
    temp_data_700_1mio <- subset(Data_700_1mio, select = c(nest, nest+1, nest+8, nest+9))
    grid.lambda       = c(lambda,lambda,1) ## Grid af støj-signal forhold, 50 er laveste, 150 er højeste og 10 er step size
    
    Kalman = CESKalman_Static(data=temp_data_700_1mio,max_nlags=max_nlags, grid.lambda=grid.lambda,
                              grid.sigma_init = grid.sigma_init,print_results=print_results,lambda_est_freely = lambda_est_freely)
    
    Sigma <- as.list(Kalman[5])
    LV <- as.list(Kalman[6])
    nlags <- as.list(Kalman[14])
    NIS1 <- as.list(as.list(Kalman[12][[1]])[[1]])
    NIS2 <- as.list(as.list(Kalman[12][[1]])[[2]])
    NIS3 <- as.list(as.list(Kalman[12][[1]])[[3]])
    BG <- as.list(Kalman[9])
    lambda <- as.list(Kalman[7])
    list1 <- list(Sigma, LV, nlags, NIS1, NIS2, NIS3, BG, lambda)
    output_700_1mio_static <- rbind(output_700_1mio_static, list1)}
  
}


output_o1mio_static <- data.frame(Sigma=1, LV=1, nlags=1, NIS1=1, NIS2=1, NIS3=1, BG=1, lambda=1)[1,]
for (nest in c(1,3,5,7)) {
  for (lambda in c(1,10,50,100,500,1000,10000,100000)) {
    temp_data_o1mio <- subset(Data_o1mio, select = c(nest, nest+1, nest+8, nest+9))
    grid.lambda       = c(lambda,lambda,1) ## Grid af støj-signal forhold, 50 er laveste, 150 er højeste og 10 er step size
    
    Kalman = CESKalman_Static(data=temp_data_o1mio,max_nlags=max_nlags, grid.lambda=grid.lambda,
                              grid.sigma_init = grid.sigma_init,print_results=print_results,lambda_est_freely = lambda_est_freely)
    
    Sigma <- as.list(Kalman[5])
    LV <- as.list(Kalman[6])
    nlags <- as.list(Kalman[14])
    NIS1 <- as.list(as.list(Kalman[12][[1]])[[1]])
    NIS2 <- as.list(as.list(Kalman[12][[1]])[[2]])
    NIS3 <- as.list(as.list(Kalman[12][[1]])[[3]])
    BG <- as.list(Kalman[9])
    lambda <- as.list(Kalman[7])
    list1 <- list(Sigma, LV, nlags, NIS1, NIS2, NIS3, BG, lambda)
    output_o1mio_static <- rbind(output_o1mio_static, list1)}
  
}

output_gns_static <- data.frame(Sigma=1, LV=1, nlags=1, NIS1=1, NIS2=1, NIS3=1, BG=1, lambda=1)[1,]
for (nest in c(1,3,5,7)) {
  for (lambda in c(1,10,50,100,500,1000,10000,100000)) {
    temp_data_gns <- subset(Data_gns, select = c(nest, nest+1, nest+8, nest+9))
    grid.lambda       = c(lambda,lambda,1) ## Grid af støj-signal forhold, 50 er laveste, 150 er højeste og 10 er step size
    
    Kalman = CESKalman_Static(data=temp_data_gns,max_nlags=max_nlags, grid.lambda=grid.lambda,
                              grid.sigma_init = grid.sigma_init,print_results=print_results,lambda_est_freely = lambda_est_freely)
    
    Sigma <- as.list(Kalman[5])
    LV <- as.list(Kalman[6])
    nlags <- as.list(Kalman[14])
    NIS1 <- as.list(as.list(Kalman[12][[1]])[[1]])
    NIS2 <- as.list(as.list(Kalman[12][[1]])[[2]])
    NIS3 <- as.list(as.list(Kalman[12][[1]])[[3]])
    BG <- as.list(Kalman[9])
    lambda <- as.list(Kalman[7])
    list1 <- list(Sigma, LV, nlags, NIS1, NIS2, NIS3, BG, lambda)
    output_gns_static <- rbind(output_gns_static, list1)}
  
}

#evt lav dette til et loop over alle output - virker ikke lige 
#for (data in list(output_u250_static, output_250_450_static, output_450_700_static, output_700_1mio_static, output_o1mio_static, output_gns_static
#                  )) {data <- apply(data,2,as.character)}
output_u250_static <- apply(output_u250_static,2,as.character)
output_250_450_static <- apply(output_250_450_static,2,as.character)
output_450_700_static <- apply(output_450_700_static,2,as.character)
output_700_1mio_static <- apply(output_700_1mio_static,2,as.character)
output_o1mio_static <- apply(output_o1mio_static,2,as.character)
output_gns_static <- apply(output_gns_static,2,as.character)
#write.csv(output_u250_static,"C:/specialeJR/Estimering/sigma_lambda_robust.csv", row.names = FALSE)
write.table(output_u250_static,"C:/specialeJR/Estimering/sigma_lambda_robust.csv", row.names = FALSE, sep=",")
write.table(output_250_450_static,"C:/specialeJR/Estimering/sigma_lambda_robust.csv", row.names = FALSE, col.names = TRUE, sep=",", append=TRUE)
write.table(output_450_700_static,"C:/specialeJR/Estimering/sigma_lambda_robust.csv", row.names = FALSE, col.names = TRUE, sep=",", append=TRUE)
write.table(output_700_1mio_static,"C:/specialeJR/Estimering/sigma_lambda_robust.csv", row.names = FALSE, col.names = TRUE, sep=",", append=TRUE)
write.table(output_o1mio_static,"C:/specialeJR/Estimering/sigma_lambda_robust.csv", row.names = FALSE, col.names = TRUE, sep=",", append=TRUE)
write.table(output_gns_static,"C:/specialeJR/Estimering/sigma_lambda_robust.csv", row.names = FALSE, col.names = TRUE, sep=",", append=TRUE)

