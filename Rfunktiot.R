#Libraries to use
library(RJSONIO)
library(RCurl)

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

#tail(RFIDdataFrame)

# Movementdata ------------------------------------------------------------
h = basicTextGatherer()
curlPerform(url = "http://ec2-34-252-32-133.eu-west-1.compute.amazonaws.com/Hackday/movement.php", 
            writefunction = h$update)

data <- t(data.frame(fromJSON(h$value())))
row.names(data) <- c(1:nrow(data))
MovementdataFrame <- data.frame(data, stringsAsFactors = F)

MovementdataFrame[,1] <- as.POSIXct(round(as.numeric(MovementdataFrame[,1])/1000,0),
                                tz="Europe/Helsinki",
                                origin = '1970-01-01 00:00.00 EEST')

#tail(MovementdataFrame)

# Bluetoothdata -----------------------------------------------------------
h = basicTextGatherer()
curlPerform(url = "http://ec2-34-252-32-133.eu-west-1.compute.amazonaws.com/Hackday/bluetooth.php", 
            writefunction = h$update)
data <- fromJSON(h$value())
data <- data.frame(t(sapply(data,c)))
BluetoothdataFrame <- data.frame(data, stringsAsFactors = F)

BluetoothdataFrame[,1] <- as.POSIXct(round(as.numeric(BluetoothdataFrame[,1])/1000,0),
                                    tz="Europe/Helsinki",
                                    origin = '1970-01-01 00:00.00 EEST')

#head(BluetoothdataFrame)
#tail(BluetoothdataFrame, 20)
