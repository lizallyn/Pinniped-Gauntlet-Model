# function for calculating d_y if they go to the gauntlet

learnY <- function(hunting, y_t, step, decay, y_pars, forage_loc, bundle_dy_pars, 
                   dead, baseline) {

  ymin <- y_pars["ymin"]
  ymax <- y_pars["ymax"]
  

  if(dead == TRUE){
    d_y <- NA
  } else if(forage_loc == 0){
    if(y_t >= baseline) {
      d_y <- 0
    } else {
      d_y <- decay
      }
  } else {
    if(hunting == 0){
      d_y <- step * (ymax - y_t)
    } else if(hunting > 0){
      d_y <- step * (ymin - y_t)
    }
  }
  
  return(as.numeric(d_y))
}
