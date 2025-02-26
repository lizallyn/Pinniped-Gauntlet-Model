# function for calculating d_x

learnX <- function(food, x_t, step, decay, x_pars, forage_loc,
                   dead, baseline) {

  xmin <- as.numeric(x_pars["xmin"])
  xmax <- as.numeric(x_pars["xmax"])
  baseline <- as.numeric(baseline)
  
  
  if(dead == TRUE){
    d_x <- NA
  } else {
    if(forage_loc == 0){
      if(x_t == baseline){
        d_x <- 0
      } else {
        d_x <- decay * (baseline - x_t)
      }
    } else {
      if(food > 0){
        d_x <- step * (xmax - x_t)
      } else  if(food <= 0){
        d_x <- step * (xmin - x_t)
      }
    }
  }
  
  return(as.numeric(d_x))
}

