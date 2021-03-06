# ==================================================================================
# ---- ESTIMATION OF ELASTICITIES AND SHARE PARAMETERS IN A PRODUCTION FUNCTION ----
# =================================================================================

## Skrevet af Christian S. Kastrup og Anders F. Kronborg
## MAKRO-gruppen
## Denne udgave er fra 19.01-2021

rm(list=ls())
cat("\014")
graphics.off()

# Installerer pakke
library(devtools)
devtools::install("P:/CST/Kalman/CESKalman") ## Installerer pakken
#devtools::document("P:/CST/Kalman/CESKalman")   ## Opdaterer dokumentationen (ikke n�dvendig at k�re)
#devtools::build_manual("P:/CST/Kalman/CESKalman") ## Opdaterer manual (ikke n�dvendig at k�re)
library(CESKalman)

# =================================================================================
# --------------- Simul�r noget data ----------------------------------------------
# =================================================================================

## Vi har to input i produktionsfunktionen i det givne nest. M�let er at estimere
## substitutionselasticitetten mellem de to inputs. Derfor estimeres de relative
## Budgetandele med CESKalman funktionen, der er hovedfunktionen i pakken (af samme navn).

## Her simuleres noget data. Der tages udgangspunkt i kapital, K, og arbejdskraft, L,

## Vi simulerer data til den langsigtede ligning konsistent med et s�t af stylized facts

## Ligningen er
## log(UC*K/(L*W)) = (sigma-1)*log(Gamma_K/Gamma_L) + (1-sigma)*log(UC/W) + epsilon

## Gamma_K og Gamma_L viser effektivitet af inputs i produktionsfunktionen og
## UC er user cost og W er l�nnen.


set.seed(1234)

## F�rst s�ttes et par parametre til simulering af data

sigma = 0.6 ## Typisk hvad man finder i literaturen

# Standardafvigelser
SigmaGammaK  = 0.05
SigmaGammaL  = 0.01
SigmaK       = 0.05
SigmaL       = 0.01
SigmaUC      = 0.01
SigmaW       = 0.01

#konstantled i logs
GammaKC = 0
GammaLC = 0
KC      = 0
LC      = 0

## Startv�rdier i logs, normalisering s� initial konvergens til konstant v�kstrate udg�s
GammaK0 = 0
GammaL0 = -0.02
K0      = -0.55
L0      =-0.02

# V�kstrater
trendGammaK = 0   # Konstant over tid
trendGammaL = 0.01  # v�kstrate p� ca 2% om �ret
trendK      = 0.002 # V�kstrate p� ca 3% om �ret
trendL      = 0.01  # v�kstrate p� ca 2% om �ret

## AR parametre, persistens af st�d
rhoGammaK = 0.95
rhoGammaL = 0.5
rhoK      = 0.95
rhoL      = 0.5

## Simulerer fejlled, epsilon

N = 100 ## Antal observationer

# Alle antaget log normalfordelte
epsilonGammaK = rnorm(n=N,mean=0, sd=SigmaGammaK)
epsilonGammaL = rnorm(n=N,mean=0, sd=SigmaGammaL)
epsilonK      = rnorm(n=N,mean=0,sd=SigmaK)
epsilonL      = rnorm(n=N,mean=0,sd=SigmaL)
epsilonUC     = rnorm(n=N,mean=0,sd=SigmaUC)
epsilonW      = rnorm(n=N,mean=0,sd=SigmaW)

## Genererer tidsserier

GammaK = matrix(NA,nrow=N,ncol=1)
GammaL = matrix(NA,nrow=N,ncol=1)
K      = matrix(NA,nrow=N,ncol=1)
L      = matrix(NA,nrow=N,ncol=1)

## F�rste observation. GammaK=GammaL=UC=W=1 (alts� 0 i logs, hvormed lag udg�r i t0)
GammaK[1] = exp(GammaK0 + trendGammaK + epsilonGammaK[1])
GammaL[1] = exp(GammaL0 + trendGammaL + epsilonGammaL[1])
K[1]      = exp(K0 + trendK + epsilonK[1])
L[1]      = exp(L0 + trendL + epsilonL[1])

for(t in 2:N){ ## Alle er AR processer med line�r trend i logs
  GammaK[t] = exp(GammaKC+t*trendGammaK+rhoGammaK*log(GammaK[t-1])+epsilonGammaK[t])
  GammaL[t] = exp(GammaLC+t*trendGammaL+rhoGammaL*log(GammaL[t-1])+epsilonGammaL[t])
  K[t]      = exp(KC+t*trendK+rhoK*log(K[t-1])+epsilonK[t])
  L[t]      = exp(LC + t*trendL+rhoL*log(L[t-1])+epsilonL[t])

}

