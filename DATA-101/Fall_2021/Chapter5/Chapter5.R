####################
## Chapter 5 Code ##
####################

#######################
## Linear Regression ##
#######################

## Here we read the data 
advertising = read.csv(file = 'Advertising.csv')

## Here we fit the simple linear model
md = lm(Sales ~ TV, data = advertising)

## Here we print the model summary results
summary(md)
