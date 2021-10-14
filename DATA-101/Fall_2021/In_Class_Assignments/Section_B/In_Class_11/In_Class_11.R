## Reading the csv file 
autos = read.csv(file = 'Automobile_data.csv')
head(autos)

## Creating the scatter-plot between wheel-base and length
plot(autos$wheel.base, autos$length, xlab = 'Wheel Base', ylab = 'Length', pch = 16, col = 'blue')
grid()

## From the scatter-plot, it seems that there is 
## a positive linear relationship between wheel base and 
## length

## Building the linear model 
lm_md = lm(length ~ wheel.base, data = autos)

## Checking for constant variance 
plot(fitted(lm_md), residuals(lm_md), xlab = 'Fitted Values', ylab = 'Residuals', pch = 16, col = 'blue')
abline(h = 0, lwd = 2)
grid()

## The residuals seems to follow a patter (upside-down parabola)
## which indicates that constant variance is not met.
