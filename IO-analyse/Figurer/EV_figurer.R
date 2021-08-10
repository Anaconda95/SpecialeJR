rm(list=ls())
#clear workspace
rm(list=ls())
library(mvtnorm)
library("xlsx")
#install.packages("grid")
library("grid")
#install.packages("ggplot")
#install.packages("tidyr")
library(dplyr)
library(tidyr)
library(ggplot2)
#install.packages("gridExtra")
library(gridExtra)
library(grid)
library(ggplot2)
#install.packages("ggpubr")
library(ggpubr)
library(lattice)
#install.packages("ggpubr")
library(ggpubr)
#no scientific numbers
options(scipen=999)
options(digits=5)
library(xtable)
options(xtable.floating = FALSE)
options(xtable.timestamp = "")
#install.packages("reshape2")
#install.packages("gdxrrw_1.0.8.tgz",repos=NULL)
#install.packages("RColorBrewer")
library(gdxrrw)
library("RColorBrewer")
#install.packages("viridis")  # Install
library("viridis")            # Load
#install.packages("ggsci")    # Install
library("ggsci")              # Load
#install.packages("wesanderson")  # Install
library(wesanderson)

setwd("~/Documents/GitHub/SpecialeJR /IO-analyse/Figurer")

##Reading results from GAMS
readlist = list(name='t')
gdxInfo("dyn_partiel")
#GDX library load path: /Library/Frameworks/GAMS.framework/Versions/35/Resources/
igdx(gamsSysDir="/Library/Frameworks/GAMS.framework/Versions/35/Resources/", silent=FALSE, returnStr=FALSE)

#Indfasning fra 2026-2030-----------
#rgdx.param("1250indfas2026.gdx",readlist)
EVdispinc <- rgdx.param("1250indfas2026",'EVdispinc_t')
EVexp     <- rgdx.param("1250indfas2026",'EVexp_t')

EVplots <- list()
for (p in 1:2) {
  if (p==1){
    v <- spread(EVexp,key=i, value=EVexp_t)
    title = "Expenditure"
  }
  if (p==2){
    v <- spread(EVdispinc,key=i, value=EVdispinc_t)
    title = "Disposable income"
  }
  
  v <- v %>%
    rename(Year = t)
  
  v$Year <- as.numeric(as.character(v$Year))
  
  # Adding zeros for year 2020-2025
  nuller=data.frame(Year=c(2020:2025),rep(0,6),rep(0,6),"3"=rep(0,6),"4"=rep(0,6),"5"=rep(0,6),"6"=rep(0,6))
  colnames(nuller)=c("Year",1,2,3,4,5,6)
  v=rbind(nuller,v)
  
  #Make in percent
  v[,-1]=v[,-1]*100
  
  v <- v %>%
    select(Year,1,2,3,4,5,6) %>%
    gather(key = "Quintile", value = "value", -Year)
  
  as.tibble(v)
  
  #Axis scale
  min=-2
  max=2
  
  EVplots[[p]]= ggplot(v, aes(x = Year, y = value)) + ggtitle(title)+ theme_bw() +ylim(min, max)+  theme(plot.title = element_text(size=10))+
    geom_line(aes(color = Quintile)) + 
    geom_point(aes(color=Quintile, shape=Quintile))+
    scale_color_manual(values = wes_palette("Zissou1", 5, type = "discrete"))+
    labs(y = "Pct.")
  
  if(p==1){
  bardata = filter(v, Year == 2030)}
  if(p==2){
    bardata = rbind(bardata,filter(v, Year == 2030))}
}
groupplot <- ggarrange(plotlist=EVplots, ncol=2, nrow=1, common.legend = TRUE, legend="right")

bardata$EV<- c( rep("As pct. of expenditure",5) , rep("As pct. of disposable income",5)  )
bardata$Quintile <- as.integer(as.factor(bardata$Quintile))

bardata= arrange(bardata, EV)
# Grouped bar chart
#Axis scale
min=-2
max=2

barplot <- ggplot(bardata, aes(fill=EV, y=value, x=Quintile)) + theme_bw()+ylim(min, max)+
  theme(plot.title = element_text(size=10))+ theme(legend.position="bottom")+
  geom_bar(position="dodge", stat="identity")+ 
  scale_fill_manual(values = wes_palette("Cavalcanti1", 5, type = "discrete"))+
  labs(y = "Pct.")

ggsave(
  "timeEV_1250_indfas.pdf",
  plot = groupplot,
  device="pdf",
  width = 6,
  height = 4,
  units = c("in", "cm", "mm"),
  dpi = 300,
  limitsize = TRUE,
)

ggsave(
  "bar2030_1250_indfas.pdf",
  plot = barplot,
  device="pdf",
  width = 6,
  height = 4,
  units = c("in", "cm", "mm"),
  dpi = 300,
  limitsize = TRUE,
)


