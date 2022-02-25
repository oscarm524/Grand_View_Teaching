import pandas as pd
import numpy as np
from sklearn.ensemble import RandomForestClassifier


def expand_grid(dictionary):
    return pd.DataFrame([row for row in product(*dictionary.values())], columns = dictionary.keys())


def ensemble_gabriel_ricky(test_pred1, test_pred2, test_pred3, Y, to_score1, to_score2, to_score3):
    
    ## Defining the input variables 
    X_input = pd.concat([test_pred1, test_pred2, test_pred3], axis = 1)
    X_to_score = pd.concat([to_score1, to_score2, to_score3], axis = 1)
    
    
    
    
    
    
    
def ensemble_ashlyn(test_pred1, test_pred2, test_pred3, Y, to_score1, to_score2, to_score3):