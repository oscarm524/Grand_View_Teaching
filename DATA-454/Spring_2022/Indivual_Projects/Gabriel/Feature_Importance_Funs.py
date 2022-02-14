import pandas as pd
import numpy as np
from sklearn.model_selection import StratifiedKFold
from sklearn.ensemble import RandomForestClassifier


def RF_Feature_Importance(X, Y, nsim, cv):
    
    """
    This function takes 4 arguments:
    X: input variables
    Y: target variable
    nsim: number of repetitions
    cv: number of folds
    """
    
    ## Defining list to store results 
    results = list()
    
    for i in range(0, nsim):
        
        results.append(RF_Feature_Importance_Help(X, Y, cv))
        
    return pd.DataFrame(results)
    

    
def RF_Feature_Importance_Help(X, Y, cv):
    
    ## Defining list to store results 
    feature_importance = list()

    ## Cross-validation (feature importance)
    skf = StratifiedKFold(n_splits = cv)

    for train_index, test_index in skf.split(X, Y):
    
        X_train, X_test = X.iloc[train_index], X.iloc[test_index]
        Y_train, Y_test = Y[train_index], Y[test_index]
    
        ## Building the model 
        RF = RandomForestClassifier(n_estimators = 500, max_depth = 3).fit(X_train, Y_train)
    
        ## Extracting importances
        feature_importance.append(RF.feature_importances_)
    
    return pd.DataFrame(feature_importance)
#     return pd.DataFrame(feature_importance).apply(np.mean, axis = 0)