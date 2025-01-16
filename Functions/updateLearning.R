

updateLearning <- function(salmon_consumed, w, hunting, x_t, y_t, step, decay, forage_loc, 
                         x_pars, y_pars, dead, baseline_x, baseline_y,
                         specialist, bundle_x, bundle_x_spec = NA, bundle_y, bundle_y_spec = NA){
  
  C <- salmon_consumed - w
  
  d_x <- learnX(food = C, x_t = x_t, step = step, decay = decay, 
                forage_loc = forage_loc, x_pars = x_pars, 
                dead = dead, baseline = baseline_x)
  d_y <- learnY(hunting = hunting, y_t = y_t, step = step, decay = decay, 
                forage_loc = forage_loc, y_pars = y_pars, 
                dead = dead, baseline = baseline_y)
  
  x_t1 <- x_t + d_x
  y_t1 <- y_t + d_y
  
  if(specialist == TRUE){
    P_x <- type3FuncRes(bundle_x_spec, val = x_t1)
    P_y <- type3FuncRes(bundle_y_spec, val = y_t1)
  } else {
    P_x <- type3FuncRes(bundle_x, val = x_t1)
    P_y <- type3FuncRes(bundle_y, val = y_t1)
  }
  
  return(tibble(x_t1 = x_t1, y_t1 = y_t1, P_x = P_x, P_y = P_y))
  
}

# updateLearning(salmon_consumed = salmon_consumed_pv[seal, t], w = w, hunting = H[t],
#              x_t = x[seal, t], y_t = y[seal, t],
#              forage_loc = seal_forage_loc[seal, t], bundle_dx_pars = bundle_dx_pars,
#              bundle_dy_pars = bundle_dy_pars, dead = seal %in% kill_list,
#              baseline_x = baseline_x[seal], baseline_y = baseline_y[seal],
#              specialist = seal %in% specialist_seals, bundle_x_shape_pars,
#              bundle_x_linear_pars, bundle_y_shape_pars)

# updateLearning(salmon_consumed = 10, w = w, hunting = 0,
#                x_t = 4, y_t = 2, forage_loc = 0, step = step, decay = decay, 
#                x_pars = x_pars, y_pars = y_pars, dead = F, specialist = F, 
#                baseline_x = base_x, baseline_y = base_y, bundle_x = bundle_x, 
#                bundle_y = bundle_y, bundle_x_spec = bundle_x_spec, 
#                bundle_y_spec = bundle_y_spec)

