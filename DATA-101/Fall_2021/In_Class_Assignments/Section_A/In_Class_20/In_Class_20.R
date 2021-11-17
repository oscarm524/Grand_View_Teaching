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
