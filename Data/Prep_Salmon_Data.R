# Script to create salmon arrival data
library(tidyr)
library(dplyr)

#### Arrival Data ----

# matrix with run information
# can also upload .csv with same column names

# case.study <- "Base"
# run_count <- 3
case.study <- "N1"
# case.study <- "B1"

if(case.study == "Base"){
  run_info <- read.csv("Data/salmon_run_info.csv")
  run_info <- run_info[1:run_count,]
}
if(case.study == "N1"){
  run_info <- read.csv("Data/salmon_run_info_N.csv")
}
if(case.study == "B1"){
  run_info <- read.csv("Data/salmon_run_info_B.csv")
}


# sd: # days that encompass 60% of the run peak / 2
run_info$Escape <- 1/run_info$Residence
n_species <- nrow(run_info)

# create arrival data frame
salmon_arrival <- create_salmon_arrival(3, run_info)
colnames(salmon_arrival) <- c("Day", run_info$Run)
n_days <- nrow(salmon_arrival)
data_start <- salmon_arrival$Day[1]
data_end <- max(salmon_arrival$Day)

# # test it out:
# days <- data_start:data_end
# plot(days, salmon_arrival[,2])
# lines(days, salmon_arrival[,4])
# lines(days, salmon_arrival[,3])

#### Fishery Catch Rates ----

# for learning cues
boat_days <- array(dim = n_days, data = 0)

# create catch rates
salmon_catch_rates <- data.frame(matrix(data = 0, nrow = n_days, ncol = ncol(salmon_arrival), dimnames = dimnames(salmon_arrival)))
colnames(salmon_catch_rates) <- colnames(salmon_arrival)
salmon_catch_rates$Day <- salmon_arrival$Day
for(i in 1:nrow(run_info)){
  if(run_info$Fish_Rate[i] > 0){
    fishery_dates <- (run_info$Fishery_Open[i]:run_info$Fishery_Close[i]) - (data_start-1)
    salmon_catch_rates[fishery_dates, i+1] <- run_info$Fish_Rate[i]
    boat_days[fishery_dates] <- 1
  }
}


#### Pinniped Harvest ----

# yday not loop day
harvest_open <- 65 - (data_start - 1)
harvest_close <- 105 - (data_start - 1)

min_fishers <- 13
max_fishers <- 25


