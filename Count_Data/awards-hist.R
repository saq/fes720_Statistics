try(dev.off(),silent=TRUE)

#png('award-hist.png')
barplot(t(table(awards$num_awards, awards$program)), beside = TRUE, 
        xlab = 'Number of Awards', ylab = 'Count')
#dev.off()

