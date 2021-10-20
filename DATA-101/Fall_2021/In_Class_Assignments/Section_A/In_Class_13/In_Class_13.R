## Reading the csv file
churn = read.csv(file = 'Customer_Churn.csv')

## Creating Churn_numb
churn$Churn_numb = ifelse(churn$Churn == 'No', 0, 1)

## Building the logistic regression model 
logit_md = glm(Churn_numb ~ tenure + MonthlyCharges, data = churn, 
               family = binomial(link = logit))

## Predicting the churn of customer 
## Tenure = 12, MonthlyCharges = 250
new_obs = data.frame(tenure = 12, MonthlyCharges = 250)

## Predicting churn 
predict(logit_md, newdata = new_obs, type = 'response')
