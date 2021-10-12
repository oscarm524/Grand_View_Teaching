## Reading csv file 
baseball = read.csv(file = 'Dataset_6_1.csv')
head(baseball)

## Plotting the scatter-plot between ops and runs
plot(baseball$OPS, baseball$Runs, xlab = 'OPS', ylab = 'Runs Scored')
grid()

## Fitting the line
lm_md = lm(Runs ~ OPS, data = baseball)

## Extracting model results 
summary(lm_md)

## Reading the csv file 
ken = read.csv(file = 'Dataset_6_4.csv')
head(ken)

## Fitting quadratic model to Ken's home runs data
quadratic_md = lm(HR ~ T + I(T^2), data = ken)

## Extracting model results
summary(quadratic_md)
