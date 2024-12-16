## specialist_prob
# baseline probability of going to the gauntlet for specialist individuals

# 01 Set-Up Functions
source("Functions/makeArray.R")
source("Functions/createHarvestPlan.R")
source("Functions/createSalmonArrival.R")

# 02 Prep Salmon Data
source("Data/Prep_Salmon_Data.R")

# 03 Prep Pinniped Data
source("Data/Prep_Pinniped_Data.R")

# 04 Set Pars
source("RunTheModel/03_set_pars.R")

list <- seq(0,1,0.2)

for(i in 1:length(specialist_prob)){
  specialist_prob <- list[i]
  
  # 05 Initialize Variables
  source("RunTheModel/04_initialize_variables.R")
  
  # 06 Loop Functions
  source("ParameterManipulations/loadLoopFunctions.R")
  
  # 07 Run The Loop
  source("ParameterManipulations/runLoop.R")
  
  # 08 Plots
  source("Functions/Plots_Pv.R")
  source("Functions/Plots_salmon.R")
  source("Functions/Plots_responses.R")
}


