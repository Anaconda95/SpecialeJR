#clear workspace
rm(list=ls())

library("readxl")
library("dplyr")

options(scipen=999)
fu02 <- read_xlsx("fu02_loebpris.xlsx")
df <- read_xlsx("decildata.xlsx")

#FØDEVARER OG IKKE-ALKOHOL
varegrupper = list(1, 1111,1112,1113,1114,1115,1116,1117,1118,
                   1121,1122,1123,1124,1125,1126,1127,1128,
                   1131,1132,1133,1134,1135,1136,
                   1141,1142,1143,1144,1145,1146,1147,
                   1151,1152,1153,1154,1155,
                   1161,1162,1163,1164,
                   1171,1172,1173,1174,1175,1176,
                   1181,1182,1183,1184,1185,1186,
                   1191,1192,1193,1194,1199,
                   1211,1212,1213,1221,1222,1223)

df_ny <- data.frame(decil=c("Samlet",1,2,3,4,5,6,7,8,9,10))

df_ny <- df_ny %>% 
  mutate(fisk = df %>% 
  select(starts_with("113")) %>% 
  rowSums())

df_ny <- df_ny %>% 
  mutate(ost2 = df %>% 
  select(starts_with("114")) %>% 
  rowSums())

df_ny <- df_ny %>%
  mutate(ost= 
  df %>%
  select(starts_with("114")) %>%
  rowSums()
  )

for (i in varegrupper) {
  nam <- paste0("A_", i)
  df %>%
     mutate( ost = df %>% 
     select(starts_with("113")) %>%  
     rowSums())
}

for (lag_size in c(1, 5, 10, 15, 20)) {
  
  new_col_name <- paste0("lag_result_", lag_size)
  
  grouped_data <- grouped_data %>% 
    mutate(!!sym(new_col_name) := lag(Result, n = lag_size, default = NA))
}

require(data.table)
DT <- data.table(x=1:4, skill_a=c(0,1,0,0), skill_b=c(0,1,1,0), skill_c=c(0,1,1,1))


DT %>% mutate(count = DT %>% select(starts_with("skill_")) %>% rowSums())


library(tidyverse)

df <- tibble(
  column1 = rnorm(100),
  column2 = rnorm(100),
  column3 = rnorm(100),
  column4 = rnorm(100),
  column5 = rnorm(100),
  data1 = rnorm(100),
  data2 = rnorm(100)
)

df2 <- df %>%
  mutate_at(. , vars(starts_with("column")), funs(prod1 = . * data1, prod2 = . * data2))

