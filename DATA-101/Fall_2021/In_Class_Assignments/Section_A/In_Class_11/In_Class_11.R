## Reading the csv file 
autos = read.csv(file = 'Automobile_data.csv')
head(autos)

## Creating the scatter-plot
plot(autos$wheel.base, autos$length, xlab = 'Wheel Base', ylab = 'Length', pch = 16, col = 'blue')
grid()

## Building the linear model 
lm_md = lm(length ~ wheel.base, data = autos)

## Checking for constant variance 
plot(fitted(lm_md), residuals(lm_md), xlab = 'Fitted Values', ylab = 'Residuals', pch = 16)
abline(h = 0, lwd = 2)
grid()

## From the scatter-plot, we see a patter in the 
## residuals (upside-down parabola), which indicates 
## the constant variance assumption is not met