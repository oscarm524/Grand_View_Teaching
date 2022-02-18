###########################
## Classification Models ##
###########################
 
import pandas as pd
import numpy as np
from sklearn.model_selection import StratifiedKFold
from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import RandomForestClassifier, GradientBoostingClassifier, AdaBoostClassifier
from sklearn.svm import SVC
from sklearn.metrics import accuracy_score, recall_score
from itertools import product
 

def expand_grid(dictionary):
    return pd.DataFrame([row for row in product(*dictionary.values())], columns = dictionary.keys())

def Classifier(X_train, Y_train, X_test, Y_test, model):

"""
This function applies a classification model using
the a grid of hyper-parameters. It retuns probabilities
for each combination of hyper-parameters for the give model.
 
X_train: denotes the input variables in the train dataset
Y_train: denotes the target variable in the train dataset (Y is expected to be a binary variable)
X_test: denotes the input variables in the test dataset
Y_test: denotes the target variable in the test dataset (Y is expected to be a binary variable)
model: model to be considered
"""
