rates <- function(x){ 
  ddply(x, .(species, origin, virus, temperature, dpi), 
        
        #dfrm <- subset(data, species=="Aedes albopictus" &
        #                     origin == "Freiburg, Germany" &
        #                    temperature ==24 & dpi ==14)
        
        function(dfrm){
          # total number of specimens
          n_total_specimens  = nrow((dfrm[!duplicated(dfrm[,c(1,9)]),]))
          
          # number of positive bodies
          n_positive_bodies = sum(subset(dfrm[!duplicated(dfrm[,c(1,9,10)]),], body_part == "b")$infection, na.rm = T)
          
          # number of positive legs
          n_positive_legs = sum(subset(dfrm[!duplicated(dfrm[,c(1,9,10)]),], body_part == "l")$infection, na.rm = T)
          
          # number of positive saliva
          n_positive_saliva = sum(subset(dfrm[!duplicated(dfrm[,c(1,9,10)]),], body_part == "s")$infection, na.rm = T)
          
          
          titre_mean = mean(log10(subset(dfrm[!duplicated(dfrm[,c(1,9,10)]),], body_part == "b" & infection == 1)$titre*2.5*15), na.rm = T)
          
          titre_sd = sd(log10(subset(dfrm[!duplicated(dfrm[,c(1,9,10)]),], body_part == "b" & infection == 1)$titre*2.5*15), na.rm = T)
          
          return(data.frame(n_total_specimens = n_total_specimens,
                            n_positive_bodies = n_positive_bodies,
                            n_positive_legs = n_positive_legs,
                            n_positive_saliva = n_positive_saliva,
                            IR = n_positive_bodies/n_total_specimens*100,
                            DR = n_positive_legs/n_positive_bodies*100,
                            TR = n_positive_saliva/n_positive_bodies*100,
                            titre_mean = titre_mean,
                            titre_sd = titre_sd)
          ) 
        }
  )
}