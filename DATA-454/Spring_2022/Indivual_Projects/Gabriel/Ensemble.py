import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier


def expand_grid(dictionary):
    return pd.DataFrame([row for row in product(*dictionary.values())], columns = dictionary.keys())


def ensemble_gabriel_ricky(test_pred1, test_pred2, test_pred3, Y, to_score1, to_score2, to_score3):
    
    ## Defining the input variables 
    X = pd.concat([test_pred1, test_pred2, test_pred3], axis = 1)
    X_to_score = pd.concat([to_score1, to_score2, to_score3], axis = 1)
    
    ## Splitting the data 
    X_train, X_test, Y_train, Y_test = train_test_split(X, Y, test_size = 0.2, stratify = Y)
    
    ## Number of trees in random forest
    n_estimators = [100, 300, 500]

    ## Number of features to consider at every split
    max_features = [3, 5]

    ## Maximum number of levels in tree
    max_depth = [3, 5]

    ## Minimum number of samples required to split a node
    min_samples_split = [10, 15]

    ## Minimum number of samples required at each leaf node
    min_samples_leaf = [5, 7]

    ## Creating the dictionary of hyper-parameters
    param_grid = {'n_estimators': n_estimators,
                  'max_features': max_features,
                  'max_depth': max_depth,
                  'min_samples_split': min_samples_split,
                  'min_samples_leaf': min_samples_leaf}

    param_grid = expand_grid(param_grid)

    ## Adding evaluation columns
    param_grid['evaluation'] = np.nan

    for i in range(param_grid.shape[0]):
        print('Working on job', i + 1, 'out of ', param_grid.shape[0])
        ## Fitting the model (using the ith combination of hyper-parameters)
        RF_md = RandomForestClassifier(n_estimators = param_grid['n_estimators'][i],
                                       max_features = param_grid['max_features'][i],
                                       max_depth = param_grid['max_depth'][i],
                                       min_samples_split = param_grid['min_samples_split'][i],
                                       min_samples_leaf = param_grid['min_samples_leaf'][i])

        RF_md.fit(X_train, Y)

        ## Predicting on the val dataset
        preds = RF_md.predict_proba(X_val)[:, 1]
            
        ## Computing prediction evaluation (based on 2013/2014 dmc evaluation)
        param_grid.iloc[i, 5] = np.sum(abs(Y_val - preds))

    return param_grid

    
    
    
    
def ensemble_ashlyn(test_pred1, test_pred2, test_pred3, Y, to_score1, to_score2, to_score3):