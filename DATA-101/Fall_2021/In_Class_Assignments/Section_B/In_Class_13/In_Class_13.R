## Reading the csv file
churn = read.csv(file = 'Customer_Churn.csv')

## Creating Churn_numb
churn$Churn_numb = ifelse(churn$Churn == 'No', 0, 1)

## Building the logistic regression model 
logit_md = glm(Churn_numb ~ tenure + MonthlyCharges, data = churn, 
               family = binomial(link = logit))