## L�nninger og User cost bestemmes ud fra f�rsteordensbetingelser

dY = (sigma/(sigma-1))*((K*GammaK)^((sigma-1)/sigma)+(L*GammaL)^((sigma-1)/sigma))^(sigma/(sigma-1)-1)

# diff in output wrt. K and L
UC = (((sigma-1)/sigma)*(GammaK*K)^((sigma-1)/sigma)/K)*dY*exp(epsilonUC) ## Teoretisk udledning + log normalfordelt st�d
W = (((sigma-1)/sigma)*(GammaL*L)^((sigma-1)/sigma)/L)*dY*exp(epsilonW) ## Teoretisk udledning + log normalfordelt st�d


## Vi kan nu plotte data
# 
par(mfrow=c(3,2))

plot(log(K), type="l",main="Kapital, K")
plot(log(L), type="l", main="Arbejdskraft, L")
plot(log(GammaK), type="l", main="GammaK")
plot(log(GammaL),type="l",main="GammaL")
plot(log(UC), type="l", main="User cost")
plot(log(W), type="l", main="L�nninger, W")
# 
# 
# ## I v�kstrater
# plot(diff(log(K)), type="l",main="Kapital, K")
# abline(h=0)
# 
# plot(diff(log(L)), type="l", main="Arbejdskraft, L")
# abline(h=0)
# 
# plot(diff(log(GammaK)), type="l", main="GammaK")
# abline(h=0)
# 
# plot(diff(log(GammaL)),type="l",main="GammaL")
# abline(h=0)
# 
# plot(diff(log(UC)), type="l", main="User cost")
# abline(h=0)
# 
# plot(diff(log(W)), type="l", main="L�nninger, W")
# abline(h=0)
# 
# ## Et par ratioer
# 
plot((log(K/L)),type="l",main="K/L forhold")
plot(diff(log(K/L)),type="l",main="V�kst i K/L forhold")
abline(h=0)

plot((log(GammaK/GammaL)),type="l",main="relativ teknologi")
plot(diff(log(GammaK/GammaL)),type="l",main="V�kst i relativ teknologi")
abline(h=0)

plot(log(UC/W),type="l",main="relative priser, UC/L")
plot(diff(log(UC/W)),type="l",main="v�kst i relative priser, UC/L")
abline(h=0)

## Data bekr�fter et s�t af "stylized facts"
# 1. Solow-neutral teknologi (GammaK) stort set konstant over tid
# 2. Harrod-neutral teknologiske fremskridt p� lang sigt (v�kst i teknologi sker i L)
# 3. Konstant pris p� kapital p� lang sigt
# 4. stigende l�n, der (stort set) f�lger v�ksten i teknologi p� L
# 5. Stigende K/L forhold
# 6. Relative priser er faldende
# 7. "Medium run" fluktuationer i teknologi


## Vi kan tjekke om data er genereret korrekt ved at unders�ge om sigma=0.6 i OLS regression
OLS = lm(log(K/L)-(sigma-1)*log(GammaK/GammaL)~log(UC/W))
OLS$coef[2]   ## Giver sub elasticitet p� 0.6. Alt dermed OK

## Hvad nu hvis vi antager at teknologi ikke er kendt??

# Antag Hicks-neutral teknologi
OLS = lm(log(K/L)~log(UC/W))
OLS$coef[2]   ## Giver sub elasticitet p� 0.9. Tyder p� bias mod Cobb Douglas!

## Hvordan ville en line�r trend klare sig?
trend = 1:N

OLS=lm(log(K/L)~trend+log(UC/W))

OLS$coef[3] ## Skulle gerne give en elasticitet p� 0.36, alts� nedad biased.


# =================================================================================
# --------------- Kalman smoothing  -----------------------------------------------
# =================================================================================

## Vi er nu klar til at estimere produktionsfunktionen.
## Hovedfunktionen i CESKalman pakken er CESKalman.
## Der loopes over antal lags, forskellige st�j-signal forhold, forskellige initiale
## paremetre.

## Funktionen tager som input:
data              = cbind(UC,W,K,L) ## skal st� i denne orden. 
max_nlags         = 2 ## Maksimalt antal autoregressive lags (tilf�jes kun hvis autokorrelation)
grid.lambda       = c(100,500,100) ## Grid af st�j-signal forhold, 50 er laveste, 150 er h�jeste og 10 er step size
grid.alpha_init   = c(-0.9,-0.1,0.5) # Grid af alpha, laveste, h�jeste og step size
grid.sigma_init   = c(0,1.5,0.5) ## Grid af sigma, laveste, h�jeste, step size
print_results     = T ## Skal resultater printes undervejs?
lambda_est_freely = T ## skal der startes med en initial fri estimatering af lambda?

