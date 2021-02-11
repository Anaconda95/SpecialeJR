# ==================================================================================
# ---- ESTIMATION OF ELASTICITIES AND SHARE PARAMETERS IN A PRODUCTION FUNCTION ----
# =================================================================================

## Skrevet af Christian S. Kastrup og Anders F. Kronborg
## MAKRO-gruppen
## Denne udgave er fra 23.04-2020

rm(list=ls())
cat("\014")
graphics.off()

# =================================================================================
# --------------- INSTALLING PACKAGE ----------------------------------------------
# =================================================================================
library(devtools)
devtools::install("P:/CST/Kalman/CESKalman") ## Installerer pakken
#devtools::document("P:/CST/Kalman/CESKalman")   ## Opdaterer dokumentationen (ikke nødvendig at køre)
#devtools::build_manual("P:/CST/Kalman/CESKalman") ## Opdaterer manual (ikke nødvendig at køre)
library(CESKalman)

# =================================================================================
# --------------- Simulér noget data ----------------------------------------------
# =================================================================================

## Vi har to input i produktionsfunktionen i det givne nest. Målet er at estimere
## substitutionselasticitetten mellem de to inputs. Derfor estimeres de relative
## Budgetandele med CESKalman funktionen, der er hovedfunktionen i pakken (af samme navn).

## Her simuleres noget data. Der tages udgangspunkt i kapital, K, og arbejdskraft, L,

## Vi simulerer data til den langsigtede ligning konsistent med et sæt af stylized facts

## Lignignen er
## log(UC*K/(L*W)) = (sigma-1)*log(Gamma_K/Gamma_L) + (1-sigma)*log(UC/W) + epsilon

## Gamma_K og Gamma_L viser effektivitet af inputs i produktionsfunktionen og
## UC er user cost og W er lønnen.


set.seed(1234)

## Først sættes et par parametre til simulering af data

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

## Startværdier i logs, normalisering så initial konvergens til konstant vækstrate udgås
GammaK0 = 0
GammaL0 = -0.02
K0      = -0.55
L0      =-0.02

# Vækstrater
trendGammaK = 0   # Konstant over tid
trendGammaL = 0.01  # vækstrate på ca 2% om året
trendK      = 0.002 # Vækstrate på ca 3% om året
trendL      = 0.01  # vækstrate på ca 2% om året

## AR parametre, persistens af stød
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

## Første observation. GammaK=GammaL=UC=W=1 (altså 0 i logs, hvormed lag udgår i t0)
GammaK[1] = exp(GammaK0 + trendGammaK + epsilonGammaK[1])
GammaL[1] = exp(GammaL0 + trendGammaL + epsilonGammaL[1])
K[1]      = exp(K0 + trendK + epsilonK[1])
L[1]      = exp(L0 + trendL + epsilonL[1])

for(t in 2:N){ ## Alle er AR processer med lineær trend i logs
  GammaK[t] = exp(GammaKC+t*trendGammaK+rhoGammaK*log(GammaK[t-1])+epsilonGammaK[t])
  GammaL[t] = exp(GammaLC+t*trendGammaL+rhoGammaL*log(GammaL[t-1])+epsilonGammaL[t])
  K[t]      = exp(KC+t*trendK+rhoK*log(K[t-1])+epsilonK[t])
  L[t]      = exp(LC + t*trendL+rhoL*log(L[t-1])+epsilonL[t])

}

## Lønninger og User cost bestemmes ud fra førsteordensbetingelser

dY = (sigma/(sigma-1))*((K*GammaK)^((sigma-1)/sigma)+(L*GammaL)^((sigma-1)/sigma))^(sigma/(sigma-1)-1)

# diff in output wrt. K and L
UC = (((sigma-1)/sigma)*(GammaK*K)^((sigma-1)/sigma)/K)*dY*exp(epsilonUC) ## Teoretisk udledning + log normalfordelt stød
W = (((sigma-1)/sigma)*(GammaL*L)^((sigma-1)/sigma)/L)*dY*exp(epsilonW) ## Teoretisk udledning + log normalfordelt stød


## Vi kan nu plotte data

par(mfrow=c(3,2))

plot(log(K), type="l",main="Kapital, K")
plot(log(L), type="l", main="Arbejdskraft, L")
plot(log(GammaK), type="l", main="GammaK")
plot(log(GammaL),type="l",main="GammaL")
plot(log(UC), type="l", main="User cost")
plot(log(W), type="l", main="Lønninger, W")


## I vækstrater
plot(diff(log(K)), type="l",main="Kapital, K")
abline(h=0)

plot(diff(log(L)), type="l", main="Arbejdskraft, L")
abline(h=0)

plot(diff(log(GammaK)), type="l", main="GammaK")
abline(h=0)

plot(diff(log(GammaL)),type="l",main="GammaL")
abline(h=0)

plot(diff(log(UC)), type="l", main="User cost")
abline(h=0)

plot(diff(log(W)), type="l", main="Lønninger, W")
abline(h=0)

## Et par ratioer

plot((log(K/L)),type="l",main="K/L forhold")
plot(diff(log(K/L)),type="l",main="Vækst i K/L forhold")
abline(h=0)

plot((log(GammaK/GammaL)),type="l",main="relativ teknologi")
plot(diff(log(GammaK/GammaL)),type="l",main="Vækst i relativ teknologi")
abline(h=0)

