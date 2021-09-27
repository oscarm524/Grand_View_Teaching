## Reading the csv files 
durant = read.csv('Durant_2011_2012.csv')
james = read.csv('James_2011_2012.csv')

## Computing the average number of assists (Durant)
mean(durant$AST)

## Computing the average number of assists (James)
mean(james$AST)

## Computing the margin of error of the average number of assists (Durant)
2*sd(durant$AST) / sqrt(dim(durant)[1])

## Computing the margin of error of the average number of assists (James)
2*sd(james$AST) / sqrt(dim(james)[1])

