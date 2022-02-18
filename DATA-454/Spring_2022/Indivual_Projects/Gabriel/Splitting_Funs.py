from sklearn.model_selection import train_test_split

def train_validation_test(X, Y):
    
    """
    This function splits the data into train (80%),
    validation (10%) and test (10%)
    X: input variables
    Y: target variable
    """
    
    ## Initinal split
    X_train, X_val, Y_train, Y_val = train_test_split(X, Y, test_size = 0.2, stratify = Y)
    
    ## Second split 
    X_val, X_test, Y_val, Y_test = train_test_split(X_val, Y_val, test_size = 0.5, stratify = Y_val)
    
    return [X_train, X_val, X_test, Y_train, Y_val, Y_test]