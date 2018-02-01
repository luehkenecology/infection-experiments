# set working directory
RPROJ <- list(PROJHOME = normalizePath(getwd()))
attach(RPROJ)
rm(RPROJ)
setwd(PROJHOME)

# read project
library(xlsx)

culex_1_1 <- read.xlsx("data/Culex molestus 2017.xlsx", 1)
culex_1_2 <- read.xlsx("data/Culex molestus 2017.xlsx", 2)
culex_1_3 <- read.xlsx("data/Culex molestus 2017.xlsx", 3)
culex_1_4 <- read.xlsx("data/Culex molestus 2017.xlsx", 4)

culex_2_1 <- read.xlsx("data/Culex molestus.xlsx", 1)
culex_2_2 <- read.xlsx("data/Culex molestus.xlsx", 2)
culex_2_3 <- read.xlsx("data/Culex molestus.xlsx", 3)

culex_3_1 <- read.xlsx("data/Culex pip 2017.xlsx", 1)
culex_3_2 <- read.xlsx("data/Culex pip 2017.xlsx", 2)
culex_3_3 <- read.xlsx("data/Culex pip 2017.xlsx", 3)

culex_4_1 <- read.xlsx("data/Culex pip pip.xlsx", 1)
culex_4_2 <- read.xlsx("data/Culex pip pip.xlsx", 2)

culex_5_1 <- read.xlsx("data/Culex torr 2017.xlsx", 1)
culex_5_2 <- read.xlsx("data/Culex torr 2017.xlsx", 2)
culex_5_3 <- read.xlsx("data/Culex torr 2017.xlsx", 3)

culex_6_1 <- read.xlsx("data/Culex torrentium.xlsx", 1)
culex_6_2 <- read.xlsx("data/Culex torrentium.xlsx", 2)

culex_1_1_2 <- culex_1_1[ !is.na(culex_1_1[,2]), ]
culex_1_2_2 <- culex_1_2[ !is.na(culex_1_2[,2]), ]
culex_1_3_2 <- culex_1_3[ !is.na(culex_1_3[,2]), ]
culex_1_4_2 <- culex_1_4[ !is.na(culex_1_4[,2]), ]
culex_2_1_2 <- culex_2_1[ !is.na(culex_2_1[,2]), ]
culex_2_2_2 <- culex_2_2[ !is.na(culex_2_2[,2]), ]
culex_2_3_2 <- culex_2_2[ !is.na(culex_2_3[,2]), ]
culex_3_1_2 <- culex_3_1[ !is.na(culex_3_1[,2]), ]
culex_3_2_2 <- culex_3_2[ !is.na(culex_3_2[,2]), ]
culex_3_3_2 <- culex_3_3[ !is.na(culex_3_3[,2]), ]
culex_4_1_2 <- culex_4_1[ !is.na(culex_4_1[,2]), ]
culex_4_2_2 <- culex_4_2[ !is.na(culex_4_2[,2]), ]
culex_5_1_2 <- culex_5_1[ !is.na(culex_5_1[,2]), ]
culex_5_2_2 <- culex_5_2[ !is.na(culex_5_2[,2]), ]
culex_5_3_2 <- culex_5_3[ !is.na(culex_5_3[,2]), ]
culex_6_1_2 <- culex_6_1[ !is.na(culex_6_1[,2]), ]
culex_6_2_2 <- culex_6_2[ !is.na(culex_6_2[,2]), ]

# removing columns with only NAs
culex_all <- data.frame(rbind(culex_1_1_2[,-c(1,21:22)],
                              culex_1_2_2[,-c(1,21)],
                              culex_1_3_2[,-c(1,21:22)],
                              culex_1_4_2[,-c(1,21:22)],
                              culex_2_1_2[,-c(1,21:22)],
                              culex_2_2_2[,-c(1,21:22)],
                              culex_2_3_2[,-c(1,21:22)],
                              culex_3_1_2[,-c(1,21:22)],
                              culex_3_2_2[,-c(1,21:22)],
                              culex_3_3_2[,-c(1,21:22)],
                              culex_4_1_2[,-c(1,21:22)],
                              culex_4_2_2[,-c(1,21:22)],
                              culex_5_1_2[,-c(1,21:22)],
                              culex_5_2_2[,-c(1,21:22)],
                              culex_5_3_2[,-c(1,21)],
                              culex_6_1_2[,-c(1,21:22)],
                              culex_6_2_2[,-c(1,21:22)]))

# rename columns
dimnames(culex_all)[[2]] <- c("experiment_no", "start_date",     
                              "species", "origin",         
                              "temperature", "virus",        
                              "input_total", "blood_fed_total",
                              "specimens", "body_part", "dpi",           
                              "tube_id","ct_value",
                              "infection" , "titre",
                              "titre_method", "freezer",
                              "rack", "box")

culex_all_sub <- subset(culex_all, virus %in% c("WNV"))



culex_all_sub$infection <- as.numeric(as.character(culex_all_sub$infection))


culex_all_sub <- culex_all_sub[!(culex_all_sub$experiment_no == 20 & 
                                   culex_all_sub$temperature == 27 & 
                                   culex_all_sub$dpi == 21 &
                                   culex_all_sub$specimens == 3),]

culex_all_sub$titre_method <- ifelse(culex_all_sub$titre > 0 & 
                                       is.na(culex_all_sub$titre_method), 
                                     "PCR",
                                     as.character(culex_all_sub$titre_method))


culex_all_sub$infection2 <- ifelse(culex_all_sub$titre_method == "CPE" | culex_all_sub$titre_method == "CPE/PCR"  | culex_all_sub$titre_method == "CPE /PCR", culex_all_sub$infection, ifelse(culex_all_sub$titre_method == "PCR",ifelse(culex_all_sub$titre >=100, 1, 0), NA))
culex_all_sub$infection  <- culex_all_sub$infection2
dfdf <- subset(culex_all_sub, species == "Culex torrentium" & temperature == 27 & dpi == 21)
dfdf[,12:16]

write.table(culex_all_sub, "output/culex_all_sub.csv", 
            col.names = T, row.names = F, sep = ";")