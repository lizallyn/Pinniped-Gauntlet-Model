# creates a type III functional response

type3FuncRes.A <- function(bundle_shape_pars, val){
  buffer <- bundle_shape_pars["buffer"]
  steepness <- bundle_shape_pars["steepness"]
  threshold <- bundle_shape_pars["threshold"]
  
  y <- 1-(1/((1+buffer) + exp(-steepness * (threshold - val))))
  
  return(as.numeric(y))
}

type3FuncRes <- function(bundle_shape_pars, val){
  A <- bundle_shape_pars["buffer"]
  B <- bundle_shape_pars["steepness"]
  Q <- bundle_shape_pars["threshold"]
  
  y <- A + (K - A) / (1 + Q * exp(-B*val))
  
  return(as.numeric(y))
}
