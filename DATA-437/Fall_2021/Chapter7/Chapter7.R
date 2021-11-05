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
