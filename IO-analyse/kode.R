#### THIS AWESOME SCRIPT WILL CALCULATE CO2-intensities ####
#clear workspace
rm(list=ls())

### indlæser pakker ----
#library(mvtnorm)
#library("xlsx")
##install.packages("grid")
#library("grid")
##install.packages("ggplot")
##install.packages("tidyr")
#library("dplyr")
#library("tidyr")
#library("ggplot2")
##install.packages("gridExtra")
#library(gridExtra)
#library(grid)
#library(ggplot2)
##install.packages("ggpubr")
#library(ggpubr)
#library(lattice)
##install.packages("ggpubr")
#library(ggpubr)
##no scientific numbers
#options(scipen=999)
#options(digits=5)
#library(xtable)
#options(xtable.floating = FALSE)
#options(xtable.timestamp = "")

#her sker det----

setwd("~/Documents/GitHub/SpecialeJR /IO-analyse")
emissions <- read.xlsx("~/Documents/GitHub/SpecialeJR /IO-analyse/emissions.xlsx",1)
Adata <- read.xlsx("~/Documents/GitHub/SpecialeJR /IO-analyse/A input output 117x117.xlsx",1)
totalprod <- read.xlsx("~/Documents/GitHub/SpecialeJR /IO-analyse/totalprod.xlsx",1)
Cdata <- read.xlsx("~/Documents/GitHub/SpecialeJR /IO-analyse/C.xlsx",1)
CNRdata <- read.xlsx("~/Documents/GitHub/SpecialeJR /IO-analyse/C natregn.xlsx",1)

eunfcc <- data.matrix(emissions[4:120,3]) #2018-data
eunfcclulucf <- data.matrix(emissions[4:120,4]) #2018-data
#OBS: LULUCF-UDLEDNINGER var høje i 2018 pga. varm sommer
A <- data.matrix(Adata[1:117, 4:120])     #2016-data
prod <- data.matrix(totalprod[1:117, 2])  #2016-data
C <- data.matrix(Cdata[,2:75])            #2016-data
C_NR <- data.matrix(CNRdata[2:73,2])      #2016-data
I=diag(117)

#Co2intens = eunfcc/prod
Co2intens = eunfcclulucf/prod

#Calculating CO2 intensities on brancheniveau
IlessA = I-A
IAinv = solve(IlessA)

#co2udledninger er i 1000 ton - forbundet med hver forbrugsgruppe
CO2udl_indirect = t(Co2intens)%*%IAinv%*%C
sum(CO2udl_indirect)
CO2udl_indirect_transposed=t(CO2udl_indirect)

############ DIRECT EMISSIONS FROM HOUSEHOLDS ###################
#From calculations from ENE2HA - 2019 data. 
#Vigigt: el og fjernvarme skal ikke tælles med to gange.
#De beregnede udledninger er ca. 7.8 mio ton. Heraf næsten det hele
#benzin og diesel.
share_El	=         0
share_Gas=	       	0.176601057
share_flyd=		      0.079032868
share_fjernvarme= 	0
share_benzmv=       0.744366075

#dividing out the shares
emi_hh = emissions[2,2]

#el 26 gas 27 flyd 28 fjernvarm 29 brændstof 44
CO2udl_direct=CO2udl_indirect
CO2udl_direct[1,1:74]=0
CO2udl_direct[1,26]=share_El*emi_hh
CO2udl_direct[1,27]=share_Gas*emi_hh
CO2udl_direct[1,28]=share_flyd*emi_hh
CO2udl_direct[1,29]=share_fjernvarme*emi_hh
CO2udl_direct[1,44]=share_benzmv*emi_hh

CO2udl_tot= CO2udl_indirect + CO2udl_direct

#CO2-skat: mio. kr pr 1000 ton - 1000 kr svarer til 1.
tau=1

############ PRICES ################
p = 1+CO2udl_tot[,1:72]*tau/t(C_NR)
forbgrupper=colnames(CO2skat)
colnames(p)=forbgrupper[1:72]
p

### Fremskrivning
kf21fremskriv <- read.xlsx("~/Documents/GitHub/SpecialeJR /IO-analyse/kf21frem.xlsx",1)
kf21frem_mat <- data.matrix(kf21fremskriv)
kf21frem_indeks <- kf21frem_mat

for (i in 3:10) {
  kf21frem_indeks[,i]=kf21frem_indeks[,i]/kf21frem_mat[1,i]
}
kf21frem_indeks = t(kf21frem_indeks)
colnames(kf21frem_indeks)=c(2018:2030)
kf21frem_indeks = kf21frem_indeks[-(1:2),]
head(kf21frem_indeks)

CO2intens_frem <- matrix(rep(Co2intens,13),nrow=117,ncol=13)
colnames(CO2intens_frem)=c(2018:2030)
rownames(CO2intens_frem)=emissions$NA.[4:120]
head(CO2intens_frem)

eunfcclulucf_frem <- matrix(rep(eunfcclulucf,13),nrow=117,ncol=13)
colnames(eunfcclulucf_frem)=c(2018:2030)
rownames(eunfcclulucf_frem)=emissions$NA.[4:120]


