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


###########################################
## Linear regression with dummy variable ##
###########################################

## Here we read the data
birth = read.csv(file = 'birth.txt', sep = '')

## Here we fit the linear model
md = lm(Wgt ~ Gest + Smoke, data = birth)

## Here we print the model summary 
summary(md)


#########################
## Logistic Regression ##
#########################

## Here we read the data 
Default = read.csv(file = 'Default.csv')

## Here we fit the logistic model
md = glm(default ~ balance, data = Default, family = 'binomial')

## Here we print the model summary
summary(md)


#############################################
## Logistic Regression with dummy variable ##
#############################################

## Here we read the data 
Default = read.csv(file = 'Default.csv')

## Here we fit the logistic model
md = glm(default ~ student, data = Default, family = 'binomial')

## Here we print the model summary
summary(md)


##################################
## Multiple Logistic Regression ##
##################################

## Here we read the data 
Default = read.csv(file = 'Default.csv')

## Here we fit the logistic model
md = glm(default ~ balance + income + student, data = Default, 
         family = 'binomial')

## Here we print the model summary
summary(md)
