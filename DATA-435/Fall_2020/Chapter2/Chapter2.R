## Reading data
marketing = read.csv(file = 'bank-additional-full.csv', sep = ';')

## Printing the first 6 observation
head(marketing)

## Creating conversion (1 for yes and 0 for no)
marketing$conversion = ifelse(marketing$y == 'yes', 1, 0)

## Counting the number of clients that subscribed
numb_conversion = sum(marketing$conversion)

## Counting the number of clients in the dataset
numb_clients = nrow(marketing)

## Computing conversion rate
conversion_rate = numb_conversion / numb_clients

## Loading plyr package
library(plyr)

## Counting the conversions and clients by age
age_conversion = ddply(marketing, .(age), summarise, numb_conversion = sum(conversion), 
                       numb_clients = length(age)) 

## Computing conversion by age
age_conversion$conversion = age_conversion$numb_conversion / age_conversion$numb_clients

## Visualizing conversion by age
plot(age_conversion$age, age_conversion$conversion, type = 'l', xlab = 'Age', ylab = 'Conversion')
grid()

## Creating age groups
marketing$age_group = ifelse(marketing$age < 30, '[17, 30)', 
                             ifelse(marketing$age >= 30 & marketing$age < 40, '[30, 40)',
                                    ifelse(marketing$age >= 40 & marketing$age < 50, '[40, 50)',
                                           ifelse(marketing$age >= 50 & marketing$age < 60, '[50, 60)',
                                                  ifelse(marketing$age >= 60 & marketing$age < 70, '[60, 70)', '70+')))))

## Conversion by age group
age_group_conversion = ddply(marketing, .(age_group), summarise, 
                             numb_conversion = sum(conversion), 
                             numb_clients = length(age))

## Computing conversion by age groups
age_group_conversion$conversion = age_group_conversion$numb_conversion / 
   age_group_conversion$numb_clients

## Visualizing the conversion by group
barplot(age_group_conversion$conversion, 
        names.arg = age_group_conversion$age_group, 
        main = '', ylab = 'conversion', ylim = c(0, 0.6))
box()

## Conversion vs non-conversion by marital status
marital_conversion = ddply(marketing, .(marital), summarise, 
                           conversions = sum(conversion), 
                           non_conversions = sum(conversion == 0))

## Conversion by marital status and age-group
age_group_marital_conversion = ddply(marketing, .(age_group, marital), summarise, 
                                     conversions = sum(conversion), 
                                     numb_clients = length(age_group))
