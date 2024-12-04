# Script to create salmon arrival data
library(tidyr)
library(dplyr)

source("Functions/createSalmonArrival.R")

# matrix with run information
# can also upload .csv with same column names
run_info <- data.frame(Run = c("Run1", "Run2"), Peak_Date = c(150, 175), 
                       sd = c(10, 5), Run_Size = c(10000, 1000), Residence = c(2, 9))
# sd: # days that encompass 60% of the run peak / 2

# looks good!
salmon_arrival <- create_salmon_arrival(5, run_info, arrival)
colnames(salmon_arrival) <- c("Day", run_info$Run)
# days <- test$Day[1]:max(test$Day)
# plot(days, test[,2])
# lines(days, test[,3])

