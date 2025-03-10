# creates a type III functional response

type3FuncRes.A <- function(bundle_shape_pars, val){
  buffer <- bundle_shape_pars["buffer"]
  steepness <- bundle_shape_pars["steepness"]
  threshold <- bundle_shape_pars["threshold"]
  
  y <- 1-(1/((1+buffer) + exp(-steepness * (threshold - val))))
  
  return(as.numeric(y))
}

# val <- seq(0, 10, 1)
# bundle_shape_pars <- data.frame(buffer = 0, steepness = 0.75, threshold = 200)
# type3FuncRes(bundle_shape_pars, val)

type3FuncRes <- function(bundle_shape_pars, val){
  A <- bundle_shape_pars["asymp_left"]
  B <- bundle_shape_pars["steepness"]
  Q <- bundle_shape_pars["shift"]
  K <- bundle_shape_pars["asymp_right"]
  
  res <- A + (K - A) / (1 + Q * exp(-B*val))
  
  return(as.numeric(res))
}

# val <- 0.1
# bundle_x_sl <- tibble(asymp_right = asymp_right_x_sl_val, 
#                       asymp_left = asymp_left_x_sl_val, 
#                       shift = shift_x_sl_val, steepness = steepness_x_sl_val)
# type3FuncRes(bundle_x_sl, val)

type3FuncRes.B <- function(bundle_shape_pars, val){
  p <- bundle_shape_pars["asymp_left"]
  u <- bundle_shape_pars["steepness"]
  z <- bundle_shape_pars["shift"]
  v <- bundle_shape_pars["asymp_right"]
  
  res <- ((v - (((1+exp(u*z)) * p - v)/exp(u*z))) / (exp(-z*(x-u))+1)) +
    (((1+exp(u*z)) * p - v)/((1+exp(u*z)) - 1))
  
  return(as.numeric(res))
}

