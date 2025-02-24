# for the skewed dist that peaks at naive x value

receptivityX <- function(pars, x_t){
  m <- pars["height"]
  b <- pars["width"]
  c <- pars["naive_peak"]
  
  res <- (m*x_t^((c*(b-2)+1)/(1-c) - 1) * (1-x_t)^(b-1)) / 
    (c^((c*(b-2)+1)/(1-c)-1)*(1-c)^(b-1))
  
  return(as.numeric(res))
  
}

# receptivityX(pars = tibble(height = sqrt(0.5), width = 4.5, naive_peak = 0.01), 0.1)
