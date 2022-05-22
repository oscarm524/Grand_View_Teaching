## First we create the a vector that contains the values
x = c(0, 1, 2, 0, 4, 0, 1, 2, 3)

## Here we find the mean of the vector x
mean(x)

## First we create the a vector that contains the salaries
salaries = c(35000, 37000, 35000, 33000, 210000)

## Here we find the mean of the vector salaries
mean(salaries)

## First we create the a vector that contains the salaries
salaries = c(35000, 37000, 35000, 33000)

## Here we find the mean of the vector salaries
mean(salaries)

## First we create the a vector that contains the salaries
salaries = c(35000, 37000, 35000, 33000, 210000)

## Here we find the median of the vector salaries
median(salaries)

## First we create the a vector that contains the salaries
salaries = c(35000, 37000, 35000, 33000, 210000, 39000)

## Here we find the median of the vector salaries
median(salaries)

## First we create the a vector that contains the salaries
salaries = c(35000, 37000, 35000, 33000, 210000)

## Here we find the range of the vector salaries using the max and min functions
max(salaries) - min(salaries)

## First we create the a vector that contains the heights
heights = c(65.71, 72.30, 68.31, 67.05, 70.68)

## Here we find the variance of heights 
var(heights)

## Here we find the standard deviation of heights
sd(heights)

## First we create the a vector that contains the heights
heights = c(65.71, 72.30, 68.31, 67.05, 70.68)

## Here we find the z scores of heights 
(heights - mean(heights)) / sd(heights)

## First we create the a vector that contains the heights
heights = c(65.71, 72.30, 68.31, 67.05, 70.68)

## Here we find the five-number summary of heights 
summary(heights)

## Here we manually create the data
classes = c('First', 'Second', 'Third', 'Crew')
passengers = c(325, 285, 706, 885)

## Here we create the bar chart using the barplot function
barplot(passengers, names.arg = classes, xlab = 'Class', 
        ylab = 'Passengers')

## Here we create the horizontal bar chart using the barplot function
barplot(passengers, names.arg = classes, xlab = 'Class', ylab = 'Passengers', 
        horiz = T)

## Here we manually create the data
classes = c('First', 'Second', 'Third', 'Crew')
passengers = c(325, 285, 706, 885)

## Here we compute the percentages associated to each label
passengers.pct = round(100*passengers / sum(passengers), 1)

## Here we create the labels
classes = paste0(classes, '-', passengers.pct, '%')

## Here we declare the colors for the slices
colors = c('gold', 'yellowgreen', 'lightcoral', 'lightskyblue')

## Here we create the pie chart using the pie function
pie(passengers, labels = classes, col = colors)

## Here we create the vector of stock prices
stock = c(11.88, 6.27, 5.49, 4.81, 4.40, 3.78, 3.44, 3.11, 2.88, 2.68,
           7.99, 6.07, 5.26, 4.79, 4.05, 3.69, 3.36, 3.03, 2.74, 2.63,
           7.15, 5.98, 5.07, 4.55, 3.94, 3.62, 3.26, 2.99, 2.74, 2.62,
           7.13, 5.91, 4.94, 4.43, 3.93, 3.48, 3.20, 2.89, 2.69, 2.61)
       
## Here we create the histogram of stock prices using
## the hist function       
hist(stock, col = 'gray', main = 'Stock Price', ylab = 'Number of Shares', 
     xlab = 'Price ($)')

## Here we create the vector of stock prices
stock = c(11.88, 6.27, 5.49, 4.81, 4.40, 3.78, 3.44, 3.11, 2.88, 2.68,
           7.99, 6.07, 5.26, 4.79, 4.05, 3.69, 3.36, 3.03, 2.74, 2.63,
           7.15, 5.98, 5.07, 4.55, 3.94, 3.62, 3.26, 2.99, 2.74, 2.62,
           7.13, 5.91, 4.94, 4.43, 3.93, 3.48, 3.20, 2.89, 2.69, 2.61)
       
## Here we create the box-plot of stock prices using
## the boxplot function   
boxplot(stock, ylab = 'Stock Prices ($)')    

## Here we create the variables x and y
x = seq(0, 10, len = 30)
y = sin(x)

## Here we create the scatter plot between x and y
plot(x, y, pch = 16)
grid()

## Here we read the data
apple = read.csv(file = 'AAPL.csv')

## Here we put the Date variable in the right format
apple$Date = as.Date(apple$Date, format = '%Y-%m-%d')

## Here we crete the time series plot
plot(apple$Date, apple$Adj.Close, type = 'l', col = 'skyblue', 
     lwd = 2, xlab = 'Date', ylab = 'Stock Price ($)')
grid()



