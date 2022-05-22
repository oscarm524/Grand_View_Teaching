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


