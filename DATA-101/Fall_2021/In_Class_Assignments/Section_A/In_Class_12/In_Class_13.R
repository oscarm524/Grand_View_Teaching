## Reading the csv file 
autos = read.csv(file = 'Automobile_data.csv')
head(autos)

## Building the linear regression model 
lm_md = lm(price ~ horsepower + wheel.base, data = autos)

## Extracting model results
summary(lm_md)

## Creating the new observation
newdata = data.frame('horsepower' = 150, 'wheel.base' = 100)

## Predicting price on the new observation
predict(lm_md, newdata)
