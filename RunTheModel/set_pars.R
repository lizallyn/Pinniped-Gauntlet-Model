## Set Up Parameters ----
# with different type3funcres parameters

library(lubridate)

# loop parameters
start_loop <- data_start
end_loop <- data_end
day_range <- start_loop:end_loop
days <- length(day_range)

# consumption parameters
deltat_val <- 1/24

# x parameters
base_x <- 0
xmin <- 0
xmax <- 10

# y parameters
base_y <- 0
ymin <- 0
ymax <- 10

# non-specialist x parameters
asymp_left_x_val <- 0
asymp_right_x_val <- 1
steepness_x_val <- 0.75
shift_x_val <- 100

# sea lion x parameters
asymp_left_x_sl_val <- 0.25
asymp_right_x_sl_val <- 1
steepness_x_sl_val <- 1.5
shift_x_sl_val <- 100

# specialist x parameters
asymp_left_x_spec_val <- 0.1
asymp_right_x_spec_val <- 1
steepness_x_spec_val <- 1.5
shift_x_spec_val <- 100

# non-specialist y parameters
asymp_left_y_val <- 1
asymp_right_y_val <- 0
steepness_y_val <- 2
shift_y_val <- 75

# sea lion y parameters
asymp_left_y_sl_val <- 1
asymp_right_y_sl_val <- 0
steepness_y_sl_val <- 2
shift_y_sl_val <- 10000

# specialist y parameters
asymp_left_y_spec_val <- 1
asymp_right_y_spec_val <- 0
steepness_y_spec_val <- 2
shift_y_spec_val <- 500

# individual learning parameters
specialist_prob <- 0.5
w <- 6
w_sealion <- 10
step <- 0.15
decay <- 0.1
presence <- 10
absence <- 0
rho <- 0.1
learn_rate <- 0.15

# social learning parameters
num_haulouts <- 2
mean <- 0.5 # of the beta dist
beta <- 15 # spread of the beta dist

# salmon parameters
natural_mort <- 0.0005

# hunting parameters

zone_efficiency <- NA
zone_steepness <- NA
steepness_H <- 5 # how quick does it saturate (higher = slower)
availability <- 0.9 # prop of seals spatially overlapping with fishers
accuracy <- 0.5 # prop harvested of encountered
efficiency <- availability * accuracy # what prop of total seals do they take

scenario <- "Boat"
scenario_sealion <- "None"





