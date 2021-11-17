## Reading the csv file 
autos = read.csv(file = 'autos.csv')
head(autos)

## Splitting the data 
n = dim(autos)[1]

train_index = sample(1:n, round(0.8*n))
train = autos[train_index, ]
test = autos[-train_index, ]

library(gbm)

## Defining the number of trees
n_tree = c(100, 300, 500, 800, 1000, 1500, 2000)

## Defining the depths 
n_depth = c(2, 3, 4, 5, 6)

## Defining the combination of parameters
parameters = expand.grid('Number_of_Trees' = n_tree, 'Depth' = n_depth)
parameters$RMSE = NA
parameters$MAE = NA

## Extracting the number of models to be considered
m = dim(parameters)[1]

for(i in 1:m){
   
   ## Building the gradient boosting model 
   GB = gbm(mpg ~ cylinders + displacement + horsepower + weight + acceleration, data = train, n.trees = parameters$Number_of_Trees[i], interaction.depth = parameters$Depth[i], distribution = 'gaussian')
   
   ## Predicting on the test data 
   GB_pred = predict(GB, test, n.trees = parameters$Number_of_Trees[i], type = 'response')
   
   ## Computing and storing model performance
   parameters$RMSE[i] = sqrt(mean((GB_pred - test$mpg)^2))
   parameters$MAE[i] = mean(abs(GB_pred - test$mpg))
   
}

## Sorting the results 
parameters = parameters[order(parameters$RMSE, parameters$MAE, decreasing = FALSE), ]

