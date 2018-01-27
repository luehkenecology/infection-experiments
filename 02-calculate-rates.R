# set working directory
RPROJ <- list(PROJHOME = normalizePath(getwd()))
attach(RPROJ)
rm(RPROJ)
setwd(PROJHOME)

# read project
library(plyr)

# read funtions
source("R/rates.R")

# read data
data <- read.table("output/albopictus_sub.csv", header = T, sep = ";")

# calculate rates
data_rates <- rates(data)

# only rates for dpi > 1 (why > 1 and not > 0???)
data_rates_sub <- data_rates[data_rates$dpi>1,]

# write results to ouput
write.table(data_rates_sub, "output/data_rates_sub.csv",
            col.names = T, row.names = F, sep = ";")