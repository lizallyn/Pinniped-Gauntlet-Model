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

# remove self-associations and make all 1 and 0
long_network <- long_network[-which(long_network$ID == long_network$Buddy_ID),]
long_network$Association[which(long_network$Association > 0)] <- 1

# check stats and viz
max(long_network$Association)
mean(long_network$Association)
hist(long_network$Association)

# describe a binomial dist to it
num_connections <- length(which(long_network$Association == 1))
total_nodes <- nrow(long_network)
prob_1 <- num_connections/total_nodes

# simulate fake data from the fitted beta and viz it
# round so almost-zeroes become zeroes again - janky zi workaround
sim_network <- rbinom(500000,1, prob_1)
# max(sim_network)
# mean(sim_network)
# hist(sim_network)
sim_network_2 <- rbinom(500000,1, prob_1)
sim_network_3 <- rbinom(500000,1, prob_1)
