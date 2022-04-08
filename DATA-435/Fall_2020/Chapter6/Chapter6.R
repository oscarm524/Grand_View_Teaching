###############
## Chapter 6 ##
###############

rm(list = ls())

## Reading the csv file 
online_retail = read.csv(file = 'Online_Retail.csv', stringsAsFactors = F)

## Putting InvoiceDate in the right format
online_retail$InvoiceDate = as.Date(online_retail$InvoiceDate)

## Removing data 
online_retail = online_retail[(online_retail$InvoiceDate < as.Date('2011-12-01')), ]

## Removing negative quantities
online_retail = online_retail[online_retail$Quantity > 0, ]

## Removing missing CustomerID
online_retail = online_retail[!is.na(online_retail$CustomerID), ]

## Computing Total Sales
online_retail$Total_Sales = online_retail$Quantity * online_retail$UnitPrice

## Loading plyr
library(plyr)

## Summarizing the data by CustomerID and invoice
orders = ddply(online_retail, .(CustomerID, InvoiceNo), summarise, Total_Sales = sum(Total_Sales), InvoiceDate = max(InvoiceDate))

## Summarizing by CustomerID
customer_orders = ddply(online_retail, .(CustomerID), summarise, min_sales = min(Total_Sales), max_sales = max(Total_Sales), avg_sales = mean(Total_Sales), count = length(Total_Sales), min_invoice_date = min(InvoiceDate), max_invoice_date = max(InvoiceDate), purchase_duration = as.numeric(difftime(max(InvoiceDate), min(InvoiceDate), units = 'days')), purchase_frequency = as.numeric(difftime(max(InvoiceDate), min(InvoiceDate), units = 'days')) / length(Total_Sales))

## Grouping data by CustomerID 
customer_orders = ddply(online_retail, .(CustomerID, InvoiceDate), summarise, sales_sum = sum(Total_Sales), sales_avg = mean(Total_Sales), sales_count = length(Total_Sales))

## Loading lubridate
library(lubridate)

## Rounding InvoiceDate to nearest quarter
online_retail$InvoiceDate = as.character(round_date(online_retail$InvoiceDate, 'quarter'))

## Creating the Quarter variable
online_retail$Quarter = ifelse(online_retail$InvoiceDate == '2012-01-01', 'Q1', ifelse(online_retail$InvoiceDate == '2011-10-01', 'Q2', 
ifelse(online_retail$InvoiceDate == '2011-07-01', 'Q3',
ifelse(online_retail$InvoiceDate == '2011-04-01', 'Q4', 'Q5'))))

## Aggregating by quarter
customer_orders = ddply(online_retail, .(CustomerID, Quarter), summarise, sales_sum = sum(Total_Sales), sales_avg = mean(Total_Sales), sales_count = length(Total_Sales))

## Reshaping the data from long to wide
customer_orders = reshape(customer_orders, direction = 'wide', v.names = c('sales_sum', 'sales_avg', 'sales_count') ,timevar = 'Quarter', idvar = 'CustomerID')

## Filling missing values with 0
customer_orders[is.na(customer_orders)] = 0

## Loading packages
library(caret)
library(randomForest)
library(e1071)
library(Metrics)

## Splitting data into train (80%) and test (20%)
train_index = createDataPartition(customer_orders$sales_sum.Q1, p = 0.8, list = F)
train = customer_orders[train_index, ]
test = customer_orders[-train_index, ]

#######################
## Linear Regression ##
#######################

## Building the model 
lm_md = lm(sales_sum.Q1 ~ sales_sum.Q2 + sales_sum.Q3 + sales_sum.Q4 + sales_sum.Q5, data = train)

## Predicting on test
lm_preds = predict(lm_md, newdata = test)

## Comparing prediction vs actual
print(paste0('The linear regression model RMSE is: ', rmse(test$sales_sum.Q1, lm_preds)))
print(paste0('The linear regression model MAE is: ', mae(test$sales_sum.Q1, lm_preds))) 

###################
## Random Forest ##
###################

## Building the model 
RF_md = randomForest(sales_sum.Q1 ~ sales_sum.Q2 + sales_sum.Q3 + sales_sum.Q4 + sales_sum.Q5, data = train, ntree = 500)

## Predicting on test
RF_preds = predict(RF_md, newdata = test)

## Comparing prediction vs actual
print(paste0('The random forest model RMSE is: ', rmse(test$sales_sum.Q1, RF_preds)))
print(paste0('The random forest model MAE is: ', mae(test$sales_sum.Q1, RF_preds))) 

#########
## SVM ##
#########

## Building the model 
SVM_md = svm(sales_sum.Q1 ~ sales_sum.Q2 + sales_sum.Q3 + sales_sum.Q4 + sales_sum.Q5, data = train, kernel = 'linear')

## Predicting on test
SVM_preds = predict(SVM_md, newdata = test)

## Comparing prediction vs actual
print(paste0('The svm model RMSE is: ', rmse(test$sales_sum.Q1, SVM_preds)))
print(paste0('The svm model MAE is: ', mae(test$sales_sum.Q1, SVM_preds))) 

