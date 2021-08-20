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
md = glm(default ~ balance + income + student, data = Default, family = 'binomial')

## Here we print the model summary
summary(md)


####################
## Decision Trees ##
####################

## Here we read the data 
Default = read.csv(file = 'Default.csv')

## Here we load the rpart library
library(rpart)

## Here we fit the tree
tree.md = rpart(default ~ balance + income + student, data = Default)

## Here we visualize the tree
plot(tree.md, uniform = T, margin = 0.1)
text(tree.md, use.n = T, all = T, cex = 0.8)

## Here we predict the probability of default for balance = 1500
## income = 35000 and student = No
predict(tree.md, 
        newdata = data.frame(balance = 1500, income = 35000, student = 'No'), 
        type = 'prob')


###################
## Random Forest ##
###################

## Here we read the data 
Default = read.csv(file = 'Default.csv')

## Here we load the randomForest library
library(randomForest)

## Here we fit the random forest to the data
rf.md = randomForest(default ~ balance + income + student, data = Default)

## Here we predict the probability of default for balance = 1500
## income = 35000 and student = No
predict(rf.md, 
        newdata = data.frame(balance = 1500, income = 35000, 
                             student = factor('No', levels = c('No', 'Yes')), 
        type = 'prob')
