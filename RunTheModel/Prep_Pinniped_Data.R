### For creating, storing, editing data on pinniped species
# Dec 2024

# Pinniped input
pinnipeds <- data.frame(Pv = 300, Zc = 25, Ej = 1)
num_pinn_sp <- length(which(pinnipeds > 0))

# consumption parameters
# replace these with .csv inputs when values finalized and justified
alpha <- 0.05 
alpha <- data.frame(matrix(nrow = n_species, ncol = num_pinn_sp, data = alpha))
colnames(alpha) <- colnames(pinnipeds)
rownames(alpha) <- run_info$Run

Cmax_pv <- 5
Cmax_zc <- 15
Cmax_ej <- 20
Cmax <- data.frame(matrix(nrow = n_species, ncol = num_pinn_sp, data = Cmax_ej))
Cmax$Pv <- Cmax_pv
Cmax$Zc <- Cmax_zc

gamma <- -1 # pred dep, this expects something between -1, 0
Y <- 0 # this freaks out when I make it > 0, might just delete