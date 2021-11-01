## Reading the csv file
churn = read.csv(file = 'Customer_Churn.csv')
head(churn)

## Changing labels to 0-1
churn$Churn_numb = ifelse(churn$Churn == 'No', 0, 1)
head(churn)

## Defining the null model 
md_null = glm(Churn_numb ~ 1, data = churn, family = 'binomial')
summary(md_null)

## Defining the full model 
md_full = glm(Churn_numb ~ gender + SeniorCitizen + tenure + Contract + PaperlessBilling + MonthlyCharges + DeviceProtection + TechSupport, data = churn, family = 'binomial')
summary(md_full)

## Forward selection 
forward_selection = step(md_null, scope = list(lower = md_null, upper = md_full), direction = 'forward')

## Backward selection 
backward_selection = step(md_full, direction = 'backward')
