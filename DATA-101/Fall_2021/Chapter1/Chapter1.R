## Here we read the time series in R 
returns = read.csv(file = 'time_series.csv', header = T)
returns$Date = as.Date(returns$Date, format = '%m/%d/%Y')

## Here we print the first six observation of the data set
head(returns)

## Here we create a time series plot of the annual total return
plot(returns$Date, returns$Ann_Total_Return, type = 'l', col = 'blue', 
     xlab = 'Date', ylab = 'Annual Total Return (%)')
grid()

## Let's plot the forecasted total returns 
plot(returns$Date, returns$Ann_Total_Return, type = 'l', col = 'blue', 
     xlab = 'Date', ylab = 'Annual Total Return (%)')

## Here we add the forecasted returns
lines(returns$Date, returns$Ann_Forecast_Total_Return, col = 'orange')

## Here we add the confidence region
polygon(c(returns$Date, rev(returns$Date)), 
        c(returns$Up_95_Bound, rev(returns$Low_95_Bound)), 
        col = '#CCCCCC4D')
grid()