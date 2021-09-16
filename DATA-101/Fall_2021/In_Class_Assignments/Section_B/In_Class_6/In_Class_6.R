## Reading the csv file 
Index = read.csv(file = 'Index.csv')
head(Index)

## Creating a bar-chart of Index
barplot(table(Index$Index))

## Most of the data falls under either Index 4 or 5

## Side-by-side boxplots
boxplot(Height ~ Gender, data = Index)

## From the side-by-side boxplot, we see that the height distributions are similar

## Side-by-side boxplots
boxplot(Weight ~ Gender, data = Index)

## From the side-by-side boxplot, we see that the weight distributions are similar.
