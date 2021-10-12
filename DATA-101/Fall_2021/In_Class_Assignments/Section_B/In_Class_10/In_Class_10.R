## Reading the csv file 
autos = read.csv(file = 'Automobile_data.csv')
head(autos)

## Creating the scatter-plot
plot(autos$wheel.base, autos$length, xlab = 'Wheel Base', ylab = 'Length', pch = 16, col = 'blue')
grid()

## In the scatter-plot, we see that there is a positive
## linear relationship between wheel-base and length

## Building the linear model
lm_md = lm(length ~ wheel.base, data = autos)

## Extracting model results
summary(lm_md)

## Slope interpretation
## For one unit of increase in wheel base,
## on average, length increases by 1.844
