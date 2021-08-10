#Kør først data og pakker.

#install.packages("reshape2")
#install.packages("gdxrrw_1.0.8.tgz",repos=NULL)
#install.packages("RColorBrewer")
library(gdxrrw)
library("RColorBrewer")
#install.packages("viridis")  # Install
library("viridis")           # Load
#install.packages("ggsci")  # Install
library("ggsci")           # Load
#install.packages("wesanderson")  # Install
library(wesanderson)

df_kvintiler= list(kvint_1,kvint_2,kvint_3, kvint_4, kvint_5)
w= list()
x=list()
for (dfdf in 1:length(df_kvintiler) ) {
  
  # Dataindlæsning  ---------
  df <- df_kvintiler[[dfdf]]
 
  df     <- transform( df,
                       w1 = df$kod_fisk_mej /df$ialt,
                       w2 = df$ovr_fode/df$ialt,
                       w3 = df$bol/df$ialt,
                       w4 = df$ene_hje/df$ialt,
                       w5 = df$ene_tra/df$ialt,
                       w6 = df$tra/df$ialt,
                       w7 = df$ovr_var/df$ialt,
                       w8 = df$ovr_tje/df$ialt
  ) 
  df     <- transform( df,
                       x1 = df$kod_fisk_mej /priser$Pris.kod_fisk_mej,
                       x2 = df$ovr_fode     /priser$Pris.ovr_fode,
                       x3 = df$bol          /priser$Pris.bol,
                       x4 = df$ene_hje      /priser$Pris.ene_hje,
                       x5 = df$ene_tra      /priser$Pris.ene_tra,
                       x6 = df$tra          /priser$Pris.tra,
                       x7 = df$ovr_var      /priser$Pris.ovr_var,
                       x8 = df$ovr_tje      /priser$Pris.ovr_tje 
  )
 
  w[[dfdf]] = matrix(c(df$w1,df$w2,df$w3,df$w4,df$w5,df$w6,df$w7,df$w8),  nrow=26, ncol=8)
  x[[dfdf]] = matrix(c(df$x1,df$x2,df$x3,df$x4,df$x5,df$x6,df$x7,df$x8), nrow=26, ncol=8)
}

T=26
n=8

cons_shares=list()
shareplot=list()
w1=w[[1]]
w2=w[[2]]
w3=w[[3]]
w4=w[[4]]
w5=w[[5]]
x1=x[[1]]
x2=x[[2]]
x3=x[[3]]
x4=x[[4]]
x5=x[[5]]

titles= c("Meat and dairy","Other foods","Housing","Energy for housing","Energy for transport","Transport","Other goods","Other services")
for (i in 1:8) {
  cons_shares[[i]] = matrix(c(w1[1:T,i],w2[,i],w3[,i],w4[,i],w5[,i]),nrow=26, ncol=)

  v=data.frame(cons_shares[[i]])
  v$Year=c(1994:2019)
  colnames(v)=c(1,2,3,4,5,"Year")
  
  v$Year <- as.numeric(as.character(v$Year))
  
  v[,-6]=v[,-6]*100
  
  v <- v %>%
    #select(Year,1,2,3,4,5) %>%
    gather(key = "Quintile", value = "value", -Year)
  
  as_tibble(v)
  
  title=titles[i]
  
  shareplot[[i]]= ggplot(v, aes(x = Year, y = value)) + ggtitle(title)+ theme_bw() +  theme(plot.title = element_text(size=10))+
    geom_line(aes(color = Quintile)) + 
    geom_point(aes(color=Quintile, shape=Quintile))+
    scale_color_manual(values = wes_palette("Zissou1", 5, type = "discrete"))+
    labs(y = "Pct.")
}
stortplot = ggarrange(plotlist=shareplot, ncol=2, nrow=4, common.legend = TRUE, legend="bottom")

ggsave(
  "shareplot_quintiles.pdf",
  plot = stortplot,
  device="pdf",
  width = 8.27,
  height = 11.69,
  units = c("in", "cm", "mm"),
  dpi = 300,
  limitsize = TRUE,
)

### PRISER
v = priser


