# set working directory
RPROJ <- list(PROJHOME = normalizePath(getwd()))
attach(RPROJ)
rm(RPROJ)
setwd(PROJHOME)

# read library
library(ggplot2)

# read data
data <- read.table("output/data_rates_sub.csv", header = T, sep = ";")

#
ggplot(data, aes(as.factor(temperature), as.numeric(TR))) + 
  geom_point() +
  xlab("Temperature (°C)") + 
  ylab("Transmission rate (%)") +
  facet_wrap(~origin+dpi) + 
  theme_bw()

data$dpi <- revalue(as.character(data$dpi), c("14" = "14 dpi",
                                              "21" = "21 dpi"))

png("figure/tranmission_rate.png",width = 5, height=4, units = 'in', res = 2000)
ggplot(data, aes(as.factor(temperature), (as.numeric(TR)))) +
  geom_bar(fill = "black", col = "black", stat = "identity") +
  facet_wrap(~ origin+dpi) +
  geom_text(aes(label = paste(formatC(round(TR,2), 2, format = "f"), "%", sep = " "), 
                y = 0.5+(as.numeric(TR)) + 2.5), size = 3, 
            position =  position_dodge(width = 1)) +
  ylab("Transmission rate (%)") +
  xlab(expression("Temperature ("*degree*C*")")) +
  scale_y_continuous(limits = c(0,45), expand = c(0, 0)) +
  theme_bw()
dev.off()