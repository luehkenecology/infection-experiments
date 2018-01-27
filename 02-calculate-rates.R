# set working directory
RPROJ <- list(PROJHOME = normalizePath(getwd()))
attach(RPROJ)
rm(RPROJ)
setwd(PROJHOME)

# read project
library(xlsx)

# read funtions
source("R/rates.R")

# read data
data <- read.table("output/albopictus_sub.csv", header = T)

data_rates <- rates(albopictus_sub)

# only rates
data_rates_sub <- data_rates[data_rates$dpi>1,]

# write results
write.table(data_rates_sub, "output/data_rates_sub.csv",
            col.names = T, row.names = F, sep = ";")


