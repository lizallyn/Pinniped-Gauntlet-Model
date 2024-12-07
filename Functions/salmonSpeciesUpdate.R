# function that adds the arriving salmon of each run
# for a given day of the year

library(tidyr)
library(dplyr)

salmonSpeciesUpdate <- function(day, salmon, arrive_data) {
  onthisday <- data.frame(day)
  for (i in 2:ncol(salmon)){
    onthisday[i] <- salmon[i] + 
      (arrive_data %>% slice(day) %>% pull(colnames(salmon[i])))
  }
  colnames(onthisday) <- colnames(salmon)
  return(onthisday)
}

# salmonSpeciesUpdate(50, daily_salmon_list, arrive_data = salmon_arrival)
