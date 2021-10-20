## Reading the csv file
churn = read.csv(file = 'Customer_Churn.csv')

## Creating Churn_numb
churn$Churn_numb = ifelse(churn$Churn == 'No', 0, 1)
