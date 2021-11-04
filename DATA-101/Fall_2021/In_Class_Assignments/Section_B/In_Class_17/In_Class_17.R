## Reading the csv file 
churn = read.csv(file = 'Customer_Churn.csv')
head(churn)

## Changing labels to 0-1
churn$Churn_numb = ifelse(churn$Churn == 'No', 0, 1)
head(churn)