colnames(v)=c("Year","1: Meat and dairy","2: Other foods","3: Housing","4: Energy for housing","5: Energy for transport","6: Transport","7: Other goods","8: Other services")


v <- v %>%
  #select(Year,1,2,3,4,5) %>%
  gather(key = "Composite", value = "value", -Year)

#rebase
v <- v %>%
  group_by(Composite) %>%
  mutate(VAL.IND = value/value[Year==1995]*100)

priceplot <- ggplot(v, aes(x = Year, y = VAL.IND)) + theme_bw() + ylim(80, 240)+
  geom_line(aes(color = Composite)) + 
  geom_point(aes(color=Composite, shape=Composite))+
  scale_color_manual(values = wes_palette("Rushmore", 8, type = "continuous"))+
  scale_shape_manual(values=seq(0,8))+
  labs(y = "1995=100")

ggsave(
  "priceplot.pdf",
  plot = priceplot,
  device="pdf",
  width =6 ,
  height = 4,
  units = c("in", "cm", "mm"),
  dpi = 300,
  limitsize = TRUE,
)

prisindeksdata <- read.xlsx("/Users/rasmuskaslund/Documents/GitHub/SpecialeJR /Data/prisindeks.xlsx", 1)


v <- indk_forb_kvint

v2 <- data.frame(Year=v$Year, Q1.Disposable.Income = v$Dispk1,Q2.Disposable.Income = v$Dispk2,
                 Q3.Disposable.Income = v$Dispk3,Q4.Disposable.Income = v$Dispk4, Q5.Disposable.Income = v$Dispk5,
                 Q1.Total.Consumption = v$Forbk1, Q2.Total.Consumption = v$Forbk2, Q3.Total.Consumption = v$Forbk3, 
                 Q4.Total.Consumption = v$Forbk4, Q5.Total.Consumption = v$Forbk5)

head(v2)

prisindeksdata$Prisindeks_2015

v2=v2/prisindeksdata$Prisindeks_2015

v2$Year=c(1994:2019)

((v2$Q1.Disposable.Income[26]/v2$Q1.Disposable.Income[1])^(1/26)-1)*100
((v2$Q5.Disposable.Income[26]/v2$Q5.Disposable.Income[1])^(1/26)-1)*100
((v2$Q1.Total.Consumption[26]/v2$Q1.Total.Consumption[1])^(1/26)-1)*100
((v2$Q5.Total.Consumption[26]/v2$Q5.Total.Consumption[1])^(1/26)-1)*100

#LAVER LIGE EN FED lineær MODEL for fremskrivning af forbrug og indkomst
realindkforb = v2
head(realindkforb)
realindkforb$trend=c(1:26)
realindkforb$Q6.Total.Consumption = df_h$ialt/prisindeksdata$Prisindeks_2015
realindkforb$Q6.Disposable.Income = disp_indk$Hele.landet/prisindeksdata$Prisindeks_2015
c1=lm(log(Q1.Total.Consumption)~trend, data = realindkforb)
c2=lm(log(Q2.Total.Consumption)~trend, data = realindkforb)
c3=lm(log(Q3.Total.Consumption)~trend, data = realindkforb)
c4=lm(log(Q4.Total.Consumption)~trend, data = realindkforb)
c5=lm(log(Q5.Total.Consumption)~trend, data = realindkforb)
c6=lm(log(Q6.Total.Consumption)~trend, data = realindkforb)
i1=lm(log(Q1.Disposable.Income)~trend, data = realindkforb)
i2=lm(log(Q2.Disposable.Income)~trend, data = realindkforb)
i3=lm(log(Q3.Disposable.Income)~trend, data = realindkforb)
i4=lm(log(Q4.Disposable.Income)~trend, data = realindkforb)
i5=lm(log(Q5.Disposable.Income)~trend, data = realindkforb)
i6=lm(log(Q6.Disposable.Income)~trend, data = realindkforb)

trends= data.frame(cons=c(c1$coefficients[2],c2$coefficients[2],c3$coefficients[2],c4$coefficients[2],c5$coefficients[2],c6$coefficients[2]), 
dispinc=c(i1$coefficients[2],i2$coefficients[2],i3$coefficients[2],i4$coefficients[2],i5$coefficients[2],i6$coefficients[2]) )

