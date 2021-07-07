####################
## Chapter 3 Code ##
####################

rm(list = ls())

## Loading quantmod
library(quantmod)

## Downloading IBM stock price data 
ibm = getSymbols('IBM', from = '2019-01-01', to = '2020-12-31', auto.assign = F)

## Calculating the daily price return
ibm$return = Delt(ibm$IBM.Close)

#######################
## Log-Total Returns ##
#######################

## Loading quantmod
library(quantmod)

## Downloading IBM stock price data 
ibm = getSymbols('IBM', from = '2019-01-01', to = '2020-12-31', auto.assign = F)

## Calculating the log total return
ibm$log_return = diff(log(ibm$IBM.Adjusted))

###################################
## Cumulative Arithmetic Returns ##
###################################

## Loading quantmod
library(quantmod)

## Downloading IBM stock price data 
ibm = getSymbols('IBM', from = '2019-01-01', to = '2020-12-31', auto.assign = F)

## Calculating the total return
ibm$tot_return = Delt(ibm$IBM.Adjusted)

## Calculating the gross return 
ibm$gross_return = 1 + ibm$tot_return

## Removing missing values
ibm = na.omit(ibm)

## Calculating the cumulative gross returns
ibm$gross_cum = cumprod(ibm$gross_return)

## Converting cumulative gross returns to cumulative net returns
ibm$net_cum = ibm$gross_cum - 1


####################################
## Cumulative Logarithmic Returns ##
####################################

## Loading quantmod
library(quantmod)

## Downloading IBM stock price data 
ibm = getSymbols('IBM', from = '2019-01-01', to = '2020-12-31', auto.assign = F)

## Calculating the log total return
ibm$log_return = diff(log(ibm$IBM.Adjusted))

## Removing missing values
ibm = na.omit(ibm)

## Calculating the cumulative log returns
ibm$log_cum = cumsum(ibm$log_return)


####################
## Weekly Returns ##
####################

## Loading quantmod
library(quantmod)

## Downloading IBM stock price data 
ibm = getSymbols('IBM', from = '2019-01-01', to = '2020-12-31', auto.assign = F)

## Changing stock data from daily to weekly
ibm = to.weekly(ibm)

## Calculating weekly returns
ibm$weekly_returns = Delt(ibm$ibm.Adjusted)


#####################
## Monthly Returns ##
#####################

## Loading quantmod
library(quantmod)

## Downloading IBM stock price data 
ibm = getSymbols('IBM', from = '2019-01-01', to = '2020-12-31', auto.assign = F)

## Changing stock data from daily to weekly
ibm = to.monthly(ibm)

## Calculating monthly returns
ibm$monthly_returns = Delt(ibm$ibm.Adjusted)

