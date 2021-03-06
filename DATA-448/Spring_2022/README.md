# DATA-448: Predictive Analytics 

In this repository, I store all the code presendted in the lecture notes of DATA-448.

## Chapter 1: Class Imbalanced Data

This chapter discusses some of the standard techniques that practitioners consider when it comes to imbalanced binary classification problems. An imbalance occurs when one or more classes have very low proportion in the training data as compared to the other classes. Imbalance can be present in any dataset or application, and hence, the machine learning practitioner should be aware of the implications of modeling this type of data. The following topics are covered:

    - Performing classification on imbalanced data
    - Model tuning
        - Alternate cutoffs
            - ROC
            - Precision and Recall Curve
        - Class weights
    - Sampling methods
        - Under-sampling 
        - Over-sampling 
        - SMOTE
    - Cost-Sensitive training

## Chapter 2: Multiclass Classification

This chapter discusses the two common techniques that are considered in multi-class classification problems. Multi-class classification problems involve classifying instances or samples into one class out of multiple classes (more than two). Each sample is assigned only one label and can’t be assigned more than one label at a time. The following topics are coverd:

    - Understanding multi-class classification
        - One-vs-all classifier
        - One-vs-one classifier
        - Performance matrics
            - Precision
            - Recall
            - F1

## Chapter 3: Feature Engineering

This chapter discusses some of the standard techniques in feature engineering. Feature engineering is the act of extracting features from raw data and transforming them into formats that are suitable for the machine learning model. It is a crucial step in the machine learning pipeline, because the right feature can ease the difficulty of modeling, and therefore enable the pipeline to output results of higher quality. The following topics are covered:

    - Encoding categorical predictors
    - Engineering numeric predictors
        - 1:1 Transformations
    - Detecting interaction effects
        - Principles in the search of interactions
        - Tree-based methods
    - Nonlinear featurization via k-means
    
## Chapter 4: Feature Selection    

This chapter discusses some of the standard techniques in feature selection. Feature engineering is a important component of predictive analytics. And the hope is that some of the newly engineered features capture a predictive relationship with the outcome. But some may not be relevant to the outcome. Moreover, some of the original predictors also may not contain predictive information. For a number of models, predictive performance is degraded as the number of uninformative predictors increases. Therefore, there is a genuine need to appropriately select predictors for modeling. The following topidcs are covered:

    - Goals of feature selection
    - Effect of irrelevant features
    - Gready search methods
        - Simple filters
        - Recursive feature selection (RFE)
    
    
## Chapter 5: Hyper-parameter Tuning

This chapter discusses some of the standard techniques in hyper-parameter tuning. Choosing the right hyper-parameters when building a machine learning model is one of the biggest problems faced by data science practitioners. We start this chapter by defining parameters and hyper-parameters and their difference. Also, we discuss how hyper-parameters affect the overall process of model building. The following topics are covered:

    - The need of hyper-parameter optimization
    - Standard algorithms and their hyper-parameters
    - Hyper-parameter optimization
        - Grid search 
        - Random search 
        

## Chapter 6: Stacking Model Predictions

This chapter discusses the idea behind stacking model predictions. Stacking or Stacked Generalization is an ensemble machine learning algorithm. The benefit of stacking is that it can harness the capabilities of a range of well-performing models on a classification or regression task and make predictions that have better performance than any single model in the ensemble. The following topics are covered:

    - Stacked generalization
    - Implementing stacked generalization by combining predictions
    - Homogeneous ensembles


## Chapter 7: Gradient Boosting with XGBoost

This chapter discusses the idea and features of XGBoost. Decision trees produced machine learning models that were too accurate and failed to generalize well to new data. Ensemble methods proved more efective by combining many decision trees via bagging and boosting. A leading algorithm that emerged from the tree ensemble trajectory was gradient boosting. The consistency, power, and outstanding results of gradient boosting convinced Tianqi Chen from the University of Washington to enhance its capabilities. He called the new algorithm XGBoost, short for Extreme Gradient Boosting. Chen's new form of gradient boosting included
built-in regularization and impressive gains in speed. The following topics are covered:

    - XGBoost features
    - Learning objective
    - Building XGBoost models
    - XGBoost hyper-parameters
    - XGBoost alternative base learners



