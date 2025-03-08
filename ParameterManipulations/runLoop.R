# run the loop

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