#1250 DKK from 2022-----------

EVdispinc <- rgdx.param("1250straks",'EVdispinc_t')
EVexp     <- rgdx.param("1250straks",'EVexp_t')

EVplots <- list()
for (p in 1:2) {
  if (p==1){
    v <- spread(EVexp,key=i, value=EVexp_t)
    title = "Expenditure"
  }
  if (p==2){
    v <- spread(EVdispinc,key=i, value=EVdispinc_t)
    title = "Disposable income"
  }
  
  v <- v %>%
    rename(Year = t)
  
  v$Year <- as.numeric(as.character(v$Year))
  
  # Adding zeros for year 2020-2025
  nuller=data.frame(Year=c(2020:2021),rep(0,2),rep(0,2),"3"=rep(0,2),"4"=rep(0,2),"5"=rep(0,2),"6"=rep(0,2))
  colnames(nuller)=c("Year",1,2,3,4,5,6)
  v=rbind(nuller,v)
  
  #Make in percent
  v[,-1]=v[,-1]*100
  
  v <- v %>%
    select(Year,1,2,3,4,5,6) %>%
    gather(key = "Quintile", value = "value", -Year)
  
  as.tibble(v)
  
  #Axis scale
  min=-3
  max=2
  
  EVplots[[p]]= ggplot(v, aes(x = Year, y = value)) + ggtitle(title)+ theme_bw() +ylim(min, max)+  theme(plot.title = element_text(size=10))+
    geom_line(aes(color = Quintile)) + 
    geom_point(aes(color=Quintile, shape=Quintile))+
    scale_color_manual(values = wes_palette("Zissou1", 5, type = "discrete"))+
    labs(y = "Pct.")
  
  if(p==1){
    bardata = filter(v, Year == 2030)}
  if(p==2){
    bardata = rbind(bardata,filter(v, Year == 2030))}
}
groupplot <- ggarrange(plotlist=EVplots, ncol=2, nrow=1, common.legend = TRUE, legend="right")

bardata$EV<- c( rep("As pct. of expenditure",5) , rep("As pct. of disposable income",5)  )
bardata$Quintile <- as.integer(as.factor(bardata$Quintile))

bardata= arrange(bardata, EV)
# Grouped bar chart
#Axis scale
min=-2
max=2

barplot <- ggplot(bardata, aes(fill=EV, y=value, x=Quintile)) + theme_bw()+ylim(min, max)+
  theme(plot.title = element_text(size=10))+ theme(legend.position="bottom")+
  geom_bar(position="dodge", stat="identity")+ 
  scale_fill_manual(values = wes_palette("Cavalcanti1", 5, type = "discrete"))+
  labs(y = "Pct.")

ggsave(
  "timeEV_1250_straks.pdf",
  plot = groupplot,
  device="pdf",
  width = 6,
  height = 4,
  units = c("in", "cm", "mm"),
  dpi = 300,
  limitsize = TRUE,
)

ggsave(
  "bar2030_1250_straks.pdf",
  plot = barplot,
  device="pdf",
  width = 6,
  height = 4,
  units = c("in", "cm", "mm"),
  dpi = 300,
  limitsize = TRUE,
)


## 1250 DKK on agriculture only ------

EVdispinc <- rgdx.param("landbrugsafgift",'EVdispinc_t')
EVexp     <- rgdx.param("landbrugsafgift",'EVexp_t')

EVplots <- list()
for (p in 1:2) {
  if (p==1){
    v <- spread(EVexp,key=i, value=EVexp_t)
    title = "Expenditure"
  }
  if (p==2){
    v <- spread(EVdispinc,key=i, value=EVdispinc_t)
    title = "Disposable income"
  }
  
  v <- v %>%
    rename(Year = t)
  
  v$Year <- as.numeric(as.character(v$Year))
  
  # Adding zeros for year 2020-2021
  nuller=data.frame(Year=c(2020:2021),rep(0,2),rep(0,2),"3"=rep(0,2),"4"=rep(0,2),"5"=rep(0,2),"6"=rep(0,2))
  colnames(nuller)=c("Year",1,2,3,4,5,6)
  v=rbind(nuller,v)
  
  #Make in percent
  v[,-1]=v[,-1]*100
  
  v <- v %>%
    select(Year,1,2,3,4,5,6) %>%
    gather(key = "Quintile", value = "value", -Year)
  
  as.tibble(v)
  
  #Axis scale
  min=-0.5
  max=0.1
  
  EVplots[[p]]= ggplot(v, aes(x = Year, y = value)) + ggtitle(title)+ theme_bw() +ylim(min, max)+  theme(plot.title = element_text(size=10))+
    geom_line(aes(color = Quintile)) + 
    geom_point(aes(color=Quintile, shape=Quintile))+
    scale_color_manual(values = wes_palette("Zissou1", 5, type = "discrete"))+
    labs(y = "Pct.")
  
  if(p==1){
    bardata = filter(v, Year == 2030)}
  if(p==2){
    bardata = rbind(bardata,filter(v, Year == 2030))}
}
groupplot <- ggarrange(plotlist=EVplots, ncol=2, nrow=1, common.legend = TRUE, legend="right")
groupplot


