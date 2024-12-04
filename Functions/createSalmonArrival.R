# function to create daily arrival counts
# buffer = how many sd to make the date range encompass everything
create_salmon_arrival <- function(buffer, run_info, arrival){
  start_date <- min(run_info$Peak_Date) - 
    (buffer * run_info$sd[which(run_info$Peak_Date == min(run_info$Peak_Date))])
  end_date <- max(run_info$Peak_Date) + 
    (buffer * run_info$sd[which(run_info$Peak_Date == max(run_info$Peak_Date))])
  arrival <- data.frame(Day = start_date:end_date)
  num_runs <- nrow(run_info)
  for(t in 1:num_runs){
    sd <- run_info$sd[t]
    run_size <- run_info$Run_Size[t]
    peak_date <- run_info$Peak_Date[t]
    arrival[,t+1] <- floor(run_size * 
                             dnorm(start_date:end_date, 
                                   peak_date, sd = sd))
  }
  return(arrival)
}

# looks good!
# test <- create_salmon_arrival(5, run_info, arrival)
# days <- test$Day[1]:max(test$Day)
# plot(days, test[,2])
# lines(days, test[,3])