x<-read.csv("X1.csv")
y <- read.csv("y1.csv")
  min_max_normalize <- function(x) {
  (x - min(x)) / (max(x) - min(x))
}
  
  # Normalize the y variable
  min_y <- min(y)
  max_y <- max(y)
  normalized_y <- (y - min_y) / (max_y - min_y)
  
  # Print the normalized y variable
  print(normalized_y)
  
# Apply normalization to the data
x_normalized <- as.data.frame(lapply(x, min_max_normalize))
data_filtered <- x_normalized[, colSums(is.na(x_normalized)) == 0]

# Check the normalized data
print(x_normalized)


data_combined <- cbind(data_filtered, RICE_YIELD = normalized_y)
set.seed(123)  # for reproducibility
train_index <- sample(nrow(data_combined), 0.7 * nrow(data_combined))
train_data <- data_combined[train_index, ]
test_data <- data_combined[-train_index, ]
library(randomForest)

rf_model <- randomForest(x = train_data[, -which(names(train_data) == "RICE_YIELD")], 
                         y = train_data$RICE_YIELD, 
                         ntree = 500) 
rf_predictions_test <- predict(rf_model, newdata = test_data[, -which(names(test_data) == "RICE_YIELD")])

actual_values <- test_data$RICE_YIELD  # Assuming RICE_YIELD is your actual response variable in the test data
r_squared <- 1 - sum((actual_values - rf_predictions_test)^2) / sum((actual_values - mean(actual_values))^2)

# Calculate Mean Squared Error (MSE)
mse <- mean((actual_values - rf_predictions_test)^2)

# Calculate Root Mean Squared Error (RMSE)
rmse <- sqrt(mse)

# Print the results
print(paste("R-squared (R2):", r_squared))
print(paste("Mean Squared Error (MSE):", mse))
print(paste("Root Mean Squared Error (RMSE):", rmse))

# Load required libraries
library(caret)
library(gbm)

# Linear Regression
lm_model <- lm(RICE_YIELD ~ ., data = train_data)
lm_predictions_test <- predict(lm_model, newdata = test_data)

# Calculate R-squared for linear regression
lm_r_squared <- cor(lm_predictions_test, test_data$RICE_YIELD)^2

# Gradient Boosting
gbm_model <- gbm(RICE_YIELD ~ ., data = train_data, n.trees = 500, distribution = "gaussian")
gbm_predictions_test <- predict(gbm_model, newdata = test_data, n.trees = 500)

# Calculate R-squared for gradient boosting
gbm_r_squared <- cor(gbm_predictions_test, test_data$RICE_YIELD)^2

# Print results
print(paste("Linear Regression R-squared (R2):", lm_r_squared))
print(paste("Gradient Boosting R-squared (R2):", gbm_r_squared))

