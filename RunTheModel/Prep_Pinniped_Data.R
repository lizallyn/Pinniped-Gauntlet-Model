### For creating, storing, editing data on pinniped species
# Dec 2024

# Pinniped input
num_seals <- 300
num_zc <- 80
num_ej <- 0
pinnipeds <- data.frame(Pv = num_seals, Zc = num_zc, Ej = num_ej)
print(pinnipeds)

num_pinn_sp <- length(which(pinnipeds > 0))
list_of_pinns <- colnames(pinnipeds[which(pinnipeds > 0)])

num_haulouts <- 2 # for Pv

## Specialist Behavior Prevalence
prop_specialists <- 0.1
num_specialist_zc <- 0 # figure out if we're keeping this? 4 phenotypes?

## Seasonality
sealion_arrival <- 1

## consumption parameters
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

gamma <- -1 # pred dep, this expects something between -1, 0
Y <- 0 # this freaks out when I make it > 0, might just delete

error_msg <- "Error in pinniped accounting! They cannot count and neither can you!"

## Social Associations

# See "social_associations_cleanup.R" for more details
# pulled from association matrix from Zac monitoring Zc at EMB
# define parameters of the Beta dist fit to the associations
shape1 <- 0.137
shape2 <- 13.058

# set max receptivity value to scale associations to
max.sociality <- 0.5 

# create associations matrix for Pv
# round so 0's get created
associations <- matrix(data = round(rbeta(num_seals * num_seals, shape1, shape2), digits = 3), nrow = num_seals, ncol = num_seals)
colnames(associations) <- 1:num_seals
rownames(associations) <- 1:num_seals
# make self-associations = 0
# and mirror across 1:1 axis
for(i in 1:num_seals){
  associations[i,i] <- 0
  for(j in 1:(i-1)){
    associations[j,i] <- associations[i,j]
  }
}
# scale so max total associations for any individual is max.sociality
sociality <- colSums(associations)
sociality.scaled <- sociality * (max.sociality/max(sociality))
for(i in 1:num_seals){
  for(k in 1:num_seals){
    associations[k,i] <- associations[k,i] * (sociality.scaled[i]/max(sociality[i]))
  }
}

if(num_zc > 0){
  # create associations matrix for Zc
  # round so 0's get created
  associations <- matrix(data = round(rbeta(num_zc * num_zc, shape1, shape2), digits = 3), nrow = num_zc, ncol = num_zc)
  colnames(associations) <- 1:num_zc
  rownames(associations) <- 1:num_zc
  # make self-associations = 0
  # and mirror across 1:1 axis
  for(i in 1:num_zc){
    associations[i,i] <- 0
    for(j in 1:(i-1)){
      associations[j,i] <- associations[i,j]
    }
  }
  # scale so max total associations for any individual is max.sociality
  sociality <- colSums(associations)
  sociality.scaled <- sociality * (max.sociality/max(sociality))
  for(i in 1:num_zc){
    for(k in 1:num_zc){
      associations[k,i] <- associations[k,i] * (sociality.scaled[i]/max(sociality[i]))
    }
  }
}


if(num_ej > 0){
  # create associations matrix for Ej
  # round so 0's get created
  associations <- matrix(data = round(rbeta(num_ej * num_ej, shape1, shape2), digits = 3), nrow = num_ej, ncol = num_ej)
  colnames(associations) <- 1:num_ej
  rownames(associations) <- 1:num_ej
  # make self-associations = 0
  # and mirror across 1:1 axis
  for(i in 1:num_ej){
    associations[i,i] <- 0
    for(j in 1:(i-1)){
      associations[j,i] <- associations[i,j]
    }
  }
  # scale so max total associations for any individual is max.sociality
  sociality <- colSums(associations)
  sociality.scaled <- sociality * (max.sociality/max(sociality))
  for(i in 1:num_ej){
    for(k in 1:num_ej){
      associations[k,i] <- associations[k,i] * (sociality.scaled[i]/max(sociality[i]))
    }
  }
}
