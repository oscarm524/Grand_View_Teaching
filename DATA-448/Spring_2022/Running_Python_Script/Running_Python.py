import boto3
import pandas as pd; pd.set_option('display.max_columns', 50)
import numpy as np
import matplotlib.pyplot as plt
from sklearn.preprocessing import MinMaxScaler
from sklearn.model_selection import train_test_split, GridSearchCV, RandomizedSearchCV
from sklearn.ensemble import AdaBoostClassifier
from sklearn.tree import DecisionTreeClassifier
from sklearn.metrics import classification_report
import precision_recall_cutoff

## Defining the bucket 
s3 = boto3.resource('s3')
bucket_name = 'data-448'
bucket = s3.Bucket(bucket_name)

## Defining the csv file 
file_key = 'In_Class_Assignments/turnover.csv'

bucket_object = bucket.Object(file_key)
file_object = bucket_object.get()
file_content_stream = file_object.get('Body')

## Reading the csv file
turnover = pd.read_csv(file_content_stream)

## Changing sales to dummy variables
turnover = pd.concat([turnover.drop(columns = ['sales'], axis = 1), pd.get_dummies(turnover['sales'])], axis = 1)

## Changing salary to dummy variables
turnover = pd.concat([turnover, pd.get_dummies(turnover['salary'])], axis = 1)

## Creating interactions/features from the decision tree
turnover['interaction_1'] = np.where((turnover['satisfaction_level'] <= 0.465) & (turnover['number_project'] <= 2.5) & (turnover['last_evaluation'] <= 0.575), 1, 0)
turnover['interaction_2'] = np.where((turnover['satisfaction_level'] <= 0.465) & (turnover['number_project'] >= 2.5) & (turnover['satisfaction_level'] >= 0.115), 1, 0)
turnover['interaction_3'] = np.where((turnover['satisfaction_level'] >= 0.465) & (turnover['time_spend_company'] <= 4.5) & (turnover['average_montly_hours'] <= 290.5), 1, 0)

## Defining the input and target variables
X = turnover.drop(columns = ['left', 'salary'], axis = 1)
Y = turnover['left']

## Spliting the data into train, validation, and test
X_train, X_test, Y_train, Y_test = train_test_split(X, Y, test_size = 0.2, stratify = Y)

## Selecting top 5 variables
X_train = X_train[['interaction_3', 'interaction_1', 'satisfaction_level', 'time_spend_company', 'number_project']]
X_test = X_test[['interaction_3', 'interaction_1', 'satisfaction_level', 'time_spend_company', 'number_project']]

Ada_param_grid = {'n_estimators': [100, 300, 500],
                  'base_estimator__min_samples_split': [10, 15],
                  'base_estimator__min_samples_leaf': [5, 7],
                  'base_estimator__max_depth': [3, 5, 7],
                  'learning_rate': [0.001, 0.01, 0.1]}

## Running grid search with 3 fold 
Ada_grid_search = GridSearchCV(AdaBoostClassifier(base_estimator = DecisionTreeClassifier()), Ada_param_grid, cv = 3, scoring = 'f1', n_jobs = -1).fit(X_train, Y_train)

## Extracting best model 
Ada = Ada_grid_search.best_estimator_

## Refitting the model 
Ada_md = Ada.fit(X_train, Y_train)

## Predicting on test
Ada_pred = Ada_md.predict_proba(X_test)[:, 1]

## Strong prediction into csv 
Ada_pred = pd.DataFrame(Ada_pred)
Ada_pred.to_csv('likelihoods', index = False)