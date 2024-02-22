# Read the data

# Step 1: Data Preprocessing
# Check for missing values
sum(is.na(data_combined))

# Step 2: Feature Engineering
# (No specific feature engineering applied in this example)

# Step 3: Model Selection and Tuning
# Random Forest model
library(randomForest)
rf_model <- randomForest(RICE_YIELD ~ ., data = data_combined)

# Decision Tree model
library(rpart)
dt_model <- rpart(RICE_YIELD ~ ., data = data_combined)

# SVM model
library(e1071)
svm_model <- svm(RICE_YIELD ~ ., data = data_combined)

# XGBoost model
library(xgboost)
xgb_model <- xgboost(data = as.matrix(data_combined[, -which(names(data_combined) == "RICE_YIELD")]), 
                     label = data_combined$RICE_YIELD,
                     nrounds = 100,
                     objective = "reg:squarederror",
                     eval_metric = "rmse")

# Step 4: Ensemble Methods
# Combine models using ensemble techniques if necessary

# Step 5: Cross-validation
# Evaluate models using cross-validation techniques

# Step 6: Model Evaluation
# Random Forest
rf_predictions <- predict(rf_model, data_combined)
rf_mae <- mean(abs(rf_predictions - data_combined$RICE_YIELD))
rf_mse <- mean((rf_predictions - data_combined$RICE_YIELD)^2)
rf_rmse <- sqrt(mean((rf_predictions - data_combined$RICE_YIELD)^2))
rf_r_squared <- cor(rf_predictions, data_combined$RICE_YIELD)^2

# Decision Tree
dt_predictions <- predict(dt_model, data_combined)
dt_mae <- mean(abs(dt_predictions - data_combined$RICE_YIELD))
dt_mse <- mean((dt_predictions - data_combined$RICE_YIELD)^2)
dt_rmse <- sqrt(mean((dt_predictions - data_combined$RICE_YIELD)^2))
dt_r_squared <- cor(dt_predictions, data_combined$RICE_YIELD)^2

# SVM
svm_predictions <- predict(svm_model, data_combined)
svm_mae <- mean(abs(svm_predictions - data_combined$RICE_YIELD))
svm_mse <- mean((svm_predictions - data_combined$RICE_YIELD)^2)
svm_rmse <- sqrt(mean((svm_predictions - data_combined$RICE_YIELD)^2))
svm_r_squared <- cor(svm_predictions, data_combined$RICE_YIELD)^2

# XGBoost
xgb_predictions <- predict(xgb_model, as.matrix(data_combined[, -which(names(data_combined) == "RICE_YIELD")]))
xgb_mae <- mean(abs(xgb_predictions - data_combined$RICE_YIELD))
xgb_mse <- mean((xgb_predictions - data_combined$RICE_YIELD)^2)
xgb_rmse <- sqrt(mean((xgb_predictions - data_combined$RICE_YIELD)^2))
xgb_r_squared <- cor(xgb_predictions, data_combined$RICE_YIELD)^2

# Displaying metrics
results <- data.frame(
  Model = c("Random Forest", "Decision Tree", "SVM", "XGBoost"),
  MAE = c(rf_mae, dt_mae, svm_mae, xgb_mae),
  MSE = c(rf_mse, dt_mse, svm_mse, xgb_mse),
  RMSE = c(rf_rmse, dt_rmse, svm_rmse, xgb_rmse),
  R_squared = c(rf_r_squared, dt_r_squared, svm_r_squared, xgb_r_squared)
)

print(results)

save(xgb_model, file = "xgb_model.RData")
