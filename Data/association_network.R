# Creating fake association network from Zach's data
# see "social_associations_cleanup.R" in Case Studies repo

library(tidyr)

set.seed <- 5

## load associations from Zach for 735 EMB Zc over all years of monitoring
# 0s mean those individuals never overlapped (between or within years)
network <- read.csv("Data/social_network_associations_zac_EMB.csv")

# wide to long format
long_network <- network %>% 
  pivot_longer(!ID, names_to = "Buddy_ID", values_to = "Association")

# remove self-associations and make 0s non-zero
long_network <- long_network[-which(long_network$ID == long_network$Buddy_ID),]
long_network$Association[which(long_network$Association == 0)] <- 0.0000001

# check stats and viz
max(long_network$Association)
mean(long_network$Association)
hist(long_network$Association, breaks = seq(0, 0.3, 0.01))

# fit a beta dist to it
start_vals <- list(shape1 = 0.1, shape2 = 10)
fit <- MASS::fitdistr(x = long_network$Association, densfun = "beta", start = start_vals)

# simulate fake data from the fitted beta and viz it
# round so almost-zeroes become zeroes again - janky zi workaround
sim_network <- round(rbeta(500000, fit$estimate[1], fit$estimate[2]), digits = 3)
max(sim_network)
mean(sim_network)
hist(sim_network, breaks = seq(0, 1, 0.01), xlim = c(0, 0.3))


