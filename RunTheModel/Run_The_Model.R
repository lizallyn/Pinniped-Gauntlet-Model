# Run the model for all flexible pinnipeds and flexible salmon runs

# clear environment
rm(list=ls())

## Run it Manually

# case.study <- "Base"
# run_count <- 3
case.study <- "N1"
# case.study <- "B1"

# 01 Set-Up Functions
source("Functions/makeArray.R")
source("Functions/createHarvestPlan.R")
source("Functions/createSalmonArrival.R")

# 02 Prep Salmon Data
source("Data/Prep_Salmon_Data.R")

# 03 Prep Pinniped Data
source("Data/Prep_Pinniped_Data.R")

# 04 Set Pars
source("RunTheModel/set_pars.R")

# 05 Initialize Variables
source("RunTheModel/initialize_variables.R")

# 06 Loop Functions
source("Functions/salmonSpeciesUpdate.R")
source("Functions/decideForagingDestination.R")
source("Functions/collusion.R")
source("Functions/getHarvested.R")
source("Functions/learnX.R")
source("Functions/learnY_2.R")
source("Functions/type3FuncRes.R")
source("Functions/linearFuncRes.R")
source("Functions/updateLearning_2.R")
source("Functions/makePlots.R")

# 07 Run The Loop
if(no_seals == F && no_zc == F && no_ej == F){
  source("Functions/rungeKutta_3.R")
  source("RunTheModel/06_The_Loop.R")
  source("Functions/Plots_Ej.R")
  source("Functions/Plots_Zc.R")
} else if(no_seals == F && no_zc == F && no_ej == T){
  source("Functions/rungeKutta_2.R")
  source("RunTheModel/The_Loop_pv_zc.R")
  source("Functions/Plots_Zc.R")
} else if(no_seals == F && no_zc == T && no_ej == F){
  source("Functions/rungeKutta_2.R")
  # add if needed later
  source("Functions/Plots_Ej.R")
} else if(no_seals == F && no_zc == T && no_ej == T){
  source("Functions/rungeKutta.R")
  source("RunTheModel/06_The_Loop_pv.R")
} else {print(error_msg)}

# 08 Plots
source("Functions/Plots_Pv.R")
source("Functions/Plots_salmon.R")
source("Functions/Plots_responses.R")

# Look at the Results
gauntlet_plot + plot_layout(guides = "collect")
plot_seals #/ plot_ej / plot_zc + plot_layout(axis_titles = "collect")
escape_plot
eaten_sp_plot
plot_eaten #/ plot_eaten_ej / plot_eaten_zc + plot_layout(guides = "collect")
fished_plot
plot_H #+ plot_H_ej + plot_H_zc
salmon_catch
salmon_escapement
salmon_eaten
escape_plot / eaten_sp_plot / fished_plot + plot_layout(axis_titles = "collect", guides = "collect")

# check colorblind grid:
# cvd_grid(eaten_sp_plot)

plot_probs
plot_x
plot_Px
plot_y
plot_Py
length(kill_list)
