library(rpart)

dt_model <- rpart(RICE_YIELD ~ ., data = train_data)
dt_predictions <- predict(dt_model, test_data)

dt_mae <- mae(dt_predictions, test_data$RICE_YIELD)
dt_mse <- mse(dt_predictions, test_data$RICE_YIELD)
dt_rmse <- rmse(dt_predictions, test_data$RICE_YIELD)
dt_r_squared <- cor(dt_predictions, test_data$RICE_YIELD)^2

print("Decision Tree Performance Metrics:")
print(paste("Mean Absolute Error (MAE):", dt_mae))
print(paste("Mean Squared Error (MSE):", dt_mse))
print(paste("Root Mean Squared Error (RMSE):", dt_rmse))
print(paste("R-squared:", dt_r_squared))