plot(log(UC/W),type="l",main="relative priser, UC/L")
plot(diff(log(UC/W)),type="l",main="vækst i relative priser, UC/L")
abline(h=0)

## Data bekræfter et sæt af "stylized facts"
# 1. Solow-neutral teknologi (GammaK) stort set konstant over tid
# 2. Harrod-neutral teknologiske fremskridt på lang sigt (vækst i teknologi sker i L)
# 3. Konstant pris på kapital på lang sigt
# 4. stigende løn, der (stort set) følger væksten i teknologi på L
# 5. Stigende K/L forhold
# 6. Relative priser er faldende
# 7. "Medium run" fluktuationer i teknologi


## Vi kan tjekke om data er genereret korrekt ved at undersøge om sigma=0.6 i OLS regression
OLS = lm(log(K/L)-(sigma-1)*log(GammaK/GammaL)~log(UC/W))
OLS$coef[2]   ## Giver sub elasticitet på 0.6. Alt dermed OK

# =================================================================================
# --------------- Kalman smoothing  -----------------------------------------------
# =================================================================================

## Vi er nu klar til at estimere produktionsfunktionen.
## Hovedfunktionen i CESKalman pakken er CESKalman.
## Der loopes over antal lags, forskellige støj-signal forhold, forskellige initiale
## paremetre.

# Der er skrevet en kort dokumentation, findes ved ?CESKalman eller i vedlagte manual.
# Men den er ikke helt up to date, så I kan være nødt til selv at se funktionen efter.
# Disclamer: Der kan sagtens være fejl og kodningen er ikke særlig elegant!

## Funktionen tager som input:
data              = cbind(UC,W,K,L) ## skal stå i denne orden.
max_nlags         = 2 ## Maksimalt antal autoregressive lags (tilføjes kun hvis autokorrelation)
grid.lambda       = c(50,150,10) ## Grid af støj-signal forhold, 50 er laveste, 1000 er højeste og 10 er step size
grid.alpha_init   = c(-0.9,-0.1,0.2) # Grid af alpha, laveste, højeste og step size
grid.sigma_init   = c(0,1.5,0.2) ## Grid af epsilon, laveste, højeste, step size
print_results     = T ## Skal resultater printes undervejs?
ECM               = T   ## Skal en fejlkorrektionsmodel anvendes, eneste afprøvede pt, koden er dog så småt kodet til RW også, men ikke testet endnu.
ARIMA             =  c(0,2,0) ## Hvilken ARIMA skal anvendes for teknologi? I(2) er eneste mulige pt
lambda_est_freely = F ## skal der startes med en initial fri estimatering af lambda?

## den optimale løsning er den der maksimerer likelihood, givet ingen autokorrelation og overholdelse af NIS test

## Vær obs på at den godt kan tage noget tid at køre.

Kalman = CESKalman(data=data,max_nlags=max_nlags, grid.lambda=grid.lambda,grid.alpha_init = grid.alpha_init,
                   grid.sigma_init = grid.sigma_init,print_results=print_results,ECM=ECM,ARIMA=ARIMA,
                   lambda_est_freely = lambda_est_freely)


## Vi kan nu printe output og plotte relativ til faktisk teknologi
cat(paste("Long run elasticity, sigma: ",round(Kalman$sigma,2),"    Inverse støj-signal forhold, lambda=",round(Kalman$est.lambda,2)),sep="")
cat("\n")
par(mfrow=c(1,1))
plot(Kalman$Gamma,main="Relative (log) teknologier, log(GammaK/GammaL)",ylab="",xlab="",type="l",lwd=2)
lines(log(GammaK/GammaL),lty=2,lwd=2)

## NB: Hvis K/L forholdet tilnærmer sig en lineær trend, så kan filteret have problemer med at identificere
## en elasticitet, da en lineær trend i relativ teknologi vil forklare K/L forholdet bedst. Derfor kræves
## en vis grad af volatilitet i K/L før man får meningfulde estimater.

## I indeværende tilfælde formår filteret at reproducere elasticiteten. Skulle gerne give sigma=0.56 og lambda=100.39,
## hvis alt er gået korrekt til. Det er dog ikke alle tilfælde hvor ML estimatet er foretrukket. Derfor bør grid
## proceduren også bruges. Filteret formår også til temmelig stor præcision at genskabe data. Mindre niveau-forskelle
## skyldes afvigelser i elasiciteten fra den sande.

## Hvordan ville en lineær trend klare sig?
trend = 1:N

OLS=lm(log(K/L)~trend+log(UC/W))

OLS$coef[3] ## Skulle gerne give en elasticitet på 0.36, altså nedad biased.


# =================================================================================
# --------------- Bootstrapping konfidensinterval ---------------------------------
# =================================================================================

## Denne funktion kan anvendes til at bootstrappe konfidensintervaller. Det skal dog understreges
## at bootstrapping er en fixed design residual based og burde nok være en rekursiv (grundet lag struktur)
## Dermed kan der være fejl i konfidensbåndene og det virker generelt til at de er opad biased. Det gælder
## særligt for alpha, hvilket sandsynligvis skyldes den manglende rekursive design.
## Så I bør skrive jeres egen kode til dette men er velkommen til at tage udgangspunkt i CESKalman_Bootstrap

Bootstrap = CESKalman_Bootstrap(Estimation=Kalman,data=data,ndraw=500,print_results = TRUE)
