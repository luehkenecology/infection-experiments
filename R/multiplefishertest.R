fish_test_infection_rate<- function(test_results){
  test <- as.numeric(test_results$infection_rate)
  total <- rep(100, length(test))
  tt <- data.frame(pairwise.fisher.test(test, total, , p.adjust.method="bonferroni")$p.value)
  name_vector <- paste(test_results$species, test_results$origin, "temp", test_results$temperature, "dpi", test_results$dpi, sep = "_")
  colnames(tt) <- name_vector[1:max(length(name_vector))-1]
  cbind(experiment = name_vector[-1], tt)
}

fish_test_transmission_rate <- function(test_results){
  test <- as.numeric(test_results$transmission_rate)
  total <- rep(100, length(test))
  tt <- data.frame(pairwise.fisher.test(test, total, , p.adjust.method="bonferroni")$p.value)
  name_vector <- paste(test_results$species, test_results$origin, "temp", test_results$temperature, "dpi", test_results$dpi, sep = "_")
  colnames(tt) <- name_vector[1:max(length(name_vector))-1]
  cbind(experiment = name_vector[-1], tt)
}

fish_test_transmission_efficiency <- function(test_results){
  test <- test_results$transmission_efficiency
  total <- rep(100, length(test))
  tt <- data.frame(pairwise.fisher.test(test, total, , p.adjust.method="bonferroni")$p.value)
  name_vector <- paste(test_results$species, test_results$origin, "temp", test_results$temperature, "dpi", test_results$dpi, sep = "_")
  colnames(tt) <- name_vector[1:max(length(name_vector))-1]
  cbind(experiment = name_vector[-1], tt)
}

fish_test_transmission_efficacy_salvia_body <- function(test_results){
  test <- test_results$transmission_efficacy_salvia_body
  total <- rep(100, length(test))
  tt <- data.frame(pairwise.fisher.test(test, total, , p.adjust.method="bonferroni")$p.value)
  name_vector <- paste(test_results$species, test_results$origin, "temp", test_results$temperature, "dpi", test_results$dpi, sep = "_")
  colnames(tt) <- name_vector[1:max(length(name_vector))-1]
  cbind(experiment = name_vector[-1], tt)
}

fish_test_transmission_efficacy_salvia_total_input <- function(test_results){
  test <- test_results$transmission_efficacy_salvia_total_input
  total <- rep(100, length(test))
  tt <- data.frame(pairwise.fisher.test(test, total, , p.adjust.method="bonferroni")$p.value)
  name_vector <- paste(test_results$species, test_results$origin, "temp", test_results$temperature, "dpi", test_results$dpi, sep = "_")
  colnames(tt) <- name_vector[1:max(length(name_vector))-1]
  cbind(experiment = name_vector[-1], tt)
}