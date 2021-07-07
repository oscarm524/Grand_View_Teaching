###############
## Chapter 2 ##
###############

rm(list = ls())

## Loading quantmod
library(quantmod)

## Importing apple stock data 
apple = getSymbols('AAPL', from = '2020-01-01', to = '2020-10-31', auto.assign = F)
apple = data.frame(apple)
# apple$Date = as.Date(row.names(apple), format = '%Y-%m-%d')
# row.names(apple) = NULL

plot(apple$AAPL.Adjusted, main = 'Apple Adj. Close Stock Price ($)')

summary(apple)

## Selecting the first 20 observations
first_20_obs = apple[1:20, ]

## Removing observations 10 to 20 
removing_10_to_20 = apple[-c(10:20), ]

## Selecting Open and Close variables
open_close_vars = apple[, c(1, 4)]

## or the following
open_close_vars = apple[, c('AAPL.Open', 'AAPL.Close')]

## Removing low and high variables
remove_low_high = apple[, -c(2, 3)]

## or the following
remove_low_high = apple[, !(names(apple) %in% c('AAPL.Low', 'AAPL.High'))]

## Subsetting stock data from september and october 
sep_oct_data = subset(apple, index(apple) >= '2020-09-01' & index(apple) <= '2020-10-31')

## Converting apple daily stock data to weekly data
apple_weekly = to.weekly(apple)

## Converting apple daily stock data to monthly data
apple_monthly = to.monthly(apple)

## Converting apple daily stock data to quarterly data
apple_quarterly = to.quarterly(apple)

## Apple data
apple = getSymbols('AAPL', from = '2019-12-31', to = '2020-10-31', auto.assign = F)

## Netflix data
netflix = getSymbols('NFLX', from = '2019-12-31', to = '2020-10-31', auto.assign = F) 

## IBM data
ibm = getSymbols('IBM', from = '2019-12-31', to = '2020-10-31', auto.assign = F)

## Amazon data
amazon = getSymbols('AMZN', from = '2019-12-31', to = '2020-10-31', auto.assign = F)

## SP500 data 
sp500 = getSymbols('^GSPC', from = '2019-12-31', to = '2020-10-31', auto.assign = F)


## Selecting close prices
Close_Prices = data.frame(cbind(apple$AAPL.Close, netflix$NFLX.Close, ibm$IBM.Close, amazon$AMZN.Close, sp500$GSPC.Close))

## Computing the index for each of the securites
Close_Prices$AAPL.Index =  Close_Prices$AAPL.Close / Close_Prices$AAPL.Close[1]
Close_Prices$NFLX.Index =  Close_Prices$NFLX.Close / Close_Prices$NFLX.Close[1]
Close_Prices$IBM.Index =  Close_Prices$IBM.Close / Close_Prices$IBM.Close[1]
Close_Prices$AMZN.Index =  Close_Prices$AMZN.Close / Close_Prices$AMZN.Close[1]
Close_Prices$GSPC.Index =  Close_Prices$GSPC.Close / Close_Prices$GSPC.Close[1]

plot(as.Date(rownames(Close_Prices)), Close_Prices$AAPL.Index, type = 'l', lwd = 2, xlab = 'Date', ylim = c(0.5, 2), ylab = 'Value of Investment ($)'); grid()
abline(h = 1, lwd = 2, lty = 2)
lines(as.Date(rownames(Close_Prices)), Close_Prices$NFLX.Index, lwd = 2, col = 'red')
lines(as.Date(rownames(Close_Prices)), Close_Prices$IBM.Index, lwd = 2, col = 'blue')
lines(as.Date(rownames(Close_Prices)), Close_Prices$AMZN.Index, lwd = 2, col = 'green')
lines(as.Date(rownames(Close_Prices)), Close_Prices$GSPC.Index, lwd = 2, col = 'brown')
legend('topleft', lty = c(1, 1, 1, 1, 1), lwd = c(2, 2, 2, 2, 2), col = c('black', 'red', 'blue', 'green', 'brown'), c('AAPL', 'NFLX', 'IBM', 'AMZN', 'SP500'))

#####################
## Moving Averages ##
#####################

## Loading quantmod
library(quantmod)

## Importing apple stock data 
apple = getSymbols('AAPL', from = '2018-01-01', to = '2020-10-31', auto.assign = F)

## Computing the moving averages
apple$MA_50 = rollmean(apple$AAPL.Close, k = 50, align = 'right')
apple$MA_200 = rollmean(apple$AAPL.Close, k = 200, align = 'right')

## Converting data to data-frame
apple = data.frame(apple)

## Plotting the apple stock price
plot(as.Date(rownames(apple)), apple$AAPL.Close, type  = 'l', lwd = 2, xlab = 'Date', ylab = 'Apple Stock Price ($)')
grid()

