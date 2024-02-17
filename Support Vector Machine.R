# Load required library
library(e1071)  # For SVM

# Train SVM model
svm_model <- svm(RICE_YIELD ~ ., data = train_data)

# Predictions using SVM model
svm_predictions <- predict(svm_model, test_data)

# Calculate performance metrics for SVM
svm_mae <- mae(svm_predictions, test_data$RICE_YIELD)
svm_mse <- mse(svm_predictions, test_data$RICE_YIELD)
svm_rmse <- rmse(svm_predictions, test_data$RICE_YIELD)
svm_r_squared <- cor(svm_predictions, test_data$RICE_YIELD)^2

# Print performance metrics for SVM
print("SVM Performance Metrics:")
print(paste("Mean Absolute Error (MAE):", svm_mae))
print(paste("Mean Squared Error (MSE):", svm_mse))
print(paste("Root Mean Squared Error (RMSE):", svm_rmse))
print(paste("R-squared:", svm_r_squared))
save(svm_model, file = "svm_model.RData")
