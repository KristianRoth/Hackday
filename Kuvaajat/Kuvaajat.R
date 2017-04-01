setwd("C/Users/Joni/Hackday")
Sys.setenv(LANG = "en")
library(ggplot2)
library(ggthemes)

# Datan generointi --------------------------------------------------------

daySeq <- seq(as.Date('2017/01/01'), as.Date('2017/04/2'), by="day")

#Generate probabilities for days and times
dayProbs <- rep(c(runif(11),2,2,1,2,3,runif(30),1,1,1,runif(30),3,runif(12)))
day <- sort(sample(daySeq, 10000, replace = T, prob = dayProbs))

timeProbs <- c(runif(1),2,3,2.5,2,1.5,1,runif(17))
time <- sample(24,10000,T, prob= timeProbs)

dataBarPlot <- data.frame(day,time)

ghostClasses <- c("Delta","Asteriski"," Ewert Kupiainen","Graveyard")
ghosts <- sample(ghostClasses,10000,T,prob=c(1,1,0.2,0.3))

# Kuvaaja: Kummitukset vs aika --------------------------------------------
p <- ggplot(dataBarPlot, aes(x=as.factor(time),fill=as.factor(1) )) + 
  geom_bar() +
  scale_fill_manual(values=c("#9C3636")) +
  labs(x="", y="")+
  scale_x_discrete(breaks=c(5,10,15,20))+
  theme(legend.position="none",
        axis.text.x  = element_text(size=26, colour = "black"),
        axis.text.y  = element_text(size=26, colour = "black"),
        panel.background = element_rect(fill = "transparent", colour = NA),
        plot.background = element_rect(fill = "transparent", colour = NA),
        axis.ticks = element_blank(),
        panel.grid.minor=element_blank(),
        panel.grid.major.x=element_blank(),
        panel.grid.major.y=element_line(colour="black"))


png("barPlot.png",bg = "transparent", type="cairo")
print(p)
dev.off()


# Kuvaaja: xxx ------------------------------------------------------------

p<- ggplot(data.frame(day), aes(x=day)) +
  scale_x_date(day) +
  geom_line(stat="count", colour="#9C3636", size=1.5) +
  labs(x = "", y = "")+
  scale_y_continuous(breaks=c(200,400))+
  theme(legend.position="none",
        axis.text.x  = element_text(size=26, colour = "black"),
        axis.text.y  = element_text(size=26, colour = "black"),
        panel.background = element_rect(fill = "transparent", colour = NA),
        plot.background = element_rect(fill = "transparent", colour = NA),
        axis.ticks = element_blank(),
        panel.grid.minor=element_blank(),
        panel.grid.major.y=element_line(colour="black"),
        panel.grid.major.x=element_line(colour="black"))

png("linePlot.png",bg = "transparent", type="cairo")
print(p)
dev.off()



# Kuvaaja: Kummitusten laatu vs aika --------------------------------------

p <- ggplot(data.frame(time, ghosts), aes(x=time))+
  geom_bar(aes(fill="#9C3636")) +
  facet_wrap(~ghosts)+
  scale_x_continuous(breaks=c(10,20))+
  labs(x = "", y = "")+
  theme(legend.position="none",
        axis.text.x  = element_text(size=26, colour = "black"),
        axis.text.y  = element_text(size=26, colour = "black"),
        panel.background = element_rect(fill = "transparent", colour = NA),
        plot.background = element_rect(fill = "transparent", colour = NA),
        axis.ticks = element_blank(),
        panel.grid.minor=element_blank(),
        panel.grid.major.y=element_line(colour="black"),
        panel.grid.major.x=element_line(colour="black"),
        strip.text.x = element_text(size=20, colour = "black"),
        strip.background = element_rect(fill="transparent"))

png("facetPlot.png",bg = "transparent", type="cairo")
print(p)
dev.off()

