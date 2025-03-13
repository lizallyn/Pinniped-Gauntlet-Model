# using conversion from Oneill 2014

chinookKcal <- function(length_mm){
  (length_mm^3.122) * 0.000011
}


cohoWeight <- function(length_cm){
  ln_w <- -5.468 + 3.151 * log(length_cm)
  weight <- exp(ln_w)
  ln_kcal <- 0.94 * ln_w + 7.31
  kcal <- exp(ln_kcal)
  return(data.frame(weight = weight, kcal = kcal))
}

cohoWeight(56.7)
