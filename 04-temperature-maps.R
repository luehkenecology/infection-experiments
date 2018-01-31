# set working directory---------------------------------------------------------------------------
RPROJ <- list(PROJHOME = normalizePath(getwd()))
attach(RPROJ)
rm(RPROJ)
setwd(PROJHOME)

# load libraries---------------------------------------------------------------------------
library(raster)
library(lubridate)
library(RcppRoll)
library(plyr)

# load function---------------------------------------------------------------------------
source("R/timeline.R")
source("R/cum_temp_days.R")


# read a decade of eobs temperature data
eobs_data <- lapply(2007:2016, function(x) stack(paste("output/eobs/tg_0.25deg_reg_v14.0_europe_", 
                                                     x, ".grd", sep = "")))

# cropping information
cropping_info <- c(-9, 25, 35, 55)

# crop temperature files
eobs_data_crop <- lapply(eobs_data, function(x) crop(x, cropping_info))

# stack the 10 years
eobs_data_crop_stack <- stack(eobs_data_crop)

# change raster to matrix
eobs_data_matrix <- getValues(eobs_data_crop_stack)

# caculate timeline from 2007 to 2016
ee <- timeline(2007, 2016)


# temps
ddd <- c(18, 21, 24, 27)

for(i in 1:4){
  
  zika_risk <- apply(eobs_data_matrix, 1, function(x) cum_temp_days(x, 
                                               time_period = 14, 
                                               temp_thresh = ddd[i]))
  zika_risk_mean <- apply(zika_risk, 2, 
                          function(x) mean(x, na.rm = T))
  
  zika_mean_map <- setValues(eobs_data_crop_stack[[1]], 
                             zika_risk_mean)

  writeRaster(zika_mean_map,
              filename=paste("output/mean_temp_14dpi_",ddd[i],"C.grd", sep = ""),
              bandorder='BIL', overwrite=TRUE)
}

zika_risk <- apply(gdg2, 1, function(x) ZIKA(x, 
                                             time_period = 28, 
                                             temp_thresh = 21))
zika_risk_mean <- apply(zika_risk, 2, 
                        function(x) mean(x, na.rm = T))

zika_mean_map <- setValues(el[[1]], 
                           zika_risk_mean)
plot(zika_mean_map>1)