bardata$EV<- c( rep("As pct. of expenditure",5) , rep("As pct. of disposable income",5)  )
bardata$Quintile <- as.integer(as.factor(bardata$Quintile))

bardata= arrange(bardata, EV)
# Grouped bar chart
#Axis scale
min=-0.5
max=0.5

barplot <- ggplot(bardata, aes(fill=EV, y=value, x=Quintile)) + theme_bw()+ylim(min, max)+
  theme(plot.title = element_text(size=10))+ theme(legend.position="bottom")+
  geom_bar(position="dodge", stat="identity")+ 
  scale_fill_manual(values = wes_palette("Cavalcanti1", 5, type = "discrete"))+
  labs(y = "Pct.")

ggsave(
  "landbrugev.pdf",
  plot = groupplot,
  device="pdf",
  width = 6,
  height = 4,
  units = c("in", "cm", "mm"),
  dpi = 300,
  limitsize = TRUE,
)

ggsave(
  "landbrugevbarchart.pdf",
  plot = barplot,
  device="pdf",
  width = 6,
  height = 4,
  units = c("in", "cm", "mm"),
  dpi = 300,
  limitsize = TRUE,
)




## 1250 dkk, gasoline not taxed --------
#rgdx.param("1250indfas2026.gdx",readlist) 
EVdispinc <- rgdx.param("benzundtag",'EVdispinc_t')
EVexp     <- rgdx.param("benzundtag",'EVexp_t')

EVplots <- list()
for (p in 1:2) {
  if (p==1){
    v <- spread(EVexp,key=i, value=EVexp_t)
    title = "Expenditure"
  }
  if (p==2){
    v <- spread(EVdispinc,key=i, value=EVdispinc_t)
    title = "Disposable income"
  }
  
  v <- v %>%
    rename(Year = t)
  
  v$Year <- as.numeric(as.character(v$Year))
  
  # Adding zeros for year 2020-2025
  nuller=data.frame(Year=c(2020:2025),rep(0,6),rep(0,6),"3"=rep(0,6),"4"=rep(0,6),"5"=rep(0,6),"6"=rep(0,6))
  colnames(nuller)=c("Year",1,2,3,4,5,6)
  v=rbind(nuller,v)
  
  #Make in percent
  v[,-1]=v[,-1]*100
  
  v <- v %>%
    select(Year,1,2,3,4,5,6) %>%
    gather(key = "Quintile", value = "value", -Year)
  
  as.tibble(v)
  
  #Axis scale
  min=-1.5
  max=0.5
  
  EVplots[[p]]= ggplot(v, aes(x = Year, y = value)) + ggtitle(title)+ theme_bw() +ylim(min, max)+  theme(plot.title = element_text(size=10))+
    geom_line(aes(color = Quintile)) + 
    geom_point(aes(color=Quintile, shape=Quintile))+
    scale_color_manual(values = wes_palette("Zissou1", 5, type = "discrete"))+
    labs(y = "Pct.")
  
  if(p==1){
    bardata = filter(v, Year == 2030)}
  if(p==2){
    bardata = rbind(bardata,filter(v, Year == 2030))}
}
groupplot <- ggarrange(plotlist=EVplots, ncol=2, nrow=1, common.legend = TRUE, legend="right")

bardata$EV<- c( rep("As pct. of expenditure",5) , rep("As pct. of disposable income",5)  )
bardata$Quintile <- as.integer(as.factor(bardata$Quintile))

bardata= arrange(bardata, EV)
# Grouped bar chart
#Axis scale
min=-2
max=2

barplot <- ggplot(bardata, aes(fill=EV, y=value, x=Quintile)) + theme_bw()+ylim(min, max)+
  theme(plot.title = element_text(size=10))+ theme(legend.position="bottom")+
  geom_bar(position="dodge", stat="identity")+ 
  scale_fill_manual(values = wes_palette("Cavalcanti1", 5, type = "discrete"))+
  labs(y = "Pct.")

ggsave(
  "benz_undtag_evtime.pdf",
  plot = groupplot,
  device="pdf",
  width = 6,
  height = 4,
  units = c("in", "cm", "mm"),
  dpi = 300,
  limitsize = TRUE,
)

ggsave(
  "benz_undtag_bar.pdf",
  plot = barplot,
  device="pdf",
  width = 6,
  height = 4,
  units = c("in", "cm", "mm"),
  dpi = 300,
  limitsize = TRUE,
)


