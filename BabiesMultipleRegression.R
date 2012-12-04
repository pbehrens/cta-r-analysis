# load ggplot to use later on to make some simple plots
library(ggplot2)

baby.data <- na.omit(read.csv(file="data/babies.txt", head=TRUE, sep=" "))
# set column names
colnames(baby.data) <- c("BirthWeight", "Gestation", "Parity", "Age", "Height", "Weight", "Smoke")

summary(baby.data)

cor(baby.data)

ggplot(baby.data, aes(x = BirthWeight, y = Smoke)) + geom_point()
ggplot(baby.data, aes(x = Gestation, y = BirthWeight)) + geom_point()

ggplot(baby.data, aes(x = Gestation, y = BirthWeight)) + 
geom_point()+
geom_smooth(method = 'lm', se = FALSE)