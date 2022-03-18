import pandas as pd 
import numpy as np
from sklearn.metrics import precision_recall_curve

'''
The precision_recall_cutoff function takes 2 arguments:

Y_test: actual labels from the test data-frame
Y_pred: predicted likelihoods from a model 

This function estimated the optimal cutoff value based 
on the precision_recall_curve function and returns the 
predicted labels based onn the optimal cutoff value from 
the precision_recall_curve function.
'''

def precision_recall_cutoff(Y_test, Y_pred):
    
    ## Computing the precision recall curve
    precision, recall, thresholds = precision_recall_curve(Y_test, Y_pred)
    
    ## Creating the precision-recall data-frame
    precision_recall = pd.DataFrame({'precision': precision[:-1], 'recall': recall[:-1], 'cutoff': thresholds})
    
    ## Finding the optimal cutoff (closest to precision = 1, recall = 1)
    precision_recall['1_minus_precision'] = 1 - precision_recall['precision']
    precision_recall['1_minus_recall'] = 1 - precision_recall['recall']
    precision_recall['Distance_to_perfect_model'] = np.sqrt(precision_recall['1_minus_precision']**2 + precision_recall['1_minus_recall']**2)
    
    ## Sorting based on Distance 
    precision_recall = precision_recall.sort_values(by = 'Distance_to_perfect_model').reset_index(drop = True)
    
    ## Changing likelihoods to labels 
    pred_label = np.where(Y_pred < precision_recall['cutoff'][0], 0, 1)
    
    return pred_label
    
    