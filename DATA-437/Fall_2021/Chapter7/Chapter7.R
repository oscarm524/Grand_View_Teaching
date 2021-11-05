## Reading the csv file
teams = read.csv(file = 'Teams.csv')
head(teams)

## Selecting variables and season of interest
my_teams = subset(teams, yearID > 2000, select = c(teamID, yearID, lgID, G, W, L, R, RA))
head(my_teams)
