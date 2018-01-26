# set working directory
RPROJ <- list(PROJHOME = normalizePath(getwd()))
attach(RPROJ)
rm(RPROJ)
setwd(PROJHOME)

# read project
library(xlsx)

#
albopictus1 <- read.xlsx("data/Aedes albopictus Deutschland.xlsx", 1)
albopictus2 <- read.xlsx("data/Aedes albopictus Deutschland.xlsx", 2)
albopictus3 <- read.xlsx("data/Aedes albopictus Deutschland.xlsx", 3)
albopictus4 <- read.xlsx("data/Aedes albopictus Deutschland.xlsx", 4)
albopictus5 <- read.xlsx("data/Aedes albopictus Italien 2017.xlsx", 1)
albopictus6 <- read.xlsx("data/Aedes albopictus Italien 2017.xlsx", 2)


