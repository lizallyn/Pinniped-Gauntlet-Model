# with x as Px to get rid of Px

updateLearning <- function(salmon_consumed, w, hunting, boats, x_t, step, decay, forage_loc, 
                           x_pars, dead, baseline_x, rho, learn_rate, w1, w2, w3,
                           specialist, bundle_x, bundle_x_spec = NA, bundle_y, bundle_y_spec = NA){
  
  C <- salmon_consumed - w
  
  d_x <- learnX(food = C, x_t = x_t, step = step, decay = decay, 
                forage_loc = forage_loc, x_pars = x_pars, 
                dead = dead, baseline = baseline_x)
  x_t1 <- x_t + d_x
  
  update <- learnY(hunting = hunting, boats = boats,
                   forage_loc = forage_loc, rho = rho, learn_rate = learn_rate,
                   dead = dead, w1 = w1, w2 = w2, w3 = w3)
  y <- as.numeric(update["y_hat"])
  
  
  if(specialist == TRUE){
    P_x <- x_t1
    P_y <- 1 - y
  } else {
    P_x <- x_t1
    P_y <- 1 - y
  }
  
  return(tibble(x_t1 = x_t1, y_t1 = y, P_x = P_x, P_y = P_y,
                w1 <- update["w1"], w2 <- update["w2"],
                w3 <- update["w3"]))
  
}

# updateLearning(salmon_consumed = salmon_consumed_pv[seal, t], w = w, hunting = H[t],
#              x_t = x[seal, t], y_t = y[seal, t],
#              forage_loc = seal_forage_loc[seal, t], bundle_dx_pars = bundle_dx_pars,
#              bundle_dy_pars = bundle_dy_pars, dead = seal %in% kill_list,
#              baseline_x = baseline_x[seal], baseline_y = baseline_y[seal],
#              specialist = seal %in% specialist_seals, bundle_x_shape_pars,
#              bundle_x_linear_pars, bundle_y_shape_pars)

# updateLearning(salmon_consumed = 10, boats = 1, w = w, hunting = 0, rho = rho, learn_rate = learn_rate,
#                x_t = 4, forage_loc = 1, step = step, decay = decay,
#                x_pars = x_pars, dead = F, specialist = F, w2 = 0.3, w1 = 0.2,
#                baseline_x = base_x, bundle_x = bundle_x, w3 = 0.3,
#                bundle_y = bundle_y, bundle_x_spec = bundle_x_spec,
#                bundle_y_spec = bundle_y_spec)

