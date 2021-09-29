## Reading csv file 
interactions = read.csv(file = 'customer_interactions.csv')

## Standardize the data 
interactions$z_spend = (interactions$spend - mean(interactions$spend)) / sd(interactions$spend)
interactions$z_interactions = (interactions$interactions - mean(interactions$interactions)) / sd(interactions$interactions)

## Performing k-means
four_clusters = kmeans(interactions[,c('z_spend', 'z_interactions')], centers = 4, nstart = 20)

## Appending cluster labels
interactions$cluster = four_clusters$cluster

## Visualizing the data with clusters
plot(interactions$interactions, interactions$spend, col = interactions$cluster, xlab = 'Interactions', ylab = 'Spend ($')

## Performing hierarchical clustering 
hc_average = hclust(dist(interactions[,c('z_spend', 'z_interactions')], method = 'euclidean'), method = 'average')
plot(hc_average)

