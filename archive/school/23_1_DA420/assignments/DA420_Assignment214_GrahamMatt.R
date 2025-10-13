# Source: http://statistics.berkeley.edu/classes/s133/heart.r
heart1 = function(name){
  t = seq(0,60,len=100)
  plot(c(-8,8),c(0,20),type='n',axes=FALSE,xlab='',ylab='')
  x = -.01*(-t^2+40*t+1200)*sin(pi*t/180)
  y = .01*(-t^2+40*t+1200)*cos(pi*t/180)
  lines(x,y, lwd=4)
  lines(-x,y, lwd=4)
  text(0,7,"Happy Valentine's Day",col='red',cex=2.5)
  text(0,5.5,name,col='red',cex=2.5)
}

heart1("Matt!")
