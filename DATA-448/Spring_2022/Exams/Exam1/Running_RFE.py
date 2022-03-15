import pandas as pd; pd.set_option('display.max_columns', 50)
import numpy as np
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split
from sklearn.feature_selection import RFECV
from sklearn.tree import DecisionTreeClassifier, plot_tree
from sklearn.ensemble import RandomForestClassifier

## Reading data files
train = pd.read_csv('train.csv')
test = pd.read_csv('test.csv')

# ## Chaning labels
train['SEX'] = np.where(train['SEX'] == 1, 'male', 'female')
train['EDUCATION'] = np.where(train['EDUCATION'] == 1, 'graduate_school', 
                              np.where(train['EDUCATION'] == 2, 'university',
                                       np.where(train['EDUCATION'] == 3, 'high_school', 'other_unknown')))
train['MARRIAGE'] = np.where(train['MARRIAGE'] == 1, 'married', 
                             np.where(train['MARRIAGE'] == 2, 'single', 'other'))


test['SEX'] = np.where(test['SEX'] == 1, 'male', 'female')
test['EDUCATION'] = np.where(test['EDUCATION'] == 1, 'graduate_school', 
                              np.where(test['EDUCATION'] == 2, 'university',
                                       np.where(test['EDUCATION'] == 3, 'high_school', 'other_unknown')))
test['MARRIAGE'] = np.where(test['MARRIAGE'] == 1, 'married', 
                             np.where(test['MARRIAGE'] == 2, 'single', 'other'))

## Creating ID columns
train['ID'] = list(range(1, train.shape[0] + 1))

## Splitting the data into train and test
training = train.groupby('default payment next month', group_keys = False).apply(lambda x: x.sample(frac = 0.8))
testing = train[~np.isin(train['ID'], training['ID'])]

## Dropping ID
training = training.drop(columns = 'ID', axis = 1)
testing = testing.drop(columns = 'ID', axis = 1)

## Defining inputs and target variables
X_train = training.drop(columns = 'default payment next month', axis = 1).reset_index(drop = True)
Y_train = training['default payment next month'].reset_index(drop = True)

X_test = testing.drop(columns = 'default payment next month', axis = 1).reset_index(drop = True)
Y_test = testing['default payment next month'].reset_index(drop = True)

## Changing labels to dummies 
X_train = pd.concat([X_train.drop(columns = 'SEX', axis = 1), pd.get_dummies(X_train['SEX'])], axis = 1)
X_train = pd.concat([X_train.drop(columns = 'EDUCATION', axis = 1), pd.get_dummies(X_train['EDUCATION'])], axis = 1)
X_train = pd.concat([X_train.drop(columns = 'MARRIAGE', axis = 1), pd.get_dummies(X_train['MARRIAGE'])], axis = 1)

X_test = pd.concat([X_test.drop(columns = 'SEX', axis = 1), pd.get_dummies(X_test['SEX'])], axis = 1)
X_test = pd.concat([X_test.drop(columns = 'EDUCATION', axis = 1), pd.get_dummies(X_test['EDUCATION'])], axis = 1)
X_test = pd.concat([X_test.drop(columns = 'MARRIAGE', axis = 1), pd.get_dummies(X_test['MARRIAGE'])], axis = 1)
