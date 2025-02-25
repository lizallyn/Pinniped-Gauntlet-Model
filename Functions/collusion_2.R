# social information sharing using combined receptivity term

socialInfo <- function(network, receptivity, probs){
  seals_in_clique <- which(network > 0)
  social_info <- mean(probs[seals_in_clique])
  
}