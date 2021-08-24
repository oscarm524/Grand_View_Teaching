###############
## Chapter 2 ##
###############

## Reading NY Yankees data
NY = read.csv(file = 'NY_Yankees.csv')

## Removing white-space
NY$season_2011 = trimws(NY$season_2011)

## Creating a frequency table
table(NY$season_2011)

## Creating a relative frequency table
prop.table(table(NY$season_2011))

################
## Histograms ##
################

## Histogram of Jammael Charles' rushing attempts in 2010
charles = read.csv(file = 'Dataset_2_2.csv')

hist(charles$Yards, col = 'gray', xlab = 'Yards', ylab = 'Frequency')
box()

## Histogram of shooting percentage
shooting = read.csv(file = 'Dataset_2_3.csv')

hist(shooting$SPCT, col = 'gray', xlab = 'Shooting Percentage', ylab = 'Frequency')
box()

## Histogram of guards
hist(shooting$SPCT[shooting$Pos == 'G'], col = 'gray', xlab = 'Shooting Percentage', ylab = 'Frequency')
box()

## Histogram of forwards
hist(shooting$SPCT[shooting$Pos %in% c('SF', 'PF')], col = 'gray', xlab = 'Shooting Percentage', ylab = 'Frequency')
box()

