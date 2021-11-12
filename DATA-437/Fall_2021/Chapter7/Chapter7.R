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

## Computing the log-ratios
my_teams$log_W_L = log(my_teams$W / my_teams$L)
my_teams$log_R_RA = log(my_teams$R / my_teams$RA)
head(my_teams)

## Estimating k in 7.4
lm_pyt = lm(log_W_L ~ 0 + log_R_RA, data = my_teams)

## Extracting model results
summary(lm_pyt)

## Creating Caola's IR formula
IR = function(RS, RA){
   y = (RS^2 + RA^2)^2 / (2*RS*RA^2)
   return(y)
}

## Creating combinations of RS and RA
IR_table = expand.grid(RS = seq(3, 6, by = 0.5), RA = seq(3, 6, by = 0.5))

## Computing the IR
IR_table$IR = IR(IR_table$RS, IR_table$RA)
head(IR_table)

#########################################
## Value of Plays Using Run Expectancy ##
#########################################

## Reading 2016 season data 
data2016 = read.csv(file = 'all2016.csv')
head(data2016)

## Computing the three variables 
data2016$RUNS = data2016$AWAY_SCORE_CT + data2016$HOME_SCORE_CT
data2016$HALF.INNING = paste0(data2016$GAME_ID, data2016$INN_CT, data2016$BAT_HOME_ID)
data2016$RUNS.SCORED = (data2016$BAT_DEST_ID > 3) + (data2016$RUN1_DEST_ID > 3) + (data2016$RUN2_DEST_ID > 3) + (data2016$RUN3_DEST_ID)
