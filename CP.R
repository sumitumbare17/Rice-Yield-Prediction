library(randomForest)
library(Metrics)

x_data <- read.csv("X1.csv")
y_data <- read.csv("y1.csv")

data <- cbind(x_data, y_data)

set.seed(123)
train_indices <- sample(1:nrow(data), 0.8 * nrow(data)) 
train_data <- data[train_indices, ]
test_data <- data[-train_indices, ]

rf_model <- randomForest(RICE_YIELD ~ ., data = train_data)

predictions <- predict(rf_model, test_data)

mae_value <- mae(predictions, test_data$RICE_YIELD)
mse_value <- mse(predictions, test_data$RICE_YIELD)
rmse_value <- rmse(predictions, test_data$RICE_YIELD)
r_squared <- cor(predictions, test_data$RICE_YIELD)^2

print("Performance Metrics:")
print(paste("Mean Absolute Error (MAE):", mae_value))
print(paste("Mean Squared Error (MSE):", mse_value))
print(paste("Root Mean Squared Error (RMSE):", rmse_value))
print(paste("R-squared:", r_squared))