for (i in 1:117) {
  if(i <= 3){kf21sektor=1}
  if(i ==4 || i==5){kf21sektor=4}
  if(i ==6){kf21sektor=6}
  if(i >= 7 && i <= 19){kf21sektor=5} #fremstilling
  if(i ==20){kf21sektor=4} #raffinaderier
  if(i >= 21 && i <= 40){kf21sektor=5} #fremstilling
  if(i ==41){kf21sektor=6} #rep af maskiner
  if(i ==42){kf21sektor=3} #el
  if(i ==43){kf21sektor=8} #gas:husholdninger
  if(i ==44){kf21sektor=3} #varme
  if(i ==45 || i==46){kf21sektor=3} #vand  og kloak :elforbrug
  if(i ==47){kf21sektor=2} #affald
  if(i >= 48 && i<=50) {kf21sektor=5} #byganlæg
  if(i >= 51 && i<=55){kf21sektor=6} #gørdetselv og bilhandel og øvrig handel
  if(i >= 56 && i<=62){kf21sektor=7} #transport
  if(i >= 63){kf21sektor=6} #alle mulige og umulige serviceerhverv, off. sektor mv.
  CO2intens_frem[i,1:13]=kf21frem_indeks[kf21sektor,1:13]*CO2intens_frem[i,1:13]
  eunfcclulucf_frem[i,1:13]=kf21frem_indeks[kf21sektor,1:13]*eunfcclulucf_frem[i,1:13]
}


tau_landbrug = matrix(0, nrow=117, ncol=13)
tau=1.25
tau_landbrug[1,] =c(0,0,0,0,1,1,1,1,1,1,1,1,1)*tau
CO2udl_indirect_frem = matrix(NA,nrow=74,ncol=13)
CO2tax_indirect_frem = matrix(NA,nrow=74,ncol=13)
for (y in 1:13) {
  CO2udl_indirect_frem[,y] = CO2intens_frem[,y]%*%IAinv%*%C
  CO2tax_indirect_frem[,y] = (tau_landbrug[,y]*CO2intens_frem[,y])%*%IAinv%*%C
}
colnames(CO2udl_indirect_frem)=c(2018:2030)
rownames(CO2udl_indirect_frem)=colnames(C)
head(CO2udl_indirect_frem)

#Så skal vi se på de direkte udledninger. Det er på forbrugsgrupper.
CO2udl_direct_frem=t(CO2udl_direct)
CO2udl_direct_frem = matrix(rep(CO2udl_direct_frem,13),nrow=74,ncol=13)
colnames(CO2udl_direct_frem)=c(2018:2030)
rownames(CO2udl_direct_frem)=colnames(C)

CO2udl_direct_frem[26,]=share_El*emi_hh*1 #er nul
CO2udl_direct_frem[27,]=share_Gas*emi_hh*kf21frem_indeks[8,1:13] #husholdninger
CO2udl_direct_frem[28,]=share_flyd*emi_hh*kf21frem_indeks[8,1:13] #husholdninger i kf21
CO2udl_direct_frem[29,]=share_fjernvarme*emi_hh*1 #er nul
CO2udl_direct_frem[44,]=share_benzmv*emi_hh*kf21frem_indeks[7,1:13] #transport


#Og så kan vi lægge dem sammen
CO2udl_tot_frem=CO2udl_direct_frem+CO2udl_indirect_frem
#CO2-skat: mio. kr pr 1000 ton - 1000 kr svarer til 1.
tau=1.25
tau_indfas = matrix(rep(c(0,0,0,0,0,0,0,0,0.2,0.4,0.6,0.8,1)*tau,72),nrow=72,ncol=13,byrow=TRUE)   #2026-2030 indførsel
#tau_indfas = matrix(rep(c(0,0,0,0,1,1,1,1,1,1,1,1,1)*tau,72),nrow=72,ncol=13,byrow=TRUE)            #2022-indførsel

#landbrugsafgift
CO2tax_tot_frem = CO2tax_indirect_frem + 0

#brændstoffer til transport undtaget
CO2tax_udenbenz_frem = tau_indfas
CO2tax_udenbenz_frem[44,]=0

############ PRICES ################
C_NRmat=matrix(rep(C_NR,13),nrow = 72,ncol=13)
p_frem = 1+CO2udl_tot_frem[1:72,]*tau_indfas/C_NRmat

#landbrugsafgift
p_frem = 1+CO2tax_tot_frem[1:72,]/C_NRmat
head(p_frem)

#uden benz
p_frem = 1+CO2udl_tot_frem[1:72,]*CO2tax_udenbenz_frem/C_NRmat
head(p_frem)

###########Aggregating to our 8 groups ############
c(CNRdata$NA.[-1])
kod_fisk_mej = c(2,3,4,5,6)
ovr_fode     =c(1,7,8,9,10,11,12,13,14,15,16,17)
bol   =c(21,22,23,24) 
ene_hje = c(26,27,28,29)
ene_tra = c(44)
tra =    c(42,43,45,46)
ovr_var = c(18,20,30:35,36,38,39,50:59,65:67)
ovr_tje = c(19,25,37,40,41,47,48,49,60,61,62,63,64,68:72)

