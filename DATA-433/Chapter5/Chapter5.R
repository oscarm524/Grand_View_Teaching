####################
## Chapter 5 Code ##
####################

## Loading quantmod
library(quantmod)

## Downloading Amazon stock price data 
amazon = getSymbols('AMZN', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

## Computing the total returns 
amazon$tot_return = as.numeric(Delt(amazon$AMZN.Adjusted))

## Computing the variance of the total returns
var(amazon$tot_return, na.rm = T)

## Computing the standard deviation of the total returns
sd(amazon$tot_return, na.rm = T)

####################
## Portfolio Risk ##
####################

## Loading quantmod
library(quantmod)

## Downloading Amazon stock price data 
amazon = getSymbols('AMZN', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

## Downloading IBM stock price data 
ibm = getSymbols('IBM', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

## Computing the total returns
amazon$tot_return = as.numeric(Delt(amazon$AMZN.Adjusted))
ibm$tot_return = as.numeric(Delt(ibm$IBM.Adjusted))

## Computing the variance of the total returns
amazon_var = var(amazon$tot_return, na.rm = T)
ibm_var = var(ibm$tot_return, na.rm = T)

## Computing the covariance
amazon_ibm_cov = cov(na.omit(amazon$tot_return), na.omit(ibm$tot_return))

## Computing the portfolio variance
portfolio_risk = 0.75^2*amazon_var + 0.25^2*ibm_var + 2*0.75*0.25*amazon_ibm_cov

## Loading quantmod
library(quantmod)

## Downloading Amazon stock price data 
amazon = getSymbols('AMZN', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

## Downloading IBM stock price data 
ibm = getSymbols('IBM', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

## Computing the total returns
amazon$tot_return = as.numeric(Delt(amazon$AMZN.Adjusted))
ibm$tot_return = as.numeric(Delt(ibm$IBM.Adjusted))

## Defining the data-frame of returns
returns = data.frame(amazon$tot_return, ibm$tot_return)
returns = na.omit(returns)

## Computing the variance-covariance matrix
returns_cov = cov(returns)

## Defining the vector of weights
w = c(0.75, 0.25)

## Computing the variance of the portfolio
portfolio_var = t(w) %*% returns_cov %*% w
portfolio_var


## Loading quantmod
library(quantmod)

## Downloading Amazon stock price data 
amazon = getSymbols('AMZN', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

## Downloading Tesla stock price data 
tesla = getSymbols('TSLA', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

## Downloading Apple stock price data
apple = getSymbols('AAPL', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

## Downloading IBM stock price data 
ibm = getSymbols('IBM', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

## Computing the total returns
amazon$tot_return = as.numeric(Delt(amazon$AMZN.Adjusted))
tesla$tot_return = as.numeric(Delt(tesla$TSLA.Adjusted))
apple$tot_return = as.numeric(Delt(apple$AAPL.Adjusted))
ibm$tot_return = as.numeric(Delt(ibm$IBM.Adjusted))

## Defining the data-frame of returns
returns = data.frame(amazon$tot_return, tesla$tot_return, apple$tot_return, ibm$tot_return)
returns = na.omit(returns)

## Computing the variance-covariance matrix
returns_cov = cov(returns)

## Defining the vector of weights
w = c(0.35, 0.35, 0.20, 0.10)

## Computing the variance of the portfolio
portfolio_var = t(w) %*% returns_cov %*% w
portfolio_var


##################
## Gaussian VaR ##
##################

## Loading quantmod
library(quantmod)

## Downloading Amazon stock price data 
amazon = getSymbols('AMZN', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

## Downloading Netflix stock price data 
netflix = getSymbols('NFLX', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

## Downloading Tesla stock price data 
tesla = getSymbols('TSLA', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

## Computing total returns
amazon$tot_return = as.numeric(Delt(amazon$AMZN.Adjusted))
netflix$tot_return = as.numeric(Delt(netflix$NFLX.Adjusted))
tesla$tot_return = as.numeric(Delt(tesla$TSLA.Adjusted))

## Defining the returns data-frame
returns = data.frame(AMZN_tot_return = as.numeric(amazon$tot_return), NFLX_tot_return = as.numeric(netflix$tot_return), TSLA_tot_return = as.numeric(tesla$tot_return))
returns = na.omit(returns)

## Computing portfolio return 
returns$portfolio_return = 0.35*returns$AMZN_tot_return + 0.35*returns$NFLX_tot_return + 0.30*returns$TSLA_tot_return

## Computing the portfolio mean return 
mu = mean(returns$portfolio_return)

## Computing the portfolio standard deviation
sigma = sd(returns$portfolio_return)

## Computing the VaR
VaR = -(mu + sigma*qnorm(0.05))*100000


####################
## Historical VaR ##
####################

## Loading quantmod
library(quantmod)

## Downloading Amazon stock price data 
amazon = getSymbols('AMZN', from = '2018-01-01', to = '2020-12-31', auto.assign = F)

## Downloading Netflix stock price data 
netflix = getSymbols('NFLX', from = '2018-01-01', to = '2020-12-31', auto.assign = F)

## Downloading Tesla stock price data 
tesla = getSymbols('TSLA', from = '2018-01-01', to = '2020-12-31', auto.assign = F)

## Computing total returns
amazon$tot_return = as.numeric(Delt(amazon$AMZN.Adjusted))
netflix$tot_return = as.numeric(Delt(netflix$NFLX.Adjusted))
tesla$tot_return = as.numeric(Delt(tesla$TSLA.Adjusted))

## Defining the returns data-frame
returns = data.frame(AMZN_tot_return = as.numeric(amazon$tot_return), NFLX_tot_return = as.numeric(netflix$tot_return), TSLA_tot_return = as.numeric(tesla$tot_return))
returns = na.omit(returns)

## Computing value of each security
returns$AMZN_gross_return = 1 + returns$AMZN_tot_return
returns$AMZN_cum_return = cumprod(returns$AMZN_gross_return)
AMZN_current_value = 0.35*tail(returns$AMZN_cum_return, 1)*100000

returns$NFLX_gross_return = 1 + returns$NFLX_tot_return
returns$NFLX_cum_return = cumprod(returns$NFLX_gross_return)
NFLX_current_value = 0.35*tail(returns$NFLX_cum_return, 1)*100000

returns$TSLA_gross_return = 1 + returns$TSLA_tot_return
returns$TSLA_cum_return = cumprod(returns$TSLA_gross_return)
TSLA_current_value = 0.30*tail(returns$TSLA_cum_return, 1)*100000

## Simulating portfolio returns
sim_portfolio = AMZN_current_value*returns$AMZN_tot_return + NFLX_current_value*returns$NFLX_tot_return + TSLA_current_value*returns$TSLA_tot_return

## Computing the 5% historical VaR
VaR = quantile(sim_portfolio, 0.05)


#################
## Gaussian ES ##
#################

## Loading quantmod
library(quantmod)

## Downloading Amazon stock price data 
amazon = getSymbols('AMZN', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

## Downloading Netflix stock price data 
netflix = getSymbols('NFLX', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

## Downloading Tesla stock price data 
tesla = getSymbols('TSLA', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

## Computing total returns
amazon$tot_return = as.numeric(Delt(amazon$AMZN.Adjusted))
netflix$tot_return = as.numeric(Delt(netflix$NFLX.Adjusted))
tesla$tot_return = as.numeric(Delt(tesla$TSLA.Adjusted))

## Defining the returns data-frame
returns = data.frame(AMZN_tot_return = as.numeric(amazon$tot_return), NFLX_tot_return = as.numeric(netflix$tot_return), TSLA_tot_return = as.numeric(tesla$tot_return))
returns = na.omit(returns)

## Computing portfolio return 
returns$portfolio_return = 0.35*returns$AMZN_tot_return + 0.35*returns$NFLX_tot_return + 0.30*returns$TSLA_tot_return

## Computing the portfolio mean return 
mu = mean(returns$portfolio_return)

## Computing the portfolio standard deviation
sigma = sd(returns$portfolio_return)

## Computing the ES
ES = (mu + sigma*dnorm(qnorm(0.05))/0.05)*100000

###################
## Historical ES ##
###################

## Loading quantmod
library(quantmod)

## Downloading Amazon stock price data 
amazon = getSymbols('AMZN', from = '2018-01-01', to = '2020-12-31', auto.assign = F)

## Downloading Netflix stock price data 
netflix = getSymbols('NFLX', from = '2018-01-01', to = '2020-12-31', auto.assign = F)

## Downloading Tesla stock price data 
tesla = getSymbols('TSLA', from = '2018-01-01', to = '2020-12-31', auto.assign = F)

## Computing total returns
amazon$tot_return = as.numeric(Delt(amazon$AMZN.Adjusted))
netflix$tot_return = as.numeric(Delt(netflix$NFLX.Adjusted))
tesla$tot_return = as.numeric(Delt(tesla$TSLA.Adjusted))

## Defining the returns data-frame
returns = data.frame(AMZN_tot_return = as.numeric(amazon$tot_return), NFLX_tot_return = as.numeric(netflix$tot_return), TSLA_tot_return = as.numeric(tesla$tot_return))
returns = na.omit(returns)

## Computing value of each security
returns$AMZN_gross_return = 1 + returns$AMZN_tot_return
returns$AMZN_cum_return = cumprod(returns$AMZN_gross_return)
AMZN_current_value = 0.35*tail(returns$AMZN_cum_return, 1)*100000

returns$NFLX_gross_return = 1 + returns$NFLX_tot_return
returns$NFLX_cum_return = cumprod(returns$NFLX_gross_return)
NFLX_current_value = 0.35*tail(returns$NFLX_cum_return, 1)*100000

returns$TSLA_gross_return = 1 + returns$TSLA_tot_return
returns$TSLA_cum_return = cumprod(returns$TSLA_gross_return)
TSLA_current_value = 0.30*tail(returns$TSLA_cum_return, 1)*100000

## Simulating portfolio returns
sim_portfolio = AMZN_current_value*returns$AMZN_tot_return + NFLX_current_value*returns$NFLX_tot_return + TSLA_current_value*returns$TSLA_tot_return

## Computing the 5% historical VaR
VaR = quantile(sim_portfolio, 0.05)

## Computing the average of the of losses in excess of VaR
ES = mean(sim_portfolio[sim_portfolio < as.numeric(VaR)])

###############
## Parkinson ##
###############

## Loading quantmod
library(quantmod)

## Downloading Amazon stock price data 
amazon = getSymbols('AMZN', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

## Computing the log(h_t/l_t)
amazon$log_high_low = log(amazon$AMZN.High / amazon$AMZN.Low)

## Computing log-square
amazon$log_square = amazon$log_high_low^2

## Computing the sum of log-square
log_square_sum = sum(amazon$log_square)

## Computing the Parkinson volatility measure
Parkinson = sqrt((1/(4*nrow(amazon)*log(2))) * log_square_sum)


##################
## Garman-Klass ##
##################

## Loading quantmod
library(quantmod)

## Downloading Amazon stock price data 
amazon = getSymbols('AMZN', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

## Computing the log(h_t/l_t) and its square
amazon$log_high_low = log(amazon$AMZN.High / amazon$AMZN.Low)
amazon$log_high_low_square = amazon$log_high_low^2

## Computing the log(c_t/o_t) and its square
amazon$log_close_open = log(amazon$AMZN.Close / amazon$AMZN.Open)
amazon$log_close_open_square = amazon$log_close_open^2

## Computing the Garman-Klass volatility measure
Garman_Klass = sqrt((1/(2*nrow(amazon)))*sum(amazon$log_high_low_square - ((2*log(2)-1)/nrow(amazon))*amazon$log_close_open_square))


#########
## RSY ##
#########

## Loading quantmod
library(quantmod)

## Downloading Amazon stock price data 
amazon = getSymbols('AMZN', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

## Computing the log(h_t/c_t) 
amazon$log_high_close = log(amazon$AMZN.High / amazon$AMZN.Close)

## Computing the log(h_t/o_t)
amazon$log_high_open = log(amazon$AMZN.High / amazon$AMZN.Open)

## Computing the log(l_t/c_t)
amazon$log_low_close = log(amazon$AMZN.Low / amazon$AMZN.Close)

## Computing the log(l_t/o_t)
amazon$log_low_open = log(amazon$AMZN.Low / amazon$AMZN.Open)

## Computing the RSY volatility measure
RSY = sqrt((1/nrow(amazon))*sum(amazon$log_high_close*amazon$log_high_open + amazon$log_low_close*amazon$log_low_open))


################
## Yang-Zhang ##
################

## Loading quantmod
library(quantmod)

## Downloading Amazon stock price data 
amazon = getSymbols('AMZN', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

## Computing sigma^2 close-to-open
sigma_square_close_to_open = (1/(nrow(amazon)-1))*(sum((log(amazon$AMZN.Open[-1] / amazon$AMZN.Close[-nrow(amazon)])  - (1/nrow(amazon))*sum(log(amazon$AMZN.Open[-1] / amazon$AMZN.Close[-nrow(amazon)])))^2))

## Computing sigma^2 open-to-close
sigma_square_open_to_close = (1/(nrow(amazon)-1))*sum((log(amazon$AMZN.Close / amazon$AMZN.Open) - (1/nrow(amazon))*sum(log(amazon$AMZN.Close / amazon$AMZN.Open)))^2)

## Computing k
k = 0.34 / (1.34 + ((nrow(amazon) + 1) / (nrow(amazon) - 1)))

## Computing the Yang-Zhang volatility measure
Yang_Zhang = sqrt(sigma_square_close_to_open + k*sigma_square_open_to_close + (1-k)*RSY^2)

