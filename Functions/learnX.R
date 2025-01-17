# function for calculating d_x

learnX <- function(food, x_t, step, decay, x_pars, forage_loc,
                   dead, baseline) {

  xmin <- as.numeric(x_pars["xmin"])
  xmax <- as.numeric(x_pars["xmax"])
  
  
  if(dead == TRUE){
    d_x <- NA
  } else {
    if(forage_loc == 0){
      if(x_t == baseline){
        d_x <- 0
      } else {
        d_x <- max(-decay, (baseline - x_t))
      }
    } else {
      if(food > 0){
        lambda <- presence
        d_x <- step * (lambda - x_t)
      } else  if(food <= 0){
        lambda <- absence
        d_x <- step * (lambda - x_t)
      }
    }
  }
  
  return(as.numeric(d_x))
}

# learnX(food = 1, x_t = 1, step = step, decay = decay, x_pars = x_pars,
#        forage_loc = 1, dead = F, baseline = 0)
