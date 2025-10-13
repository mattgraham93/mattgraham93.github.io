my.datafile <- tempfile()
cat(file=my.datafile, "
49 1809 43 1590 25
25 1841 28 1560 19
40 1659 30 1620 38
52 1779 57 1540 26
58 1616 52 1420 30
32 1695 27 1660 23
43 1730 52 1610 33
47 1740 43 1580 26
31 1685 23 1610 26
26 1735 25 1590 23
", sep=" ")

options(scipen=999) # suppressing scientific notation
huswif <- read.table(my.datafile, header=FALSE, col.names=c("Hage",
                                                            "Hheight", "Wage", "Wheight", "Hagefm"))
attach(huswif) #attaching the data frame

# Getting the sample mean vector:
colMeans(huswif)
# Getting the sample covariance matrix:
round(var(huswif),digits=2)
# Getting the sample correlation matrix:
round(cor(huswif),digits=2)
# Calculations to show the relationship between the covariance and correlation matrices:
my.S <- var(huswif)
D.minus.12 <- diag( 1/sqrt(diag(my.S) ) )
my.R <- D.minus.12 %*% my.S %*% D.minus.12
my.R
cov2cor(my.S)

# Getting distance matrix (Euclidean distances) between raw observations
dis <- dist(huswif)
dist2full<-function(ds){
  n<-attr(ds,"Size")
  full<-matrix(0,n,n)
  full[lower.tri(full)]<-ds
  full+t(full)
}
dis.matrix<-dist2full(dis)
round(dis.matrix,digits=2)

# Getting distance matrix (Euclidean distances) between SCALED observations
std <- sapply(huswif, sd) # finding standard deviations of variables
huswif.std <- sweep(huswif,2,std,FUN="/") # dividing each variable by its standard deviation
dis <- dist(huswif.std)
dis.matrix<-dist2full(dis)
round(dis.matrix,digits=2)

# Normality Check
# Normal Q-Q plots for the first four variables in the data set, considered separately:
# This checks normality of the marginal distributions

par(mfrow=c(2,2)) # Setting up for a 2 by 2 array of plots
qqnorm(huswif[,1], ylab="Ordered Observations", main = "Normal Q-Q
Plot, Husband's Age")
qqline(huswif[,1])
qqnorm(huswif[,2], ylab="Ordered Observations", main = "Normal Q-Q
Plot, Husband's Height")
qqline(huswif[,2])
qqnorm(huswif[,3], ylab="Ordered Observations", main = "Normal Q-Q
Plot, Wife's Age")
qqline(huswif[,3])
qqnorm(huswif[,4], ylab="Ordered Observations", main = "Normal Q-Q
Plot, Wife's Height")
qqline(huswif[,4])
par(mfrow=c(1,1))

# Using Everitt's chisplot function to check multivariate normality of entire data set:
#Copy the chisplot function into R
chisplot <- function(x) {
  if (!is.matrix(x)) stop("x is not a matrix")
  ### determine dimensions
  n <- nrow(x)
  p <- ncol(x)
  xbar <- apply(x, 2, mean)
  S <- var(x)
  S <- solve(S)
  index <- (1:n)/(n+1)
  xcent <- t(t(x) - xbar)
di <- apply(xcent, 1, function(x,S) x %*% S %*% x,S)
quant <- qchisq(index,p)
plot(quant, sort(di), ylab = "Ordered distances",
xlab = "Chi-square quantile", lwd=2,pch=1)
}

chisplot(as.matrix(huswif))