write.xlsx(trends,"trends.xlsx",)
write.xlsx(realindkforb,"realindkforb.xlsx",)


colnames(v2) = c("Year","Q1 Disposable Income",
                 "Q2 Disposable Income",
                 "Q3 Disposable Income",
                 "Q4 Disposable Income",
                 "Q5 Disposable Income",
                 "Q1 Expenditure",
                 "Q2 Expenditure",
                 "Q3 Expenditure",
                 "Q4 Expenditure",
                 "Q5 Expenditure")

v <- v2 %>%
  gather(key = "Quintile", value = "value", -Year)

v$value = v$value/1000

forbindkplot <-   ggplot(v, aes(x = Year, y = value)) + theme_bw() +
  geom_line(aes(color = Quintile, linetype = Quintile)) + 
  scale_color_manual(values = c("#3B9AB2","#3B9AB2","#78B7C5", "#78B7C5","#EBCC2A","#EBCC2A","#E1AF00","#E1AF00","#F21A00","#F21A00"),)+
  scale_linetype_manual(values = c("solid","twodash", "solid", "twodash","solid","twodash","solid","twodash","solid","twodash"))+
  labs(y = "1,000 DKK (2015-prices)")

ggsave(
  "forb_indk.pdf",
  plot = forbindkplot,
  device="pdf",
  width =6 ,
  height = 4,
  units = c("in", "cm", "mm"),
  dpi = 300,
  limitsize = TRUE,
)


#savings
v <- indk_forb_kvint
v2 = data.frame(Year=c(1994:2019))
v2$sk1 = (1-v$Forbk1/v$Dispk1)*100
v2$sk2 = (1-v$Forbk2/v$Dispk2)*100
v2$sk3 = (1-v$Forbk3/v$Dispk3)*100
v2$sk4 = (1-v$Forbk4/v$Dispk4)*100
v2$sk5 = (1-v$Forbk5/v$Dispk5)*100

colnames(v2) = c("Year","1","2","3","4","5")

v <- v2 %>%
  gather(key = "Quintile", value = "value", -Year)

savingsplot <- ggplot(v, aes(x = Year, y = value)) +  theme_bw() +  
  geom_line(aes(color = Quintile)) + 
  geom_point(aes(color=Quintile, shape=Quintile))+
  scale_color_manual(values = wes_palette("Zissou1", 5, type = "discrete"))+
  labs(y = "Pct.")

ggsave(
  "savings.pdf",
  plot = savingsplot,
  device="pdf",
  width =6 ,
  height = 4,
  units = c("in", "cm", "mm"),
  dpi = 300,
  limitsize = TRUE,
)

#price and real consumption graphs
coeffs=c(10,1,0.001,1,1,1,1,5)
priceconsplot=list()
titles= c("Meat and dairy","Other foods","Housing","Energy for housing","Energy for transport","Transport","Other goods","Other services")
for (i in 1:8) {
  cons_shares[[i]] = matrix(c(x1[1:T,i],x2[,i],x3[,i],x4[,i],x5[,i]),nrow=26, ncol=)
  
  v=data.frame(cons_shares[[i]])
  v$Year=c(1994:2019)
  v$Price=priser[,(i+1)]
  colnames(v)=c(1,2,3,4,5,"Year","Price")
  
  v$Year <- as.numeric(as.character(v$Year))
  
  v <- v %>%
    #select(Year,1,2,3,4,5) %>%
    gather(key = "Quintile", value = "value", -Year,-Price)
  
  v$value = v$value/1000
  v$Price = v$Price*100
  as_tibble(v)
  
  #coeff=coeffs[i]
  coeff=1
  
  title=titles[i]
  priceconsplot[[i]]= ggplot(v, aes(x = Year, y = value))+
    ggtitle(title)+ theme_bw() +  theme(plot.title = element_text(size=10))+
    geom_line(aes(color = Quintile)) + 
    geom_line(aes(y=Price/coeff), size=1) +
    scale_y_continuous( name = "1,000 2015-DKK",sec.axis = sec_axis(~.*coeff, name="2015=100"))+
    geom_point(aes(color=Quintile, shape=Quintile))+
    scale_color_manual(values = wes_palette("Zissou1", 5, type = "discrete"))
  
}
stortplot = ggarrange(plotlist=priceconsplot, ncol=2, nrow=4, common.legend = TRUE, legend="bottom")

