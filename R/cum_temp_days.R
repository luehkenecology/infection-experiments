cum_temp_days <- function(values, time_period = 14, temp_thresh = 21){
  
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