## KRAKA samlign --------
#rgdx.param("1250indfas2026.gdx",readlist) 
EVexp     <- rgdx.param("1250indfas2026",'EVexp_t')
CS_exp     <- rgdx.param("1250indfas2026",'CS_inc')
CS_kraka_exp <- rgdx.param("1250indfas2026",'CS_kraka_inc')

bardata <- filter(EVexp, t == 2030)
CSexp <-  filter(CS_exp, t == 2030)
CSkrakaexp <- filter(CS_kraka_exp, t == 2030)
bardata$CSexp= -CSexp$CS_inc
bardata$CSkrakaexp = -CSkrakaexp$CS_kraka_inc

bardata <- bardata %>%
  select(-t) %>%
  gather(key = "EVmip", value = "value", -i)
bardata <- filter(bardata,i!=6)
bardata$value=bardata$value*100
bardata$Welfare = c(rep("EV",5),rep("Consumer surplus",5),rep("Consumer surplus, Kraka's method",5)) 
bardata$Quintile = bardata$i
bardata

min=-2
max=0.5

barplot=ggplot(bardata, aes(fill=Welfare, y=value, x=Quintile)) + theme_bw()+  ylim(min, max)+
  theme(plot.title = element_text(size=10))+ theme(legend.position="bottom")+
  geom_bar(position="dodge", stat="identity")+ 
  scale_fill_manual(values = wes_palette("Cavalcanti1", 3, type = "discrete"))+
  labs(y = "Pct.")

ggsave(
  "bar_sammenlign_indfas.pdf",
  plot = barplot,
  device="pdf",
  width = 6,
  height = 4,
  units = c("in", "cm", "mm"),
  dpi = 300,
  limitsize = TRUE,
)

#rgdx.param("1250indfas2026.gdx",readlist) 
EVexp     <-    rgdx.param("benzundtag",'EVexp_t')
CS_exp     <-   rgdx.param("benzundtag",'CS_inc')
CS_kraka_exp <- rgdx.param("benzundtag",'CS_kraka_inc')

bardata <- filter(EVexp, t == 2030)
CSexp <-  filter(CS_exp, t == 2030)
CSkrakaexp <- filter(CS_kraka_exp, t == 2030)
bardata$CSexp= -CSexp$CS_inc
bardata$CSkrakaexp = -CSkrakaexp$CS_kraka_inc

bardata <- bardata %>%
  select(-t) %>%
  gather(key = "EVmip", value = "value", -i)
bardata <- filter(bardata,i!=6)
bardata$value=bardata$value*100
bardata$Welfare = c(rep("EV",5),rep("Consumer surplus",5),rep("Consumer surplus, Kraka's method",5)) 
bardata$Quintile = bardata$i
bardata

barplot <- ggplot(bardata, aes(fill=Welfare, y=value, x=Quintile)) + theme_bw()+ylim(min, max)+
  theme(plot.title = element_text(size=10))+ theme(legend.position="bottom")+
  geom_bar(position="dodge", stat="identity")+ 
  scale_fill_manual(values = wes_palette("Cavalcanti1", 3, type = "discrete"))+
  labs(y = "Pct.")

ggsave(
  "bar_sammenlign_benzundtag.pdf",
  plot = barplot,
  device="pdf",
  width = 6,
  height = 4,
  units = c("in", "cm", "mm"),
  dpi = 300,
  limitsize = TRUE,
)

# SAmlign LES, CD og fast efterspørgsel---------------------------
CS_LES     <-   rgdx.param("les_cd_fast",'CS_inc')
CS_FAST    <-   rgdx.param("les_cd_fast",'CS_fast_exp')
CS_CD      <-   rgdx.param("les_cd_fast",'CS_cd_exp')

bardata <- filter(CS_LES, t == 2030)
bardata$CS_inc = -bardata$CS_inc
CSfast <-   filter(CS_FAST, t == 2030)
CScd  <-   filter(CS_CD, t == 2030)
bardata$CSfast= -CSfast$CS_fast_exp
bardata$CScd = -CScd$CS_cd_exp

bardata <- bardata %>%
  select(-t) %>%
  gather(key = "EVmip", value = "value", -i)
bardata <- filter(bardata,i!=6)
bardata$value=bardata$value*100
bardata$Welfare = c(rep("1: CS - LES",5),rep("2: CS -  Leontief",5),rep("3: CS -  Cobb Douglas",5)) 
bardata$Quintile = bardata$i
bardata

min=-2
max=0.5

barplot=ggplot(bardata, aes(fill=Welfare, y=value, x=Quintile)) + theme_bw()+  ylim(min, max)+
  theme(plot.title = element_text(size=10))+ theme(legend.position="bottom")+
  geom_bar(position="dodge", stat="identity")+ 
  scale_fill_manual(values = wes_palette("Cavalcanti1", 3, type = "discrete"))+
  labs(y = "Pct.")

