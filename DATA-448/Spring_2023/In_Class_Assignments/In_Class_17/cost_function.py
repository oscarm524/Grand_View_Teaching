import pandas as pd
import numpy as np
from sklearn.metrics import confusion_matrix

def cost_function(Y_true, Y_pred):
    
    '''
    This a customize scoring function that takes two arguments:
    Y_true: true labels
    Y_pred: likelihoods from the model   
    '''
    
    ## Defining cutoff values in a data-frame
    results = pd.DataFrame({'cutoffs': np.round(np.linspace(0.05, 0.95, num = 40, endpoint = True), 2)})
    results['cost'] = np.nan
    
    for i in range(0, results.shape[0]):
        
        ## Changing likelihoods to labels
        Y_pred_lab = np.where(Y_pred < results['cutoffs'][i], 0, 1)
        
        ## Computing confusion matrix and scoring based on description
        X = confusion_matrix(Y_pred_lab, Y_true)
        results['cost'][i] = -1500 * X[1, 0] - 1000 * X[0, 1] + 500 * X[1, 1]
        
    ## Sorting results 
    results = results.sort_values(by = 'cost', ascending = False).reset_index(drop = True)
    
    return [results['cost'][0], results['cutoffs'][0]]


