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


