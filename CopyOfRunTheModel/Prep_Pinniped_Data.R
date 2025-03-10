### For creating, storing, editing data on pinniped species
# Feb 2025

# Pinniped input
num_seals <- 100
num_zc <- 20
num_ej <- 10
pinnipeds <- data.frame(Pv = num_seals, Zc = num_zc, Ej = num_ej)

num_pinn_sp <- length(which(pinnipeds > 0))
list_of_pinns <- colnames(pinnipeds[which(pinnipeds > 0)])

num_haulouts <- 2 # for Pv

## Specialist Behavior Prevalence
prop_specialists <- 0.1
num_specialist_zc <- 0 # figure out if we're keeping this? 4 phenotypes?

## Seasonality
sealion_arrival <- 1

## consumption parameters

if(bounds == "Made-Up"){
  # replace these with .csv inputs when values finalized and justified
  alpha <- 0.05 
  alpha_mat <- data.frame(matrix(nrow = n_species, ncol = num_pinn_sp, data = alpha))
  colnames(alpha_mat) <- list_of_pinns
  rownames(alpha_mat) <- run_info$Run
  
  Cmax_pv <- 5
  Cmax_zc <- 15
  Cmax_ej <- 20
  Cmax_mat <- data.frame(matrix(nrow = n_species, ncol = num_pinn_sp, 
                                data = Cmax_ej, dimnames = dimnames(alpha_mat)))
  Cmax_mat$Pv <- Cmax_pv
  Cmax_mat$Zc <- Cmax_zc
}
if(bounds == "High Consumption"){
  # replace these with .csv inputs when values finalized and justified
  alpha <- 0.05 
  alpha_mat <- data.frame(matrix(nrow = n_species, ncol = num_pinn_sp, data = alpha))
  colnames(alpha_mat) <- list_of_pinns
  rownames(alpha_mat) <- run_info$Run
  
  Cmax_mat <- data.frame(matrix(nrow = n_species, ncol = num_pinn_sp, 
                                data = NA, dimnames = dimnames(alpha_mat)))
  Cmax_mat["Run1",] <- ceiling(high_energetics["Sockeye",])
  Cmax_mat["Run2",] <- ceiling(high_energetics["Chinook",])
  Cmax_mat["Run3",] <- ceiling(high_energetics["Chum",])
}
if(bounds == "Low Consumption"){
  # replace these with .csv inputs when values finalized and justified
  alpha <- 0.05 
  alpha_mat <- data.frame(matrix(nrow = n_species, ncol = num_pinn_sp, data = alpha))
  colnames(alpha_mat) <- list_of_pinns
  rownames(alpha_mat) <- run_info$Run
  
  Cmax_mat <- data.frame(matrix(nrow = n_species, ncol = num_pinn_sp, 
                                data = NA, dimnames = dimnames(alpha_mat)))
  Cmax_mat["Run1",] <- ceiling(low_energetics["Sockeye",])
  Cmax_mat["Run2",] <- ceiling(low_energetics["Chinook",])
  Cmax_mat["Run3",] <- ceiling(low_energetics["Chum",])
}

gamma <- -1 # pred dep, this expects something between -1, 0
Y <- 0 # always 0 for this.

error_msg <- "Error in pinniped accounting! They cannot count and neither can you!"

## Social Associations

# See "social_associations_cleanup.R" for more details
# pulled from association matrix from Zac monitoring Zc at EMB
network_pv <- matrix(data = sim_network[1:(num_seals * num_seals)], 
                     nrow = num_seals, ncol = num_seals)
colnames(network_pv) <- 1:num_seals
rownames(network_pv) <- 1:num_seals
# make self-associations = 0
# and mirror across 1:1 axis
for(i in 1:num_seals){
  network_pv[i,i] <- 0
  for(j in 1:(i-1)){
    network_pv[j,i] <- network_pv[i,j]
  }
}

if(num_zc > 0){
  # create associations matrix for Zc
  # round so 0's get created
  network_zc <- matrix(data = sim_network_2[1:(num_zc * num_zc)], 
                       nrow = num_zc, ncol = num_zc)
  colnames(network_zc) <- 1:num_zc
  rownames(network_zc) <- 1:num_zc
  # make self-associations = 0
  # and mirror across 1:1 axis
  for(i in 1:num_zc){
    network_zc[i,i] <- 0
    for(j in 1:(i-1)){
      network_zc[j,i] <- network_zc[i,j]
    }
  }
}


if(num_ej > 0){
  # create associations matrix for Zc
  # round so 0's get created
  network_ej <- matrix(data = sim_network_2[1:(num_ej * num_ej)], 
                       nrow = num_ej, ncol = num_ej)
  colnames(network_ej) <- 1:num_ej
  rownames(network_ej) <- 1:num_ej
  # make self-associations = 0
  # and mirror across 1:1 axis
  for(i in 1:num_ej){
    network_ej[i,i] <- 0
    for(j in 1:(i-1)){
      network_ej[j,i] <- network_ej[i,j]
    }
  }
}
