
#' Densité de loi normale multivariée
#'
#'Calcule les images par la fonction de densité d'une gaussienne multivariée
#'
#' @param x pxn matrice avec n le nombre de d'observation et p le nombre de dimension
#' @param mean vecteur de moyenne de la gaussienne (de taille px1)
#' @param varcovM matrice de covariance de la gaussienne (de taille pxp)
#' @param Log si True, retournera le logarithme des densités. Par défaut, la valeur est TRUE.
#'
#' @return une liste contenant la matrice d'entrée x et y les valeurs de la densité
#' de la gaussienne multivariée en x
#' @export
#'
#' @examples
#' mvnpdf(x=matrix(1.96), Log=FALSE)
#'dnorm(1.96)
#'
#'mvnpdf(x=matrix(rep(1.96, 2), nrow=2, ncol=1), Log=FALSE)
#'
mvnpdf <- function(x, mean =  rep(0, nrow(x)),
                   varcovM = diag(nrow(x)), Log = TRUE){
  n<-ncol(x)
  p<-nrow(x)
  x0<-x-mean
  Rinv <- solve(varcovM)
  det<-det(varcovM)

  y<-NULL
  for (i in 1:n){
    yj<-1/((2*pi)^(p/2)*det^(1/2))*exp(-0.5*t(x0[,i]) %*% Rinv %*% x0[,i])
    y<-c(y,yj)
  }

  if(Log){
    y<-log(y)
  }

  res<-list(x=x, y=y)
  return(res)
}

#' Plot of the mvnpdf function
#'
#' @param x an object of class \code{mvnpdf} resulting from a call of
#' \code{mvnpdf()} function.
#' @param ... graphical parameters passed to \code{plot()} function.
#'
#' @return Nothing is returned, only a plot is given
#' @export
#'
#' @examples
#' pdfvalues <- mvnpdf(x=matrix(seq(-3,3, by=0.1), nrow=1), Log=FALSE)
#' plot(pdfvalues)
plot.mvnpdf <- function(x, ...){
  graphics::plot(x$x[1, ], x$y, type = "l", ylab="mvnpdf", xlab="Obs (1st dim)", ...)
}



