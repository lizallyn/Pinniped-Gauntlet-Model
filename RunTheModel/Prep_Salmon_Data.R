# Script to create salmon arrival data
library(tidyr)
library(dplyr)

source("Functions/createSalmonArrival.R")

#### Arrival Data ----

# matrix with run information
# can also upload .csv with same column names
run_info <- data.frame(Run = c("Run1", "Run2"), Peak_Date = c(150, 175), 
                       sd = c(10, 5), Run_Size = c(10000, 1000), Residence = c(2, 9))
# sd: # days that encompass 60% of the run peak / 2
run_info$Escape <- 1/run_info$Residence
n_species <- nrow(run_info)

# create arrival data frame
salmon_arrival <- create_salmon_arrival(6, run_info, arrival)
colnames(salmon_arrival) <- c("Day", run_info$Run)
n_days <- nrow(salmon_arrival)
data_start <- salmon_arrival$Day[1]
data_end <- max(salmon_arrival$Day)

# test it out:
# days <- test$Day[1]:max(test$Day)
# plot(days, test[,2])
# lines(days, test[,3])


#### Fishery Catch Rates ----

Run1_fish_rate <- 0.05 # see "estFishingRate.R"
Run2_fish_rate <- 0.025

Run1_fishery_days <- 70:80
Run2_fishery_days <- NA
# fishery_range <- fishery_open:fishery_close
# # convert to loop t from dayofyear
# fishery_days <- fishery_range[which(fishery_range %in% day_range)] - (start_loop - 1)

Run1_catch_rate <- rep(0, nrow(salmon_arrival))
Run1_catch_rate[Run1_fishery_days] <- Run1_fish_rate
Run2_catch_rate <- rep(0, nrow(salmon_arrival))
Run2_catch_rate[Run2_fishery_days] <- Run2_fish_rate

salmon_catch_rates <- data.frame(salmon_arrival$Day, Run1_catch_rate, Run2_catch_rate)
colnames(salmon_catch_rates) <- colnames(salmon_arrival)

harvest_open <- 70
harvest_close <- 80
