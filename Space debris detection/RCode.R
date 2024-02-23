# Read the data
data <- read.csv("Processed_Data.csv")

# Convert RCS_SIZE to factor
data$RCS_SIZE <- as.factor(data$RCS_SIZE)

# Remove the COUNTRY_CODE column
data <- subset(data, select = -c(COUNTRY_CODE))

# Remove non-predictive columns
data <- data[, -which(names(data) %in% c("OBJECT_TYPE", "LAUNCH_DATE"))]

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
conf_matrix <- table(predictions, test_data$RCS_SIZE)

# Calculate evaluation metrics
accuracy <- sum(diag(conf_matrix)) / sum(conf_matrix)

# Calculate precision, recall, and F1 score for each class
precision <- recall <- f1_score <- numeric(length = nlevels(test_data$RCS_SIZE))

for (i in 1:nlevels(test_data$RCS_SIZE)) {
  class_label <- levels(test_data$RCS_SIZE)[i]
  
  # Calculate precision for class i
  precision[i] <- ifelse(sum(conf_matrix[i, ]) == 0, 0, conf_matrix[i, i] / sum(conf_matrix[i, ]))
  
  # Calculate recall for class i
  recall[i] <- ifelse(sum(conf_matrix[, i]) == 0, 0, conf_matrix[i, i] / sum(conf_matrix[, i]))
  
  # Calculate F1 score for class i
  f1_score[i] <- ifelse((precision[i] + recall[i]) == 0, 0, 2 * precision[i] * recall[i] / (precision[i] + recall[i]))
}

# Display results
cat("Accuracy:", accuracy, "\n")

# Display precision, recall, and F1 score for each class
for (i in 1:nlevels(test_data$RCS_SIZE)) {
  class_label <- levels(test_data$RCS_SIZE)[i]
  cat("Precision (", class_label, "):", precision[i], "\n")
  cat("Recall (", class_label, "):", recall[i], "\n")
  cat("F1 Score (", class_label, "):", f1_score[i], "\n")
}
