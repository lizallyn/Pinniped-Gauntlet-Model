# function for calculating d_y if they go to the gauntlet

learnY <- function(hunting, boats, learn_rate, rho, forage_loc, w1, w2, w3,
                   dead) {
  x1 <- boats
  x2 <- hunting #features
  x3 <- forage_loc
  y <- hunting #consequence
  
  w1 <- as.numeric(w1)
  w2 <- as.numeric(w2)
  w3 <- as.numeric(w3)
  
  if(dead == TRUE){
    y_hat <- NA
    w1_1 <- NA
    w2_1 <- NA
    w3_1 <- NA
  } else {
    y_hat <- max((w1 + w2 + w3), 0)
    w1_1 <- w1 + learn_rate * x1 * (y - y_hat) - decay * w1
    w2_1 <- w2 + learn_rate * x2 * (y - y_hat) - decay * w2
    w3_1 <- w3 + learn_rate * x3 * (y - y_hat) - decay * w3
  }
  
  return(tibble(y_hat = y_hat, w1 = w1_1, w2 = w2_1, 
                w3 = w3_1))
  
}


# learnY(hunting = 0, boats = 0, y_hat = 0, step = step, decay = decay, y_pars = y_pars, 
#        forage_loc = 1, dead = F, baseline = base_y)
