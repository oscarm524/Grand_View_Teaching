## Reading the csv file 
Index = read.csv(file = 'Index.csv')
head(Index)

## Creating a bar chart of Index
barplot(table(Index$Index))

## Creating side-by-side boxplots
boxplot(Height ~ Gender, data = Index)

