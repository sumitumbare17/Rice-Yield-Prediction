data <- read.csv("X1.csv", header = TRUE)

# Remove columns where all values are zero
data_filtered <- data[, colSums(data != 0) > 0]

