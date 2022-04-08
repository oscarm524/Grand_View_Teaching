# DATA-101: Intro to data analytics

In this repository, I store all the code presented in the lecture notes of DATA-101.

## Chapter 1: Data Analytics Overview

This chapter provides a high-level of what data analytics is. The following topics are covered:

    - The basics of data analytics
    - Key terms to know
        - Business intelligence
        - Big data
        - Data mining
        - Text mining
        - Machine learning
        - Predictive modeling
        - Deep learning
        - Artificial intelligence
    - Data analytics process
        - Business understanding
        - Data understanding
        - Data preparation
        - Modeling 
        - Evaluation
        - Deployment
    - Data analytics types:
        - Descriptive analytics
        - Diagnostic analytics
        - Predictive analytics
        - Prescriptive analytics
    - Benefits of data analytics
    - Risks of data analytics
        

## Chapter 2: Data Analytics Solution to Real-Life Problems

This chapter provides a recipe for data professionals that want to use analytics methodoloy and tools to answer specific business problems. The following topics are covered: 

    - Converting business problems into analytics solutions
    - Assessing feasibility 
    - Designing an analytics plan


## Chapter 3: Data Exploration

Data exploration is a key component of analytics because it allows practitioners to have a good understanding of the data and its quality. The following topics are covered:

    - The data quality report
        - Central tendency
        - Variation and shape
        - Skewness
        - Exploring numerical data
        - Organizing variables
        - Data visualization
    - Identifying data quality issues
    - The data quality report summary


## Chapter 4: Similarity, Neighbors and Clustering

Several data analytics methodologies rely on similarity. If two things (people, products, etc) are similar in some way, they often share other characteristics as well. Some data analytics procedures are based on grouping similar things and conducting analysis in each of the groups. In this chapter, we will learn about similarity and how to apply it in different tasks. The following topics are covered:

    - Similarity and distance
        - Euclidean distance
    - Nearest neighbors
        - k-nn algorithm
    - Clustering
        - k-means 
        - Hierarchical clustering

## Chapter 5: Fitting Model to Data

Fitting a model to a data set involves finding a model of the target variable in terms of the features and/or other descriptive attributes of the data. This process requires the specification of the structure of the model, which may or may not depend on parameters. If the model depends on numeric parameters, then they need to be estimated using data and a specific procedure that most of the time requires the optimization of an objective function. This approach is called parametric modeling. The most common parametric model are linear models. On the other hand, if the model does not depend on any numeric parameter, they are known as non-parametric models. An example of a non-parametric model is k-nearest neighbors algorithm that makes predictions based on the k most similar training observation for a new observation. In this chapter, we will learn about some common parametric and non-parametric models. The following topics are covered:

    - Linear regression
        - Simple linear regression
        - Multiple linear regression
        - Linear regression with categorical variables
    - Classification
        - Logistic regression
    - Tree-based methods
        - Decision trees
        - Bagging
        - Random forest
        - Boosting

## Chapter 6: Intro to Predictive Modeling

We usually make decision based on information. In some cases we have tangible, objective data, such as the morning traffic or weather report. Other times we use intuition and experience like "I should avoid the bridge this morning because it usually gets bogged down when it snows" or "I should wear a big coat today because it will snow." In either case, we are predicting future events given the information and experience we currently have, and we are making decisions based on those predictions. Predictive modeling has been widely applied in many fields over the last two decades and examples can be found everywhere. The following topics are covered:

    - Variable selection
        - Backward selection
        - Forward selection
        - Hybrid selection
    - Model evaluation 
    - Hyper-parameter tuning 
        - Hyper-parameter tuning of k-nn
        - Hyper-parameter tuning of random forest
        - Hyper-parameter tuning of boosting