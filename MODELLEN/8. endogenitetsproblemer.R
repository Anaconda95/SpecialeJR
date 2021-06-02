v <- indk_forb_kvint

v2 <- data.frame(Year=v$Year, Q1.Disposable.Income = v$Dispk1,Q2.Disposable.Income = v$Dispk2,
                 Q3.Disposable.Income = v$Dispk3,Q4.Disposable.Income = v$Dispk4, Q5.Disposable.Income = v$Dispk5,
                 Q1.Total.Consumption = v$Forbk1, Q2.Total.Consumption = v$Forbk2, Q3.Total.Consumption = v$Forbk3, 
                 Q4.Total.Consumption = v$Forbk4, Q5.Total.Consumption = v$Forbk5)

v <- v2 %>%
  gather(key = "Quintile", value = "value", -Year)

ggplot(v, aes(x = Year, y = value)) +
  geom_line(aes(color = Quintile, linetype = Quintile)) + 
  scale_color_manual(values = c("darkred","darkred","steelblue", "steelblue","darkorange3","darkorange3","deeppink1","deeppink1","darkgreen","darkgreen"),)+
  scale_linetype_manual(values = c("solid","twodash", "solid", "twodash","solid","twodash","solid","twodash","solid","twodash"))+
  scale_size_manual(values=c(0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5))+
  labs(y = "DKK")
