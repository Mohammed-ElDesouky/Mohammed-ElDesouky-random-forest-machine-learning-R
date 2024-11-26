# Random-forest-machine-learning-R
This is an example R-script to implement a Machine Learning model (Random Forest) to identify variables that trigger most changes on an outcome variable in a big-data for policy targeting and prioritization

#### Overview
A high-dimensionality (big) data is characterized by large number of variables. Unlike in other domains, in the development sector, variable (change drivers) identification is fundamental for targeting and policy prioritization, hence, traditional dimensionality reduction techniques (e.g. PCA) that collapse data into new components might not be a suitable implementation to address this need. Needless to say, that traditional multiple regression testing may not be practically viable at all from a time efficiency perspective. 
Some Machine Learning methods can provide a way to address this problem. In particular, the method highlighted within this post (Random Forest) provide a solution to evaluate variable importance with relation to an outcome variable of interest. The good news is that, Random Forest can be implemented in a few lines of codes in R—however, a researcher may find the need to tune some of the model’s hyper parameters to fit the data.

- ##### About the script
  The script provides a standard (generic) pipeline for pre-processing and implementation of the Random Forest method on a relatively cleaned and structured data, as well as, visualization of variable importance.

