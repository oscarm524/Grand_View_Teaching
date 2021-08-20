####################
## Chapter 5 Code ##
####################

## Here we read the data 
advertising = read.csv(file = 'Advertising.csv')

## Here we fit the simple linear model
md = lm(Sales ~ TV, data = advertising)

## Here we print the model summary results
summary(md)

################################
## Checking linear assumption ##
################################

## Here we read the data 
advertising = read.csv(file = 'Advertising.csv')

## Here we fit the simple linear model
md = lm(Sales ~ TV, data = advertising)

## Here we print the model summary results
summary(md)

## Here we check for linearity by creating the scatter plot
plot(advertising$TV, residuals(md), xlab = 'TV', ylab = 'Residuals')
grid()
abline(h = 0, lwd = 2)
