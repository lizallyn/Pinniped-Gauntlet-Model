## Set Up Variables ----
# with no more Px

### Blank arrays----

oneDzeroes <- makeArray(days, start.val = 0, names = "Day")

### Bundle Consumption Parameters ----

consumption_pars <- data.frame(matrix(data = NA, nrow = 3, ncol = 6))
colnames(consumption_pars) <- c("Species", "N", "Cmax", "alpha", "gamma", "Y")
consumption_pars$Species <- c("Pv", "Ej", "Zc")

### Salmon ----

empty_salmon_df <- data.frame(matrix(data = 0, nrow = n_days, ncol = ncol(salmon_arrival), dimnames = dimnames(salmon_arrival)))
empty_salmon_df$Day <- salmon_arrival$Day

salmon_list <- empty_salmon_df[-n_days,] # this ends up needing to be in loopdays
escape_salmon <- empty_salmon_df
fished_salmon <- empty_salmon_df
eaten_salmon <- empty_salmon_df
consumed_total <- rep(0, n_days)

### Seals ----

if(num_seals > 0) {
  
  twoDzeroes <- makeArray(c(num_seals, days), start.val = 0, names = c("Seal", "Day"))
  
  num_specialists <- round(num_seals * prop_specialists)
  # num_seals_2_copy <- num_seals/num_haulouts
  salmon_consumed_pv <- twoDzeroes
  seal_prob_gauntlet <- makeArray(c(num_seals, days), start.val = base_x, names = c("Seal", "Day"))
  seal_forage_loc <- twoDzeroes
  seals_at_gauntlet_save <- list(rep(NA, days))
  
  if(num_specialists == 0){
    specialist_seals <- NA
  } else {
    specialist_seals <- sample(1:num_seals, num_specialists)
  }
  seal_prob_gauntlet[specialist_seals] <- base_x_spec
  
  #social learning and network
  receptivity <- twoDzeroes
  receptivity_x <- twoDzeroes
  receptivity_y <- twoDzeroes
  
  base_x <- makeArray(c(num_seals, days), start.val = base_x, names = c("Seal", "Day"))
  base_x[specialist_seals,] <- base_x_spec
  x <- base_x
  y <- twoDzeroes
  C <- twoDzeroes
  P_x <- twoDzeroes
  P_y <- makeArray(c(num_seals, days), start.val = 1, names = c("Seal", "Day"))
  P_social <- twoDzeroes
  
  #for learnX
  step <- rep(step, num_seals)
  step[specialist_seals] <- step_spec
  
  #for learnY R-W&P
  risk_boat_pv <- twoDzeroes
  risk_hunt_pv <- twoDzeroes
  risk_g_pv <- twoDzeroes
  pred_risk_pv <- twoDzeroes
  
  harvest_days_pv <- harvest_days
  # harvest_days_pv <- harvest_days[which(harvest_days %in% 1:days)]
  harvest_plan_pv <- createHarvestPlan(scenario = scenario, 
                                       harvest_days = harvest_days_pv,
                                       empty.array = oneDzeroes)
  boat_days[which(harvest_plan_pv == scenario)] <- 1
  kill_list <- list()
  H <- oneDzeroes
  
  no_seals <- FALSE
} else {no_seals <- TRUE}


### California Sea Lions ----

if(num_zc > 0) {
  
  twoDzeroes_zc <- makeArray(c(num_zc, days), start.val = 0, names = c("CSL", "Day"))
  
  # num_zc_2_copy <- num_zc 
  salmon_consumed_zc <- twoDzeroes_zc
  zc_prob_gauntlet <- makeArray(c(num_zc, days), start.val = base_x_sl, names = c("CSL", "Day"))
  zc_forage_loc <- twoDzeroes_zc
  zc_at_gauntlet_save <- list(rep(NA, days))
  
  if(num_specialist_zc == 0){
    specialist_zc <- NA
  } else {
    specialist_zc <- sample(1:num_zc, num_specialist_zc)
  }
  
  #social learning and network
  receptivity_zc <- twoDzeroes
  receptivity_x_zc <- twoDzeroes
  receptivity_y_zc <- twoDzeroes
  
  x_zc <- makeArray(c(num_zc, days), start.val = base_x_sl, names = c("CSL", "Day"))
  y_zc <- twoDzeroes_zc
  C_zc <- twoDzeroes_zc
  P_x_zc <- twoDzeroes_zc
  P_y_zc <- makeArray(c(num_zc, days), start.val = 1, names = c("CSL", "Day"))
  P_social_zc <- twoDzeroes_zc
  
  #for learnY R-W&P
  risk_boat_zc <- twoDzeroes_zc
  risk_hunt_zc <- twoDzeroes_zc
  risk_g_zc <- twoDzeroes_zc
  pred_risk_zc <- twoDzeroes_zc
  
  harvest_days_zc <- harvest_days
  # harvest_days_zc <- harvest_days_zc[which(harvest_days_zc %in% 1:days)]
  harvest_plan_zc <- createHarvestPlan(scenario = scenario_sealion, 
                                       harvest_days = harvest_days_zc,
                                       empty.array = oneDzeroes)
  boat_days[which(harvest_plan_zc == scenario_sealion)] <- 1
  kill_list_zc <- list()
  H_zc <- oneDzeroes
  
  no_zc <- FALSE
} else {no_zc <- TRUE}


### Steller Sea Lions ----

if(num_ej > 0){
  
  twoDzeroes_ej <- makeArray(c(num_ej, days), start.val = 0, names = c("SSL", "Day"))
  
  # num_ej_2_copy <- num_ej
  salmon_consumed_ej <- twoDzeroes_ej
  ej_prob_gauntlet <- makeArray(c(num_ej, days), start.val = base_x_sl, names = c("SSL", "Day"))
  ej_forage_loc <- twoDzeroes_ej
  ej_at_gauntlet_save <- list(rep(NA, days))
  
  #social learning and network
  receptivity_ej <- twoDzeroes
  receptivity_x_ej <- twoDzeroes
  receptivity_y_ej <- twoDzeroes
  
  x_ej <- makeArray(c(num_ej, days), start.val = base_x_sl, names = c("SSL", "Day"))
  y_ej <- twoDzeroes_ej
  C_ej <- twoDzeroes_ej
  P_x_ej <- twoDzeroes_ej
  P_y_ej <- makeArray(c(num_ej, days), start.val = 1, names = c("SSL", "Day"))
  P_social_ej <- twoDzeroes_ej
  
  #for learnY R-W&P
  risk_boat_ej <- twoDzeroes_ej
  risk_hunt_ej <- twoDzeroes_ej
  risk_g_ej <- twoDzeroes_ej
  pred_risk_ej <- twoDzeroes_ej
  
  harvest_days_ej <- harvest_days
  harvest_plan_ej <- createHarvestPlan(scenario = scenario_sealion, 
                                       harvest_days = harvest_days_ej,
                                       empty.array = oneDzeroes)
  boat_days[which(harvest_plan_ej == scenario_sealion)] <- 1
  kill_list_ej <- list()
  H_ej <- oneDzeroes
  
  no_ej <- FALSE
} else {no_ej <- TRUE}

### X and Y Shape Parameter Bundles ----

x_pars <- tibble(xmin = xmin, xmax = xmax)



