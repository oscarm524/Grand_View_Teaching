from sklearn.model_selection import train_test_split

def train_validation_test(X, Y):
    
    """
    This function splits the data into train (80%),
    validation (10%) and test (10%)
    X: input variables
    Y: target variable
    """
    
    ## Initinal split