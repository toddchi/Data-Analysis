# Load libraries
library(ModelMetrics)
library(rpart)
library(rpart.plot)
devtools::install_github("devanshagr/CrossValidation")


# Read data
train <- read.csv("Prediction3Train.csv")
test <- read.csv("Prediction3Students.csv")
location <- read.csv("Location.csv")

# Convert Hired to factor
train$Hired <- as.factor(train$Hired)

# Check for unique majors and states in each dataset
train_merged <- merge(train, location, by="University", all.x=TRUE)
test_merged <- merge(test, location, by="University", all.x=TRUE)

train_states <- unique(train_merged$State)
test_states <- unique(test_merged$State)
new_states <- setdiff(test_states, train_states)

print(paste("Number of states in test but not in train:", length(new_states)))
print("New states in test data:")
print(new_states)

# Create feature engineering function
create_features <- function(data, location_data) {
  # Merge with location data
  data <- merge(data, location_data, by="University", all.x=TRUE)
  
  # Handle missing states
  data$State[is.na(data$State)] <- "Unknown"
  
  # Create region feature instead of using individual states
  northeast <- c("ME", "NH", "VT", "MA", "RI", "CT", "NY", "NJ", "PA")
  midwest <- c("OH", "MI", "IN", "IL", "WI", "MN", "IA", "MO", "ND", "SD", "NE", "KS")
  south <- c("DE", "MD", "DC", "VA", "WV", "NC", "SC", "GA", "FL", "KY", "TN", "AL", "MS", "AR", "LA", "OK", "TX")
  west <- c("MT", "ID", "WY", "CO", "NM", "AZ", "UT", "NV", "WA", "OR", "CA", "AK", "HI")
  
  data$Region <- "Unknown"
  data$Region[data$State %in% northeast] <- "Northeast"
  data$Region[data$State %in% midwest] <- "Midwest"
  data$Region[data$State %in% south] <- "South"
  data$Region[data$State %in% west] <- "West"
  
  # GPA features
  data$GPA_Bracket <- cut(data$GPA, 
                          breaks = c(0, 2.0, 2.5, 3.0, 3.5, 4.0),
                          labels = c("Very Low", "Low", "Medium", "High", "Very High"),
                          right = FALSE)
  
  data$GPA_Above3 <- as.integer(data$GPA >= 3.0)
  data$GPA_Above35 <- as.integer(data$GPA >= 3.5)
  
  # Simple major categorization
  data$MajorCategory <- "NonSTEM"  # Default
  
  # STEM 
  data$MajorCategory[grepl("Computer|Software|Data|Engineering|Math|Physics|IT|Technology", 
                           data$Major, ignore.case = TRUE)] <- "STEM"
  
  # Remove the State column to avoid factor level issues
  data$State <- NULL
  
  return(data)
}

# Apply feature engineering - avoids using State as a predictor
train_with_features <- create_features(train, location)
test_with_features <- create_features(test, location)

# Verify Category distribution in both datasets
print("MajorCategory in training data:")
print(table(train_with_features$MajorCategory))

print("MajorCategory in test data:")
print(table(test_with_features$MajorCategory))

print("Region in training data:")
print(table(train_with_features$Region))

print("Region in test data:")
print(table(test_with_features$Region))

# Convert factors with specified levels to ensure consistency
all_major_categories <- unique(c(train_with_features$MajorCategory, test_with_features$MajorCategory))
train_with_features$MajorCategory <- factor(train_with_features$MajorCategory, levels = all_major_categories)
test_with_features$MajorCategory <- factor(test_with_features$MajorCategory, levels = all_major_categories)

all_regions <- unique(c(train_with_features$Region, test_with_features$Region))
train_with_features$Region <- factor(train_with_features$Region, levels = all_regions)
test_with_features$Region <- factor(test_with_features$Region, levels = all_regions)

# Build a model - now without State as a predictor
model <- rpart(Hired ~ MajorCategory + GPA + GPA_Bracket + Region,
               data = train_with_features,
               method = "class",
               control = rpart.control(cp = 0.01, minsplit = 20))

# Run cross-validation
cv_results <- CrossValidation::cross_validate(train_with_features, model, 5, 0.8)
print("Cross-Validation Results:")
print(paste("Average CV Accuracy:", cv_results[[2]]$average_accuracy_all))

# Model diagnostics
print("Variable importance:")
print(model$variable.importance)

# Plot the tree
rpart.plot(model, main = "Hiring Decision Tree")

# Make predictions
test_predictions <- predict(model, test_with_features, type = "class")

# Create submission file
submission <- data.frame(
  ID = test_with_features$ID,
  Hired = test_predictions
)

# Write submission file
write.csv(submission, "Prediction3submission.csv", row.names = FALSE)
