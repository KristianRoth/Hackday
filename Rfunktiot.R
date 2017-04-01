#Käytettävät kirjastot
library(ggplot2)
library(ggthemes)



set.seed(322)

# Kummitukset vs kellonaika -----------------------------------------------
aika <- sample(24,1000,T, prob=c(runif(1),2,4,3,2,runif(19)))
qplot(aika, geom="histogram", bins=24) +
  theme_few() +
  labs(x = "Aika", y = "Kummitusten määrä")
  

# Aikasarja kummituksista -------------------------------------------------
päivä <- sample(seq(as.Date('2017/01/01'), as.Date('2017/03/31'), by="day"),
                1000,
                T,
                prob = c(runif(50),4, runif(39)))


ggplot(data.frame(päivä), aes(x=päivä)) +
  scale_x_date(päivä, date_labels = "%b %d") +
  geom_line(stat="count") +
  theme_few() +
  labs(x = "Päivämäärä", y = "Havaittujen kummitusten määrä")



