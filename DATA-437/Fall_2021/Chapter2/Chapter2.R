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
