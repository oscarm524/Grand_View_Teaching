## Reading the csv file
teams = read.csv(file = 'Teams.csv')
head(teams)

## Selecting variables and seasons of interest
my_teams = subset(teams, yearID > 2000, select = c(teamID, yearID, lgID, G, W, L, R, RA))
head(my_teams)

## Computing RD and Wpct
my_teams$RD = my_teams$R - my_teams$RA
my_teams$Wpct = my_teams$W / (my_teams$W + my_teams$L)
head(my_teams)

## Building the linear model 
lm_md = lm(Wpct ~ RD, data = my_teams)

## Extracting model results
summary(lm_md)

## Computing the winning percentage using 7.1
my_teams$Wpct_pyt = my_teams$R^2 / (my_teams$R^2 + my_teams$RA^2)
head(my_teams)
