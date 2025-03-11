# separate script for diet energetics stuff

#### Parameter Cmax ####
# see Obsidian note "Parameter - Cmax"
# energy estimates from Oneill 2014
Pv_kcal <- 3549
Zc_kcal <- 22803
Ej_kcal <- 35851
pinn_kcal <- data.frame(Pv = Pv_kcal, Zc = Zc_kcal, Ej = Ej_kcal)

chinookGR_kcal <- 7034
chinookLN_kcal <- 11723
chinook_kcal <- 13409
chum_kcal <- 4200
coho_kcal <- 4982
sockeye_kcal <- 4264
salmon_kcal <- data.frame(GreenRiver = chinookGR_kcal, LocNis = chinookLN_kcal, 
                          Chinook = chinook_kcal, Chum = chum_kcal, 
                          Coho = coho_kcal, Sockeye = sockeye_kcal)
energetics <- data.frame(matrix(data = NA, nrow = length(salmon_kcal), 
                                ncol = length(pinn_kcal)))
for(i in 1:length(pinn_kcal)){
  for(j in 1:length(salmon_kcal))
    energetics[j,i] <- pinn_kcal[i]/salmon_kcal[j]
}
colnames(energetics) <- c("Pv", "Zc", "Ej")
rownames(energetics) <- c("GreenRiver", "LocNis", "Chinook", 
                          "Chum", "Coho", "Sockeye")

# diet proportions from Thomas 2017
Pv_diet_props <- data.frame(Chinook = 0.15, Chum = 0.52, 
                            Coho = 0.034, Sockeye = 0.24)
# diet proportions from Scordino 2022
Ej_diet_props <- data.frame(Chinook = 0.68, Chum = 0.205, 
                            Coho = 0.474, Sockeye = 0.01)
# diet proportions from Scordino 2022
Zc_diet_props <- data.frame(Chinook = 0.057, Chum = 0.229, 
                            Coho = 0.543, Sockeye = 0.057)

# low case consumption Cmax estimates (via scat samples)
low_energetics <- energetics[3:6,"Pv"] * Pv_diet_props
low_energetics[2,] <- energetics[3:6, "Zc"] * Zc_diet_props
low_energetics[3,] <- energetics[3:6, "Ej"] * Ej_diet_props
rownames(low_energetics) <- c("Pv", "Zc", "Ej")
low_energetics <- t(low_energetics)

# high case consumption Cmax estimates (high-grading, belly-biting)
high_energetics <- data.frame(matrix(data = NA, nrow = 3, ncol = 4))
high_energetics[1,] <- energetics[3:6,"Pv"] * 2
high_energetics[2,] <- energetics[3:6, "Zc"] * 2
high_energetics[3,] <- energetics[3:6, "Ej"] * 2
rownames(high_energetics) <- c("Pv", "Zc", "Ej")
colnames(high_energetics) <- c("Chinook", "Chum", "Coho", "Sockeye")
high_energetics <- t(high_energetics)

#### Parameter w ####

# see Obsidian note Parameter-w
# from Olesiuk 1990 and scordino 2022 mostly
# have to eat more salmon than expected from an open water diet

# in kcal:
w <- data.frame(Pv = 110, Zc = 3032.8, Ej = 4158.7)
run_kcal <- data.frame(Run1 = as.numeric(salmon_kcal["Sockeye"]), 
                       Run2 = as.numeric(salmon_kcal["Chinook"]),
                       Run3 = as.numeric(salmon_kcal["Chum"]))
