## Reading the csv file 
autos = read.csv(file = 'Automobile_data.csv')

## Reporting number of observations and variables
dim(autos)

## Printing the last three observation
tail(autos, 3)

## Frequency table of company
table(autos$company)

## Selecting audi cars with four cylinders
audi_4 = subset(autos, company == 'audi' & num.of.cylinders == 'four')
audi_4

