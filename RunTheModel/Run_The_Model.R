# Run the model for all three pinnipeds and flexible salmon runs

# clear environment
rm(list=ls())
# setwd("/Users/lizallyn/Documents/GitHub/Pinniped-Case-Studies")

## Run it Manually

# 01 Set-Up Functions
source("Functions/makeArray.R")
source("Functions/createHarvestPlan.R")
source("Functions/createSalmonArrival.R")

# 02 Prep Data
source("RunTheModel/Prep_Salmon_Data.R")

# 03 Set Pars
source("RunTheModel/03_set_pars.R")

# 04 Initialize Variables
source("RunTheModel/04_initialize_variables.R")

# 05 Loop Functions
source("Functions/salmonSpeciesUpdate.R")
source("Functions/decideForagingDestination.R")
source("Functions/collusion.R")
source("Functions/rungeKutta_3.R")
source("Functions/getHarvested.R")
source("Functions/learnX.R")
source("Functions/learnY.R")
source("Functions/type3FuncRes.R")
source("Functions/linearFuncRes.R")
source("Functions/updateLearning.R")

# 06 Run The Loop
source("RunTheModel/06_The_Loop.R")

# 07 Plots
source("Functions/makePlots.R")
source("Functions/Plots_Pv.R")
source("Functions/Plots_Ej.R")
source("Functions/Plots_Zc.R")
source("Functions/Plots_salmon.R")
source("Functions/Plots_responses.R")


# Look at the Results
gauntlet_plot + plot_layout(guides = "collect")
plot_seals / plot_ej / plot_zc + plot_layout(axis_titles = "collect")
escape_plot
eaten_sp_plot
plot_eaten / plot_eaten_ej / plot_eaten_zc + plot_layout(guides = "collect")
fished_plot
plot_H + plot_H_ej + plot_H_zc
salmon_catch
salmon_escapement
salmon_eaten
escape_plot / eaten_sp_plot / fished_plot + plot_layout(axis_titles = "collect", guides = "collect")

# check colorblind grid:
cvd_grid(eaten_sp_plot)
