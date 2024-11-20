K_to_C <- function(tempK){
  C <- (tempK - 273.5) 
  return(C)
}


f_to_k <- function(tempF){
  k <- ((tempF - 32) * (5/9)) + 273.15 
  return(k)
}