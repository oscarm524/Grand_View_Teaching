import pandas as pd 
import numpy as np
from sklearn.metrics import precision_recall_curve

def precision_recall_cutoff(Y_test, Y_pred):
    
    ## Computing the precision recall curve
    precision, recall, thresholds = precision_recall_curve(Y_test, Y_pred)
    
    ## Creating the precision-recall data-frame
    precision_recall = pd.DataFrame('precision': precision, 'recall': recall, 'cutoff': thresholds)
    
    