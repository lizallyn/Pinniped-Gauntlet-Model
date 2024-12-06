# function that adds the arriving salmon of each run
# for a given day of the year

library(tidyr)
library(dplyr)

salmonSpeciesUpdate <- function(day, salmon_list, arrive_data) {
  onthisday <- data.frame(day)
  for (i in 2:ncol(salmon_list)){
    onthisday[i] <- salmon_list[i] + 
      (arrive_data %>% slice(day) %>% pull(colnames(salmon_list[i])))
  }
  colnames(onthisday) <- colnames(salmon_list)
  return(onthisday)
}

# salmonSpeciesUpdate(50, daily_salmon_list, arrive_data = salmon_arrival)
