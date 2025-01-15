# creates a type III functional response

type3FuncRes.A <- function(bundle_shape_pars, val){
  buffer <- bundle_shape_pars["buffer"]
  steepness <- bundle_shape_pars["steepness"]
  threshold <- bundle_shape_pars["threshold"]
  
  y <- 1-(1/((1+buffer) + exp(-steepness * (threshold - val))))
  
  return(as.numeric(y))
}

type3FuncRes <- function(bundle_shape_pars, val){
  A <- bundle_shape_pars["asymp_left"]
  B <- bundle_shape_pars["steepness"]
  Q <- bundle_shape_pars["shift"]
  K <- bundle_shape_pars["asymp_right"]
  
  res <- A + (K - A) / (1 + Q * exp(-B*val))
  
  return(as.numeric(res))
}

# val <- seq(0, 10, 1)
# bundle_shape_pars <- data.frame(buffer = 0, steepness = 0.75, threshold = 200)
# type3FuncRes(bundle_shape_pars, val)
