# set working directory
RPROJ <- list(PROJHOME = normalizePath(getwd()))
attach(RPROJ)
rm(RPROJ)
setwd(PROJHOME)

# read library
library(ggplot2)

# read data
data <- read.table("output/data_rates_culex-wnv.csv", header = T, sep = ";")


data$dpi <- revalue(as.character(data$dpi), c("14" = "14 dpi",
                                              "21" = "21 dpi"))

data$TR[is.na(as.numeric(data$TR))] <- 0

data_sub <- subset(data, temperature > 18)
addd <- data_sub[1:2,] 
addd$temperature <- 21
addd$TR <- NA
data_sub2 <- rbind(data_sub, addd)

data_sub2$titles <- paste(formatC(round(data_sub2$TR,2), 0, format = "f"), "%", sep = " ")
data_sub2$titles[17:18] <- "NA"
data_sub2$height_text <- ifelse(is.na(as.numeric(data_sub2$TR)), 3.5, 0.5+as.numeric(data_sub2$TR) + 3)
data_sub2$TR[is.na(data_sub2$TR)] <- 0

levels(data_sub2$species)= c("Culex pipiens molestus"=expression(paste(italic("Culex pipiens pipiens "), "biotype ", italic("molestus"))),
                             "Culex pipiens pipiens"=expression(paste(italic("Culex pipiens pipiens "), "biotype ", italic("pipiens"))),
                             "Culex torrentium"=expression(italic("Culex torrentium")))

png("figure/TR-wnv.png",width = 4, height=6.5, units = 'in', res = 2000)
ggplot(data_sub2, aes(as.factor(temperature), as.numeric(TR), fill = as.character(dpi))) +
  geom_bar(col = "black", stat = "identity", position=position_dodge()) +
  facet_wrap(~ species,labeller=label_parsed, ncol = 1) +
  #geom_text(aes(label = paste(formatC(round(TR,2), 0, format = "f"), "%", sep = " "), 
  #              y = 0.5+as.numeric(TR) + 3), size = 3, 
  #          position =  position_dodge(width = 1)) +
  geom_text(aes(label = titles, 
                y = height_text), size = 3, 
            position =  position_dodge(width = 1)) +
  ylab("Transmission rate (%)") +
  xlab(expression("Temperature ("*degree*C*")")) +
  labs(fill='dpi') +
  scale_y_continuous(limits = c(0,100), expand = c(0, 0)) +
  scale_fill_manual(values=c("gray", "black"))+
  theme_bw()
dev.off()


data_sub <- subset(data, temperature > 18)
addd <- data_sub[1:2,] 
addd$temperature <- 21
addd$TE <- NA
data_sub2 <- rbind(data_sub, addd)


data_sub2$titles <- paste(formatC(round(data_sub2$TE,2), 0, format = "f"), "%", sep = " ")
data_sub2$titles[17:18] <- "NA"
data_sub2$height_text <- ifelse(is.na(as.numeric(data_sub2$TE)),3.5/100*30 , as.numeric(data_sub2$TE) + 3.5/100*30)
data_sub2$TE[is.na(data_sub2$TE)] <- 0

levels(data_sub2$species)= c("Culex pipiens molestus"=expression(paste(italic("Culex pipiens pipiens "), "biotype ", italic("molestus"))),
                             "Culex pipiens pipiens"=expression(paste(italic("Culex pipiens pipiens "), "biotype ", italic("pipiens"))),
                             "Culex torrentium"=expression(italic("Culex torrentium")))

png("figure/TE-wnv.png",width = 4, height=6.5, units = 'in', res = 2000)
ggplot(data_sub2, aes(as.factor(temperature), as.numeric(TE), fill = as.character(dpi))) +
  geom_bar(col = "black", stat = "identity", position=position_dodge()) +
  facet_wrap(~ species,labeller=label_parsed, ncol = 1) +
  geom_text(aes(label = titles, 
                y = height_text), size = 3, 
            position =  position_dodge(width = 1)) +
  ylab("Transmission efficiency (%)") +
  xlab(expression("Temperature ("*degree*C*")")) +
  labs(fill='dpi') +
  scale_y_continuous(limits = c(0, 30), expand = c(0, 0)) +
  scale_fill_manual(values=c("gray", "black"))+
  theme_bw()
dev.off()