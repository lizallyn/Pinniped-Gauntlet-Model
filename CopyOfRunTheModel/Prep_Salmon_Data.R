# Script to create salmon arrival data
library(tidyr)
library(dplyr)
library(anytime)
library(lubridate)

#### Arrival Data ----

# matrix with run information
# can also upload .csv with same column names

# case.study <- "Base"
# run_count <- 3
# case.study <- "N1"
# case.study <- "B1"

# boat_days <- array(dim = n_days, data = 0)

# Case Base
if(case.study == "Base"){
  run_info <- read.csv("Data/salmon_run_info.csv")
  run_info <- run_info[1:run_count,]
  
  run_info$Escape <- 1/run_info$Residence
  n_species <- nrow(run_info)
  
  # create arrival data frame
  salmon_arrival <- create_salmon_arrival(5, run_info) # width of dist
  colnames(salmon_arrival) <- c("Day", run_info$Run)
  n_days <- nrow(salmon_arrival)
  data_start <- salmon_arrival$Day[1]
  data_end <- max(salmon_arrival$Day)
  
  boat_days <- array(dim = n_days, data = 0)
  
  salmon_catch_rates <- data.frame(matrix(data = 0, nrow = n_days, 
                                          ncol = ncol(salmon_arrival), 
                                          dimnames = dimnames(salmon_arrival)))
  colnames(salmon_catch_rates) <- colnames(salmon_arrival)
  salmon_catch_rates$Day <- salmon_arrival$Day
  
  for(i in 1:n_species){
    if(run_info$Fish_Rate[i] > 0){
      fishery_dates <- (run_info$Fishery_Open[i]:run_info$Fishery_Close[i]) - (data_start-1)
      salmon_catch_rates[fishery_dates, i+1] <- run_info$Fish_Rate[i]
      boat_days[fishery_dates] <- 1
    }
  }
  
  sealion_arrival <- 1
  
  harvest_open <- 65 - (data_start - 1)
  harvest_close <- 105 - (data_start - 1)
  harvest_days <- harvest_open:harvest_close
  
  min_fishers <- 13
  max_fishers <- 25
  
  min_harvesters <- 0
  max_harvesters <- max_fishers
  num_harvesters <- sample(min_harvesters:max_harvesters, n_days, replace = T)
  
}
# Case N1
if(case.study == "N1"){
  run_info <- read.csv("Data/salmon_run_info_N.csv")
  
  run_info$Escape <- 1/run_info$Residence
  n_species <- nrow(run_info)
  
  # create arrival data frame
  salmon_arrival <- create_salmon_arrival(5, run_info)
  colnames(salmon_arrival) <- c("Day", run_info$Run)
  n_days <- nrow(salmon_arrival)
  data_start <- salmon_arrival$Day[1]
  data_end <- max(salmon_arrival$Day)
  
  
  # catch data --> rates
  salmon_catch_rates <- data.frame(matrix(data = 0, nrow = n_days, ncol = ncol(salmon_arrival), dimnames = dimnames(salmon_arrival)))
  colnames(salmon_catch_rates) <- colnames(salmon_arrival)
  salmon_catch_rates$Day <- salmon_arrival$Day
  
  catch_info <- read.csv("Data/salmon_catch_info_N.csv")
  catch_info$Day <- yday(anydate(catch_info$Dates))
  catch_info$Day[which(catch_info$Day < catch_info$Day[1])] <- catch_info$Day[which(catch_info$Day < catch_info$Day[1])] + 366 #wrap year
  fishery_dates <- which(catch_info[,2] + catch_info[,3] + catch_info[,4] > 0) # loop days not doy
  
  salmon_catch_rates$Chum[which(catch_info$Chum > 0)] <- 0.1
  salmon_catch_rates$LocNis[which(catch_info$LocNis > 0)] <- 0.08
  salmon_catch_rates$GR[which(catch_info$GR > 0)] <- 0.07
  # salmon_catch_rates$Chum[which(salmon_catch_rates$Chum > 1)] <- 0.2
  # salmon_catch_rates$LocNis[which(salmon_catch_rates$LocNis > 1)] <- 0.2
  # salmon_catch_rates$GR[which(salmon_catch_rates$GR > 1)] <- 0.2
  # salmon_catch_rates <- salmon_catch_rates %>% 
  #   mutate(
  #     across(everything(), ~replace_na(.x, 0))
  #   )
  
  # for learning cues
  boat_days <- array(dim = n_days, data = 0)
  boat_days[fishery_dates] <- 1
  
  sealion_arrival <- 296
  
  # hunt info setup
  num_harvesters <- catch_info$Boats
  harvest_days <- which(catch_info$Boats > 0)
  
}
# Case B1
if(case.study == "B1"){
  run_info <- read.csv("Data/salmon_run_info_B.csv")
}






