general <- function(data) {ddply(data, .(species, origin, temperature, virus), 
                                 function(dfrm)
                                   c(input_specimens = sum(dfrm[!duplicated(dfrm[,1,9,11]),]$input_total),
                                     blood_feeding_specimens = sum(dfrm[!duplicated(dfrm[,1,9,11]),]$blood_fed_total),
                                     blood_feeding_percentage = sum(dfrm[!duplicated(dfrm[,1,9,11]),]$blood_fed_total)/sum(dfrm[!duplicated(dfrm[,1,9,11]),]$input_total)*100,
                                     non_blood_feeding_specimens = sum(dfrm[!duplicated(dfrm[,1,9,11]),]$input_total)-sum(dfrm[!duplicated(dfrm[,1,9,11]),]$blood_fed_total),
                                     non_blood_feeding_percentage = (sum(dfrm[!duplicated(dfrm[,1,9,11]),]$input_total)-sum(dfrm[!duplicated(dfrm[,1,9,11]),]$blood_fed_total))/sum(dfrm[!duplicated(dfrm[,1,9,11]),]$input_total)*100,
                                     died_during_experiment_specimens = sum(dfrm[!duplicated(dfrm[,1,9,11]),]$blood_fed_total)-nrow((dfrm[!duplicated(dfrm[,c(1,9,11)]),])),
                                     died_during_experiment_percentage = (sum(dfrm[!duplicated(dfrm[,1,9,11]),]$blood_fed_total)-nrow((dfrm[!duplicated(dfrm[,c(1,9,11)]),]))/sum(dfrm[!duplicated(dfrm[,1,9,11]),]$blood_fed_total)*100,
                                     analysed_specimens = nrow((dfrm[!duplicated(dfrm[,c(1,9,11)]),])),
                                     percentage_analysed_specimens_input_specimens = nrow((dfrm[!duplicated(dfrm[,c(1,9,11)]),]))/sum(dfrm[!duplicated(dfrm[,1,9,11]),]$input_total)*100,
                                     percentage_analysed_specimens_blood_feeding_specimens = nrow((dfrm[!duplicated(dfrm[,c(1,9,11)]),]))/sum(dfrm[!duplicated(dfrm[,1,9,11]),]$blood_fed_total)*100,
                                     mean_ct_value = mean(dfrm$ct_value, na.rm = T),
                                     sd_ct_value = sd(dfrm$ct_value, na.rm = T),
                                     mean_titre = mean(dfrm$titre*2.5*15, na.rm = T),
                                     sd_titre = sd(dfrm$titre*2.5*15, na.rm = T))
                                 )
}
