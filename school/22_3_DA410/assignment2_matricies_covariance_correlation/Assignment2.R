# 3.10
# Use the calcium data in Table 3.4:
# (a) Calculate S using the data matrix Y as in (3.29).\
# (c) Find R using (3.37)
location <- c(1,2,3,4,5,6,7,8,9,10)
y1 <- c(35,35,40,10,6,20,35,35,35,30)
y2 <- c(3.5,4.9,30.0,2.8,2.7,2.8,4.6,10.9,8.0,1.6)
y3 <- c(2.80,2.70,4.38,3.21,2.73,2.81,2.88,2.90,3.28,3.20)

cal_yield <- cbind(y1,y2,y3)
cal_yield_prime <- t(cal_yield)
n <- dim(cal_yield)[1] # get length of calcium yields

# a: calculate S using data matrix Y as in 3.29
S <- cor(cal_yield)

# c: Find R using 3.37
R <- var(cal_yield)

# 3.14
# For the variables in Table 3.4, define z = 3yi — yi + 2yz = (3, —1,2)y. Find
# ~z and s\ in two ways:


# (a) Evaluate z for each row of Table 3.4 and find ~z and s2z directly from
# ζι,ζ2,...,ζιο using (3.1) and (3.5).
lin_comb <- matrix(c(3, -1, 2), nrow=1)
a <- t(lin_comb)
yield_means <- matrix(colMeans(cal_yield))
yield_means

z_bar <- lin_comb %*% yield_means
z_bar

s2z <- lin_comb %*% S %*% a
s2z

# 3.21
# The data in Table 3.8 consist of head measurements on first and second sons
# (Frets 1921). Define j/i and yi as the measurements on the first son and x\
# and X2 for the second son.

t3_8 <- read.table("../data/T3_8_SONS.DAT", header=FALSE,
                   col.names=c("FHL", "FHB", "SHL", "SHB"))
attach(t3_8)

# (a) Find the mean vector for all four variables and partition it into (x_bar/y_bar) as in
# (3.41).
colMeans(t3_8)


# (b) Find the covariance matrix for all four variables and partition it into
my.S <- round(var(t3_8), digits=2)
# my.R <- round(cor(t3_8), digits=2)
my.S
# my.R