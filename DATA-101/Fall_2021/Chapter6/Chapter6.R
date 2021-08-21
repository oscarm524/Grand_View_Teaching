####################
## Chapter 6 Code ##
####################


#######################
## Forward Selection ##
#######################

## Here we read the data into R
auto = read.csv(file = 'auto.csv')

## Here we define the null model
null_md = lm(mpg ~ 1, data = auto)

## Here we define the upper model 
upper_md = lm(mpg ~ cylinders + displacement + horsepower + weight + 
                    acceleration, data = auto)

## Here we perform forward selection
forward_selection = step(null_md, 
                         scope = list(lower = null_md, upper = upper_md), 
                         direction = "forward")


########################
## Backward Selection ##
########################

## Here we read the data into R
auto = read.csv(file = 'auto.csv')

## Here we define the full model 
full_md = lm(mpg ~ cylinders + displacement + horsepower + weight + 
                   acceleration, data = auto)

## Here we perform backward selection
backward_selection = step(full_md, direction = 'backward') 


######################
## Hybrid Selection ##
######################

## Here we read the data into R
auto = read.csv(file = 'auto.csv')

## Here we define the full model 
full_md = lm(mpg ~ cylinders + displacement + horsepower + weight + 
                    acceleration, data = auto)

## Here we perform hybrid selection
hybrid_selection = step(full_md, direction = 'both') 
