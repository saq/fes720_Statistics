
try(dev.off(),silent=TRUE)

stripchart(sparrow$Head~sparrow$Sex, 
           ylab = 'Head Size', xlab = 'Sex', font.lab = 2, cex.lab = 1.5,
           las = 1,
           vertical = TRUE, 
           method = 'jitter', 
           col = c('darkgrey', 'red'), pch = 21)

points(x = 1:2, y = tapply(sparrow$Head, sparrow$Sex, mean), 
       pch = 20, cex = 3)

