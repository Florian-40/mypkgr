#' logarithm with parallel
#'
#' @param x a vector to calculate logarithm
#' 
#' @import foreach
#' @importFrom parallel detectCores
#' @importFrom parallel makeCluster
#' @importFrom doParallel registerDoParallel
#' 
#' @return logarithm of each coordinate of x
#' @export
#' 
#' @examples 
#' log_par(1:100)
log_par <- function(x){
  chk <- Sys.getenv("_R_CHECK_LIMIT_CORES_", "")
  
  if (nzchar(chk) && chk == "TRUE") {
    # use 2 cores in CRAN/Travis/AppVeyor
    Ncpus <- 2L
  } else {
    # use all cores in devtools::test()
    Ncpus <- parallel::detectCores()-1
  }
  cl <- parallel::makeCluster(Ncpus)
  doParallel::registerDoParallel(cl)
  i<-0
  res <- foreach(i=1:length(x), .combine='c') %dopar%(log(x[i]))
  parallel::stopCluster(cl)
  return(res)
}

#' logarithm sequentiel
#'
#' @param x a vector 
#'
#' @return a vector of logarithm of x
#' @export
#'
#' @examples
#' log_seq(1:100)
log_seq <- function(x){
  # try this yourself (spoiler alert: it is quite long...):
  #res <- numeric(length(x))
  #for(i in 1:length(x)){
     #res[i] <- log(x[i])
  # }
  #return(res)
  return(log(x))
}