ggsave(
  "bar_samlign_nyttefunk.pdf",
  plot = barplot,
  device="pdf",
  width = 6,
  height = 4,
  units = c("in", "cm", "mm"),
  dpi = 300,
  limitsize = TRUE,
)




#Indfasning fra 2026-2030 income growth differentiated growth rates-----------
#rgdx.param("1250indfas2026.gdx",readlist)
EVdispinc <- rgdx.param("frem1250_diffincgrowth",'EVdispinc_diff')
EVexp     <- rgdx.param("frem1250_diffincgrowth",'EVexp_diff')

EVplots <- list()
for (p in 1:2) {
  if (p==1){
    v <- spread(EVexp,key=i, value=EVexp_diff)
    title = "Expenditure"
  }
  if (p==2){
    v <- spread(EVdispinc,key=i, value=EVdispinc_diff)
    title = "Disposable income"
  }
  
  v <- v %>%
    rename(Year = t)
  
  v$Year <- as.numeric(as.character(v$Year))
  
  # Adding zeros for year 2020-2025
  nuller=data.frame(Year=c(2020:2025),rep(0,6),rep(0,6),"3"=rep(0,6),"4"=rep(0,6),"5"=rep(0,6),"6"=rep(0,6))
  colnames(nuller)=c("Year",1,2,3,4,5,6)
  v=rbind(nuller,v)
  
  #Make in percent
  v[,-1]=v[,-1]*100
  
  v <- v %>%
    select(Year,1,2,3,4,5,6) %>%
    gather(key = "Quintile", value = "value", -Year)
  
  as_tibble(v)
  
  #Axis scale
  min=-2
  max=2
  
  EVplots[[p]]= ggplot(v, aes(x = Year, y = value)) + ggtitle(title)+ theme_bw() +ylim(min, max)+  theme(plot.title = element_text(size=10))+
    geom_line(aes(color = Quintile)) + 
    geom_point(aes(color=Quintile, shape=Quintile))+
    scale_color_manual(values = wes_palette("Zissou1", 5, type = "discrete"))+
    labs(y = "Pct.")
  
  if(p==1){
    bardata = filter(v, Year == 2030)}
  if(p==2){
    bardata = rbind(bardata,filter(v, Year == 2030))}
}
groupplot <- ggarrange(plotlist=EVplots, ncol=2, nrow=1, common.legend = TRUE, legend="right")

bardata$EV<- c( rep("As pct. of expenditure",5) , rep("As pct. of disposable income",5)  )
bardata$Quintile <- as.integer(as.factor(bardata$Quintile))

bardata= arrange(bardata, EV)
# Grouped bar chart
#Axis scale
min=-2
max=2

barplot <- ggplot(bardata, aes(fill=EV, y=value, x=Quintile)) + theme_bw()+ylim(min, max)+
  theme(plot.title = element_text(size=10))+ theme(legend.position="bottom")+
  geom_bar(position="dodge", stat="identity")+ 
  scale_fill_manual(values = wes_palette("Cavalcanti1", 5, type = "discrete"))+
  labs(y = "Pct.")

ggsave(
  "timeEV_1250_indfas_diffincgrowth.pdf",
  plot = groupplot,
  device="pdf",
  width = 6,
  height = 4,
  units = c("in", "cm", "mm"),
  dpi = 300,
  limitsize = TRUE,
)

ggsave(
  "bar2030_1250_indfas_diffincgrowth.pdf",
  plot = barplot,
  device="pdf",
  width = 6,
  height = 4,
  units = c("in", "cm", "mm"),
  dpi = 300,
  limitsize = TRUE,
)


#Indfasning fra 2026-2030 income growth uniform-----------
#rgdx.param("1250indfas2026.gdx",readlist)
EVdispinc <- rgdx.param("frem1250_uniformincgrowth",'EVdispinc_diff')
EVexp     <- rgdx.param("frem1250_uniformincgrowth",'EVexp_diff')

