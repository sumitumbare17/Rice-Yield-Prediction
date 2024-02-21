# Install and load required packages
install.packages("caret")
library(caret)

# Read the data
data <- read.csv("Processed_Data.csv")

# Convert RCS_SIZE to factor
data$RCS_SIZE <- as.factor(data$RCS_SIZE)

# Remove the COUNTRY_CODE column
data <- subset(data, select = -c(COUNTRY_CODE))

# Remove non-predictive columns
data <- data[, -which(names(data) %in% c("OBJECT_TYPE", "RCS_SIZE", "LAUNCH_DATE"))]

# Split data into predictors and target variable
X <- data[, -which(names(data) == "RCS_SIZE")]
y <- data$RCS_SIZE

# Train-test split (80% train, 20% test)
set.seed(123) # for reproducibility
train_index <- sample(nrow(data), 0.8 * nrow(data))
train_data <- data[train_index, ]
test_data <- data[-train_index, ]

# Train SVM model
svm_model <- svm(formula = RCS_SIZE ~ ., data = train_data, kernel = "radial")

# Predict on test data
predictions <- predict(svm_model, test_data)

# Calculate confusion matrix
conf_matrix <- confusionMatrix(predictions, test_data$RCS_SIZE)

# Extract metrics
accuracy <- conf_matrix$overall['Accuracy']
precision <- conf_matrix$byClass['Precision']
recall <- conf_matrix$byClass['Recall']
f1_score <- conf_matrix$byClass['F1']

# Display results
cat("Accuracy:", accuracy, "\n")
cat("Precision:", precision, "\n")
cat("Recall:", recall, "\n")
cat("F1 Score:", f1_score, "\n")
