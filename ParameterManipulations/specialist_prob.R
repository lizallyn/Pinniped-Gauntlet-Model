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
  if(no_seals == F && no_zc == F && no_ej == F){
    source("Functions/rungeKutta_3.R")
    source("RunTheModel/06_The_Loop.R")
    source("Functions/Plots_Ej.R")
    source("Functions/Plots_Zc.R")
  } else if(no_seals == F && no_zc == F && no_ej == T){
    source("Functions/rungeKutta_2.R")
    source("RunTheModel/06_The_Loop_pv_zc.R")
    source("Functions/Plots_Zc.R")
  } else if(no_seals == F && no_zc == T && no_ej == F){
    source("Functions/rungeKutta_2.R")
    # add if needed later
    source("Functions/Plots_Ej.R")
  } else if(no_seals == F && no_zc == T && no_ej == T){
    source("Functions/rungeKutta.R")
    source("RunTheModel/06_The_Loop_pv.R")
  } else {print("Error in pinniped accounting! They cannot count and neither can you!")}
  
  # 08 Plots
  source("Functions/Plots_Pv.R")
  source("Functions/Plots_salmon.R")
  source("Functions/Plots_responses.R")
}