EVplots <- list()
for (p in 1:2) {
  if (p==1){
    v <- spread(EVexp,key=i, value=EVexp_diff)
    title = "Expenditure"
  }
  if (p==2){
    v <- spread(EVdispinc,key=i, value=EVdispinc_diff)
    title = "Disposable income"
  }
  
  v <- v %>%
    rename(Year = t)
  
  v$Year <- as.numeric(as.character(v$Year))
  
  # Adding zeros for year 2020-2025
  nuller=data.frame(Year=c(2020:2025),rep(0,6),rep(0,6),"3"=rep(0,6),"4"=rep(0,6),"5"=rep(0,6),"6"=rep(0,6))
  colnames(nuller)=c("Year",1,2,3,4,5,6)
  v=rbind(nuller,v)
  
  #Make in percent
  v[,-1]=v[,-1]*100
  
  v <- v %>%
    select(Year,1,2,3,4,5,6) %>%
    gather(key = "Quintile", value = "value", -Year)
  
  as_tibble(v)
  
  #Axis scale
  min=-2
  max=2
  
  EVplots[[p]]= ggplot(v, aes(x = Year, y = value)) + ggtitle(title)+ theme_bw() +ylim(min, max)+  theme(plot.title = element_text(size=10))+
    geom_line(aes(color = Quintile)) + 
    geom_point(aes(color=Quintile, shape=Quintile))+
    scale_color_manual(values = wes_palette("Zissou1", 5, type = "discrete"))+
    labs(y = "Pct.")
  
  if(p==1){
    bardata = filter(v, Year == 2030)}
  if(p==2){
    bardata = rbind(bardata,filter(v, Year == 2030))}
}
groupplot <- ggarrange(plotlist=EVplots, ncol=2, nrow=1, common.legend = TRUE, legend="right")

bardata$EV<- c( rep("As pct. of expenditure",5) , rep("As pct. of disposable income",5)  )
bardata$Quintile <- as.integer(as.factor(bardata$Quintile))

bardata= arrange(bardata, EV)
# Grouped bar chart
#Axis scale
min=-2
max=2

barplot <- ggplot(bardata, aes(fill=EV, y=value, x=Quintile)) + theme_bw()+ylim(min, max)+
  theme(plot.title = element_text(size=10))+ theme(legend.position="bottom")+
  geom_bar(position="dodge", stat="identity")+ 
  scale_fill_manual(values = wes_palette("Cavalcanti1", 5, type = "discrete"))+
  labs(y = "Pct.")

ggsave(
  "timeEV_1250_indfas_unifincgrowth.pdf",
  plot = groupplot,
  device="pdf",
  width = 6,
  height = 4,
  units = c("in", "cm", "mm"),
  dpi = 300,
  limitsize = TRUE,
)

ggsave(
  "bar2030_1250_indfas_unifincgrowth.pdf",
  plot = barplot,
  device="pdf",
  width = 6,
  height = 4,
  units = c("in", "cm", "mm"),
  dpi = 300,
  limitsize = TRUE,
)



# Lav en stor fed sammenligningstabel ------------- 
EVdispinc_no <- rgdx.param("frem1250_noincgrowth",'EVdispinc_t',squeeze=FALSE)
EVexp_no     <- rgdx.param("frem1250_noincgrowth",'EVexp_t',squeeze=FALSE)
w_no  <-       rgdx.param("frem1250_noincgrowth",'w_resul_t')
mu_no  <-      rgdx.param("frem1250_noincgrowth",'mu_resul_t')
dispinc_no  <- rgdx.param("frem1250_noincgrowth",'dispinc_resul_t')

EVdispinc_uni <- rgdx.param("frem1250_uniformincgrowth",'EVdispinc_diff',squeeze=FALSE)
EVexp_uni     <- rgdx.param("frem1250_uniformincgrowth",'EVexp_diff',squeeze=FALSE)
w_uni  <-      rgdx.param("frem1250_uniformincgrowth",'w_resul_t')
mu_uni  <-      rgdx.param("frem1250_uniformincgrowth",'mu_resul_t')
dispinc_uni  <- rgdx.param("frem1250_uniformincgrowth",'dispinc_resul_t')

EVdispinc_diff <- rgdx.param("frem1250_diffincgrowth",'EVdispinc_diff',squeeze=FALSE)
EVexp_diff   <- rgdx.param("frem1250_diffincgrowth",'EVexp_diff',squeeze=FALSE)
w_diff   <- rgdx.param("frem1250_diffincgrowth",'w_resul_t')
mu_diff  <- rgdx.param("frem1250_diffincgrowth",'mu_resul_t')
dispinc_diff  <- rgdx.param("frem1250_diffincgrowth",'dispinc_resul_t')