## Adding the 50-day moving average
lines(as.Date(rownames(apple)), apple$MA_50, col = 'blue', lwd = 2)

## Adding the 200-day moving average
lines(as.Date(rownames(apple)), apple$MA_200, col = 'brown', lwd = 2)

## Adding the legend
legend('topleft', lwd = c(2, 2, 2), col = c('black', 'blue', 'brown'), c('Apple Price', '50-day MA', '100-day MA'))


##########
## MACD ##
##########

## Loading quantmod
library(quantmod)

## Importing apple stock data 
apple = getSymbols('AAPL', from = '2018-01-01', to = '2020-10-31', auto.assign = F)

## Selecting variables of interest
apple_to_consider = subset(apple, select = c(AAPL.Close))

## This function computes the EMA for a given period k
EMA_k = function(stock_data, periods = 12){
	
	## Extracting the number of data-points
	n = dim(stock_data)[1]
	
	## Defining an array to store the EMA 
	EMA = array()
	EMA[1:(periods-1)] = NA
	EMA[periods] = mean(stock_data[1:periods])
	
	## Computing k
	k = 2 / (periods + 1)
	
	## Looping to compute the other EMAs
	for(i in (periods + 1):n){
		
		EMA[i] = stock_data[i] * k + EMA[i - 1] * (1 - k)
		
	}
	EMA = reclass(EMA, stock_data)
	return(EMA)
}

test = EMA_k(apple_to_consider, periods = 12)


#####################
## Bollinger Bands ##
#####################

## Loading quantmod
library(quantmod)

## Downloading Amazon stock price data 
amazon = getSymbols('AMZN', from = '2019-01-01', to = '2020-12-31', auto.assign = F)

## Computing the moving averages and standard deviation
amazon$ma = rollmean(amazon$AMZN.Close, k = 20, align = 'right')
amazon$sd = rollapply(amazon$AMZN.Close, width = 20, FUN = sd, fill = NA)

## Computing the Bollinger bands
amazon$up = amazon$ma + 2*amazon$sd
amazon$low = amazon$ma - 2*amazon$sd

## Plotting the Bollinger bands
plot(amazon$AMZN.Close, main = 'Bollinger Bands of Amazon', ylim = c(min(amazon$low, na.rm = T) - 10, max(amazon$up, na.rm = T) + 10))
lines(amazon$ma, col = 'blue', lwd = 2)
lines(amazon$up, col = 'green', lwd = 2)
lines(amazon$low, col = 'green', lwd = 2)

#########
## RSI ##
#########

## Loading quantmod
library(quantmod)

## Downloading Amazon stock price data 
amazon = getSymbols('AMZN', from = '2019-01-01', to = '2020-12-31', auto.assign = F)

## Selecting variable of interest
amazon_close = subset(amazon, select = AMZN.Close)

## Calculating difference in price
amazon_close$Delta = diff(amazon_close$AMZN.Close)

## Computing dummy variables to indicate whether price went up or down
amazon_close$up = ifelse(amazon_close$Delta > 0, 1, 0)
amazon_close$down = ifelse(amazon_close$Delta <= 0, 1, 0)

## Dropping missing values
amazon_close = na.omit(amazon_close)

## Computing prices for up and down
amazon_close$up_val = abs(amazon_close$Delta * amazon_close$up)
amazon_close$down_val = abs(amazon_close$Delta * amazon_close$down)

## Computing up and down averages
amazon_close$up_avg = rollapply(amazon_close$up_val, width = 14, FUN = mean, fill = NA)
amazon_close$down_avg = rollapply(amazon_close$down_val, width = 14, FUN = mean, fill = NA)

## Computing the up and down Wilder Moving Averages
amazon_close$up_WMA = amazon_close$up_avg
amazon_close$down_WMA = amazon_close$down_avg

for(i in 15:dim(amazon_close)[1]){

   amazon_close$up_WMA[i] = as.numeric(amazon_close$up_WMA[i-1]) + (as.numeric(amazon_close$up_avg[i]) - as.numeric(amazon_close$up_WMA[i-1])) / 14
   amazon_close$down_WMA[i] = as.numeric(amazon_close$down_WMA[i-1]) + (as.numeric(amazon_close$down_avg[i]) - as.numeric(amazon_close$down_WMA[i-1])) / 14
   
}

## Calculating the RS
amazon_close$RS = amazon_close$up_WMA / amazon_close$down_WMA

## Calculating the RIS
amazon_close$RIS = 100 - (100 / (1 + amazon_close$RS))

## Visualizing the RSI
plot(as.Date(index(amazon_close)), amazon_close$RIS, type = 'l', col = 'black', lwd = 2, xlab = 'Date', ylab = 'RSI (14-day Moving Average)', ylim = c(0, 100))
abline(h = 70, lty = 2)
abline(h = 30, lty = 2)
grid()



