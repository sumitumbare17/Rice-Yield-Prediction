# Install xgboost package if not already installed
if (!requireNamespace("xgboost", quietly = TRUE)) {
  install.packages("xgboost")
}

# Load required library
library(xgboost)

# Train XGBoost model
xgb_model <- xgboost(data = as.matrix(train_data[, -which(names(train_data) == "RICE_YIELD")]), 
                     label = train_data$RICE_YIELD,
                     nrounds = 100,  # Number of boosting rounds
                     objective = "reg:squarederror",  # Objective for regression
                     eval_metric = "rmse")  # Evaluation metric

# Predictions using XGBoost model
xgb_predictions <- predict(xgb_model, as.matrix(test_data[, -which(names(test_data) == "RICE_YIELD")]))

# Calculate performance metrics for XGBoost
xgb_mae <- mae(xgb_predictions, test_data$RICE_YIELD)
xgb_mse <- mse(xgb_predictions, test_data$RICE_YIELD)
xgb_rmse <- rmse(xgb_predictions, test_data$RICE_YIELD)
xgb_r_squared <- cor(xgb_predictions, test_data$RICE_YIELD)^2

# Print performance metrics for XGBoost
print("XGBoost Performance Metrics:")
print(paste("Mean Absolute Error (MAE):", xgb_mae))
print(paste("Mean Squared Error (MSE):", xgb_mse))
print(paste("Root Mean Squared Error (RMSE):", xgb_rmse))
print(paste("R-squared:", xgb_r_squared))

