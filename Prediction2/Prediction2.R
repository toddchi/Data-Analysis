# Load libraries
library(ModelMetrics)
library(rpart)
library(rpart.plot)
# Install CrossValidation if needed
devtools::install_github("devanshagr/CrossValidation")
library(CrossValidation)

# Read data
marriage <- read.csv("Prediction2025-2Train.csv")
marriage$Outcome <- as.factor(marriage$Outcome)

# Create features like in the recitation
create_features <- function(data) {
  # Add personality match features
  data$Same_EI <- as.integer(substr(data$Groom_MB, 1, 1) == substr(data$Bride_MB, 1, 1))
  data$Same_SN <- as.integer(substr(data$Groom_MB, 2, 2) == substr(data$Bride_MB, 2, 2))
  data$Same_TF <- as.integer(substr(data$Groom_MB, 3, 3) == substr(data$Bride_MB, 3, 3))
  data$Same_JP <- as.integer(substr(data$Groom_MB, 4, 4) == substr(data$Bride_MB, 4, 4))
  
  # Total matching traits
  data$Total_Matches <- data$Same_EI + data$Same_SN + data$Same_TF + data$Same_JP
  
  # Education and age features
  data$Same_Edu <- as.integer(data$Groom_Edu == data$Bride_Edu)
  data$Age_Diff <- abs(data$Groom_Age - data$Bride_Age)
  
  return(data)
}

# Split data
set.seed(2025)
train_indices <- sample(1:nrow(marriage), 0.8*nrow(marriage))
marriageTrain <- marriage[train_indices, ]
marriageTest <- marriage[-train_indices, ]

# Apply feature engineering
marriageTrain <- create_features(marriageTrain)
marriageTest <- create_features(marriageTest)

# Build a model following recitation pattern
unified_model <- rpart(Outcome ~ Total_Matches + Same_Edu + Age_Diff + Groom_Edu + Bride_Edu + Groom_Age + Bride_Age,
                       data = marriageTrain,
                       method = "class",
                       control = rpart.control(cp = 0.01, minsplit = 30))

# Run cross-validation using CrossValidation package
cv_results <- CrossValidation::cross_validate(marriageTrain, unified_model, 10, 0.8)
print("Cross-Validation Results:")
print(paste("Average CV Accuracy:", cv_results[[2]]$average_accuracy_all))

# Make predictions
test_predictions <- predict(unified_model, marriageTest, type = "class")
train_predictions <- predict(unified_model, marriageTrain, type = "class")

# Calculate accuracies
train_accuracy <- mean(marriageTrain$Outcome == train_predictions)
test_accuracy <- mean(marriageTest$Outcome == test_predictions)

print(paste("Training Data Set Accuracy:", train_accuracy))
print(paste("Test Data Set Accuracy:", test_accuracy))

# Plot the tree
print("Decision Tree:")
rpart.plot(unified_model)

# Read test data for submission
test_data <- read.csv("Prediction2025-2TestStud.csv")
test_data <- create_features(test_data)

# Make predictions on test data
submission_predictions <- predict(unified_model, test_data, type = "class")

# Create submission file
submission <- data.frame(
  ID = test_data$ID,
  Outcome = submission_predictions
)

# Write submission file
write.csv(submission, "Prediction2025-2submission.csv", row.names = FALSE)