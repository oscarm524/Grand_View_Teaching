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

##########
## Mean ##
##########

## Reading Tom Brady's passing yards data (2001-2011)
brady = read.csv(file = 'Dataset_2_1.csv')

## Computing the mean of passing yards
mean(brady$PY)

############
## Median ##
############

## Reading Tom Brady's passing yards data (2001-2011)
brady = read.csv(file = 'Dataset_2_1.csv')

## Computing the median of passing yards
median(brady$PY)

##############
## Variance ##
##############

## Reading csv file
shooting = read.csv(file = 'Dataset_2_3.csv')

## Computing the variance of shooting percentages of forwards
var(shooting$SPCT[shooting$Pos %in% c('SF', 'PF')])

## Computing the variance of shooting percentages of guards
var(shooting$SPCT[shooting$Pos == 'G'])

########################
## Standard Deviation ##
########################

## Computing the standard deviation of shooting percentages of forwards
sd(shooting$SPCT[shooting$Pos %in% c('SF', 'PF')])

## Computing the standard deviation of shooting percentages of guards
sd(shooting$SPCT[shooting$Pos == 'G'])

##############################
## Coefficient of Variation ##
##############################

## Computing the CV of shooting percentages of forwards
mean_forward = mean(shooting$SPCT[shooting$Pos %in% c('SF', 'PF')])
sd_forward = sd(shooting$SPCT[shooting$Pos %in% c('SF', 'PF')])
CV_forward = sd_forward / mean_forward

## Computing the CV of shooting percentages of guards
mean_guard = mean(shooting$SPCT[shooting$Pos == 'G'])
sd_guard = sd(shooting$SPCT[shooting$Pos == 'G'])
CV_guard = sd_guard / mean_guard

#########
## IQR ##
#########

## Reading csv file
shooting = read.csv(file = 'Dataset_2_3.csv')

## Computing the IQR of forwards shooting percentages
forward = shooting$SPCT[shooting$Pos %in% c('SF', 'PF')]
Q3_forward = quantile(forward, 0.75)
Q1_forward = quantile(forward, 0.25)
IQR_forward = as.numeric(Q3_forward) - as.numeric(Q1_forward)

## Computing the IQR of guards shooting percentages
guard = shooting$SPCT[shooting$Pos == 'G']
Q3_guard = quantile(guard, 0.75)
Q1_guard = quantile(guard, 0.25)
IQR_guard = as.numeric(Q3_guard) - as.numeric(Q1_guard)
