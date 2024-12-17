## Set Up Parameters ----

library(lubridate)

# loop parameters
start_loop <- data_start
end_loop <- data_end
day_range <- start_loop:end_loop
days <- length(day_range)

# consumption parameters
deltat_val <- 1/24

# seal learning parameters
specialist_prob <- 0.5
baseline_x_val <- 0
baseline_y_val <- 0
specialist_baseline_y <- 0
w <- 6
w_sealion <- 10
ymin <- -10
ymax <- 0
intercept_x_val <- 0.01
xmax <- 10

steepness <- 1
threshold_val <- -5
threshold_specialist <- -10

# steepness_x_specialist <- 0.1
threshold_x_specialist <- 0.1
step <- 0.5
decay <- 0.5
buffer_Pymin_val <- 0
buffer_Pymin_specialist <- 0.5
buffer_Pxmin_specialist <- 0

# social learning parameters
mean <- 0.5 # of the beta dist
beta <- 15 # spread of the beta dist

# salmon parameters
natural_mort <- 0.0005

# hunting parameters

zone_efficiency <- NA
zone_steepness <- NA
steepness_H <- 20 # how quick does it saturate (higher = slower)
availability <- 0.1 # prop of seals spatially overlapping with fishers
accuracy <- 0.1 # prop harvested of encountered
efficiency <- availability * accuracy # what prop of total seals do they take

scenario <- "Boat"
scenario_sealion <- "None"





