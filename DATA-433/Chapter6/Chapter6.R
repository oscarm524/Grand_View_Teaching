####################
## Chapter 6 Code ##
####################

rm(list = ls())

## Loading quantmod
library(quantmod)

## Downloading Amazon stock price data 
amazon = getSymbols('AMZN', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

## Downloading Tesla stock price data 
tesla = getSymbols('TSLA', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

## Downloading Netflix stock price data 
netflix = getSymbols('NFLX', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

## Downloading Apple stock price data 
apple = getSymbols('AAPL', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

## Downloading S&P 500 stock price data 
sp = getSymbols('^GSPC', from = '2020-01-01', to = '2020-12-31', auto.assign = F)

## Computing the returns
returns = data.frame(AMZN_tot_return = as.numeric(Delt(amazon$AMZN.Adjusted)), TSLA_tot_return = as.numeric(Delt(tesla$TSLA.Adjusted)), NFLX_tot_return = as.numeric(Delt(netflix$NFLX.Adjusted)), AAPL_tot_return = as.numeric(Delt(apple$AAPL.Adjusted)), benchmark_return = as.numeric(Delt(sp$GSPC.Adjusted)))
row.names(returns) = index(amazon)
returns = na.omit(returns)

## Computing portfolio return
returns$Portfolio_return = 0.35*returns$AMZN_tot_return + 0.35*returns$TSLA_tot_return + 0.2*returns$NFLX_tot_return + 0.1*returns$AAPL_tot_return

## Computing the Sharpe Ratio of the portfolio
daily_risk_free = 0.0008 / 365
mu_portfolio = mean(returns$Portfolio_return)
sd_portfolio = sd(returns$Portfolio_return)
Sharpe_Portfolio = (mu_portfolio - daily_risk_free) / sd_portfolio

## Computing the Sharpe Ratio of the benchmark
mu_benchmark = mean(returns$benchmark_return)
sd_benchmark = sd(returns$benchmark_return)
Sharpe_Benchmark = (mu_benchmark - daily_risk_free) / sd_benchmark

## Computing the Roy Ratio of the portfolio
MAR = 0.0062 / 365
mu_portfolio = mean(returns$Portfolio_return)
sd_portfolio = sd(returns$Portfolio_return)
Roy_Portfolio = (mu_portfolio - MAR) / sd_portfolio

## Computing the Roy Ratio of the benchmark
mu_benchmark = mean(returns$benchmark_return)
sd_benchmark = sd(returns$benchmark_return)
Roy_Benchmark = (mu_benchmark - MAR) / sd_benchmark

## Computing the beta
reg = lm(Portfolio_return ~ benchmark_return, data = returns)
beta = summary(reg)$coefficient[2]

## Computing the Treynor Ratio of the portfolio
daily_risk_free = 0.0008 / 365
mu_portfolio = mean(returns$Portfolio_return)
Treynor_Portfolio = (mu_portfolio - daily_risk_free) / beta

## Computing the Sortino Ratio of the portfolio
MAR = 0.0062 / 365
mu_portfolio = mean(returns$Portfolio_return)
returns$Portfolio_return_minus_MAR = returns$Portfolio_return - MAR
DD_portfolio = sqrt((1/(nrow(returns) - 1))* sum(returns$Portfolio_return_minus_MAR[which(returns$Portfolio_return_minus_MAR < 0)]^2))
Sortino_Portfolio = (mu_portfolio - MAR) / DD_portfolio

## Computing the Sortino Ratio of the benchmark
mu_benchmark = mean(returns$benchmark_return)
returns$benchmark_return_minus_MAR = returns$benchmark_return - MAR
DD_benchmark = sqrt((1/(nrow(returns) - 1))* sum(returns$benchmark_return_minus_MAR[which(returns$benchmark_return_minus_MAR < 0)]^2))
Sortino_Benchmark = (mu_benchmark - MAR) / DD_benchmark

## Computing the Information Ratio of the portfolio
returns$Active_Return = returns$Portfolio_return - returns$benchmark_return
alpha_portfolio = mean(returns$Active_Return)
sigma_active = sd(returns$Active_Return)
IR_Portfolio = alpha_portfolio / sigma_active


