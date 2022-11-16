import boto3
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn.preprocessing import MinMaxScaler
from sklearn.cluster import SpectralClustering

## Defining the bucket 
s3 = boto3.resource('s3')
bucket_name = 'data-445'
bucket = s3.Bucket(bucket_name)

## Defining the csv file 
file_key = 'Fall_2021/In_Class_Assignments/circle_data.csv'

bucket_object = bucket.Object(file_key)
file_object = bucket_object.get()
file_content_stream = file_object.get('Body')

## Reading the csv file
circles = pd.read_csv(file_content_stream)

## Changing the scale 
scaler = MinMaxScaler()

circles[['x_0_1', 'y_0_1']] = scaler.fit_transform(circles)

## Running spectral clustering (clusters = 2) 
spectral_clustering = SpectralClustering(n_clusters = 2, affinity = 'nearest_neighbors', n_neighbors = 20).fit(circles[['x_0_1', 'y_0_1']])

## Appending the cluster labels 
circles['spectral_cluster'] = spectral_clustering.labels_

## Saving results 
circles.to_csv('clustering_circles.csv', index = False)
