# social information sharing using combined receptivity term

socialInfo <- function(network, receptivity, probs, self){
  seals_in_clique <- which(network > 0)
  if(length(seals_in_clique > 0)){
    social_info <- mean(probs[seals_in_clique], na.rm = TRUE)
    return(as.numeric(social_info))
  } else {return(as.numeric(probs[self]))}
}
