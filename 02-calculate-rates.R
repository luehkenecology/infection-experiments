# set working directory
RPROJ <- list(PROJHOME = normalizePath(getwd()))
attach(RPROJ)
rm(RPROJ)
setwd(PROJHOME)

# read project
library(xlsx)

# read funtions
source("R/rates.R")

data <- read.table("output/albopictus_sub.csv", header = T)

ggg <- rates(albopictus_sub)
ggg2 <- ggg[ggg$dpi>1,]

