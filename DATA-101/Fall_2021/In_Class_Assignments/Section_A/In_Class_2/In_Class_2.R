## Reading csv file
autos = read.csv(file = 'Automobile_data.csv')

## finding number of observations and variables
dim(autos)

## Printing the last three observations
tail(autos, 3)

## Creating a frequency table for company
table(autos$company)

## Selecting audi cars with four cylinder
audi_4 = subset(autos, company == 'audi' & num.of.cylinders == 'four')
