rates <- function(x){ 
  ddply(x, .(species, origin, virus, temperature, dpi), 
        
        
     #dfrm <- subset(data, species=="Aedes albopictus" &
    #                 origin == "Freiburg, Germany" &
    #                   temperature ==27 & dpi ==14)
    # colnames(dfrm)
       
    
     
        function(dfrm) 
          c(infection_rate_A = sum(subset(dfrm, body_part == "b")$infection, na.rm = T),
            
            infection_rate_B = (nrow((dfrm[!duplicated(dfrm[,c(1,9,11)]),]))),
            
            infection_rate = sum(subset(dfrm, body_part == "b")$infection, na.rm = T)/
              (nrow((dfrm[!duplicated(dfrm[,c(1,9,11)]),])))*100,
            
            infection_rate_out = paste(sum(subset(dfrm, body_part == "b")$infection, na.rm = T),"/",
                                     (nrow((dfrm[!duplicated(dfrm[,c(1,9,11)]),]))),
                                     " (",
                                     format(round(sum(subset(dfrm, body_part == "b")$infection, na.rm = T)/
                                       (nrow((dfrm[!duplicated(dfrm[,c(1,9,11)]),])))*100, 1),nsmall = 1),
                                     ")",
                                   sep = ""),
            
            ####
            dissimination_rate_A = sum(subset(dfrm, body_part == "l")$infection, na.rm = T),
            dissimination_rate_B = sum(subset(dfrm, body_part == "b")$infection, na.rm = T),
            
            dissimination_rate = sum(subset(dfrm, body_part == "l")$infection, na.rm = T)/
              sum(subset(dfrm, body_part == "b")$infection, na.rm = T)*100,
            
            dissimination_rate_out  = paste( ifelse(sum(subset(dfrm, body_part == "l")$infection, na.rm = T) == 0,  0,
                                                    format(round(sum(subset(dfrm, body_part == "l")$infection, na.rm = T)/
                                                                   sum(subset(dfrm, body_part == "b")$infection, na.rm = T)*100, 1), nsmall = 2)),
                                           " (",
                                           sum(subset(dfrm, body_part == "l")$infection, na.rm = T),
                                           "/",
                                           sum(subset(dfrm, body_part == "b")$infection, na.rm = T),
                                                 ")", sep = ""),
            
          #  infection_rate_perc =  sum(subset(dfrm, body_part == "b")$infection, na.rm = T)/
          #    (nrow((dfrm[!duplicated(dfrm[,c(1,9)]),])))*100,
            
          transmission_rate_A = sum(subset(dfrm, body_part == "s")$infection, na.rm = T),
          transmission_rate_B = sum(subset(dfrm, body_part == "b")$infection, na.rm = T),
          
          transmission_rate = sum(subset(dfrm, body_part == "s")$infection, na.rm = T)/
                                                               sum(subset(dfrm, body_part == "b")$infection, na.rm = T)*100,
          
          
          transmission_rate_out  = paste(ifelse(sum(subset(dfrm, body_part == "s")$infection, na.rm = T) == 0,  0,
                                                formatC(round(sum(subset(dfrm, body_part == "s")$infection, na.rm = T)/
                                                               sum(subset(dfrm, body_part == "b")$infection, na.rm = T)*100, 1), 2, format = "f")),
                                    " (",
                                    sum(subset(dfrm, body_part == "s")$infection, na.rm = T),
                                    "/",
                                    sum(subset(dfrm, body_part == "b")$infection, na.rm = T),
                                    ")", sep = ""),
          
          #titreMEAN = mean(log10(dfrm$titre*2.5*15), na.rm = T),
          
          #titreSD = sd(log10(dfrm$titre*2.5*15), na.rm = T),
          
          titreMEAN = mean(log10(subset(dfrm, body_part == "b" & infection == 1)$titre*2.5*15), na.rm = T),
          
          titreSD = sd(log10(subset(dfrm, body_part == "b" & infection == 1)$titre*2.5*15), na.rm = T),
          
          titre_out =  paste(format(round(mean(log10(subset(dfrm, body_part == "b" & infection == 1)$titre*2.5*15), na.rm = T), 2), nsmall = 1),
                             " (",
                             format(round(sd(log10(subset(dfrm, body_part == "b" & infection == 1)$titre*2.5*15), na.rm = T), 2), nsmall = 1),
                             ")", sep = "")
          
  
            #transmission_efficacy_salvia_body = ifelse(sum(subset(dfrm, body_part == "s")$infection, na.rm = T) == 0 & 
            #                             sum(subset(dfrm, body_part == "b")$infection, na.rm = T) == 0,  0,
            #                           sum(subset(dfrm, body_part == "s")$infection, na.rm = T)/
            #                             sum(subset(dfrm, body_part == "b")$infection, na.rm = T)*100),
            
            #transmission_efficacy_salvia_total_input = ifelse(sum(subset(dfrm, body_part == "s")$infection, na.rm = T) == 0 & 
            #                                                    sum(dfrm[!duplicated(dfrm[1:7]),]$input_total) == 0,  0,
            #                           sum(subset(dfrm, body_part == "s")$infection, na.rm = T)/
            #                             sum(dfrm[!duplicated(dfrm[1:7]),]$input_total)*100)#,
            #DIR1 = ifelse(sum(subset(dfrm, body_part == "l")$infection, na.rm = T) == 0 & 
            #                sum(subset(dfrm, body_part == "b")$infection, na.rm = T) == 0,  0,
            #              sum(subset(dfrm, body_part == "l")$infection, na.rm = T)/
            #                sum(subset(dfrm, body_part == "b")$infection, na.rm = T)*100),
            #DIR2 = ifelse(sum(subset(dfrm, body_part == "l")$infection, na.rm = T) == 0 & 
            #                (unique(dfrm$blood_fed_specimens)-unique(dfrm$dead_specimens)) == 0, 0, 
            #              sum(subset(dfrm, body_part == "l")$infection, na.rm = T)/
            #                (unique(dfrm$blood_fed_specimens)-unique(dfrm$dead_specimens))*100)
          )
  )
}