## Reading the csv file
autos = read.csv(file = 'autos.csv')
head(autos)

## Splitting the data 
n = dim(autos)[1]

train_index = sample(1:n, round(0.8*n))
train = autos[train_index, ]
test = autos[-train_index, ]

## Defining the number of trees 
n_tree = c(100, 300, 500, 800, 1000, 1500, 2000)

## Defining the depth of the trees
n_depth = c(2, 3, 4, 5, 6)

## Combining the trees and depths
parameters = expand.grid('Number_of_Trees' =  n_tree, 'Depth' = n_depth)
parameters$RMSE = NA
parameters$MAE = NA

## Extracting the number of parameter combinations 
n = dim(parameters)[1]

library(gbm)

for(i in 1:n){
   
   ## Building the gradient boosting model 
   GBM = gbm(mpg ~ cylinders + displacement + horsepower + weight + acceleration, data = train, n.trees = parameters$Number_of_Trees[i], interaction.depth = parameters$Depth[i], distribution = 'gaussian')
   
   ## Predicting on the test dataset 
   GBM_pred = predict(GBM, test, n.trees = parameters$Number_of_Trees[i], type = 'response')
   
   ## Storing results
   parameters$RMSE[i] = sqrt(mean((GBM_pred - test$mpg)^2))
   parameters$MAE[i] = mean(abs(GBM_pred - test$mpg))
}

## Sorting based on RMSE and MAE
parameters = parameters[order(parameters$RMSE, parameters$MAE, decreasing = FALSE), ]
