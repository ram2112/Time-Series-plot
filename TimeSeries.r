library(ggplot2)
library(xts)
library(gridExtra)

agg <- read.csv("AggInfl.csv",na.strings = "")

agg <- xts(x = agg[,-1], order.by = agg[,1])

agg <- xts(agg[,-1], order.by=as.Date(paste0(agg[,1],"-01-01")))

temp <- data.frame(index(agg),stack(as.data.frame(coredata(agg))))


names(temp)[1] <- "Year"
names(temp)[2] <- "Infl"
names(temp)[3] <- "Country"

p1 <- ggplot(temp,aes(x =Year, y=Infl, color=Country)) + geom_line()

p1 <- p1 + ylim(-10, 30)

p2 <- ggplot(temp,aes(x =Year, y=Infl, color=Country)) + geom_point()

p2 <- p2 + ylim(-10, 30)

p1 <- p1 + ggtitle("Aggregate Inflation Line Plot")

p2 <- p2 + ggtitle("Aggregate Inflation Point Plot")

p1 <- p1 + 
  theme(axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.x=element_text(color = "black",size=15),
        axis.text.y=element_text(color="black",size=15),
        panel.background=element_rect(fill = "white"),
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        axis.line = element_line(colour = "black", size = 1),
        plot.title = element_text(lineheight=.8, face="bold")) 

p2 <- p2 + 
  theme(axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.x=element_text(color = "black",size=15),
        axis.text.y=element_text(color="black",size=15),
        panel.background=element_rect(fill = "white"),
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        axis.line = element_line(colour = "black", size = 1),
        plot.title = element_text(lineheight=.8, face="bold")) 

grid.arrange(p1, p2, nrow=2, ncol=1)