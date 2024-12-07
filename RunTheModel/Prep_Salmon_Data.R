# Script to create salmon arrival data
library(tidyr)
library(dplyr)

#### Arrival Data ----

# matrix with run information
# can also upload .csv with same column names

# from data.frame
# run_info <- data.frame(Run = c("Run1", "Run2"), Peak_Date = c(150, 175),
#                        sd = c(10, 5), Run_Size = c(10000, 1000), Residence = c(2, 9))

# from .csv
run_info <- read.csv("RunTheModel/salmon_run_info.csv")

# 2 Runs
# run_info <- run_info[1:2,]
# 3 Runs
# run_info <- run_info[1:3,]
# 4 Runs
run_info <- run_info[1:4,]

# sd: # days that encompass 60% of the run peak / 2
run_info$Escape <- 1/run_info$Residence
n_species <- nrow(run_info)

# create arrival data frame
salmon_arrival <- create_salmon_arrival(4, run_info)
colnames(salmon_arrival) <- c("Day", run_info$Run)
n_days <- nrow(salmon_arrival)
data_start <- salmon_arrival$Day[1]
data_end <- max(salmon_arrival$Day)

# test it out:
# days <- test$Day[1]:max(test$Day)
# plot(days, test[,2])
# lines(days, test[,3])


#### Fishery Catch Rates ----

salmon_catch_rates <- matrix(data = 0, nrow = n_days, ncol = nrow(run_info)+1)
colnames(salmon_catch_rates) <- colnames(salmon_arrival)
for(i in 1:nrow(run_info)){
  if(run_info$Fish_Rate[i] > 0){
    fishery_dates <- (run_info$Fishery_Open[i]:run_info$Fishery_Close[i]) - (data_start-1)
    salmon_catch_rates[fishery_dates, i+1] <- run_info$Fish_Rate[i]
  }
}

#### Harvest ----

# yday not loop day
harvest_open <- 70
harvest_close <- 80
