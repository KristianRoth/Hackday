#!/usr/bin/env Rscript
fileConn<-file("values.txt")
pred <- readLines(fileConn)
pred <- list(ennuste = as.numeric(pred[1]), muutos = as.numeric(pred[2]))
muutos <- rnorm(1,pred$muutos/2,0.01)
ennuste <- max(min(pred$ennuste+muutos,0.95),0.05)
writeLines(c(as.character(ennuste),as.character(muutos)), fileConn)
print(c(ennuste,muutos))
close(fileConn)