Storfeddata = data.frame(Decile = c(1,1,1,1,3,3,3,3,5,5,5,5), Year = c(rep(c(2018,2026,2030,2040),3))     ) 
#no
Storfeddata$w1_no =        filter(w_no,       k==2018 | k==2026 | k==2030 | k==2040, j==1, i==1 | i==3 |i==5)$value
Storfeddata$w5_no =        filter(w_no,       k==2018 | k==2026 | k==2030 | k==2040, j==5, i==1 | i==3 |i==5)$value
Storfeddata$exp_no =       filter(mu_no,      j==2018 | j==2026 | j==2030 | j==2040, i==1 | i==3 |i==5)$value/1000
Storfeddata$dispinc_no=    filter(dispinc_no, j==2018 | j==2026 | j==2030 | j==2040, i==1 | i==3 |i==5)$value/1000
Storfeddata$EVexp_no =     filter(EVexp_no,   t==2018 | t==2026 | t==2030 | t==2040, i==1 | i==3 |i==5)$EVexp_t*100
Storfeddata$EVdispinc_no = filter(EVdispinc_no,   t==2018 | t==2026 | t==2030 | t==2040, i==1 | i==3 |i==5)$EVdispinc_t*100
#uni
Storfeddata$w1_uni =        filter(w_uni,       k==2018 | k==2026 | k==2030 | k==2040, j==1, i==1 | i==3 |i==5)$value
Storfeddata$w5_uni =        filter(w_uni,       k==2018 | k==2026 | k==2030 | k==2040, j==5, i==1 | i==3 |i==5)$value
Storfeddata$exp_uni =       filter(mu_uni,      j==2018 | j==2026 | j==2030 | j==2040, i==1 | i==3 |i==5)$value/1000
Storfeddata$dispinc_uni=    filter(dispinc_uni, j==2018 | j==2026 | j==2030 | j==2040, i==1 | i==3 |i==5)$value/1000
Storfeddata$EVexp_uni =     filter(EVexp_uni,   t==2018 | t==2026 | t==2030 | t==2040, i==1 | i==3 |i==5)$EVexp_diff*100
Storfeddata$EVdispinc_uni = filter(EVdispinc_uni,   t==2018 | t==2026 | t==2030 | t==2040, i==1 | i==3 |i==5)$EVdispinc_diff*100
#diff
Storfeddata$w1_diff =        filter(w_diff,       k==2018 | k==2026 | k==2030 | k==2040, j==1, i==1 | i==3 |i==5)$value
Storfeddata$w5_diff =        filter(w_diff,       k==2018 | k==2026 | k==2030 | k==2040, j==5, i==1 | i==3 |i==5)$value
Storfeddata$exp_diff =       filter(mu_diff,      j==2018 | j==2026 | j==2030 | j==2040, i==1 | i==3 |i==5)$value/1000
Storfeddata$dispinc_diff=    filter(dispinc_diff, j==2018 | j==2026 | j==2030 | j==2040, i==1 | i==3 |i==5)$value/1000
Storfeddata$EVexp_diff =     filter(EVexp_diff,   t==2018 | t==2026 | t==2030 | t==2040, i==1 | i==3 |i==5)$EVexp_diff*100
Storfeddata$EVdispinc_diff = filter(EVdispinc_diff,   t==2018 | t==2026 | t==2030 | t==2040, i==1 | i==3 |i==5)$EVdispinc_diff*100

write.xlsx(Storfeddata,"storfedtabel.xlsx",)
# Lav en sammenligningstabel for w'erne - ingen skatteændringer

w_no = rgdx.param("notax_nog",'w_resul_t')
w_uni = rgdx.param("notax_unig",'w_resul_t')
w_diff = rgdx.param("notax_diffg",'w_resul_t')

wtab_data = data.frame(Decile = c(1,1,1,3,3,3,5,5,5), Year = c(rep(c(2018,2030,2040),3))     ) 
wtab_data$w1_no =          filter(w_no,       k==2018 | k==2030 | k==2040, j==1, i==1 | i==3 |i==5)$value
wtab_data$w2_no =          filter(w_no,       k==2018 | k==2030 | k==2040, j==2, i==1 | i==3 |i==5)$value
wtab_data$w3_no =          filter(w_no,       k==2018 | k==2030 | k==2040, j==3, i==1 | i==3 |i==5)$value
wtab_data$w4_no =          filter(w_no,       k==2018 | k==2030 | k==2040, j==4, i==1 | i==3 |i==5)$value
wtab_data$w5_no =          filter(w_no,       k==2018 | k==2030 | k==2040, j==5, i==1 | i==3 |i==5)$value
wtab_data$w6_no =          filter(w_no,       k==2018 | k==2030 | k==2040, j==6, i==1 | i==3 |i==5)$value
wtab_data$w7_no =          filter(w_no,       k==2018 | k==2030 | k==2040, j==7, i==1 | i==3 |i==5)$value
wtab_data$w8_no =          filter(w_no,       k==2018 | k==2030 | k==2040, j==8, i==1 | i==3 |i==5)$value

