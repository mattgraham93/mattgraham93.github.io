
#################################
## Code for use in R (not SAS) ##
#################################

X <- read.table("T10_1_CHEM.dat")
X <- as.matrix(cbind(rep(1,19),X[,5:7]))

Y <- read.table("T10_1_CHEM.dat")
Y <- as.matrix(Y[,2:4])

Bhat <- solve(t(X)%*%X) %*% t(X)%*%Y
Bhat

n <- nrow(X)
q <- ncol(X)-1

Se <- 1/(n-q-1) *  ( t(Y)%*%Y - t(Bhat)%*%t(X)%*%Y )
Se

xo <- c(1, 160,25,5)

covBhat <- kronecker(Se, solve(t(X)%*%X))
covBhat
sqrt(diag(covBhat))

varEy <- Se * c(t(xo) %*% solve(t(X)%*%X) %*% xo)
sqrt(diag(varEy))

vary <- Se * c(1 + t(xo) %*% solve(t(X)%*%X) %*% xo)
sqrt(diag(vary))

round(cbind(  t(Bhat) %*% xo - qt(.975,15)*sqrt(diag(varEy)),
        t(Bhat) %*% xo + qt(.975,15)*sqrt(diag(varEy)) ) ,2 )

round(cbind(  t(Bhat) %*% xo - qt(.975,15)*sqrt(diag(vary)),
        t(Bhat) %*% xo + qt(.975,15)*sqrt(diag(vary)) ) ,2 )




