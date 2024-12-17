# w
# offset from missed foraging opportunities outside the Gauntlet

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

list <- seq(from = 0, to = 20, length.out = 5)
Escape <- data.frame(matrix(data = NA, ncol = n_species+1))
Consumed <- data.frame(matrix(data = NA, ncol = n_species+1))

for(i in 1:length(list)){
  w <- list[i]
  w_sealion <- list[i] * 3
  
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
  
  ## save relevant variables and responses
  Escape[i,] <- c(list[i], salmon_escapement)
  Consumed[i,] <- c(list[i], salmon_eaten)
}

colnames(Escape) <- c("Par", rownames(run_info))
colnames(Consumed) <- c("Par", rownames(run_info))
escape_plot <- makePlot_4(data = Escape, variable.name = "Run", 
                          value.name = "Salmon Escaped", colors = colors_salmon,
                          loop_days = F, start_loop = 1)
eaten_plot <- makePlot_4(data = Consumed, variable.name = "Run", 
                         value.name = "Salmon Eaten", colors = colors_salmon,
                         loop_days = F, start_loop = 1)
escape_plot
eaten_plot


