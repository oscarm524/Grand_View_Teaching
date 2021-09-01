## Reading csv file
goalie_stats = read.csv(file = 'game_goalie_stats.csv')
head(goalie_stats)

## Loading plyr 
library(plyr)

## Counting the number of games of each player
player_games = ddply(goalie_stats, .(player_id), summarise, numb_of_games = length(unique(game_id)))
player_games

## Creating a histogram of the number of games
hist(player_games$numb_of_games, col = 'gray', xlab = 'Number of Games')
box()

