####################
## Chapter 6 Code ##
####################


#######################
## Forward Selection ##
#######################

## Here we read the data into R
auto = read.csv(file = 'auto.csv')

## Here we define the null model
null_md = lm(mpg ~ 1, data = auto)

## Here we define the upper model 
upper_md = lm(mpg ~ cylinders + displacement + horsepower + weight + 
                    acceleration, data = auto)

## Here we perform forward selection
forward_selection = step(null_md, 
                         scope = list(lower = null_md, upper = upper_md), 
                         direction = "forward")


########################
## Backward Selection ##
########################

## Here we read the data into R
auto = read.csv(file = 'auto.csv')

## Here we define the full model 
full_md = lm(mpg ~ cylinders + displacement + horsepower + weight + 
                   acceleration, data = auto)

## Here we perform backward selection
backward_selection = step(full_md, direction = 'backward') 


######################
## Hybrid Selection ##
######################

## Here we read the data into R
auto = read.csv(file = 'auto.csv')

## Here we define the full model 
full_md = lm(mpg ~ cylinders + displacement + horsepower + weight + 
                   acceleration, data = auto)

## Here we perform hybrid selection
hybrid_selection = step(full_md, direction = 'both') 


############################
## Evaluating Classifiers ##
############################

## Here we read the data into R
breast_cancer = read.csv(file = 'wisconsin_breast_cancer.csv')

## Here we recode diagnosis 
## Notice that we want to predict the probability of malignant cancer
breast_cancer$diagnosis = ifelse(breast_cancer$diagnosis == 'B', 0, 1)

## Here we select the variables of interest
breast_cancer = breast_cancer[, c('diagnosis', 'area_worst', 'radius_worst', 
                                  'compactness_mean')]

## First we need to create a function that transform a variable to 0-1 range
normalize_0_1 = function(x){
	return((x - min(x)) / (max(x) - min(x)))
}

## Here we standardize the 30 features in the data set
breast_cancer[, 2:4] = data.frame(lapply(breast_cancer[, 2:4], normalize_0_1))

## Here we split the data into training and testing
set.seed(6.13)

n = dim(breast_cancer)[1]
training.obs = sample(1:n, round(0.7*n))

train = breast_cancer[training.obs, ]
test = breast_cancer[-training.obs, ]

## Here we train a 3-nearest neighbor in the training set
library(class)
three_nearest_neighbors = knn(train[, -1], test[, -1], 
                              cl = train$diagnosis, k = 3)

## Here we evaluate the performance of 3-NN classifier
library(caret)
confusionMatrix(three_nearest_neighbors, as.factor(test$diagnosis))


## Here we trainig a random forest in the training set
library(randomForest)
rf_md = randomForest(as.factor(diagnosis) ~ area_worst + radius_worst + 
                                            compactness_mean, data = train)

## Here we use the random forest model to predict on test
rf_preds = predict(rf_md, test, type = 'class')

## Here we evaluate the performance of random forest
confusionMatrix(rf_preds, as.factor(test$diagnosis))

## Here we train a boosted classification tree
library(gbm)
gbm_md = gbm(as.factor(diagnosis) ~ area_worst + radius_worst + compactness_mean, 
                                    data = train, distribution = 'bernoulli', 
                                    n.trees = 500, interaction.depth = 3)

## Here we use the boosted classification tree to predict on test
gbm_preds = predict(gbm_md, test, n.trees = 500, type = 'response')

## Here we convert probability to labels
gbm_preds = ifelse(gbm_preds < 0.5, 0, 1)

## Here we evaluate the performance of boosted classification tree
confusionMatrix(as.factor(gbm_preds), as.factor(test$diagnosis))