#Tjek skal være lig 0                  
sum(c(kod_fisk_mej,ovr_fode,bol,ene_hje,ene_tra,tra,ovr_var,ovr_tje))-sum(c(1:72))

#Regner nogle laspeyres index ud
p_frem_8grp = matrix(NA,nrow = 8,ncol = 13)

list8grp=list(kod_fisk_mej,ovr_fode,bol,ene_hje,ene_tra,tra,ovr_var,ovr_tje)

p_frem_8grp
total_cons_8grp=rep(NA,8)
Co2intens_8grp_frem= matrix(NA,nrow=8, ncol=13)
sum(C_NR[kod_fisk_mej,1])
weights=rep(NA,72)
for (i in 1:8) {
  varer=list8grp[[i]]
  total_cons_8grp[i]=sum(C_NR[varer,1])
  for (j in varer) {
    weights[j]=C_NR[j]/total_cons_8grp[i]
  }
  for (y in 1:13) {
    p_frem_8grp[i,y] = sum(p_frem[varer,y]*weights[varer])
  }
}

colnames(p_frem_8grp)=c(2018:2030)
rownames(p_frem_8grp)=c(1:8)
p_frem_8grp

p_frem_8grp_2040 = matrix(NA,nrow=8,ncol=23)
p_frem_8grp_2040[,1:13]=p_frem_8grp
p_frem_8grp_2040[,14:23]=rep(p_frem_8grp[,13],10)
colnames(p_frem_8grp_2040)=c(2018:2040)
rownames(p_frem_8grp_2040)=c(1:8)
p_frem_8grp_2040


#lav figur med branche udledninger
v1 = data.frame(t(eunfcclulucf_frem))
v2 = data.frame(t(CO2udl_direct_frem))

v = data.frame(Year=c(2018:2030), Agriculture=v1$X010000.Landbrug.og.gartneri, "Concrete manufacturing"=v1$X230020.Betonindustri.og.teglværker, 
               Electricity= v1$X350010.Elforsyning, "Heating" = v1$X350030.Varmeforsyning, Waste=v1$X383900.Renovation..genbrug.og.forureningsbekæmpelse, "Energy for transport (consumption)" = v2$X07220.Brændstof.og.smøremidler.til.køretøjer....Anvendelse.
               )
colnames(v)=c("Year", "Agriculture", "Concrete manufacturing", "Electricity", "Heating","Waste management", "Transport fuels (households)")
#v$Year <- as.numeric(as.character(v$Year))
v <- v %>%
#  select(-Agriculture) %>%
  gather(key = "Industry", value = "value", -Year)
as.tibble(v)


emissionplot <- ggplot(v, aes(x = Year, y = value)) +  theme_bw() + #scale_y_continuous(trans='log10') + #xlim(2018,2030)+
  scale_x_continuous(breaks = round(seq(18, 2030, by = 2),1)) +theme(legend.position="bottom")+
  geom_line(aes(color = Industry)) + 
  geom_point(aes(color=Industry, shape=Industry))+
  scale_color_manual(values = wes_palette("Zissou1", 6, type = "continuous"))+
  labs(y = "1,000 tons CO2e")

ggsave(
  "emissionkf21.pdf",
  plot = emissionplot,
  device="pdf",
  width = 6,
  height = 6,
  units = c("in", "cm", "mm"),
  dpi = 300,
  limitsize = TRUE,
)

#lav figur med co2-intensiteter.
Co2intens_8grp_frem= matrix(NA,nrow=8, ncol=13)

for (i in 1:8) {
  varer=list8grp[[i]]
  for (y in 1:13){
    Co2intens_8grp_frem[i,y] = sum(CO2udl_tot_frem[varer,y])/total_cons_8grp[i]
  }
}


v = matrix(c(c(2018:2030),t(Co2intens_8grp_frem)), nrow=13, ncol=9)
v=data.frame(v)
colnames(v)=c("Year","Meat and dairy","Other foods","Housing","Energy for housing","Energy for transport","Transport","Other goods","Other services")
#v$Year <- as.numeric(as.character(v$Year))
v <- v %>%
  select(Year, "Meat and dairy", "Other foods", "Energy for housing", "Energy for transport") %>%
  gather(key = "Composite", value = "value", -Year)
as.tibble(v)

intensplot <- ggplot(v, aes(x = Year, y = value)) +  theme_bw() + ylim(0,0.3)+
  scale_x_continuous(breaks = round(seq(18, 2030, by = 2),1)) +theme(legend.position="bottom")+
  geom_line(aes(color = Composite)) + 
  geom_point(aes(color=Composite, shape=Composite))+
  scale_color_manual(values = wes_palette("Zissou1", 4, type = "continuous"))+
  labs(y = "Tons CO2e/1000 DKK")+guides(color=guide_legend(nrow=2,byrow=TRUE))
intensplot

ggsave(
  "intens21.pdf",
  plot = intensplot,
  device="pdf",
  width = 6,
  height = 4,
  units = c("in", "cm", "mm"),
  dpi = 300,
  limitsize = TRUE,
)

