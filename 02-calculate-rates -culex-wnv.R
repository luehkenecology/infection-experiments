# set working directory
RPROJ <- list(PROJHOME = normalizePath(getwd()))
attach(RPROJ)
rm(RPROJ)
setwd(PROJHOME)

# read library
library(plyr)

# read funtions
source("R/rates.R")

# read data
data <- read.table("output/culex_all_sub.csv", header = T, sep = ";")

# calculate rates
data_rates <- rates(data)

# only rates for dpi > 1 (why > 1 and not > 0???)
data_rates_sub <- data_rates[data_rates$dpi > 13 & data_rates$dpi < 22,]

# write results to ouput
write.table(data_rates_sub, "output/data_rates_culex-wnv.csv",
            col.names = T, row.names = F, sep = ";")
