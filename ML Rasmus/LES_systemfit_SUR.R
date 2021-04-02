library(systemfit)

#no scientific numbers
options(scipen=999)

#Step1: Load Data set
df<-read.csv("simpeldata4grup.csv",sep=';')
attach(df)
names(df)
dim(df)
View(df)

#make prices and shares
df     <- transform( df,
       p1 = FØDEVARER.OG.IKKE.ALKOHOLISKE.DRIKKEVARER/Faste.FØDEVARER,
       p2 = ALKOHOLISKE.DRIKKEVARER.OG.TOBAK/Faste.ALKOHOL,
       p3 = BEKLÆDNING.OG.FODTØJ/Faste.BEKLÆDNING,
       p4 = BOLIGBENYTTELSE..ELEKTRICITET.OG.OPVARMNING/Faste.BOLIG.EL.OG.OPVARMNING
) 
df     <- transform( df,
       w1 = FØDEVARER.OG.IKKE.ALKOHOLISKE.DRIKKEVARER/Sumloeb,
       w2 = ALKOHOLISKE.DRIKKEVARER.OG.TOBAK/Sumloeb,
       w3 = BEKLÆDNING.OG.FODTØJ/Sumloeb,
       w4 = BOLIGBENYTTELSE..ELEKTRICITET.OG.OPVARMNING/Sumloeb
) 
df     <- transform( df,
       phat1=p1/Sumloeb,
       phat2=p2/Sumloeb,
       phat3=p3/Sumloeb,
       phat4=p4/Sumloeb
) 



#example
eqfood <- w1 ~ b1*phat1 + a1 * (1-(phat1*b1+phat2*b2+phat3*b3+phat4*b4))
eqalko <- w2 ~ b2*phat2 + a2 * (1-(phat1*b1+phat2*b2+phat3*b3+phat4*b4))
eqbekl <- w3 ~ b3*phat3 + a3 * (1-(phat1*b1+phat2*b2+phat3*b3+phat4*b4))
eqboli <- w4 ~ b4*phat4 + (1-a1-a2-a3) * (1-(phat1*b1+phat2*b2+phat3*b3+phat4*b4))

labels <- list( "food", "alko","kleidung","bolig el mm" )
start.values <- c(a1=0.23, a2=0.043, a3=0.072, a4=0.655,
                  b1=35000, b2=5000, b3=9000, b4=80000)
model <- list( eqfood, eqalko, eqbekl, eqboli)

model.sur <- nlsystemfit( "SUR", model, start.values, data=df, eqnlabels=labels )
print( model.sur )






