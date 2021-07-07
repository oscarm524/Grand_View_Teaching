###############
## Chapter 5 ##
###############

rm(list = ls())

## Reading the csv file 
churn = read.csv(file = 'Churn_Data.csv')

## Building the logistic regression model
logit_md = glm(Churn ~ Age + EstimatedSalary + CreditScore + Balance + NumOfProducts, data = churn, family = binomial(link = logit))

predict(logit_md, newdata = data.frame(Age = 50, EstimatedSalary = 100000, CreditScore = 600, Balance = 100000, NumOfProducts = 2), type = 'response')

summary(logit_md)

## Loading the randomforest package
library(randomForest)

## Building the random forest model
RF_md = randomForest(as.factor(Churn) ~ Age + EstimatedSalary + CreditScore + Balance + NumOfProducts, data = churn)

predict(RF_md, newdata = data.frame(Age = 50, EstimatedSalary = 100000, CreditScore = 600, Balance = 100000, NumOfProducts = 2), type = 'prob')

## Loading the support vector machine package
library(e1071)

## Building the svm model 
SVM_md = svm(Churn ~ Age + EstimatedSalary + CreditScore + Balance + NumOfProducts, data = churn, kernel = 'linear', probability = T)

predict(SVM_md, newdata = data.frame(Age = 50, EstimatedSalary = 100000, CreditScore = 600, Balance = 100000, NumOfProducts = 2), probability = T)


## Loading all the needed packages
library(randomForest)
library(e1071)
library(caret)

## Reading the csv file 
churn = read.csv(file = 'Churn_Data.csv')

## split data into train (80%) and test (20%) 
train_index = createDataPartition(y = churn$Churn, p = 0.8, list = F)
train = churn[train_index, ]
test = churn[-train_index, ]

#########################
## Logistic Regression ##
#########################

logit_md = glm(Churn ~ Age + EstimatedSalary + CreditScore + Balance + NumOfProducts, data = train, family = binomial(link = logit))

## Predicting on test dataset
logit_preds = predict(logit_md, newdata = test, type = 'response')

## Change to 0-1 using cutoff = 0.3
logit_preds = ifelse(logit_preds > 0.3, 1, 0)
confusionMatrix(as.factor(logit_preds), as.factor(test$Churn))

###################
## Random Forest ##
###################

RF_md = randomForest(as.factor(Churn) ~ Age + EstimatedSalary + CreditScore + Balance + NumOfProducts, data = train, ntree = 500)

## Predicting on test dataset
RF_preds = predict(RF_md, newdata = test, type = 'prob')[, 2]

## Change to 0-1 using cutoff = 0.3
RF_preds = ifelse(RF_preds > 0.3, 1, 0)
confusionMatrix(as.factor(RF_preds), as.factor(test$Churn))

#########
## SVM ##
#########

SVM_md = svm(Churn ~ Age + EstimatedSalary + CreditScore + Balance + NumOfProducts, data = train, kernel = 'linear', probability = T)

## Predicting on test dataset
SVM_preds = predict(SVM_md, newdata = test, probability = T)

## Change to 0-1 using cutoff = 0.3
SVM_preds = ifelse(SVM_preds > 0.3, 1, 0)
confusionMatrix(as.factor(SVM_preds), as.factor(test$Churn))

