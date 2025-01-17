# function for calculating d_y if they go to the gauntlet

learnY <- function(hunting, y_t, step, decay, y_pars, forage_loc, 
                   dead, baseline) {

  ymin <- as.numeric(y_pars["ymin"])
  ymax <- as.numeric(y_pars["ymax"])
  

  if(dead == TRUE){
    d_y <- NA
  } else {
    if(forage_loc == 0) {
      if(y_t == baseline) {
        d_y <- 0
      } else {
        d_y <- max(-decay, (baseline - y_t))
      }
    } else {
      if(hunting == 0) {
        lambda <- absence
        d_y <- step * (lambda - y_t)
      } else if(hunting > 0){
        lambda <- presence
        d_y <- step * (lambda - y_t)
      }
    }
  }
  
  return(as.numeric(d_y))
}

# learnY(hunting = 0, y_t = 2, step = step, decay = decay, y_pars = y_pars, 
#        forage_loc = 1, dead = F, baseline = base_y)
