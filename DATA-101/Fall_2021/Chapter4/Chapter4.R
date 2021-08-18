######################
## Chapter 4 R-code ##
######################

## First we declare the vectors u and v
u = c(23, 2, 2)
v = c(40, 10, 1)

## Here we compute the Euclidean distance
sqrt(sum((u - v)^2))


##########
## k-nn ##
##########

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

