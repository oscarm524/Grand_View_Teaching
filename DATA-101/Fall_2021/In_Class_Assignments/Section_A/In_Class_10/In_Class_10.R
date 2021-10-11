## Reading the csv file 
autos = read.csv(file = 'Automobile_data.csv')
head(autos)

## Creating the scatter-plot
plot(autos$length, autos$wheel.base, col = 'blue', pch = 16, xlab = 'Length', ylab = 'Wheel Base')
grid()

## Building the linear model
lm_md = lm(length ~ wheel.base, data = autos)

## Extracting model results 
summary(lm_md)

## The estimated slope is 1.844
## Interpretation: for one unit of increase in wheel base, 
## on average, length increases by 1.844
