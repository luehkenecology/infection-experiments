# set working directory
RPROJ <- list(PROJHOME = normalizePath(getwd()))
attach(RPROJ)
rm(RPROJ)
setwd(PROJHOME)

# read project
library(xlsx)

albopictus_1_1 <- read.xlsx("data/Aedes albopictus calabria.xlsx", 1)
albopictus_1_2 <- read.xlsx("data/Aedes albopictus calabria.xlsx", 3)

albopictus_2_1 <- read.xlsx("data/Aedes albopictus Deutschland.xlsx", 1)
albopictus_2_2 <- read.xlsx("data/Aedes albopictus Deutschland.xlsx", 2)
albopictus_2_3 <- read.xlsx("data/Aedes albopictus Deutschland.xlsx", 3)
albopictus_2_4 <- read.xlsx("data/Aedes albopictus Deutschland.xlsx", 4)

albopictus_3_1 <- read.xlsx("data/Aedes albopictus Freiburg.xlsx", 1)
albopictus_3_2 <- read.xlsx("data/Aedes albopictus Freiburg.xlsx", 2)
albopictus_3_3 <- read.xlsx("data/Aedes albopictus Freiburg.xlsx", 3)

albopictus_4_1 <- read.xlsx("data/Aedes albopictus Italien 2017.xlsx", 1)
albopictus_4_2 <- read.xlsx("data/Aedes albopictus Italien 2017.xlsx", 2)

albopictus_1_1_2 <- albopictus_1_1[ !is.na(albopictus_1_1[,2]), ]
albopictus_1_2_2 <- albopictus_1_2[ !is.na(albopictus_1_2[,2]), ]
albopictus_2_1_2 <- albopictus_2_1[ !is.na(albopictus_2_1[,2]), ]
albopictus_2_2_2 <- albopictus_2_2[ !is.na(albopictus_2_2[,2]), ]
albopictus_2_3_2 <- albopictus_2_3[ !is.na(albopictus_2_3[,2]), ]
albopictus_2_4_2 <- albopictus_2_4[ !is.na(albopictus_2_4[,2]), ]
albopictus_3_1_2 <- albopictus_3_1[ !is.na(albopictus_3_1[,2]), ]
albopictus_3_2_2 <- albopictus_3_2[ !is.na(albopictus_3_2[,2]), ]
albopictus_3_3_2 <- albopictus_3_3[ !is.na(albopictus_3_3[,2]), ]
albopictus_4_1_2 <- albopictus_4_1[ !is.na(albopictus_4_1[,2]), ]
albopictus_4_2_2 <- albopictus_4_2[ !is.na(albopictus_4_2[,2]), ]

# removing columns with only NAs
albopictus_all <- data.frame(rbind(albopictus_1_1_2[,-c(1,21:22)],
                                   albopictus_1_2_2[,-c(1,21:22)],
                                   albopictus_2_1_2[,-c(1,21:22)],
                                   albopictus_2_2_2[,-c(1,21:22)],
                                   albopictus_2_3_2[,-c(1,21)],
                                   albopictus_2_4_2[,-c(1,21)],
                                   albopictus_3_1_2[,-c(1,21:22)],
                                   albopictus_3_2_2[,-c(1,21:22)],
                                   albopictus_3_3_2[,-c(1,21:22)],
                                   albopictus_4_1_2[,-c(1,21:22)],
                                   albopictus_4_2_2[,-c(1,21:22)]))

# rename columns
dimnames(albopictus_all)[[2]] <- c("experiment_no",  "start_date",     
                                   "species" ,        "origin",         
                                   "temperature",     "virus",        
                                   "input_total",     "blood_fed_total",
                                   "specimens", "body_part", "dpi",           
                                   "tube_id" ,       
                                   "ct_value" ,       "infection"  ,   
                                   "titre" ,          "titre_method" ,  
                                   "freezer" ,        "rack",         
                                   "box" )  

albopictus_sub <- subset(albopictus_all, virus %in% c("ZIKV"))
albopictus_sub$infection2 <- ifelse(albopictus_sub$titre_method == "CPE" | albopictus_sub$titre_method == "CPE/PCR", albopictus_sub$infection, ifelse(albopictus_sub$titre_method == "PCR",ifelse(albopictus_sub$ct_value <= 35, 1, 0), NA))
albopictus_sub$infection  <- albopictus_sub$infection2

write.table(albopictus_sub, "output/albopictus_sub.csv", 
            col.names = T, row.names = F, sep = ";")






# identify titres <= 1e+02 but infection = 0
ego <- cbind(albopictus_sub$titre>=1e+02, albopictus_sub$infection)
write.table(albopictus_sub[which((ego[,1] == ego[,2])==F),], "output/emp.csv")
