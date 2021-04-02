# Claas Heuer, February 2016
#
# Maximum Likelihood Estimation of parameters of bivariate normal distribution.
# We attempt to estimate the correlation between the two random vectors
# (as well as means and variances). A prior on the correlation coefficient 
# is put that forces that estimate between -1 and 1.
# We do something similar for the variance components to force
# those to be positive.
library(mvtnorm)

# likelihood on correlation coefficient.
# this is essentially a uniform prior on 
# the range -1 to 1 and 0 density outside 
# that range
corlik <- function(x) {
  
  res <- 0
  if(x >= -1 & x <= 1) res = 1 
  
  return(log(res))
}

# the likelihood for the variance components.
# uniform above 0 and zero if negative
varlik <- function(x) {
  
  res <- 0
  if(x > 0) res = 1
  
  return(log(res))
  
}

# the likelihood function = L(y;.) = y ~ MVN(mu, sigma) * rho ~ U(-1,1)
lik <- function(par, y) {
  
  # we construct the covariance matrix out of the correlation coefficient
  # and the variance components
  covAB <- par[5] * (sqrt(par[3]) * sqrt(par[4]))
  sigma <- array(c(par[3], covAB, covAB, par[4]), dim=c(2,2))
  
  # the likelihood of y
  L1 <- dmvnorm(x = Y, mean = c(par[1],par[2]), sigma = sigma, log=TRUE)
  
  # the prior = likelihood of rho (correlation coefficient)
  L2 <- corlik(par[5])
  
  # and the priors on the variance components
  L3 <- varlik(par[3])
  L4 <- varlik(par[4])
  
  # the joint likelihood
  return(-sum(L1 + L2 + L3 + L4))
  
}


# those are the optimizers available 
methods = c("Nelder-Mead", "BFGS", "CG", "L-BFGS-B", "SANN","Brent")

# the parameters we wish to estimate
p <- c(0,0,1,1,0.2)
names(p) <- c("mu1","mu2","tauA","tauB","rho")

# create random data
n = 10
tauA <- 3
tauB <- 10
rho = 0.7
covAB <- rho * (sqrt(tauA) * sqrt(tauB))
muA <- 5
muB <- 20

# the variance-covariance matrix
sigma <- array(c(tauA,covAB,covAB,tauB), dim=c(2,2))

# the random data
Y <- rmvnorm(n, c(muA,muB), sigma)

# Get the Maximum Likelihood estimates for our unknowns
ML <- optim(p, lik, y=y, method = methods[2])

res <- as.list(ML$par)
res$covAB <- res$rho * (sqrt(res$tauA) * sqrt(res$tauB))

# compare ML estimates with empiricals
out <- rbind(unlist(res), c(colMeans(Y), var(Y[,1]), var(Y[,2]), cor(Y)[1,2], cov(Y)[1,2]))
colnames(out) <- names(res)
rownames(out) <- c("ML","empirical")

# insepct results
out