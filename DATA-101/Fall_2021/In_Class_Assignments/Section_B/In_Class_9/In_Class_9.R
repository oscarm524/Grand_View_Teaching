## Reading the csv file 
interactions = read.csv(file = 'customer_interactions.csv')
head(interactions)

## Computing the z-scores
interactions$z_spend = (interactions$spend - mean(interactions$spend)) / sd(interactions$spend)
interactions$z_interactions = (interactions$interactions - mean(interactions$interactions)) / sd(interactions$interactions)
head(interactions)

## Running k-means
interactions_clusters = kmeans(interactions[, c(3, 4)], centers = 4, nstart = 20)

## Extracting and appending cluster labels
interactions$cluster = interactions_clusters$cluster
head(interactions)

## Running hierarchical clustering
hc = hclust(dist(interactions[, c(3, 4)], method = 'euclidean'), method = 'complete')

## Visualizing the dendrogram
plot(hc)
