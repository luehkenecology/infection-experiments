# set working directory
RPROJ <- list(PROJHOME = normalizePath(getwd()))
attach(RPROJ)
rm(RPROJ)
setwd(PROJHOME)

# read project
library(xlsx)

# read
albopictus1 <- read.xlsx("data/Aedes albopictus Deutschland.xlsx", 1)
albopictus2 <- read.xlsx("data/Aedes albopictus Deutschland.xlsx", 2)
albopictus3 <- read.xlsx("data/Aedes albopictus Deutschland.xlsx", 3)
albopictus4 <- read.xlsx("data/Aedes albopictus Deutschland.xlsx", 4)
albopictus5 <- read.xlsx("data/Aedes albopictus Italien 2017.xlsx", 1)
albopictus6 <- read.xlsx("data/Aedes albopictus Italien 2017.xlsx", 2)

# delete rows of the NAs by NAs in the names of experiments
albopictus1_1 <- albopictus1[ !is.na(albopictus1[,2]), ]
albopictus2_1 <- albopictus2[ !is.na(albopictus2[,2]), ]
albopictus3_1 <- albopictus3[ !is.na(albopictus3[,2]), ]
albopictus4_1 <- albopictus4[ !is.na(albopictus4[,2]), ]
albopictus5_1 <- albopictus5[ !is.na(albopictus5[,2]), ]
albopictus6_1 <- albopictus6[ !is.na(albopictus6[,2]), ]

# delete columns only with NAs
albopictus_all <- data.frame(rbind(albopictus1_1[,-22],
                                   albopictus2_1[,-22],
                                   albopictus3_1,
                                   albopictus4_1,
                                   albopictus5_1[,-22],
                                   albopictus6_1[,-22]))

# delete row_no
albopictus_all_2 <- albopictus_all[,2:20]

# rename columns to fit the rates-function
dimnames(albopictus_all_2)[[2]] <- c("experiment_no",  "start_date",      "species" ,        "origin",         
                                   "temperature",     "virus",           "input_total",     "blood_fed_total",
                                   "specimens", "body_part", "dpi",             "tube_id" ,       
                                   "ct_value" ,       "infection"  ,     "titre" ,          "titre_method" ,  
                                   "freezer" ,        "rack",            "box" )  