ggsave(
  "priceconsplot.pdf",
  plot = stortplot,
  device="pdf",
  width = 8.27,
  height = 11.69,
  units = c("in", "cm", "mm"),
  dpi = 300,
  limitsize = TRUE,
)

### with indexed real consumption
plottelotte=list()
for (i in 1:8) {
  cons_shares[[i]] = matrix(c(x1[1:T,i],x2[,i],x3[,i],x4[,i],x5[,i]),nrow=26, ncol=)
  
  v=data.frame(cons_shares[[i]])
  v$Year=c(1994:2019)
  v$Price=priser[,(i+1)]
  colnames(v)=c(1,2,3,4,5,"Year","Price")
  
  
  
  v$Year <- as.numeric(as.character(v$Year))
  
  v <- v %>%
    #select(Year,1,2,3,4,5) %>%
    gather(key = "Quintile", value = "value", -Year,)
  v <- v %>%
    group_by(Quintile) %>%
    mutate(VAL.IND = value/value[Year==1995]*100)
  
  as_tibble(v)
  
  #coeff=coeffs[i]
  coeff=1
  
  title=titles[i]
  plottelotte[[i]]= ggplot(v, aes(x = Year, y = VAL.IND))+
    ggtitle(title)+ theme_bw() +  theme(plot.title = element_text(size=10))+
    geom_line(aes(color = Quintile)) + 
    geom_point(aes(color=Quintile, shape=Quintile))+
    scale_color_manual(values = c("#3B9AB2","#78B7C5", "#EBCC2A","#E1AF00","#F21A00","black"),)+
    labs(y = "1995=100")
}
stortplot = ggarrange(plotlist=plottelotte, ncol=2, nrow=4, common.legend = TRUE, legend="bottom")
ggsave(
  "indexpricecons.pdf",
  plot = stortplot,
  device="pdf",
  width = 8.27,
  height = 11.69,
  units = c("in", "cm", "mm"),
  dpi = 300,
  limitsize = TRUE,
)

#just real consumption
consplot=list()
titles= c("Meat and dairy","Other foods","Housing","Energy for housing","Energy for transport","Transport","Other goods","Other services")
for (i in 1:8) {
  cons_shares[[i]] = matrix(c(x1[1:T,i],x2[,i],x3[,i],x4[,i],x5[,i]),nrow=26, ncol=)
  
  v=data.frame(cons_shares[[i]])
  v$Year=c(1994:2019)
  v$Price=priser[,(i+1)]
  colnames(v)=c(1,2,3,4,5,"Year","Price")
  
  v$Year <- as.numeric(as.character(v$Year))
  
  v <- v %>%
    #select(Year,1,2,3,4,5) %>%
    gather(key = "Quintile", value = "value", -Year,-Price)
  
  v$value = v$value/1000
  v$Price = v$Price*100
  as_tibble(v)
  
  #coeff=coeffs[i]
  coeff=1
  
  title=titles[i]
  consplot[[i]]= ggplot(v, aes(x = Year, y = value))+
    ggtitle(title)+ theme_bw() +  theme(plot.title = element_text(size=10))+
    geom_line(aes(color = Quintile)) + 
    geom_point(aes(color=Quintile, shape=Quintile))+
    scale_color_manual(values = wes_palette("Zissou1", 5, type = "discrete"))+
    labs(y = "1,000 DKK (2015 prices)")
  
}
stortplot = ggarrange(plotlist=consplot, ncol=2, nrow=4, common.legend = TRUE, legend="bottom")

ggsave(
  "consplot.pdf",
  plot = stortplot,
  device="pdf",
  width = 8.27,
  height = 11.69,
  units = c("in", "cm", "mm"),
  dpi = 300,
  limitsize = TRUE,
)


#<color-palette name="Zissou1" type="regular" >
#  <color>#3B9AB2</color>
#  <color>#78B7C5</color>
#  <color>#EBCC2A</color>
#  <color>#E1AF00</color>
#  <color>#F21A00</color>

