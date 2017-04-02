library(ggplot2)
library(RJSONIO)
library(RCurl)
library(bitops)
# RFIDdata ----------------------------------------------------------------
h = basicTextGatherer()
curlPerform(url = "http://ec2-34-252-32-133.eu-west-1.compute.amazonaws.com/Hackday/rfid.php", 
            writefunction = h$update)
data <- t(data.frame(fromJSON(h$value())))
row.names(data) <- c(1:nrow(data))
RFIDdataFrame <- data.frame(data, stringsAsFactors = F)

RFIDdataFrame[,1] <- as.POSIXct(round(as.numeric(RFIDdataFrame[,1])/1000,0),
                                tz="Europe/Helsinki",
                                origin = '1970-01-01 00:00.00 EEST')



RFIDplotData <- data.frame(time = format(RFIDdataFrame$timestamp, "%H"))
p <- ggplot(RFIDplotData, aes(x=as.factor(time),fill=as.factor(1) )) + 
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


png("/var/www/html/Hackday/Kuvaajat/barPlot.png",bg = "transparent", type="cairo")
print(p)
dev.off()