wtab_data$w1_uni =          filter(w_uni,       k==2018 | k==2030 | k==2040, j==1, i==1 | i==3 |i==5)$value
wtab_data$w2_uni =          filter(w_uni,       k==2018 | k==2030 | k==2040, j==2, i==1 | i==3 |i==5)$value
wtab_data$w3_uni =          filter(w_uni,       k==2018 | k==2030 | k==2040, j==3, i==1 | i==3 |i==5)$value
wtab_data$w4_uni =          filter(w_uni,       k==2018 | k==2030 | k==2040, j==4, i==1 | i==3 |i==5)$value
wtab_data$w5_uni =          filter(w_uni,       k==2018 | k==2030 | k==2040, j==5, i==1 | i==3 |i==5)$value
wtab_data$w6_uni =          filter(w_uni,       k==2018 | k==2030 | k==2040, j==6, i==1 | i==3 |i==5)$value
wtab_data$w7_uni =          filter(w_uni,       k==2018 | k==2030 | k==2040, j==7, i==1 | i==3 |i==5)$value
wtab_data$w8_uni =          filter(w_uni,       k==2018 | k==2030 | k==2040, j==8, i==1 | i==3 |i==5)$value

wtab_data$w1_diff =          filter(w_diff,       k==2018 | k==2030 | k==2040, j==1, i==1 | i==3 |i==5)$value
wtab_data$w2_diff =          filter(w_diff,       k==2018 | k==2030 | k==2040, j==2, i==1 | i==3 |i==5)$value
wtab_data$w3_diff =          filter(w_diff,       k==2018 | k==2030 | k==2040, j==3, i==1 | i==3 |i==5)$value
wtab_data$w4_diff =          filter(w_diff,       k==2018 | k==2030 | k==2040, j==4, i==1 | i==3 |i==5)$value
wtab_data$w5_diff =          filter(w_diff,       k==2018 | k==2030 | k==2040, j==5, i==1 | i==3 |i==5)$value
wtab_data$w6_diff =          filter(w_diff,       k==2018 | k==2030 | k==2040, j==6, i==1 | i==3 |i==5)$value
wtab_data$w7_diff =          filter(w_diff,       k==2018 | k==2030 | k==2040, j==7, i==1 | i==3 |i==5)$value
wtab_data$w8_diff =          filter(w_diff,       k==2018 | k==2030 | k==2040, j==8, i==1 | i==3 |i==5)$value

write.xlsx(wtab_data,"wtab.xlsx",)


# dekomponer CS på varer frem 1250 -----------
CS_g_exp     <- rgdx.param("frem1250_decomposeCS",'CS_g_exp')
CS_g_exp$CS_g_exp =-CS_g_exp$CS_g_exp*100  
CS_g_exp = filter(CS_g_exp, t==2030, i!=6)

CS_g_inc     <- rgdx.param("frem1250_decomposeCS",'CS_g_inc')
CS_g_inc$CS_g_inc =-CS_g_inc$CS_g_inc*100  
CS_g_inc = filter(CS_g_inc, t==2030, i!=6)

v=CS_g_exp

v$Composite = c(rep(c("1: Meat and dairy","2: Other foods","3: Housing","4: Energy for housing","5: Energy for transport","6: Transport","7: Other goods","8: Other services") , 5))
colnames(v)= c("Quintile","g","t","value","Composite")

plotexp <- ggplot(v, aes(fill=Composite, y=value, x=Quintile)) + theme_bw()  + 
  geom_bar(position=position_stack(reverse = TRUE), stat="identity", color="#222222", size=0.25)+
  scale_fill_manual(values = wes_palette("Rushmore", 8, type = "continuous"))+
   labs(y = "Pct. of total expenditure")

v=CS_g_inc

v$Composite = c(rep(c("1: Meat and dairy","2: Other foods","3: Housing","4: Energy for housing","5: Energy for transport","6: Transport","7: Other goods","8: Other services") , 5))
colnames(v)= c("Quintile","g","t","value","Composite")

plotinc<- ggplot(v, aes(fill=Composite, y=value, x=Quintile)) + theme_bw()  + 
  geom_bar(position=position_stack(reverse = TRUE), stat="identity", color="#222222", size=0.25)+
  scale_fill_manual(values = wes_palette("Rushmore", 8, type = "continuous"))+
  labs(y = "Pct. of disposable income")

CSdecomplst = list(plotexp,plotinc)

groupplot <- ggarrange(plotlist=CSdecomplst, ncol=2, nrow=1, common.legend = TRUE, legend="right")



ggsave(
  "cs_decomposed_exp.pdf",
  plot = plotexp,
  device="pdf",
  width =6 ,
  height = 4,
  units = c("in", "cm", "mm"),
  dpi = 300,
  limitsize = TRUE,
)

ggsave(
  "cs_decomposed_inc.pdf",
  plot = plotinc,
  device="pdf",
  width =6 ,
  height = 4,
  units = c("in", "cm", "mm"),
  dpi = 300,
  limitsize = TRUE,
)

ggsave(
  "cs_decomposed_grouped.pdf",
  plot = groupplot,
  device="pdf",
  width =6 ,
  height = 4,
  units = c("in", "cm", "mm"),
  dpi = 300,
  limitsize = TRUE,
)
