rm(list=ls())


IO2017 <- read_xlsx("C:/specialeJR/Input Output/NIO2017.xlsx", sheet="Io2017")

### Så skal vi vel på en måde lave fra 117-grupperingen til 8 grupperingen. 

gruppe1 <- IO2017 %>% select(starts_with("01120"),starts_with("01130"), starts_with("0114"))

gruppe2 <- IO2017 %>% select(starts_with("01110"),starts_with("0115"), starts_with("0115"),starts_with("0116"),starts_with("0117"),starts_with("0118"),starts_with("0119"),
                             starts_with("0121"),starts_with("0122"), starts_with("021"), starts_with("022"), starts_with("023"), starts_with("0290"))


gruppe3 <- IO2017 %>% select(starts_with("04100"),starts_with("04200"),starts_with("04300"),starts_with("04401"), starts_with("0441"), starts_with("0443"), starts_with("0444"))



gruppe4 <- IO2017 %>% select(starts_with("045"))


gruppe5 <- IO2017 %>% select(starts_with("0722"))

gruppe6 <- IO2017 %>% select(starts_with("071"),starts_with("0721"), starts_with("0724"),
                             starts_with("073"))

gruppe7 <- IO2017 %>% select(starts_with("0311"),starts_with("0313"), starts_with("0320"), starts_with("0321"),
                             starts_with("051"),starts_with("052"),starts_with("053"), starts_with("054"), starts_with("055"),
                             starts_with("0561"), starts_with("061"),starts_with("091"),starts_with("092"),starts_with("093"),
                             starts_with("095"),starts_with("1212"),starts_with("123"))

gruppe8 <- IO2017 %>% select(starts_with("04402"),starts_with("03140"),starts_with("0442"),starts_with("0562"),starts_with("062"),starts_with("063"),
                             starts_with("08"),starts_with("094"),starts_with("096"),starts_with("10"),starts_with("11"),
                             starts_with("1211"),starts_with("122"),starts_with("124"),starts_with("125"),starts_with("126"),starts_with("127"))


samlet = cbind(gruppe1,gruppe2,gruppe3,gruppe4,gruppe5,gruppe6,gruppe7,gruppe8)


brancher <- IO2017["Brancher"]


brancher[,"kod_fisk_mej"] = rowSums(gruppe1)
brancher[,"ovr_fode"] = rowSums(gruppe2)
brancher[,"bol"] = rowSums(gruppe3)
brancher[,"ene_hje"] = rowSums(gruppe4)
brancher[,"ene_tra"] = rowSums(gruppe5)
brancher[,"tra"] =rowSums(gruppe6)
brancher[,"ovr_var"] = rowSums(gruppe7)
brancher[,"ovr_tje"] = rowSums(gruppe8)

sum1 = sum(subset(brancher, select = -c(Brancher)))
sum2 = sum(subset(IO2017, select = -c(Brancher)) )


write.csv(brancher, "C:/specialeJR/Input output/Brancher_til_8grup.csv", row.names = FALSE)

