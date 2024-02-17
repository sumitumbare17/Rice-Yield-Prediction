library(randomForest)
library(Metrics)
data1 <- read.csv("X1.csv", header = TRUE)
# Remove columns where all values are zero
data_filtered <- data[, colSums(data != 0) > 0]

y_data <- read.csv("y1.csv")
data <- cbind(data_filtered, y_data)
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


# Example performance metrics
mae_value <- 10
mse_value <- 20
rmse_value <- 15
r_squared <- 0.8

# Standardize the performance metrics
mean_value <- mean(c(mae_value, mse_value, rmse_value, r_squared))
sd_value <- sd(c(mae_value, mse_value, rmse_value, r_squared))
mae_std <- (mae_value - mean_value) / sd_value
mse_std <- (mse_value - mean_value) / sd_value
rmse_std <- (rmse_value - mean_value) / sd_value
r_squared_std <- (r_squared - mean_value) / sd_value

# Create a dataframe with the standardized values
performance <- data.frame(
  Metric = c("MAE", "MSE", "RMSE", "R-squared"),
  Standardized_Value = c(mae_std, mse_std, rmse_std, r_squared_std)
)

# Plot the standardized performance metrics
library(ggplot2)
ggplot(performance, aes(x = Metric, y = Standardized_Value)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(title = "Standardized Performance Metrics",
       y = "Standardized Value") +
  theme_minimal()

