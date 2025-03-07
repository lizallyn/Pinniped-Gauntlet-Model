## Set Up Parameters ----
# with no Px anymore

library(lubridate)

# loop parameters
start_loop <- data_start
end_loop <- data_end
day_range <- start_loop:end_loop
days <- length(day_range)

# consumption parameters
deltat_val <- 1/24

# x parameters
base_x <- 0.01
base_x_spec <- 0.1
base_x_sl <- 0.25
xmin <- 0
xmax <- 1

# receptivity pars
rec_y_pars <- tibble(height = sqrt(0.5), width = 6)
rec_x_pars <- tibble(height = sqrt(0.5), width = 4.5)

# individual learning parameters
w <- 1
w_CSL <- 1.5
w_SSL <- 2
step <- 0.15
step_spec <- 0.15
decay <- 0.1
rho <- 0.1
learn_rate <- 0.15

# salmon parameters
natural_mort <- 0.0005

# hunting parameters
zone_efficiency <- NA
zone_steepness <- NA
steepness_H <- 5 # how quick does it saturate (higher = slower)
availability <- 0.5 # prop of seals spatially overlapping with fishers
accuracy <- 0.5 # prop harvested of encountered
efficiency <- availability * accuracy # what prop of total seals do they take

scenario <- "None"
scenario_sealion <- "None"





