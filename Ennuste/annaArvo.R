fileConn<-file("values.txt")
pred <- readLines(fileConn)
ennuste <- as.numeric(pred[1])
cat(round(ennuste,2)*100) 