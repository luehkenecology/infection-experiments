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
data <- read.table("output/albopictus_sub.csv", header = T, sep = ";")

# calculate rates
data_rates <- rates(data)

# write results to ouput
write.table(data_rates, "output/data_rates_sub2.csv",
            col.names = T, row.names = F, sep = ";")

dfdf <- function(n_positive_bodies, n_positive_saliva){
  data.frame(transmission_rate  = paste(formatC(round(as.numeric(data_rates$transmission_rate_A)/as.numeric(data_rates$transmission_rate_B)*100, 2), 2, format = "f"),
                             " (",
                             data_rates$transmission_rate_A,
                             "/",
                             data_rates$infection_rate_A,
                             ")", sep = ""))
}

dfdf(n_positive_bodies = data_rates$infection_rate_A,
     n_positive_saliva = data_rates$transmission_rate_A)


# only rates for dpi > 1 (why > 1 and not > 0???)
data_rates_sub <- data_rates[data_rates$dpi>1,]

# write results to ouput
write.table(data_rates_sub, "output/data_rates_sub.csv",
            col.names = T, row.names = F, sep = ";")