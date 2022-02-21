###########################
## Classification Models ##
###########################
 
import pandas as pd
import numpy as np
from sklearn.model_selection import StratifiedKFold
from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import RandomForestClassifier, GradientBoostingClassifier, AdaBoostClassifier
from sklearn.svm import SVC
from sklearn.metrics import confusion_matrix
from itertools import product
import precision_recall_cutoff
 

def expand_grid(dictionary):
    return pd.DataFrame([row for row in product(*dictionary.values())], columns = dictionary.keys())


def Classifier_Ashlyn(X_train, Y_train, X_val, Y_val, model):

    """

    This function applies a classification model using
    the a grid of hyper-parameters. It retuns probabilities
    for each combination of hyper-parameters for the give model.

    X_train: input variables in the train dataset
    Y_train: target variable in the train dataset (Y is expected to be a binary variable)
    X_val: input variables in the val dataset
    Y_val: target variable in the val dataset (Y is expected to be a binary variable)
    model: model to be considered

    """

    ###################
    ## Random Forest ##
    ###################
 
    if(model == 'RF'):

        ###############################################
        ## Defining hyer-parameters to be considered ##
        ###############################################

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

        ## Adding cutoff and points columns
        param_grid['cutoff'] = np.nan
        param_grid['points'] = np.nan

        for i in range(param_grid.shape[0]):
            print('Working on job', i + 1, 'out of', param_grid.shape[0])
            ## Fitting the model (using the ith combination of hyper-parameters)
            RF_md = RandomForestClassifier(n_estimators = param_grid['n_estimators'][i],
                                           max_features = param_grid['max_features'][i],
                                           max_depth = param_grid['max_depth'][i],
                                           min_samples_split = param_grid['min_samples_split'][i],
                                           min_samples_leaf = param_grid['min_samples_leaf'][i])

            RF_md.fit(X_train, Y_train)

            ## Predicting on the val dataset
            preds = RF_md.predict_proba(X_val)[:, 1]
            
            ## Computing prediction evaluation (based on 2010 dmc evaluation)
            opt_cutoff, points = dmc2010_optimal_cutoff(Y_val, preds)
            param_grid.iloc[i, 5] = opt_cutoff
            param_grid.iloc[i, 6] = points

        return param_grid


    ##############
    ## AdaBoost ##
    ##############

    if(model == 'Ada'):

        ###############################################
        ## Defining hyer-parameters to be considered ##
        ###############################################

        ## Number of trees
        n_estimators = [100, 300, 500]

        ## Number of features to consider at every split
        max_features = [3, 5]

        ## Maximum number of levels in tree
        max_depth = [3, 5]

        ## Learning rate
        learning_rate = [0.001, 0.01, 0.1, 1]

        ## Creating the dictionary of hyper-parameters
        param_grid = {'n_estimators': n_estimators,
                      'max_features': max_features,
                      'max_depth': max_depth,
                      'learning_rate': learning_rate}

        param_grid = expand_grid(param_grid)

        ## Adding cutoff and points columns
        param_grid['cutoff'] = np.nan
        param_grid['points'] = np.nan

        for i in range(param_grid.shape[0]):
            print('Working on job', i + 1, 'out of', param_grid.shape[0])
            ## Fitting the model (using the ith combination of hyper-parameters)
            Ada_md = AdaBoostClassifier(base_estimator = DecisionTreeClassifier(
                                        max_features = param_grid['max_features'][i], 
                                        max_depth = param_grid['max_depth'][i]),
                                        n_estimators = param_grid['n_estimators'][i],
                                        learning_rate = param_grid['learning_rate'][i])

            Ada_md.fit(X_train, Y_train)

            ## Predicting on the val dataset
            preds = Ada_md.predict_proba(X_val)[:, 1]

            ## Computing prediction evaluation (based on 2010 dmc evaluation)
            opt_cutoff, points = dmc2010_optimal_cutoff(Y_val, preds)
            param_grid.iloc[i, 4] = opt_cutoff
            param_grid.iloc[i, 5] = points
            
        return param_grid


    #######################
    ## Gradient Boosting ##
    #######################

    if(model == 'GB'):

        ###############################################
        ## Defining hyer-parameters to be considered ##
        ###############################################

        ## Number of trees
        n_estimators = [100, 300, 500]

        ## Learning rate
        learning_rate = [0.001, 0.01, 0.1, 1]

        ## Number of features to consider at every split
        max_features = [3, 5]

        ## Maximum number of levels in tree
        max_depth = [3, 5]

        ## Creating the dictionary of hyper-parameters
        param_grid = {'n_estimators': n_estimators,
                      'learning_rate': learning_rate,
                      'max_features': max_features,
                      'max_depth': max_depth}

        param_grid = expand_grid(param_grid)

        ## Adding cutoff and points columns
        param_grid['cutoff'] = np.nan
        param_grid['points'] = np.nan

        for i in range(param_grid.shape[0]):
            print('Working on job', i + 1, 'out of', param_grid.shape[0])
            ## Fitting the model (using the ith combination of hyper-parameters)
            GB_md = GradientBoostingClassifier(n_estimators = param_grid['n_estimators'][i],
                                               learning_rate = param_grid['learning_rate'][i],
                                               max_features = param_grid['max_features'][i],
                                               max_depth = param_grid['max_depth'][i])
                                               

            GB_md.fit(X_train, Y_train)

            ## Predicting on the val dataset
            preds = GB_md.predict_proba(X_val)[:, 1]

            ## Computing prediction evaluation (based on 2010 dmc evaluation)
            opt_cutoff, points = dmc2010_optimal_cutoff(Y_val, preds)
            param_grid.iloc[i, 4] = opt_cutoff
            param_grid.iloc[i, 5] = points

        return param_grid


    #########
    ## SVM ##
    #########

    if(model == 'svm'):

        ###############################################
        ## Defining hyer-parameters to be considered ##
        ###############################################

        ## Kernel
        kernel = ['rbf', 'poly', 'sigmoid']

        ## Regularization parameter
        C = [0.01, 0.1, 1, 10]

        ## Gamma
        gamma = [0.001, 0.01, 0.1, 1]

        ## Creating the dictionary of hyper-parameters
        param_grid = {'kernel': kernel,
                      'C': C,
                      'gamma': gamma}

        param_grid = expand_grid(param_grid)

        ## Adding cutoff and points columns
        param_grid['cutoff'] = np.nan
        param_grid['points'] = np.nan

        for i in range(param_grid.shape[0]):
            print('Working on job', i + 1, 'out of', param_grid.shape[0])
            ## Fitting the model (using the ith combination of hyper-parameters)
            SVM_md = SVC(kernel = param_grid['kernel'][i],
                         C = param_grid['C'][i],
                         gamma = param_grid['gamma'][i],
                         probability = True)

            SVM_md.fit(X_train, Y_train)

            ## Predicting on the val dataset
            preds = SVM_md.predict_proba(X_val)[:, 1]

            ## Computing prediction evaluation (based on 2010 dmc evaluation)
            opt_cutoff, points = dmc2010_optimal_cutoff(Y_val, preds)
            param_grid.iloc[i, 3] = opt_cutoff
            param_grid.iloc[i, 4] = points
            
            
        return param_grid
    
    

def dmc2010_optimal_cutoff(Y_true, Y_pred):
    
    ## Defining cutoff values in a data-frame
    results = pd.DataFrame({'cutoffs': np.round(np.linspace(0.05, 0.95, num = 40, endpoint = True), 2)})
    results['points'] = np.nan
    
    for i in range(0, results.shape[0]):
        
        ## Changing likelihoods to labels
        Y_pred_lab = np.where(Y_pred < results['cutoffs'][i], 0, 1)
        
        ## Computing confusion matrix and scoring form dmc-2010
        X = confusion_matrix(Y_pred_lab, Y_true)
        results['points'][i] = 1.5 * X[1, 0] - 5 * X[1, 1]
        
    ## Sorting results 
    results = results.sort_values(by = 'points', ascending = False).reset_index(drop = True)
    
    return [results['cutoffs'][0], results['points'][0]]
    