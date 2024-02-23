# Read the data
data <- read.csv("X1.csv", header = TRUE)
y_data <- read.csv("y1.csv")

# Remove columns where all values are zero
data_filtered <- data[, colSums(data != 0) > 0]

# Combine data with target variable
data_combined <- cbind(data_filtered, RICE_YIELD = y_data)

# Step 1: Split the data into training and testing sets
set.seed(123)  # for reproducibility
train_index <- sample(nrow(data_combined), 0.7 * nrow(data_combined))
train_data <- data_combined[train_index, ]
test_data <- data_combined[-train_index, ]

# Define a function for Min-Max Scaling
min_max_scale <- function(x) {
  (x - min(x)) / (max(x) - min(x))
}

# Apply Min-Max Scaling to both training and testing data
train_data_scaled <- as.data.frame(lapply(train_data[, -which(names(train_data) == "RICE_YIELD")], min_max_scale))
train_data_scaled$RICE_YIELD <- train_data$RICE_YIELD

test_data_scaled <- as.data.frame(lapply(test_data[, -which(names(test_data) == "RICE_YIELD")], min_max_scale))
test_data_scaled$RICE_YIELD <- test_data$RICE_YIELD

# Step 2: Train the models using the training set
# Random Forest model
library(randomForest)
set.seed(120)  # Setting seed 
rf_model <- randomForest(x = train_data_scaled[, -which(names(train_data_scaled) == "RICE_YIELD")], 
                         y = train_data_scaled$RICE_YIELD, 
                         ntree = 500) 

# Step 3: Evaluate the model using the testing set
# Predicting the Test set results 
rf_predictions_test <- predict(rf_model, newdata = test_data_scaled[, -which(names(test_data_scaled) == "RICE_YIELD")])

# Calculate RMSE
rf_rmse_test <- sqrt(mean((rf_predictions_test - test_data_scaled$RICE_YIELD)^2))

# Calculate R-squared
# Calculate residual sum of squares (SS_res)
SS_res <- sum((rf_predictions_test - test_data_scaled$RICE_YIELD)^2)

# Calculate total sum of squares (SS_tot)
mean_y <- mean(test_data_scaled$RICE_YIELD)
SS_tot <- sum((test_data_scaled$RICE_YIELD - mean_y)^2)

# Calculate R-squared
rf_r_squared_test <- 1 - (SS_res / SS_tot)

# Displaying metrics for testing set
results_test <- data.frame(
  Model = "Random Forest (Scaled)",
  RMSE = rf_rmse_test,
  R_squared = rf_r_squared_test
)
print(results_test)

# Plotting RMSE
library("ggplot2")
ggplot(results_test, aes(x = Model, y = RMSE, fill = Model)) +
  geom_bar(stat = "identity") +
  labs(title = "Comparison of RMSE among Models (Testing Set)",
       x = "Model",
       y = "RMSE") +
  theme_minimal()
