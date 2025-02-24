# for Y receptivity

receptivityY <- function(pars, y_t){
  m <- pars["height"]
  c <- pars["width"]
  
  res <- m * exp(-c*y_t)
  return(as.numeric(res))
}

# receptivityY(pars = tibble(height = sqrt(0.5), width = 6), 0)
