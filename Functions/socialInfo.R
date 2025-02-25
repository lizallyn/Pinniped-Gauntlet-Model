# social information sharing using combined receptivity term

socialInfo <- function(network, receptivity, locs){
  seals_in_clique <- which(network > 0)
  social_info <- mean(locs[seals_in_clique])
  return(social_info)
}
