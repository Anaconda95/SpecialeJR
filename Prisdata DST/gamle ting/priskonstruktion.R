install.packages("readxl")
install.packages("dplyr")
library("readxl")
library("dplyr")

options(scipen=999)
df <- read_xlsx("priser1994-2000.xlsx")

df <-df %>% 
  mutate(Year = c(rep(1994,12),rep(1995,12),rep(1996,12),rep(1997,12),
                  rep(1998,12),rep(1999,12),rep(2000,12) ) )
df <- df %>% 
  group_by(Year) %>% 
  summarise(across(everything(), mean))


