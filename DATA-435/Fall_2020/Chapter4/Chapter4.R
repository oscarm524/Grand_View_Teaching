###############
## Chapter 4 ##
###############

rm(list = ls())

## Reading csv file
age_income = read.csv(file = 'age_income.csv')

## First we visualize the data
plot(age_income$age, age_income$income, xlab = 'Age', ylab = 'Income ($)', pch = 16)

## First we put the variables in the same scale
age_income$income_0_1 = (age_income$income - min(age_income$income)) / (max(age_income$income) - min(age_income$income))
age_income$age_0_1 = (age_income$age - min(age_income$age)) / (max(age_income$age) - min(age_income$age))

## Performing clustering 
age_income_clustering = kmeans(cbind(age_income$income_0_1, age_income$age_0_1), centers = 4, nstart = 20)

## Extracting cluster labels 
age_income_clustering$cluster

## Appending cluster numbers
age_income$cluster = age_income_clustering$cluster

## Visualizing data with clusters
plot(age_income$age, age_income$income, xlab = 'Age', ylab = 'Income ($)', col = age_income$cluster, pch = 16)


## Reading csv file 
age_income_days = read.csv(file = 'age_income_days.csv')

## First we put the variables on the same scale
age_income_days$income_0_1 = (age_income_days$income - min(age_income_days$income)) / (max(age_income_days$income) - min(age_income_days$income))
age_income_days$age_0_1 = (age_income_days$age - min(age_income_days$age)) / (max(age_income_days$age) - min(age_income_days$age))
age_income_days$days_since_purchase_0_1 = (age_income_days$days_since_purchase - min(age_income_days$days_since_purchase)) / (max(age_income_days$days_since_purchase) - min(age_income_days$days_since_purchase))

## Performing PCA
PCA = prcomp(cbind(age_income_days$income_0_1, age_income_days$age_0_1, age_income_days$days_since_purchase_0_1))

## Extracting the components
components = PCA$x

## Plotting the first two components
plot(components[, 1], components[, 2], xlab = 'First Component', ylab = 'Second Component', pch = 16)

## Performing k-means
age_income_days_clustering = kmeans(cbind(age_income_days$income_0_1, age_income_days$age_0_1, age_income_days$days_since_purchase_0_1), centers = 3, nstart = 20)

## Appending the clusters
age_income_days$cluster = age_income_days_clustering$cluster

## Visualization of first two components with clusters
plot(components[, 1], components[, 2], col = age_income_days$cluster, xlab = 'First Component', ylab = 'Second Component', pch = 16)

##########################################
## Number of Cluster: Visual Inspection ##
##########################################

## Performing clustering 
age_income_clustering_2 = kmeans(cbind(age_income$income_0_1, age_income$age_0_1), centers = 2, nstart = 20)

age_income_clustering_3 = kmeans(cbind(age_income$income_0_1, age_income$age_0_1), centers = 3, nstart = 20)

age_income_clustering_4 = kmeans(cbind(age_income$income_0_1, age_income$age_0_1), centers = 4, nstart = 20)

age_income_clustering_5 = kmeans(cbind(age_income$income_0_1, age_income$age_0_1), centers = 5, nstart = 20)

age_income_clustering_6 = kmeans(cbind(age_income$income_0_1, age_income$age_0_1), centers = 6, nstart = 20)

## Appending cluster numbers
age_income$cluster_2 = age_income_clustering_2$cluster
age_income$cluster_3 = age_income_clustering_3$cluster
age_income$cluster_4 = age_income_clustering_4$cluster
age_income$cluster_5 = age_income_clustering_5$cluster
age_income$cluster_6 = age_income_clustering_6$cluster

plot(age_income$age, age_income$income, xlab = 'Age', ylab = 'Income ($)', col = age_income$cluster_6, pch = 16)

################
## Elbow Plot ##
################

x_1 <- seq(2, 4, len = 10)
y_1 <- -400*x_1 + 2000

x_2 <- seq(4, 10, len = 10)
y_2 <- (-200/7)*x_2 + 514.2857

plot(x_1, y_1, xlim = c(2, 10), ylim = c(0, 1200), type = 'l', xlab = 'Number of Clusters (k)', ylab = 'Sum of Squares', lwd = 2); grid()
lines(x_2, y_2, lwd = 2)


#######################
## Elbow: An Example ##
#######################

## Reading csv file
age_income = read.csv(file = 'age_income.csv')

## First we put the variables in the same scale
age_income$income_0_1 = (age_income$income - min(age_income$income)) / (max(age_income$income) - min(age_income$income))
age_income$age_0_1 = (age_income$age - min(age_income$age)) / (max(age_income$age) - min(age_income$age))

## Defining an array to store the sum of squares
sum_of_squares = array()

## Looping throught the different number of clusters
for(i in 1:15){
	sum_of_squares[i] = kmeans(cbind(age_income$income_0_1, age_income$age_0_1), centers = i, nstart = 20)$tot.withinss
}

## Visualizing the sum of squares for the different number of clusters
plot(k, sum_of_squares, type = 'o', pch = 16, ylab = 'Sum of Squares', xlab = 'Number of Clusters (k)')
grid()


############################
## Silhouette: An Example ##
############################

library(cluster)

## Reading csv file
age_income = read.csv(file = 'age_income.csv')

## First we put the variables in the same scale
age_income$income_0_1 = (age_income$income - min(age_income$income)) / (max(age_income$income) - min(age_income$income))
age_income$age_0_1 = (age_income$age - min(age_income$age)) / (max(age_income$age) - min(age_income$age))

## Defining an array to store the Silhouette score
k = 2:15
silhouette = array()

## Looping throught the different number of clusters
for(i in k){
	kmeans_md = kmeans(cbind(age_income$income_0_1, age_income$age_0_1), centers = i, nstart = 20)
	ss = silhouette(kmeans_md$cluster, dist(cbind(age_income$income_0_1, age_income$age_0_1)))
	silhouette[i] = mean(ss[, 3])
}

## Visualizing the sum of squares for the different number of clusters
plot(k, silhouette[k], type = 'o', pch = 16, ylab = 'Silhouette Score', xlab = 'Number of Clusters (k)')
grid()


