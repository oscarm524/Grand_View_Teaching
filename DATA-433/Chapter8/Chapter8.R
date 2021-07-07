##########
## CAPM ##
##########

## Loading quantmod
library(quantmod)

## Downloading Amazon stock price data 
amazon = getSymbols('AMZN', from = '2017-12-01', to = '2020-12-31', auto.assign = F)

## Downloading Tesla stock price data
tesla = getSymbols('TSLA', from = '2017-12-01', to = '2020-12-31', auto.assign = F)

## Downloading PayPal stock price data
paypal = getSymbols('PYPL', from = '2017-12-01', to = '2020-12-31', auto.assign = F)

## Downloading S&P500 stock price data
sp = getSymbols('^GSPC', from = '2017-12-01', to = '2020-12-31', auto.assign = F)

## Changing data to monthly
amazon = to.monthly(amazon)
tesla = to.monthly(tesla)
paypal = to.monthly(paypal)
sp = to.monthly(sp)

## Computing total returns
returns = data.frame(Delt(amazon$amazon.Adjusted), Delt(tesla$tesla.Adjusted), Delt(paypal$paypal.Adjusted), Delt(sp$sp.Adjusted))
names(returns) = c('AMZN_tot_return', 'TSLA_tot_return', 'PYPL_tot_return', 'SP_tot_return')
returns = na.omit(returns)

## Constructing the portfolio
returns$Portfolio = 0.4*returns$AMZN_tot_return + 0.25*returns$TSLA_tot_return + 0.35*returns$PYPL_tot_return

## Importing Risk-Free Rate from FRED 
risk = read.csv(file = 'DGS3MO.csv')
risk$date = as.Date(risk$DATE, format = '%Y-%m-%d')
risk$DGS3MO = as.numeric(as.character(risk$DGS3MO))
risk = xts(risk$DGS3MO, order.by  = risk$date)
names(risk) = c('DGS3MO')

## Changing data to monthly 
risk = to.monthly(risk)
risk = subset(risk, select = c(risk.Open))
names(risk) = c('DGS3MO')
risk = subset(risk, index(risk) >= as.yearmon('Jan 2018') & index(risk) <= as.yearmon('Dec 2020'))

write.zoo(risk, file = 'monthly_risk_free.csv', sep = ',', quote = F)

## Reading monthly risk-free rate data
risk = read.csv(file = 'monthly_risk_free.csv')

## Converting opening annualized to monthly
risk$DGS3MO = (1 + risk$DGS3MO/100)^(1/12) - 1
row.names(risk) = risk$Index
risk = subset(risk, select = c(DGS3MO))

# ## Selecing 2018 to 2020 data
# risk = subset(risk, row.names(risk) >= as.yearmon('Jan 2018') & row.names(risk) <= as.yearmon('Dec 2020'))

## Appeding risk rate to returns
returns = data.frame(cbind(returns$Portfolio, returns$SP_tot_return, risk$DGS3MO))
names(returns) = c('Portfolio', 'Market', 'Risk_Free_Rate')

## Computing excess returns
returns$Portfolio_excess = returns$Portfolio - returns$Risk_Free_Rate
returns$Market_excess = returns$Market - returns$Risk_Free_Rate

## Fitting the linear model
lm_md = lm(Portfolio_excess ~ Market_excess, data = returns)
summary(lm_md)


##################
## Market Model ##
##################

## Loading quantmod
library(quantmod)

## Downloading Amazon stock price data 
amazon = getSymbols('AMZN', from = '2017-12-01', to = '2020-12-31', auto.assign = F)

## Downloading Tesla stock price data
tesla = getSymbols('TSLA', from = '2017-12-01', to = '2020-12-31', auto.assign = F)

## Downloading PayPal stock price data
paypal = getSymbols('PYPL', from = '2017-12-01', to = '2020-12-31', auto.assign = F)

## Downloading S&P500 stock price data
sp = getSymbols('^GSPC', from = '2017-12-01', to = '2020-12-31', auto.assign = F)

## Changing data to monthly
amazon = to.monthly(amazon)
tesla = to.monthly(tesla)
paypal = to.monthly(paypal)
sp = to.monthly(sp)

## Computing total returns
returns = data.frame(Delt(amazon$amazon.Adjusted), Delt(tesla$tesla.Adjusted), Delt(paypal$paypal.Adjusted), Delt(sp$sp.Adjusted))
names(returns) = c('AMZN_tot_return', 'TSLA_tot_return', 'PYPL_tot_return', 'SP_tot_return')
returns = na.omit(returns)

## Constructing the portfolio
returns$Portfolio = 0.4*returns$AMZN_tot_return + 0.25*returns$TSLA_tot_return + 0.35*returns$PYPL_tot_return

## Fitting the market model
lm_md = lm(Portfolio ~ SP_tot_return, data = returns)
summary(lm_md)


####################
## Rolling Window ##
####################

## Loading quantmod
library(quantmod)

## Downloading Amazon stock price data 
amazon = getSymbols('AMZN', from = '2017-12-01', to = '2020-12-31', auto.assign = F)

## Downloading S&P500 stock price data
sp = getSymbols('^GSPC', from = '2017-12-01', to = '2020-12-31', auto.assign = F)

## Computing total returns
returns = data.frame(Delt(amazon$AMZN.Adjusted), Delt(sp$GSPC.Adjusted))
names(returns) = c('AMZN_tot_return', 'SP_tot_return')
returns = na.omit(returns)

## Computing the alpha and betas rolling window
alpha_beta = rollapply(returns, width = 252, FUN = function(X) 
                                                   {
                                                   	roll_reg = lm(AMZN_tot_return ~ SP_tot_return, data = as.data.frame(X))
                                                   	return(roll_reg$coef)}, 
                                                   	by.column = F)

## Adding row names
row.names(alpha_beta) = row.names(returns)[-c(1:251)]

plot(as.Date(row.names(alpha_beta)), alpha_beta[, 1], type = 'l', xlab = 'Date', ylab = 'alpha')
grid()

plot(as.Date(row.names(alpha_beta)), alpha_beta[, 2], type = 'l', xlab = 'Date', ylab = 'beta')
grid()
