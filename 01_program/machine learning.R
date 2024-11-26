rm(list=ls())
#Random Forest to iddentify varibales importance 

library(dplyr)
library(randomForest)
library(caret)
library(tidyverse)
library(haven)
library(VIM)


#loading data
g4_dta = read_dta("C:/Users/wb589124/Downloads/fourth_grade_Stata_school.dta")

# Identify columns with missing data
missing_data_cols <- colSums(is.na(g4_dta)) > 0
columns_with_na <- names(g4_dta)[missing_data_cols]
print(columns_with_na)

#simple imputation of missing data with mean
g4_dta <- g4_dta %>%
  mutate(across(where(is.numeric), ~ ifelse(is.na(.), mean(., na.rm = TRUE), .)))

# Identify columns with missing data
missing_data_cols <- colSums(is.na(g4_dta)) > 0
columns_with_na <- names(g4_dta)[missing_data_cols]
print(columns_with_na)

# Drop columns with missing data
 g4_dta <- g4_dta %>%
  select(-all_of(columns_with_na))

#removing constant columns with no variance 
constant_cols <- sapply(g4_dta, function(x) is.numeric(x) && sd(x, na.rm = TRUE) == 0)
constant_cols <- names(g4_dta)[constant_cols]
print(constant_cols)
g4_dta <- g4_dta %>% select(-all_of(constant_cols))

#feature scaling (only numerical data)
g4_dta_scaled = g4_dta %>% 
  mutate(across(where(is.numeric), ~ (.-mean(.))/sd(.)))

#split the data into training and testing sets

trainIndex <- createDataPartition(g4_dta_scaled$student_knowledge, p = .8, 
                                  list = FALSE, 
                                  times = 1)
g4_dta_train <- g4_dta_scaled[trainIndex,]
g4_dta_test <- g4_dta_scaled[-trainIndex,]

sum(is.na(g4_dta_train))

# Fit the random forest model on training data
model <- randomForest(student_knowledge ~ ., data = g4_dta_train, importance = TRUE)
print(model)

# Evaluate the model on testing data
predictions <- predict(model, g4_dta_test)
mse <- mean((predictions - g4_dta_test$student_knowledge)^2)
print(paste("Mean Squared Error:", mse))

# Evaluate and plot variable importance
importance(model)
varImpPlot(model)
