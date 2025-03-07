# Run the model for all flexible pinnipeds and flexible salmon runs
# winter 2025

# clear environment
rm(list=ls())

## Run it Manually

case.study <- "Base"
run_count <- 3
# case.study <- "N1"
# case.study <- "B1"

bounds <- "Made-Up"
# bounds <- "High Consumption"
# bounds <- "Low Consumption"

# 01 Set-Up Functions
source("Functions/makeArray.R")
source("Functions/createHarvestPlan.R")
source("Functions/createSalmonArrival.R")
source("Data/association_network.R")

# 02 Prep Salmon Data
source("CopyOfRunTheModel/Prep_Salmon_Data.R")

# 03 Prep Pinniped Data
source("CopyOfRunTheModel/Prep_Pinniped_Data.R")

# 04 Set Pars
source("CopyOfRunTheModel/set_pars.R")

# 05 Initialize Variables
source("CopyOfRunTheModel/initialize_variables.R")

# 06 Loop Functions
source("Functions/salmonSpeciesUpdate.R")
source("Functions/decideForagingDestination.R")
source("Functions/socialInfo.R")
source("Functions/collusion.R")
source("Functions/getHarvested.R")
source("Functions/receptivityY.R")
source("Functions/receptivityX.R")
source("Functions/learnX.R")
source("Functions/learnY_2.R")
source("Functions/type3FuncRes.R")
source("Functions/linearFuncRes.R")
source("Functions/updateLearning_3.R")
source("Functions/makePlots.R")

# 07 Run The Loop
if(no_seals == F && no_zc == F && no_ej == F){
  source("Functions/rungeKutta_3.R")
  source("CopyOfRunTheModel/The_Loop_all.R")
  source("Functions/Plots_Ej.R")
  source("Functions/Plots_Zc.R")
} else if(no_seals == F && no_zc == F && no_ej == T){
  source("Functions/rungeKutta_2.R")
  source("CopyOfRunTheModel/The_Loop_pv_zc.R")
  source("Functions/Plots_Zc.R")
} else if(no_seals == F && no_zc == T && no_ej == T){
  source("Functions/rungeKutta.R")
  source("CopyOfRunTheModel/The_Loop_pv.R")
} else {print(error_msg)}

# 08 Plots
source("Functions/Plots_Pv.R")
source("Functions/Plots_salmon.R")
# source("Functions/Plots_responses.R")

# Look at the Results
eaten_sp_plot
plot_eaten / plot_eaten_zc /plot_eaten_ej + plot_layout(guides = "collect")
salmon_eaten

arrive_plot
gauntlet_plot + plot_layout(guides = "collect")
plot_seals / plot_ej / plot_zc + plot_layout(axis_titles = "collect")
# plot_zc
escape_plot
eaten_sp_plot
plot_eaten / plot_eaten_zc /plot_eaten_ej + plot_layout(guides = "collect")
fished_plot
plot_H #+ plot_H_ej + plot_H_zc
salmon_catch
salmon_escapement
salmon_eaten
# escape_plot / eaten_sp_plot / fished_plot + plot_layout(axis_titles = "collect", guides = "collect")

# check colorblind grid:
# cvd_grid(eaten_sp_plot)

gauntlet_plot / plot_probs / plot_Psoc + plot_layout(guides = "collect", axes = "collect")
gauntlet_plot / plot_probs_zc / plot_Psoc_zc + plot_layout(guides = "collect", axes = "collect")
gauntlet_plot / plot_probs_ej / plot_Psoc_ej + plot_layout(guides = "collect", axes = "collect")
plot_x
plot_x_zc
plot_x_ej
plot_Px
plot_H / plot_y
plot_Py
plot_Psoc
length(kill_list)
length(kill_list_zc)
length(kill_list_ej)

plot_H / plot_y / plot_x / plot_probs + plot_layout(guides = "collect", axes = "collect")
