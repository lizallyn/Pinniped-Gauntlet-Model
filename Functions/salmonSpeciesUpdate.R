# function that adds the arriving salmon of each run
# for a given day of the year

library(tidyr)
library(dplyr)



salmonSpeciesUpdate <- function(day, salmon_list, arrive_data) {
  onthisday <- NA
  for (i in 1:nrow(salmon_list)){
    onthisday[i] <- salmon_list[i, "Count"] + 
      (arrive_data %>% slice(day) %>% pull(salmon_list$Run[i]))
  }
  return(data.frame(Run = salmon_list$Run,
                    Count = onthisday))
}

# salmon_list <- data.frame(Run = run_info$Run, Count = c(150, 10))
# salmonSpeciesUpdate(20, salmon_list, arrive_data = salmon_arrival)
