airpol.full <- read.table("C:/mattgraham93.github.io/school/22_3_DA410/data/airpoll.txt", header=TRUE)

city.names <- as.character(airpol.full[1:16,1])
airpol.data.sub <- airpol.full[1:16,2:8]

airpol.data.sub