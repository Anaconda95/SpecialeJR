rm(list=ls())

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

setwd("~/Documents/GitHub/SpecialeJR /IO-analyse/Figurer")

##Reading results from GAMS
readlist = list(name='t')
#gdxInfo("dyn_partiel")
#GDX library load path: /Library/Frameworks/GAMS.framework/Versions/35/Resources/

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
