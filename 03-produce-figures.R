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
ggplot(data, aes(as.factor(temperature), as.numeric(transmission_rate))) + 
  geom_point() +
  facet_wrap(~origin+dpi) + 
  theme_bw()
