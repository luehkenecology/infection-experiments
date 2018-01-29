# set working directory
RPROJ <- list(PROJHOME = normalizePath(getwd()))
attach(RPROJ)
rm(RPROJ)
setwd(PROJHOME)

# load libraries---------------------------------------------------------------------------
library(raster)
library(lubridate)
library(RcppRoll)
library(plyr)

# read eobs temperature data
testst <- lapply(2007:2016, function(x) stack(paste("output/eobs/tg_0.25deg_reg_v14.0_europe_", 
                                                     x, ".grd", sep = "")))


cropping_info <- c(-9, 25, 35, 55)

ell <- lapply(testst, function(x) crop(x, cropping_info))

el <- stack(ell)
#el <- stack(testst)

gdg2 <- getValues(el)

timeline <- function(start_year = 2007,end_year = 2016,
                     start_month = 1, end_month = 12,
                     start_day_of_month = 1, 
                     end_day_of_month = 31){
  
  A1<-paste(start_year, "-", start_month, "-", start_day_of_month, sep = "")
  A2<-paste(end_year, "-", end_month, "-", end_day_of_month, sep = "")
  time.s=as.POSIXct(A1,tz='UTC')
  time.e = as.POSIXct(A2,tz='UTC')
  seq(time.s, time.e, by='24 hours')
}

ee <- timeline(2007,2016)

ZIKA <- function(values, time_period = 14, temp_thresh = 21){

  DDU <- as.numeric(values)
  
  DDU2 <- roll_sum(DDU,n=time_period,
                  fill = 0, align = "right", na.rm = T)
  
  testfull<-data.frame(year = year(ee),
                       DDU = ifelse(DDU2 >= (time_period * temp_thresh), 1, 0))
  
  einsd <- ddply(testfull, "year",
                 summarize, 
                 sf = sum(DDU, na.rm = T))
  
  # output
  einsd$sf
}

ddd <- c(18, 21, 24, 27)

for(i in 1:4){
  
  zika_risk <- apply(gdg2, 1, function(x) ZIKA(x, 
                                               time_period = 14, 
                                               temp_thresh = ddd[i]))
  zika_risk_mean <- apply(zika_risk, 2, 
                          function(x) mean(x, na.rm = T))
  
  zika_mean_map <- setValues(el[[1]], 
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
