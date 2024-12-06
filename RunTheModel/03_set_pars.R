## Set Up Parameters ----

library(lubridate)

# loop parameters
start_loop <- data_start
end_loop <- data_end
day_range <- start_loop:end_loop
days <- length(day_range)

# seal parameters
num_seals <- 300
prop_specialists <- 0.025

# sea lions
num_zc <- 25
num_ej <- 1
num_specialist_zc <- 3
sealion_arrival <- yday(as.Date("2024-08-25")) - start_loop

# seal consumption parameters
deltat_val <- 1/24
alpha <- 0.05 
Cmax <- 5 # this was initially made up but actually makes some sense
gamma <- -1 # pred dep, this expects something between -1, 0
Y <- 0 # this freaks out when I make it > 0, might just delete

# sea lion consumption
Cmax_zc <- 15
Cmax_ej <- 20

# seal learning parameters
specialist_prob <- 0.5
baseline_x_val <- 0
baseline_y_val <- 0
specialist_baseline_y <- 0
w <- 6
w_sealion <- 100
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
min_fishers <- 13
max_fishers <- 25

zone_efficiency <- NA
zone_steepness <- NA
steepness_H <- 20 # how quick does it saturate (higher = slower)
availability <- 0.1 # prop of seals spatially overlapping with fishers
accuracy <- 0.1 # prop harvested of encountered
efficiency <- availability * accuracy # what prop of total seals do they take

scenario <- "Boat"
scenario_sealion <- "None"





