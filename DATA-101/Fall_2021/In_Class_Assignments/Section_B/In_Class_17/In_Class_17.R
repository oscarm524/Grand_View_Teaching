## Reading the csv file 
churn = read.csv(file = 'Customer_Churn.csv')
head(churn)

## Changing labels to 0-1
churn$Churn_numb = ifelse(churn$Churn == 'No', 0, 1)
head(churn)

## Defining the full model
md_full = glm(Churn_numb ~ gender + SeniorCitizen + tenure + Contract + PaperlessBilling + MonthlyCharges + DeviceProtection + TechSupport, data = churn, family = 'binomial')
summary(md_full)

## Running hybrid selection 
hybrid_selection = step(md_full, direction = 'both')
