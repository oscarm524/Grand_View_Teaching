import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier


def expand_grid(dictionary):
    return pd.DataFrame([row for row in product(*dictionary.values())], columns = dictionary.keys())


def ensemble_gabriel_ricky(RF_test_pred, Ada_test_pred, GB_test_pred, Y, RF_pred, Ada_pred, GB_pred):
    
    ## Defining the input variables 
    X = pd.concat([RF_test_pred, Ada_test_pred, GB_test_pred], axis = 1)
    X.columns = ['RF', 'Ada', 'GB']
    X_to_score = pd.concat([RF_pred, Ada_pred, GB_pred], axis = 1)
    X_to_score.column = ['RF', 'Ada', 'GB']
    
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

        RF_md.fit(X_train, Y_train)

        ## Predicting on the val dataset
        preds = RF_md.predict_proba(X_test)[:, 1]
            
        ## Computing prediction evaluation (based on 2013/2014 dmc evaluation)
        param_grid.iloc[i, 5] = np.sum(abs(Y_test - preds))

    ## Sorting the results in param_grid 
    param_grid = param_grid.sort_values(by = 'evaluation').reset_index(drop = True)
    
    ## Build the model to score the test
    RF = RandomForestClassifier(n_estimators = param_grid['n_estimators'][0],
                                max_features = param_grid['max_features'][0],
                                max_depth = param_grid['max_depth'][0],
                                min_samples_split = param_grid['min_samples_split'][0],
                                min_samples_leaf = param_grid['min_samples_leaf'][0]).fit(X_train, Y_train)


    ## Predicting on the dataset to be scored
    preds = RF.predict_proba(X_to_score)[:, 1]

    return preds

    
    
    
def ensemble_ashlyn(RF_test_pred, Ada_test_pred, GB_test_pred, Y, RF_pred, Ada_pred, GB_pred):
    
    ## Defining the input variables 
    X = pd.concat([RF_test_pred, Ada_test_pred, GB_test_pred], axis = 1)
    X.columns = ['RF', 'Ada', 'GB']
    X_to_score = pd.concat([RF_pred, Ada_pred, GB_pred], axis = 1)
    X_to_score.column = ['RF', 'Ada', 'GB']
    
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

        RF_md.fit(X_train, Y_train)

        ## Predicting on the val dataset
        preds = RF_md.predict_proba(X_test)[:, 1]
            
        ## Computing prediction evaluation (based on 2013/2014 dmc evaluation)
        param_grid.iloc[i, 5] = np.sum(abs(Y_test - preds))

    ## Sorting the results in param_grid 
    param_grid = param_grid.sort_values(by = 'evaluation').reset_index(drop = True)
    
    ## Build the model to score the test
    RF = RandomForestClassifier(n_estimators = param_grid['n_estimators'][0],
                                max_features = param_grid['max_features'][0],
                                max_depth = param_grid['max_depth'][0],
                                min_samples_split = param_grid['min_samples_split'][0],
                                min_samples_leaf = param_grid['min_samples_leaf'][0]).fit(X_train, Y_train)


    ## Predicting on the dataset to be scored
    preds = RF.predict_proba(X_to_score)[:, 1]

    return preds
