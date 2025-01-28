### For creating, storing, editing data on pinniped species
# Dec 2024

# Pinniped input
num_seals <- 100
num_zc <- 2
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


