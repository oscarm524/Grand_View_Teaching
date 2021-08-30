## Reading the csv file 
goalie_stats = read.csv(file = 'game_goalie_stats.csv')

## Printing the first four observations 
head(goalie_stats, 4)

## Printing the last four observations
tail(goalie_stats, 4)

## Reporting the number of team ids
length(unique(goalie_stats$team_id))

## Selecting goalies with savePercentage > 95 in winning plays
goalie_95_W = subset(goalie_stats, savePercentage > 95 & decision == 'W')
