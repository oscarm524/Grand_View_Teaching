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


###########################
## Evaluating Regressors ##
###########################

## Here we read the data 
auto = read.csv(file = 'auto.csv')

## Here we select the variables of interest
auto = auto[, c('mpg', 'cylinders', 'displacement', 'horsepower', 'weight', 
                'acceleration')]

## First we need to create a function that transform a variable to 0-1 range
normalize_0_1 = function(x){
	return((x - min(x)) / (max(x) - min(x)))
}

## Here we standardize the predictors in the data set
auto[, 2:6] = data.frame(lapply(auto[, 2:6], normalize_0_1))

## Here we split the data into training (70%) and testing (30%)
set.seed(5.23)

n = dim(auto)[1]
training.obs = sample(1:n, round(0.7*n))

train = auto[training.obs, ]
test = auto[-training.obs, ]

## Here we train a 3-nearest neighbor in the training set
library(caret)
three_nearest_neighbors = knnreg(mpg ~ cylinders + displacement + horsepower + 
                                       weight + acceleration, data = train)

## Here we predict on the test set
three_nearest_neighbors_pred = predict(three_nearest_neighbors, test)

## Here we evaluate the performance of the 3-NN
## Here we compute the RMSE
RMSE_three_nearest_neighbors =  sqrt(mean((three_nearest_neighbors_pred - 
                                           test$mpg)^2))

## Here we compute the MAE
MAE_three_nearest_neighbors = mean(abs(three_nearest_neighbors_pred - 
                                       test$mpg))

## Here we train the random forest model on the training set
library(randomForest)
rf_md = randomForest(mpg ~ cylinders + displacement + horsepower + 
                           weight + acceleration, data = train)

## Here we use the random forest model to predict on test
rf_pred = predict(rf_md, test)

## Here we evaluate the performance of the random forest
## Here we compute the RMSE
RMSE_rf = sqrt(mean((rf_pred - test$mpg)^2))

## Here we compute the MAE
MAE_rf = mean(abs(rf_pred - test$mpg))

## Here we train the boosted model in the training set
library(gbm)
gbm_md = gbm(mpg ~ cylinders + displacement + horsepower + 
                   weight + acceleration, data = train, n.tree = 500, 
                   interaction.depth = 3, distribution = 'gaussian')

## Here we use the boosted model to predict on test
gbm_pred = predict(gbm_md, test, n.tree = 500)

## Here we evaluate the performance of the boosted model
## Here we compute the RMSE
RMSE_gbm = sqrt(mean((gbm_pred - test$mpg)^2))

## Here we compute the MAE
MAE_gbm = mean(abs(gbm_pred - test$mpg))


############################
## Hyper-parameter Tuning ##
############################

##########
## k-NN ##
##########

## Here we read the data into R
breast_cancer = read.csv(file = 'wisconsin_breast_cancer.csv')

## First we drop id
breast_cancer = breast_cancer[, -1]

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

## Here we declare a matrix to store results
K_NN_results = matrix(0, nrow = 20, ncol = 3)

## Here we load the libraries
library(class)
library(caret)

## Here we compute the model performance for the 
## different number of neighbors
for(i in 1:20){
	
	## Here we fit the model
	K_NN = knn(train[, -1], test[, -1], cl = train$diagnosis, k = i)
	
	## Here we predict on create the confusion matrix
	conf_matrix = confusionMatrix(K_NN, as.factor(test$diagnosis))
	
	## Here we store the results
	K_NN_results[i, 1] = i
	K_NN_results[i, 2] = conf_matrix$overall['Accuracy'] 
	K_NN_results[i, 3] = conf_matrix$byClass['Sensitivity']
}

## Here we can visualize the results 
## First we visualize the accuracy
plot(K_NN_results[, 1], K_NN_results[, 2], xlab = 'Number of Neighbors', 
     ylab = 'Accuracy (%)', type = 'o')
grid()

## Here we visualize the sensitivity/recall
plot(K_NN_results[, 1], K_NN_results[, 3], xlab = 'Number of Neighbors', 
     ylab = 'Sensitivity (%)', type = 'o')
grid()


###################
## Random Forest ##
###################

## Here we read the data into R
breast_cancer = read.csv(file = 'wisconsin_breast_cancer.csv')

## First we drop id
breast_cancer = breast_cancer[, -1]

## Here we recode diagnosis 
## Notice that we want to predict the probability of malignant cancer
breast_cancer$diagnosis = ifelse(breast_cancer$diagnosis == 'B', 0, 1)

## Here we select the variables of interest
breast_cancer = breast_cancer[, c('diagnosis', 'area_worst', 'radius_worst', 
                                  'compactness_mean')]

## Here we split the data into training and testing
set.seed(6.13)

n = dim(breast_cancer)[1]
training.obs = sample(1:n, round(0.7*n))

train = breast_cancer[training.obs, ]
test = breast_cancer[-training.obs, ]

## Here we declare the number of trees to be considered
n_trees = c(1, 5, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 200, 300, 400, 500)

## Here we declare a matrix to store results
RF_results = matrix(0, nrow = length(n_trees), ncol = 3)
colnames(RF_results) = c('Number_of_Trees', 'Accuracy', 'Sensitivity')

## Here we compute the performance of the different number of trees
library(randomForest)
library(caret)

for(i in 1:length(n_trees)){
	
	## Here we fit the random forest 
	RF = randomForest(as.factor(diagnosis) ~ area_worst + radius_worst + 
	                                         compactness_mean, 
	                                         data = train, 
	                                         ntree = n_trees[i])
	
	## Here we predict on test data
	RF_preds = predict(RF, test)
	
	## Here we predict on create the confusion matrix
	conf_matrix = confusionMatrix(RF_preds, as.factor(test$diagnosis))
	
	## Here we store the results
	RF_results[i, 1] = n_trees[i]
	RF_results[i, 2] = conf_matrix$overall['Accuracy'] 
	RF_results[i, 3] = conf_matrix$byClass['Sensitivity']
}

## Here we can see the results
RF_results
