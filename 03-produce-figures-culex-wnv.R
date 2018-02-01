# set working directory
RPROJ <- list(PROJHOME = normalizePath(getwd()))
attach(RPROJ)
rm(RPROJ)
setwd(PROJHOME)

# read library
library(ggplot2)

# read data
data <- read.table("output/data_rates_culex-wnv.csv", header = T, sep = ";")

#
ggplot(data, aes(as.factor(temperature), as.numeric(TR))) + 
  geom_point() +
  xlab("Temperature (°C)") + 
  ylab("Transmission rate (%)") +
  facet_wrap(~origin+dpi) + 
  theme_bw()

data$dpi <- revalue(as.character(data$dpi), c("14" = "14 dpi",
                                              "21" = "21 dpi"))

data$TR[is.na(as.numeric(data$TR))] <- 0

png("figure/tranmission_rate_wnv.png",width = 4, height=6.5, units = 'in', res = 2000)
ggplot(data, aes(as.factor(temperature), as.numeric(TR), fill = as.character(dpi))) +
  geom_bar(col = "black", stat = "identity", position=position_dodge()) +
  facet_wrap(~ species, nrow = 3) +
  geom_text(aes(label = paste(formatC(round(TR,2), 0, format = "f"), "%", sep = " "), 
                y = 0.5+(as.numeric(TR)) + 3), size = 3, 
            position =  position_dodge(width = 1)) +
  ylab("Transmission rate (%)") +
  xlab(expression("Temperature ("*degree*C*")")) +
  labs(fill='dpi') +
  scale_y_continuous(limits = c(0,100), expand = c(0, 0)) +
  theme_bw()
dev.off()