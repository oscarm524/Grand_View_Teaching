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


##################################
## Constant variance assumption ##
##################################

## Here we read the data 
advertising = read.csv(file = 'Advertising.csv')

## Here we fit the simple linear model
md = lm(Sales ~ TV, data = advertising)

## Here we print the model summary results
summary(md)

## Here we check for constant variance by creating the scatter plot
plot(fitted(md), residuals(md), xlab = 'TV', ylab = 'Residuals')
grid()
abline(h = 0, lwd = 2)


###############
## R-squared ##
###############

## Here we read the data 
advertising = read.csv(file = 'Advertising.csv')

## Here we fit the simple linear model
md = lm(Sales ~ TV, data = advertising)

## Here we print the model summary results
summary(md)$r.squared


################################
## Multiple Linear Regression ##
################################

## Here we read the data 
advertising = read.csv(file = 'Advertising.csv')

## Here we fit the multiple linear model
md = lm(Sales ~ TV + Radio + Newspaper, data = advertising)

## Here we print the model summary results
summary(md)
