# Runs the daily loop
# for just Pv
# March 2025

for(t in 1:(days - 1)) {
  
  # salmon arrive at the gauntlet
  daily_salmon_list <- salmon_list[t,]
  daily_update <- salmonSpeciesUpdate(day = t, 
                                      salmon = daily_salmon_list, 
                                      arrive_data = salmon_arrival)
  salmon_list[t,] <- daily_update
  
  # decide where each seal goes that day
  seal_forage_loc[,t] <- sapply(X = seal_prob_gauntlet[,t], FUN = decideForagingDestination)
  
  # round of copying for seals
  receptivity_y[,t] <- sapply(X = y[,t], FUN = receptivityY, pars = rec_y_pars)
  receptivity_x[,t] <- sapply(X = x[,t], FUN = receptivityX, pars = rec_x_pars, 
                              baseline_x = base_x)
  receptivity[,t] <- receptivity_x[,t] * receptivity_y[,t]
  for(seal in 1:num_seals){
    social_info <- socialInfo(network_pv[,seal], receptivity = receptivity[seal,t], 
                              probs = seal_prob_gauntlet[,t])
    P_social[seal,t] <- (1-receptivity[seal,t]) * seal_prob_gauntlet[seal,t] + 
      receptivity[seal,t] * social_info
    # P_social[,t] <- saptply(X = seal_prob_gauntlet[,t], FUN = collusion, 
    #                        probs_list = seal_prob_gauntlet[,t], seals_2_copy = num_seals_2_copy, 
    #                        mean = mean, beta = beta)
    seal_forage_loc[,t] <- sapply(X = P_social[,t], FUN = decideForagingDestination)
  }
  
  
  # calculate salmon mortality 
  seals_at_gauntlet <- which(seal_forage_loc[,t] == 1)

  seals_at_gauntlet_save[[t]] <- seals_at_gauntlet
  
  num_seals_at_gauntlet <- length(seals_at_gauntlet)
  
  salmon_result <- run_rungeKutta(salmon = daily_update, 
                                  Cmax = Cmax_mat[,"Pv"], 
                                  Nseal = num_seals_at_gauntlet, 
                                  alpha = alpha_mat[,"Pv"], 
                                  gamma = gamma, 
                                  Y = Y,
                                  F_catch = as.numeric(salmon_catch_rates[t, 2:ncol(salmon_catch_rates)]), 
                                  M = natural_mort, 
                                  E = run_info$Escape, 
                                  deltat = deltat_val)
  
  # assign escape and gauntlet updates
  salmon_list[t+1, 2:ncol(salmon_list)] <- salmon_result[, "Ns"]
  escape_salmon[t+1, 2:ncol(escape_salmon)] <- salmon_result[, "E"]
  fished_salmon[t, 2:ncol(escape_salmon)] <- salmon_result[, "Catch"]
  eaten_salmon[t, 2:ncol(escape_salmon)] <- salmon_result[, "C"]
  consumed_total[t] <- sum(eaten_salmon[t, 2:ncol(escape_salmon)])
  
  # assign consumed salmon to gauntlet pinnipeds
  
  consumed_by_pv <- sum(salmon_result[,"C"])
  
  if(num_seals_at_gauntlet == 0 | consumed_by_pv == 0) {
    salmon_consumed_pv[,t] <- 0
  } else {
    salmon_consumed_pv[seals_at_gauntlet, t] <- consumed_by_pv/num_seals_at_gauntlet
  }
  
  # seal harvest
  # num_harvesters <- sample(min_harvesters:max_harvesters, 1)
  H[t] <- getHarvested(day_plan = harvest_plan_pv[t], list_gauntlet_seals = seals_at_gauntlet, 
                       num_fishers = num_harvesters[t], zone_efficiency = zone_efficiency, zone_steepness = zone_steepness, 
                       efficiency = efficiency, steepness = steepness_H)
  hunt <- 0
  if(H[t] > 0){
    hunt <- 1
    killed <- sample(seals_at_gauntlet, H[t])
    kill_list <- c(kill_list, killed)
  }
  
  ## calculate x, y and prob_gauntlet for next time step
  
  # seals
  
  for(seal in 1:num_seals){
    # bundle_y_shape_pars <- tibble(buffer = buffer_Pymin[seal],
    #                               steepness = steepness, threshold = threshold[seal])
    
    update_output <- updateLearning(salmon_consumed = salmon_consumed_pv[seal, t], 
                                    boats = boat_days[t], 
                                    rho = rho, 
                                    learn_rate = learn_rate,
                                    w = w, 
                                    hunting = hunt,
                                    x_t = x[seal, t], 
                                    x_pars = x_pars,
                                    step = step[seal], 
                                    decay = decay,
                                    forage_loc = seal_forage_loc[seal, t], 
                                    dead = seal %in% kill_list,
                                    baseline_x = base_x[seal], 
                                    w1 = risk_boat_pv[seal, t],
                                    w2 = risk_hunt_pv[seal, t], 
                                    w3 = risk_g_pv[seal, t],
                                    specialist = seal %in% specialist_seals, 
                                    bundle_x = bundle_x, 
                                    bundle_x_spec = bundle_x_spec, 
                                    bundle_y = bundle_y,
                                    bundle_y_spec = bundle_y_spec)
    
    x[seal, t+1] <- as.numeric(update_output["x_t1"])
    y[seal, t+1] <- as.numeric(update_output["y_t1"])
    P_x[seal, t+1] <- as.numeric(update_output["P_x"])
    P_y[seal, t+1] <- as.numeric(update_output["P_y"])
    risk_boat_pv[seal, t+1] <- as.numeric(update_output["w1"])
    risk_hunt_pv[seal, t+1] <- as.numeric(update_output["w2"])
    risk_g_pv[seal, t+1] <- as.numeric(update_output["w3"])
    seal_prob_gauntlet[seal, t+1] <- P_x[seal, t+1] * P_y[seal, t+1]
    
    if(seal %in% kill_list){
      seal_prob_gauntlet[seal, t+1] <- NA
      seal_forage_loc[seal, t+1] <- NA
      x[seal, t+1] <- NA
      y[seal, t+1] <- NA
      C[seal, t] <- NA
      P_x[seal, t+1] <- NA
      P_y[seal, t+1] <- NA
    }
  }

  
} # days loop


