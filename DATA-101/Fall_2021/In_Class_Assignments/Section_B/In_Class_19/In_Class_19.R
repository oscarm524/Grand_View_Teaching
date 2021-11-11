## Reading the csv file
autos = read.csv(file = 'autos.csv')
head(autos)

## Standardizing the input data 
autos$z_cylinders = (autos$cylinders - mean(autos$cylinders)) / sd(autos$cylinders)
autos$z_displacement = (autos$displacement - mean(autos$displacement)) / sd(autos$displacement)
autos$z_horsepower = (autos$horsepower - mean(autos$horsepower)) / sd(autos$horsepower)
autos$z_weight = (autos$weight - mean(autos$weight)) / sd(autos$weight)
autos$z_acceleration = (autos$acceleration - mean(autos$acceleration)) / sd(autos$acceleration)

## Splitting the data into training and testing 
n = dim(autos)[1]
train_obs = sample(1:n, round(0.8*n))

train = autos[train_obs, ]
test = autos[-train_obs, ]
