rates <- function(x){ 
  ddply(x, .(species, origin, virus, temperature, dpi), 
        
        #dfrm <- subset(culex_all_sub, species == "Culex torrentium" & temperature == 27 & dpi == 21)
        #dfrm$infection <- as.numeric(as.character(dfrm$infection))
        
        
        function(dfrm){
          # total number of specimens
          n_total_specimens  = nrow((dfrm[!duplicated(dfrm[,c(1,9)]),]))
          
          # number of positive bodies
          n_positive_bodies = sum(subset(dfrm[!duplicated(dfrm[,c(1,9,10)]),],
                                         body_part == "b")$infection, na.rm = T)
          
          # number of positive legs
          n_positive_legs = sum(subset(dfrm[!duplicated(dfrm[,c(1,9,10)]),],
                                       body_part == "l")$infection, na.rm = T)
          
          # number of positive saliva
          n_positive_saliva = sum(subset(dfrm[!duplicated(dfrm[,c(1,9,10)]),],
                                         body_part == "s")$infection, na.rm = T)
          
          # mean of titre
          titre_mean = mean(log10(subset(dfrm[!duplicated(dfrm[,c(1,9,10)]),],
                                         body_part == "b" & infection == 1)$titre*2.5*15), na.rm = T)
          
          titre_sd = sd(log10(subset(dfrm[!duplicated(dfrm[,c(1,9,10)]),],
                                     body_part == "b" & infection == 1)$titre*2.5*15), na.rm = T)
          
          return(data.frame(n_total_specimens = n_total_specimens,
                            n_positive_bodies = n_positive_bodies,
                            n_positive_legs = n_positive_legs,
                            n_positive_saliva = n_positive_saliva,
                            IR = n_positive_bodies/n_total_specimens*100,
                            DR = n_positive_legs/n_positive_bodies*100,
                            TR = n_positive_saliva/n_positive_bodies*100,
                            titre_mean = titre_mean,
                            titre_sd = titre_sd,
                            IR_out =  paste(formatC(round(n_positive_bodies/n_total_specimens*100, 2), 2, format = "f"),
                                            " (",
                                            n_positive_saliva,
                                            "/",
                                            n_positive_bodies,
                                            ")", sep = ""),
                            DR_out =  paste(formatC(round(n_positive_legs/n_positive_bodies*100, 2), 2, format = "f"),
                                            " (",
                                            n_positive_saliva,
                                            "/",
                                            n_positive_bodies,
                                            ")", sep = ""),
                            TR_out =  paste(formatC(round(n_positive_saliva/n_positive_bodies*100, 2), 2, format = "f"),
                                            " (",
                                            n_positive_saliva,
                                            "/",
                                            n_positive_bodies,
                                            ")", sep = ""),
                            titre_out = paste(formatC(round(titre_mean, 2), 2, format = "f"),
                                              " (",
                                              formatC(round(titre_sd, 2), 2, format = "f"),
                                              ")", sep = "")
          )
          )
        }
  )
}