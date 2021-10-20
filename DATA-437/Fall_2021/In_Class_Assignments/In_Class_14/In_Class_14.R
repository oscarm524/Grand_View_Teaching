## Reading the csv file 
batting = read.csv(file = 'batting.csv')
head(batting)

library(plyr)

## Aggregating data at the player level
batting_agg = ddply(batting, .(playerID), summarise, tot_AB = sum(AB, na.rm = T), tot_HR = sum(HR, na.rm = T), tot_SO = sum(SO, na.rm = T))
head(batting_agg)

## Selecting players with at least 5000 at bats
batting_agg = subset(batting_agg, tot_AB >= 5000)

## Computing HR ans SO rates
batting_agg$HR_rate = batting_agg$tot_HR / batting_agg$tot_AB
batting_agg$SO_rate = batting_agg$tot_SO / batting_agg$tot_AB

## Building the quadratic model 
quad_md = lm(SO_rate ~ HR_rate + I(HR_rate^2), data = batting_agg)

## Extracting model results
summary(quad_md)
