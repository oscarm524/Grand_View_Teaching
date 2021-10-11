## Reading the csv file 
mlb = read.csv(file = 'Dataset_2_4.csv')
head(mlb)

## Creating the scatter-plot between hits and runs
plot(mlb$H, mlb$R, xlab = 'Hits', ylab = 'Runs', pch = 16, col = 'blue')
grid()

## The scatter-plot shows a positive linear relationship 
## between hits and runs

## Computing the correlation between hits and runs
cor(mlb$H, mlb$R)

## Computing the margin of error
r = 0.643
n = dim(mlb)[1]
ME = 2*sqrt((1 - r^2) / n)
ME

## Since r is greater than the margin of error, the correlation
## between hits and runs is significant.
