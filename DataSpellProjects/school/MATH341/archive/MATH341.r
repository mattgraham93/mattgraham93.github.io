x = c(2, 6, 8, 12, -19, 30, 0, -5, 7, 16, 23, 38, -29, 35, 1, -28)
y = c(9,2,-4,42,9,23,-3,-6,5,22,-14,51,65,3,-16,-3)

mean(x)

median(x)

hist(x)

stem(x)

sort(x)

quantile(x, seq(0,1),.1)

p = c(.1,.34,.68,.93)

quantile(x,p)

IQR(x)

var(x)

sd(x)

mad(x)

boxplot(x)

plot(x,y)

cor(x,y)

n = length(x)
i = seq(1:n)
u = (i-.5)/n
s = sort(x)
plot(u, s)

y = c(0:9)
x = sample(y, 1000, replace=T)
x

# p(x = 3)
dbinom(3,10,.6)

# p(x <= 3)
pbinom(3,10,.6)

# p(x >= 4)
1 - pbinom(4,10,.6)

# calculate k probabilities
k = c(0:10)
dbinom(k,10,.6)

# p(x = 3)
dbinom(3,10,.6)

# p(x <= 3)
pbinom(3,10,.6)

# calculate k probabilities
k = c(0:10)
dbinom(k,10,.6)

# p(x <= 18)
pnorm(18,23,5)

# p(x > 18)
1 - pnorm(18,23,5)

# find percentile
q(.85, 23, 5)

r = 10000
y = rep(0,16)
ybar16 = rep(0, r)

for (i in 1:r) {
    y = rnorm(16,43,7)
    ybar16[i] = mean(y)
}

hist(ybar16)

mean(ybar16)

sd(ybar16)

y = c(133, 137, 148, 149, 152, 167, 174, 179, 189, 192, 201, 209, 210, 211, 218, 238, 245, 248, 253, 257)

sort(y)

n = length(y)
i = 1:n
u = (i - .375)/(n+.25)
x = qnorm(u)

plot(x,y, xlab = "Normal quantiles", ylab = "Cholesterol readings", lab = c(7,8,7),
    ylim = c(100,280), main = "Normal Reference Distribution Plot\n Cholesterol readings", cex = .95)
abline(lm(y ~ x))

cor(x,y)


