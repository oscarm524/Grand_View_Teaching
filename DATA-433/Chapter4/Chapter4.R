####################
## Chapter 4 Code ##
####################

## Loading quantmod
library(quantmod)

## Downloading Amazon stock price data
amazon = getSymbols('AMZN', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

## Downloading Ebay stock price data 
ebay = getSymbols('EBAY', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

## Downloading Uber stock price data
uber = getSymbols('UBER', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

## Selecting two specific data points and varible of interest for time horizon
amazon = subset(amazon, index(amazon) %in% as.Date(c('2020-01-02', '2020-12-30')), select = c(AMZN.Adjusted))
ebay = subset(ebay, index(ebay) %in% as.Date(c('2020-01-02', '2020-12-30')), select = c(EBAY.Adjusted))
uber = subset(uber, index(uber) %in% as.Date(c('2020-01-02', '2020-12-30')), select = c(UBER.Adjusted))

## Constructing the portfolio
portfolio = data.frame(amazon, ebay, uber)

## Calculating the return of each of the securities 
portfolio = data.frame(apply(portfolio, 2, Delt))

## Removing NA (missing values)
portfolio = na.omit(portfolio)

## Defining the dollar amounts
amazon_dollar = 50000
ebay_dollar = 40000
uber_dollar = 10000

## Computing the weights
w_amazon = amazon_dollar / (amazon_dollar + ebay_dollar + uber_dollar)
w_ebay = ebay_dollar / (amazon_dollar + ebay_dollar + uber_dollar)
w_uber = uber_dollar / (amazon_dollar + ebay_dollar + uber_dollar)

## Computing the portfolio return
portfolio_return = w_amazon * portfolio$AMZN.Adjusted + w_ebay * portfolio$EBAY.Adjusted + w_uber * portfolio$UBER.Adjusted
portfolio_return

## Creating the weight vector 
w = c(w_amazon, w_ebay, w_uber)

## Creating the vector of returns
r = matrix(c(portfolio$AMZN.Adjusted, portfolio$EBAY.Adjusted, portfolio$UBER.Adjusted), nrow = 3)

## Computing the portfolio return
portfolio_return = w %*% r

############################
## Equal-Weight Portfolio ##
############################

## Loading quantmod
library(quantmod)

## Downloading Amazon stock price data
amazon = getSymbols('AMZN', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

## Downloading Ebay stock price data 
ebay = getSymbols('EBAY', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

## Downloading Uber stock price data
uber = getSymbols('UBER', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

## Selecting two specific data points and variable of interest for time horizon
amazon = subset(amazon, select = c(AMZN.Adjusted))
ebay = subset(ebay, select = c(EBAY.Adjusted))
uber = subset(uber, select = c(UBER.Adjusted))

## Constructing the portfolio
portfolio = data.frame(amazon, ebay, uber)

## Computing the returns
portfolio$AMZN_ret = as.numeric(Delt(portfolio$AMZN.Adjusted))
portfolio$EBAY_ret = as.numeric(Delt(portfolio$EBAY.Adjusted))
portfolio$UBER_ret = as.numeric(Delt(portfolio$UBER.Adjusted))

## Computing gross returns 
portfolio$AMZN_ret = 1 + portfolio$AMZN_ret
portfolio$EBAY_ret = 1 + portfolio$EBAY_ret
portfolio$UBER_ret = 1 + portfolio$UBER_ret

## Removing missing values
portfolio = na.omit(portfolio)

## Computing Equal-Weight portfolio value for 2020-Q1
portfolio_Q1 = subset(portfolio, as.Date(row.names(portfolio)) >= as.Date('2020-01-01') & as.Date(row.names(portfolio)) <= as.Date('2020-03-31'))

## Computing cumulative returns
portfolio_Q1$AMZN_cum_ret = cumprod(portfolio_Q1$AMZN_ret)
portfolio_Q1$EBAY_cum_ret = cumprod(portfolio_Q1$EBAY_ret)
portfolio_Q1$UBER_cum_ret = cumprod(portfolio_Q1$UBER_ret)

## Computing w x r
portfolio_Q1$AMZN_idx = (1/3) * portfolio_Q1$AMZN_cum_ret
portfolio_Q1$EBAY_idx = (1/3) * portfolio_Q1$EBAY_cum_ret
portfolio_Q1$UBER_idx = (1/3) * portfolio_Q1$UBER_cum_ret

## Computing portfolio returns
portfolio_Q1$value = portfolio_Q1$AMZN_idx + portfolio_Q1$EBAY_idx + portfolio_Q1$UBER_idx

## Computing Equal-Weight portfolio value for 2020-Q2
portfolio_Q2 = subset(portfolio, as.Date(row.names(portfolio)) >= as.Date('2020-04-01') & as.Date(row.names(portfolio)) <= as.Date('2020-06-30'))

## Computing cumulative returns
portfolio_Q2$AMZN_cum_ret = cumprod(portfolio_Q2$AMZN_ret)
portfolio_Q2$EBAY_cum_ret = cumprod(portfolio_Q2$EBAY_ret)
portfolio_Q2$UBER_cum_ret = cumprod(portfolio_Q2$UBER_ret)

## Computing w x r
portfolio_Q2$AMZN_idx = (1/3) * portfolio_Q2$AMZN_cum_ret
portfolio_Q2$EBAY_idx = (1/3) * portfolio_Q2$EBAY_cum_ret
portfolio_Q2$UBER_idx = (1/3) * portfolio_Q2$UBER_cum_ret

## Computing portfolio returns
portfolio_Q2$value = portfolio_Q2$AMZN_idx + portfolio_Q2$EBAY_idx + portfolio_Q2$UBER_idx

## Computing Equal-Weight portfolio value for 2020-Q3
portfolio_Q3 = subset(portfolio, as.Date(row.names(portfolio)) >= as.Date('2020-07-01') & as.Date(row.names(portfolio)) <= as.Date('2020-09-30'))

## Computing cumulative returns
portfolio_Q3$AMZN_cum_ret = cumprod(portfolio_Q3$AMZN_ret)
portfolio_Q3$EBAY_cum_ret = cumprod(portfolio_Q3$EBAY_ret)
portfolio_Q3$UBER_cum_ret = cumprod(portfolio_Q3$UBER_ret)

## Computing w x r
portfolio_Q3$AMZN_idx = (1/3) * portfolio_Q3$AMZN_cum_ret
portfolio_Q3$EBAY_idx = (1/3) * portfolio_Q3$EBAY_cum_ret
portfolio_Q3$UBER_idx = (1/3) * portfolio_Q3$UBER_cum_ret

## Computing portfolio returns
portfolio_Q3$value = portfolio_Q3$AMZN_idx + portfolio_Q3$EBAY_idx + portfolio_Q3$UBER_idx

## Computing Equal-Weight portfolio value for 2020-Q4
portfolio_Q4 = subset(portfolio, as.Date(row.names(portfolio)) >= as.Date('2020-10-01') & as.Date(row.names(portfolio)) <= as.Date('2020-12-31'))

## Computing cumulative returns
portfolio_Q4$AMZN_cum_ret = cumprod(portfolio_Q4$AMZN_ret)
portfolio_Q4$EBAY_cum_ret = cumprod(portfolio_Q4$EBAY_ret)
portfolio_Q4$UBER_cum_ret = cumprod(portfolio_Q4$UBER_ret)

## Computing w x r
portfolio_Q4$AMZN_idx = (1/3) * portfolio_Q4$AMZN_cum_ret
portfolio_Q4$EBAY_idx = (1/3) * portfolio_Q4$EBAY_cum_ret
portfolio_Q4$UBER_idx = (1/3) * portfolio_Q4$UBER_cum_ret

## Computing portfolio returns
portfolio_Q4$value = portfolio_Q4$AMZN_idx + portfolio_Q4$EBAY_idx + portfolio_Q4$UBER_idx


############################
## Value-Weight Portfolio ##
############################

## Loading quantmod
library(quantmod)

## Downloading Amazon stock price data
amazon = getSymbols('AMZN', from = '2019-12-31', to = '2020-12-31', auto.assign = F)

## Downloading Ebay stock price data 
ebay = getSymbols('EBAY', from = '2019-12-31', to = '2020-12-31', auto.assign = F)

## Downloading Uber stock price data
uber = getSymbols('UBER', from = '2019-12-31', to = '2020-12-31', auto.assign = F)

## Constructing the portfolio
portfolio = data.frame(amazon$AMZN.Close, ebay$EBAY.Close, uber$UBER.Close)

## Selecting dates of interest
portfolio = subset(portfolio, row.names(portfolio) %in% c('2019-12-31', '2020-03-31', '2020-06-30', '2020-09-30'))

## Appending Outstanding shares
portfolio$AMZN_out_shares = c(497810444, 498776032, 500889651, 501751183)
portfolio$EBAY_out_shares = c(796080826, 700853258, 699881116, 689338530)
portfolio$UBER_out_shares = c(1723775076, 1733987312, 1752622515, 1763768098)

## Computing the market capitalization of each stock
portfolio$AMZN_market_cap = portfolio$AMZN.Close * portfolio$AMZN_out_shares
portfolio$EBAY_market_cap = portfolio$EBAY.Close * portfolio$EBAY_out_shares
portfolio$UBER_market_cap = portfolio$UBER.Close * portfolio$UBER_out_shares

## Computing aggregate market capitalization
portfolio$tot_market_cap = portfolio$AMZN_market_cap + portfolio$EBAY_market_cap + portfolio$UBER_market_cap

## Computing the weights
portfolio$AMZN_weight = portfolio$AMZN_market_cap / portfolio$tot_market_cap
portfolio$EBAY_weight = portfolio$EBAY_market_cap / portfolio$tot_market_cap
portfolio$UBER_weight = portfolio$UBER_market_cap / portfolio$tot_market_cap

## Computing the returns
returns = data.frame(amazon$AMZN.Adjusted, ebay$EBAY.Adjusted, uber$UBER.Adjusted)
returns$AMZN_ret = as.numeric(Delt(returns$AMZN.Adjusted))
returns$EBAY_ret = as.numeric(Delt(returns$EBAY.Adjusted))
returns$UBER_ret = as.numeric(Delt(returns$UBER.Adjusted))

## Removing NA
returns = na.omit(returns)

## Computing gross returns
returns$AMZN_gross_ret = 1 + returns$AMZN_ret
returns$EBAY_gross_ret = 1 + returns$EBAY_ret
returns$UBER_gross_ret = 1 + returns$UBER_ret

## Selecting 2020-Q1 returns
returns_Q1 = subset(returns, as.Date(row.names(returns)) >= as.Date(c('2020-01-01')) & as.Date(row.names(returns)) <= as.Date(c('2020-03-31')))

## Computing cumulative returns
returns_Q1$AMZN_cum_return = cumprod(returns_Q1$AMZN_gross_ret)
returns_Q1$EBAY_cum_return = cumprod(returns_Q1$EBAY_gross_ret)
returns_Q1$UBER_cum_return = cumprod(returns_Q1$UBER_gross_ret)

## Computing w x r
returns_Q1$AMZN_idx = 0.9199793 * returns_Q1$AMZN_cum_return
returns_Q1$EBAY_idx = 0.02874977 * returns_Q1$EBAY_cum_return
returns_Q1$UBER_idx = 0.05127094 * returns_Q1$UBER_cum_return

## Computing the portfolio value
returns_Q1$value = returns_Q1$AMZN_idx + returns_Q1$EBAY_idx + returns_Q1$UBER_idx


## Selecting 2020-Q2 returns
returns_Q2 = subset(returns, as.Date(row.names(returns)) >= as.Date(c('2020-04-01')) & as.Date(row.names(returns)) <= as.Date(c('2020-06-30')))

## Computing cumulative returns
returns_Q2$AMZN_cum_return = cumprod(returns_Q2$AMZN_gross_ret)
returns_Q2$EBAY_cum_return = cumprod(returns_Q2$EBAY_gross_ret)
returns_Q2$UBER_cum_return = cumprod(returns_Q2$UBER_gross_ret)

## Computing w x r
returns_Q2$AMZN_idx = 0.9333171 * returns_Q2$AMZN_cum_return
returns_Q2$EBAY_idx = 0.02021936 * returns_Q2$EBAY_cum_return
returns_Q2$UBER_idx = 0.04646358 * returns_Q2$UBER_cum_return

## Computing the portfolio value
returns_Q2$value = returns_Q2$AMZN_idx + returns_Q2$EBAY_idx + returns_Q2$UBER_idx


## Selecting 2020-Q3 returns
returns_Q3 = subset(returns, as.Date(row.names(returns)) >= as.Date(c('2020-07-01')) & as.Date(row.names(returns)) <= as.Date(c('2020-09-30')))

## Computing cumulative returns
returns_Q3$AMZN_cum_return = cumprod(returns_Q3$AMZN_gross_ret)
returns_Q3$EBAY_cum_return = cumprod(returns_Q3$EBAY_gross_ret)
returns_Q3$UBER_cum_return = cumprod(returns_Q3$UBER_gross_ret)

## Computing w x r
returns_Q3$AMZN_idx = 0.9381008 * returns_Q3$AMZN_cum_return
returns_Q3$EBAY_idx = 0.02492033 * returns_Q3$EBAY_cum_return
returns_Q3$UBER_idx = 0.03697886 * returns_Q3$UBER_cum_return

## Computing the portfolio value
returns_Q3$value = returns_Q3$AMZN_idx + returns_Q3$EBAY_idx + returns_Q3$UBER_idx


## Selecting 2020-Q4 returns
returns_Q4 = subset(returns, as.Date(row.names(returns)) >= as.Date(c('2020-10-01')) & as.Date(row.names(returns)) <= as.Date(c('2020-12-31')))

## Computing cumulative returns
returns_Q4$AMZN_cum_return = cumprod(returns_Q4$AMZN_gross_ret)
returns_Q4$EBAY_cum_return = cumprod(returns_Q4$EBAY_gross_ret)
returns_Q4$UBER_cum_return = cumprod(returns_Q4$UBER_gross_ret)

## Computing w x r
returns_Q4$AMZN_idx = 0.9403282 * returns_Q4$AMZN_cum_return
returns_Q4$EBAY_idx = 0.02137597 * returns_Q4$EBAY_cum_return
returns_Q4$UBER_idx = 0.03829587 * returns_Q4$UBER_cum_return

## Computing the portfolio value
returns_Q4$value = returns_Q4$AMZN_idx + returns_Q4$EBAY_idx + returns_Q4$UBER_idx
