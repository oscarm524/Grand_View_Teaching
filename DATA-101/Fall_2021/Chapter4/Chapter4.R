######################
## Chapter 4 R-code ##
######################

## First we declare the vectors u and v
u = c(23, 2, 2)
v = c(40, 10, 1)

## Here we compute the Euclidean distance
sqrt(sum((u - v)^2))


##########################
## k-NN: Classification ##
##########################

## Here we read the data into R
breast_cancer = read.csv(file = 'wisconsin_breast_cancer.csv')

## First we drop the id variable
breast_cancer = breast_cancer[, -1]

## Let's create a frequency table of diagnosis
table(breast_cancer$diagnosis)

## Let's normalize the features (0-1 transformation)

## First we need to create a function that transform a variable to 0-1 range
normalize_0_1 = function(x){
	return((x - min(x)) / (max(x) - min(x)))
}

## Here we standardize the 30 features in the data set
breast_cancer[,2:31] = data.frame(lapply(breast_cancer[,2:31], normalize_0_1))

## Here we split the data into training and testing 
breast_cancer_train = breast_cancer[0:469,]
breast_cancer_test = breast_cancer[470:569,]

## Here we load the class library
library(class)

## Here we create a two nearest neighbors classifier and predict on testing data
two_nearest_neighbors = knn(train = breast_cancer_train[,-1], test = breast_cancer_test[,-1], cl = breast_cancer_train[, 1], k = 2)

## Here we compare the actuals against predictions
table(two_nearest_neighbors, breast_cancer_test[, 1])


######################
## k-NN: Regression ##
######################

## Here we read the data 
autos = read.csv(file = 'autos.csv')

## Here we select the variables of interest
## autos_X represents number of cylinders and horsepower 
## autos_Y average mileage
autos_X = autos[,7:8]
autos_Y = autos[,9]

## Here we normalize the data (0-1 transformation)

## First we need to create a function that transform a variable to 0-1 range
normalize_0_1 = function(x){
	return((x - min(x)) / (max(x) - min(x)))
}

## Here we normalize the inputs
autos_X = data.frame(lapply(autos_X, normalize_0_1))

## Here we split the data into training and testin
autos_X_train = autos_X[0:50,]
autos_Y_train = autos_Y[0:50]

autos_X_test = autos_X[51:61,]
autos_Y_test = autos_Y[51:61]

## First we load the caret library
library(caret)

## Here we build the three nearest neighbors regressor
three_nearest_neighbors = knnreg(autos_X_train, autos_Y_train, k = 3)

## Here we predict on the testing data 
predictions = predict(three_nearest_neighbors, autos_X_test)

## Here we visualize the actuals vs predictions
plot(autos_Y_test, predictions, xlab = 'Actual Average Mileage', ylab = 'Predicted Average Mileage', pch = 16, col = 'blue')
grid() 


################
## Clustering ##
################

## Here we read the data into R
iris = read.csv(file = 'iris_data.csv')

## Let's normalize the data (z-score standardization)
normalize = function(x){
	return((x - mean(x)) / sd(x))
}

## Here we normalize the features
features = iris[, 1:4]
features_std = data.frame(lapply(features, normalize))

## Here we cluster the data into three clusters
iris_three_cluster = kmeans(features_std, centers = 3, nstart = 20)
iris_three_cluster


#############################
## Hierarchical clustering ##
#############################

hc_complete = hclust(dist(features_std, method = 'euclidean'), method = 'complete')
plot(hc_complete)
