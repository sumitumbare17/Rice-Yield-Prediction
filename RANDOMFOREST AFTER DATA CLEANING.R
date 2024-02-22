library(randomForest)
library(Metrics)
library(ggplot2)

# Read the data
data <- read.csv("X1.csv", header = TRUE)
y_data <- read.csv("y1.csv")

# Remove columns where all values are zero
data_filtered <- data[, colSums(data != 0) > 0]

# Combine data with target variable
data_combined <- cbind(data_filtered, RICE_YIELD = y_data)

# Set seed for reproducibility
set.seed(123)

# Sample indices for training data
train_indices <- sample(1:nrow(data_combined), 0.8 * nrow(data_combined)) 

# Split data into training and test sets
train_data <- data_combined[train_indices, ]
test_data <- data_combined[-train_indices, ]

# Train random forest model
rf_model <- randomForest(RICE_YIELD ~ ., data = train_data)

# Make predictions
predictions <- predict(rf_model, test_data)

# Calculate performance metrics
mae_value <- mae(predictions, test_data$RICE_YIELD)
mse_value <- mse(predictions, test_data$RICE_YIELD)
rmse_value <- rmse(predictions, test_data$RICE_YIELD)
r_squared <- cor(predictions, test_data$RICE_YIELD)^2

# Print performance metrics
print("Performance Metrics:")
print(paste("Mean Absolute Error (MAE):", mae_value))
print(paste("Mean Squared Error (MSE):", mse_value))
print(paste("Root Mean Squared Error (RMSE):", rmse_value))
print(paste("R-squared:", r_squared))

# Example performance metrics
performance_metrics <- c(MAE = mae_value, MSE = mse_value, RMSE = rmse_value, `R-squared` = r_squared)

# Standardize the performance metrics
mean_value <- mean(performance_metrics)
sd_value <- sd(performance_metrics)
standardized_metrics <- (performance_metrics - mean_value) / sd_value

# Create a dataframe with the standardized values
performance <- data.frame(
  Metric = names(standardized_metrics),
  Standardized_Value = standardized_metrics
)

# Plot the standardized performance metrics
ggplot(performance, aes(x = Metric, y = Standardized_Value)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(title = "Standardized Performance Metrics",
       y = "Standardized Value") +
  theme_minimal()
