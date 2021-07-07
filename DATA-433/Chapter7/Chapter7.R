######################
## Minimum Variance ##
######################

## Loading quantmod
library(quantmod)

## Downloading Amazon stock price data 
amazon = getSymbols('AMZN', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

## Downloading Apple stock price data 
apple = getSymbols('AAPL', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

## Computing the total returns
returns = data.frame(AMZN_tot_return = as.numeric(Delt(amazon$AMZN.Adjusted)), AAPL_tot_return = as.numeric(Delt(apple$AAPL.Adjusted)))
returns = na.omit(returns)

## Creating a series of weights
weights = data.frame(AMZN_wgt = seq(0, 1, by = 0.01))
weights$AAPL_wgt = 1 - weights$AMZN_wgt

## Computing the variance and the covariance
var_amazon = var(returns$AMZN_tot_return)
var_apple = var(returns$AAPL_tot_return)
cov_amazon_apple = cov(returns$AMZN_tot_return, returns$AAPL_tot_return)

## Computing the variance of each weight combination
weights$portfolio_variance = weights$AMZN_wgt^2 * var_amazon + weights$AAPL_wgt^2 * var_apple + 2*cov_amazon_apple*weights$AMZN_wgt*weights$AAPL_wgt

## Identifying portfolio with minimum variance
weights_min = weights[which.min(weights$portfolio_variance), ]

## Plotting the portfolio variances
plot(weights$portfolio_variance, type = 'o', ylab = 'Portfolio Variance')
grid()

##########################
## Maximum Sharpe Ratio ##
##########################

## Loading quantmod
library(quantmod)

## Downloading Amazon stock price data 
amazon = getSymbols('AMZN', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

## Downloading Apple stock price data 
apple = getSymbols('AAPL', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

## Computing the total returns
returns = data.frame(AMZN_tot_return = as.numeric(Delt(amazon$AMZN.Adjusted)), AAPL_tot_return = as.numeric(Delt(apple$AAPL.Adjusted)))
returns = na.omit(returns)

## Creating a series of weights
weights = data.frame(AMZN_wgt = seq(0, 1, by = 0.01))
weights$AAPL_wgt = 1 - weights$AMZN_wgt

## Computing the portfolio returns for each weight combination
weights$portfolio_return = weights$AMZN_wgt * mean(returns$AMZN_tot_return) + weights$AAPL_wgt * mean(returns$AAPL_tot_return)

## Computing the variance and the covariance
var_amazon = var(returns$AMZN_tot_return)
var_apple = var(returns$AAPL_tot_return)
cov_amazon_apple = cov(returns$AMZN_tot_return, returns$AAPL_tot_return)

## Computing the variance of each weight combination
weights$portfolio_variance = weights$AMZN_wgt^2 * var_amazon + weights$AAPL_wgt^2 * var_apple + 2*cov_amazon_apple*weights$AMZN_wgt*weights$AAPL_wgt

## Computing the Sharpe Ratio of each weight combination
daily_risk_rate = 0.0008 / 365
weights$Sharpe_Ratio = (weights$portfolio_return - daily_risk_rate) / sqrt(weights$portfolio_variance)

## Identifying portfolio with maximum Sharpe Ratio
weights_max = weights[which.max(weights$Sharpe_Ratio), ]

## Plotting the portfolio variances
plot(weights$portfolio_variance, weights$portfolio_return, type = 'o', xlab = 'Portfolio Variance', ylab = 'Portfolio Return')
grid()

##############################################
## Minimum Variance (quadratic programming) ##
##############################################

## Loading quantmod
library(quantmod)

## Downloading Amazon stock price data 
amazon = getSymbols('AMZN', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

## Downloading Apple stock price data 
apple = getSymbols('AAPL', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

## Computing the total returns
returns = data.frame(AMZN_tot_return = as.numeric(Delt(amazon$AMZN.Adjusted)), AAPL_tot_return = as.numeric(Delt(apple$AAPL.Adjusted)))
returns = na.omit(returns)

## Loading quadprog
library(quadprog)

## Defining the number of stocks
n = dim(returns)[2]

## Defining dvec 
dvec = rep(0, n)

## Defining the covariance matrix
D = cov(returns)

## Defining the matrix of constraints
A = rbind(rep(1, n), diag(n))
b0 = c(1, rep(0, n))

## Solving the optimization problem
weights_min_var = solve.QP(Dmat = D, dvec = dvec, Amat = t(A), bvec = b0, meq = 1)$solution


##################################################
## Maximum Sharpe-Ratio (quadratic programming) ##
##################################################

## Loading quantmod
library(quantmod)

## Downloading Amazon stock price data 
amazon = getSymbols('AMZN', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

## Downloading Apple stock price data 
apple = getSymbols('AAPL', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

## Computing the total returns
returns = data.frame(AMZN_tot_return = as.numeric(Delt(amazon$AMZN.Adjusted)), AAPL_tot_return = as.numeric(Delt(apple$AAPL.Adjusted)))
returns = na.omit(returns)

## Loading quadprog
library(quadprog)

## Defining the number of stocks
n = dim(returns)[2]

## Defining the risk free rate
daily_risk = 0.0008 / 365

## Defining dvec 
dvec = rep(0, n)

## Defining the covariance matrix
D = cov(returns)

## Defining the matrix of constraints
return_means = colMeans(returns) - daily_risk
A = rbind(return_means, diag(n))
b0 = c(1, rep(0, n))

## Solving the optimization problem
weights_max_Sharpe = solve.QP(Dmat = D, dvec = c(0, 0), Amat = t(A), bvec = b0, meq = 1)$solution
weights_max_Sharpe = weights_max_Sharpe/sum(weights_max_Sharpe)


##############################################
## Minimum Variance (quadratic programming) ##
##############################################

## Loading quantmod
library(quantmod)

## Downloading Amazon stock price data 
amazon = getSymbols('AMZN', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

## Downloading Apple stock price data 
apple = getSymbols('AAPL', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

## Downloading Netflix stock price data
netflix = getSymbols('NFLX', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

## Downloading Tesla stock price data
tesla = getSymbols('TSLA', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

## Downloading Google stock price data
google = getSymbols('GOOG', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

## Computing the total returns
returns = data.frame(AMZN_tot_return = as.numeric(Delt(amazon$AMZN.Adjusted)), AAPL_tot_return = as.numeric(Delt(apple$AAPL.Adjusted)), NFLX_tot_return = as.numeric(Delt(netflix$NFLX.Adjusted)), TSLA_tot_return = as.numeric(Delt(tesla$TSLA.Adjusted)), GOOG_tot_return = as.numeric(Delt(google$GOOG.Adjusted)))
returns = na.omit(returns)

## Loading quadprog
library(quadprog)

## Defining the number of stocks
n = dim(returns)[2]

## Defining dvec 
dvec = rep(0, n)

## Defining the covariance matrix
D = cov(returns)

## Defining the matrix of constraints
A = rbind(rep(1, n), diag(n))
b0 = c(1, rep(0, n))

## Solving the optimization problem
weights_min_var = solve.QP(Dmat = D, dvec = dvec, Amat = t(A), bvec = b0, meq = 1)$solution


##################################################
## Maximum Sharpe-Ratio (quadratic programming) ##
##################################################

## Loading quantmod
library(quantmod)

## Downloading Amazon stock price data 
amazon = getSymbols('AMZN', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

## Downloading Apple stock price data 
apple = getSymbols('AAPL', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

## Downloading Netflix stock price data
netflix = getSymbols('NFLX', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

## Downloading Tesla stock price data
tesla = getSymbols('TSLA', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

## Downloading Google stock price data
google = getSymbols('GOOG', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

## Computing the total returns
returns = data.frame(AMZN_tot_return = as.numeric(Delt(amazon$AMZN.Adjusted)), AAPL_tot_return = as.numeric(Delt(apple$AAPL.Adjusted)), NFLX_tot_return = as.numeric(Delt(netflix$NFLX.Adjusted)), TSLA_tot_return = as.numeric(Delt(tesla$TSLA.Adjusted)), GOOG_tot_return = as.numeric(Delt(google$GOOG.Adjusted)))
returns = na.omit(returns)

## Loading quadprog
library(quadprog)

## Defining the number of stocks
n = dim(returns)[2]

## Defining the risk free rate
daily_risk = 0.0008 / 365

## Defining dvec 
dvec = rep(0, n)

## Defining the covariance matrix
D = cov(returns)

## Defining the matrix of constraints
return_means = colMeans(returns) - daily_risk
A = rbind(return_means, diag(n))
b0 = c(1, rep(0, n))

## Solving the optimization problem
weights_max_Sharpe = solve.QP(Dmat = D, dvec = dvec, Amat = t(A), bvec = b0, meq = 1)$solution
weights_max_Sharpe = weights_max_Sharpe/sum(weights_max_Sharpe)









