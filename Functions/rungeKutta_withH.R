# for single predator pop
# From Tim Feb 2024

get_dXdt <- function(Ns, Cmax, Nseal, alpha, gamma, Y, F_catch, M, E, H) {
  Nseal <- max(Nseal, 1E-20)
  dNdt <- (-Cmax * alpha * Ns * (Nseal - Nseal * H)^(1 + gamma)) / (Cmax + alpha * Ns * (Nseal - Nseal * H)^gamma + Y) - 
    F_catch * Ns - M * Ns - E * Ns
  dCdt <-   (Cmax * alpha * Ns * (Nseal - Nseal * H)^(1 + gamma)) / (Cmax + alpha * Ns * (Nseal - Nseal * H)^gamma + Y)
  dCatchdt <- F_catch * Ns
  dEdt <- E * Ns
  dHuntdt <- c(H * Nseal, NA, NA, NA)
  return(c(dNdt, dCdt, dCatchdt, dEdt, dHuntdt))
}

rungeKutta <- function(X, Cmax, Nseal, alpha, gamma, Y, F_catch, M, E, H, n_species, deltat = deltat){
  K1s <- get_dXdt(Ns = X[1:n_species], Cmax, Nseal, alpha, gamma, Y, F_catch, M, E, H)
  midX <- X + deltat* 0.5 * K1s
  K2s <- get_dXdt(Ns = midX[1:n_species],Cmax, Nseal, alpha, gamma, Y, F_catch, M, E, H)
  midX <- X + deltat * 0.5 * K2s
  K3s <- get_dXdt(Ns = midX[1:n_species], Cmax, Nseal, alpha, gamma, Y, F_catch, M, E, H)
  endX <- X + deltat * K3s
  K4s <- get_dXdt(Ns = endX[1:n_species],Cmax, Nseal, alpha, gamma, Y, F_catch, M, E, H)
  Xsim <- X + deltat * (K1s / 6 + K2s / 3 + K3s / 3 + K4s / 6)
  return(c(Xsim))
}

run_rungeKutta <- function(salmon, Cmax, Nseal, alpha, gamma, Y, F_catch, M, E, H, deltat = deltat_val) {
  times <- seq(0, 1, by = deltat)
  if (times[length(times)]!= 1) {
    stop("deltat must be a division of 1")
  }
  Ns <- as.numeric(salmon[,2:ncol(salmon)])
  n_species <- length(Ns)
  X <- c(Ns, rep(0, n_species), rep(0, n_species), rep(0, n_species), rep(0, n_species))
  for (i in 1:length(times)) {
    X <- rungeKutta(X, Cmax, Nseal, alpha, gamma, Y, F_catch, M, E, H, n_species, deltat = deltat)
  }
  X.res <- matrix(X, nrow = n_species, ncol = length(X)/n_species, byrow = F)
  colnames(X.res) <- c("Ns", "C", "Catch", "E", "Hunted")
  rownames(X.res) <- colnames(salmon[,2:ncol(salmon)])
  return(X.res)
}

# Ns <- data.frame(Day = 100, Run1 = 500, Run2 = 100, Run3 = 200, Run4 = 100)
# E <- c(0.3, 0.003, 0.1, 0.02)
# F_catch <- c(0, 0, 0.1, 0)
# H <- 0.1
# 
# gamma <- -0.5
# 
# run_rungeKutta(salmon = Ns, Cmax = Cmax_mat[,"Pv"], Nseal = 15, alpha = alpha_mat[,"Pv"], gamma = gamma, Y = Y,
#                F_catch = F_catch, E = E, H = H, M = natural_mort, deltat = deltat_val)



