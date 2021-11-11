## Reading the csv file
autos = read.csv(file = 'autos.csv')
head(autos)

## Standardizing the input data 
autos$z_cylinders = (autos$cylinders - mean(autos$cylinders)) / sd(autos$cylinders)
autos$z_displacement = (autos$displacement - mean(autos$displacement)) / sd(autos$displacement)
autos$z_horsepower = (autos$horsepower - mean(autos$horsepower)) / sd(autos$horsepower)
autos$z_weight = (autos$weight - mean(autos$weight)) / sd(autos$weight)
autos$z_acceleration = (autos$acceleration - mean(autos$acceleration)) / sd(autos$acceleration)

## Splitting the data into training and testing 
n = dim(autos)[1]
train_obs = sample(1:n, round(0.8*n))

train = autos[train_obs, ]
test = autos[-train_obs, ]

##########
## k-NN ##
##########

library(caret)

knn_md = knnreg(mpg ~ z_cylinders + z_displacement + z_horsepower + z_weight + z_acceleration, data = train, k = 5)

## Predicting on the test dataset 
knn_pred = predict(knn_md, test)

## Computing the RMSE and MAE
RMSE_knn = sqrt(mean((knn_pred - test$mpg)^2))
MAE_knn = mean(abs(knn_pred - test$mpg))

###################
## Random Forest ##
###################

library(randomForest)

RF_md = randomForest(mpg ~ z_cylinders + z_displacement + z_horsepower + z_weight + z_acceleration, data = train)

## Predicting on the test dataset 
RF_pred = predict(RF_md, test)

## Computing the RMSE and MAE
RMSE_RF = sqrt(mean((RF_pred - test$mpg)^2))
MAE_RF = mean(abs(RF_pred - test$mpg))

#######################
## Gradient Boosting ##
#######################

library(gbm)

GB_md = gbm(mpg ~ z_cylinders + z_displacement + z_horsepower + z_weight + z_acceleration, data = train, n.tree = 500, interaction.depth = 4, distribution = 'gaussian')

## Predicting on the test dataset 
GB_pred = predict(GB_md, test, n.tree = 500)

## Computing the RMSE and MAE
RMSE_GB = sqrt(mean((GB_pred - test$mpg)^2))
MAE_GB = mean(abs(GB_pred - test$mpg))

## By comparing the RMSE and MAE, I select the gradient boosting model to predict mpg