## den optimale l�sning er den der maksimerer likelihood, givet ingen autokorrelation og overholdelse af NIS test

# ## V�r obs p� at den godt kan tage noget tid at k�re.
# lambda_est_freely=F
# grid.lambda = c(10000,10000,10)

Kalman = CESKalman(data=data,max_nlags=max_nlags, grid.lambda=grid.lambda,grid.alpha_init = grid.alpha_init,
                   grid.sigma_init = grid.sigma_init,print_results=print_results,lambda_est_freely = lambda_est_freely)


## Vi kan nu printe output og plotte relativ til faktisk teknologi
cat(paste("Long run elasticity, sigma: ",round(Kalman$sigma,2),"    Inverse st�j-signal forhold, lambda=",round(Kalman$est.lambda,2)),sep="")
# cat("\n")
par(mfrow=c(1,1))
plot(c(Kalman$Gamma,NA),main="Relative (log) teknologier, log(GammaK/GammaL)",ylab="",xlab="",type="l",lwd=2,
     ylim=c(min(Kalman$Gamma,log(GammaK/GammaL)),max(Kalman$Gamma,log(GammaK/GammaL))))
lines(log(GammaK/GammaL)[-1],lty=2,lwd=2)

## NB: Hvis K/L forholdet tiln�rmer sig en line�r trend, s� kan filteret have problemer med at identificere
## en elasticitet, da en line�r trend i relativ teknologi vil forklare K/L forholdet bedst. Derfor kr�ves
## en vis grad af volatilitet i K/L f�r man f�r meningfulde estimater.

## I indev�rende tilf�lde form�r filteret at reproducere elasticiteten. Skulle gerne give sigma=0.56 og lambda=100.39,
## hvis alt er g�et korrekt til. Det er dog ikke alle tilf�lde hvor ML estimatet er foretrukket. Derfor b�r grid
## proceduren ogs� bruges. Filteret form�r ogs� til temmelig stor pr�cision at genskabe data. Mindre niveau-forskelle
## skyldes afvigelser i elasiciteten fra den sande.

# =================================================================================
# --------------- Plot function ---------------------------------------------------
# =================================================================================
plot(Kalman)



## Rigtig data

US = Load_Data("USA")

data = cbind(US$q,US$w,US$K,US$L)

Kalman_US = CESKalman(data=data,max_nlags=max_nlags, grid.lambda=grid.lambda,grid.alpha_init = grid.alpha_init,
                   grid.sigma_init = grid.sigma_init,print_results=print_results,lambda_est_freely = F)

plot(Kalman_US$Gamma,type="l")


# =================================================================================
# --------------- Bootstrapping konfidensinterval ---------------------------------
# =================================================================================

## Denne funktion kan anvendes til at bootstrappe konfidensintervaller. Det skal dog understreges
## at bootstrapping er en fixed design residual based og burde nok v�re en rekursiv (grundet lag struktur)
## Dermed kan der v�re fejl i konfidensb�ndene og det virker generelt til at de er opad biased. Det g�lder
## s�rligt for alpha, hvilket sandsynligvis skyldes den manglende rekursive design.
## S� I b�r skrive jeres egen kode til dette men er velkommen til at tage udgangspunkt i CESKalman_Bootstrap
# 
#  Bootstrap = CESKalman_Bootstrap(Estimation=Kalman,data=data,ndraw=100,print_results = TRUE)



# =================================================================================
# --------------- Forbrug ---------------------------------------------------------
# =================================================================================

data              = cbind(UC,W,K,L) ## skal st� i denne orden. 

Kalman_Static=CESKalman_Static(data,grid.param_init=c(-10,-1,3),max_nlags=3,grid.lambda=c(50,500,100),
                               grid.sigma_init=c(0,1.5,0.5),lambda_est_freely=F)

Kalman_Static$sigma

plot(c(Kalman_Static$Gamma,NA),main="Relative (log) teknologier, log(GammaK/GammaL)",ylab="",xlab="",type="l",lwd=2,
     ylim=c(min(Kalman_Static$Gamma,log(GammaK/GammaL)),max(Kalman$Gamma,log(GammaK/GammaL))))
lines(log(GammaK/GammaL)[-1],lty=2,lwd=2)



