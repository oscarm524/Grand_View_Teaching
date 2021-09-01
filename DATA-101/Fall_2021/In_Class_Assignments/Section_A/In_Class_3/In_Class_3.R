## Reading the csv file 
autos = read.csv(file = 'Automobile_data.csv')

## Reporting the price of the last observation
tail(autos, 1)

## Loading plyr
library(plyr)

body_type_max = ddply(autos, .(body.style), summarise, max_price = max(price, na.rm = T))
body_type_max
