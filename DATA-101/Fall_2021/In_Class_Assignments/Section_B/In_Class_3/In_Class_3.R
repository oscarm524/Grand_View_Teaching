## Reading the csv file 
autos = read.csv(file = 'Automobile_data.csv')
head(autos)

## Reporting the price of the last observation
tail(autos, 1)

library(plyr)

body_style_max_price = ddply(autos, .(body.style), summarise, max_price = max(price, na.rm = TRUE))
body_style_max_price

