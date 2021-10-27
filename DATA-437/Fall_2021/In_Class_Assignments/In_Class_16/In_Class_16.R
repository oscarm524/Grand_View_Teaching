## Reading the csv file 
nba = read.csv(file = 'NBA_2006_2007.csv')
head(nba)

## Building the linear regression model 
lm_md = lm(W ~ EFG_pct + FTA_rate + TOV_pct + OREB_pct, data = nba)

## Extracting model results
summary(lm_md)

## Defining the new observation 
newdata = data.frame('EFG_pct' =  51, 'FTA_rate' =  0.35, 'TOV_pct' = 16, 'OREB_pct' = 32)

## Estimating the wins 
predict(lm_md, newdata, type = 'response')

