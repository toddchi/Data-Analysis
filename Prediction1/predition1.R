train <- read.csv("Prediction20251Train.csv")
test <- read.csv("Prediction20251TestStudents.csv")
submission <- read.csv("submission2025-1.csv")



print(paste("The column names are:"))
colnames(train)

myprediction <- train

# Initialize decisions with default grade C
decision <- rep('C', nrow(myprediction))

# Base F rules
decision[myprediction$Score < 61 | myprediction$Participation < 0.2] <- 'F'
decision[myprediction$Score > 70 & myprediction$Score < 90 & 
           myprediction$Participation < 0.2 & myprediction$Major == "Stats"] <- 'F'

# Modified A grade rules to handle score 90 boundary
# For scores above 90, use standard threshold
decision[myprediction$Score > 90 & myprediction$Participation >= 0.5] <- 'A'
# For exactly 90, require higher participation
decision[myprediction$Score == 90 & myprediction$Participation >= 0.7] <- 'A'

# B grade rules
# General B rule
decision[myprediction$Score >= 76 & myprediction$Score < 90 & 
           myprediction$Participation >= 0.5] <- 'B'
# Special Business Senior B rule
decision[myprediction$Major == "Business" & myprediction$Seniority == "Senior" & 
           myprediction$Score >= 76 & myprediction$Score < 90 & 
           myprediction$Participation >= 0.22] <- 'B'
# Score 90 B rule
decision[myprediction$Score == 90 & myprediction$Participation >= 0.5 & 
           myprediction$Participation < 0.7] <- 'B'

# C grade rules
decision[myprediction$Score >= 61 & myprediction$Score < 76 & 
           myprediction$Participation >= 0.2] <- 'C'
# Modified C rule to account for Business Senior exception
decision[myprediction$Score >= 76 & myprediction$Participation >= 0.2 & 
           myprediction$Participation < 0.5 & 
           !(myprediction$Major == "Business" & 
               myprediction$Seniority == "Senior")] <- 'C'

# Final overrides
decision[myprediction$Score < 61] <- 'F'
decision[myprediction$Participation < 0.2] <- 'F'

# Calculate error and accuracy
error <- mean(train$Grade != decision)
cat("The value of error computed on training data is ", error, "\n")
accuracy <- mean(train$Grade == decision)
cat("The value of accuracy computed on training data is ", accuracy)

myprediction <- test

# Initialize decisions with default grade C
decision <- rep('C', nrow(myprediction))

# Base F rules
decision[myprediction$Score < 61 | myprediction$Participation < 0.2] <- 'F'
decision[myprediction$Score > 70 & myprediction$Score < 90 & 
           myprediction$Participation < 0.2 & myprediction$Major == "Stats"] <- 'F'

# Modified A grade rules to handle score 90 boundary
# For scores above 90, use standard threshold
decision[myprediction$Score > 90 & myprediction$Participation >= 0.5] <- 'A'
# For exactly 90, require higher participation
decision[myprediction$Score == 90 & myprediction$Participation >= 0.7] <- 'A'

# B grade rules
# General B rule
decision[myprediction$Score >= 76 & myprediction$Score < 90 & 
           myprediction$Participation >= 0.5] <- 'B'
# Special Business Senior B rule
decision[myprediction$Major == "Business" & myprediction$Seniority == "Senior" & 
           myprediction$Score >= 76 & myprediction$Score < 90 & 
           myprediction$Participation >= 0.22] <- 'B'
# Score 90 B rule
decision[myprediction$Score == 90 & myprediction$Participation >= 0.5 & 
           myprediction$Participation < 0.7] <- 'B'

# C grade rules
decision[myprediction$Score >= 61 & myprediction$Score < 76 & 
           myprediction$Participation >= 0.2] <- 'C'
# Modified C rule to account for Business Senior exception
decision[myprediction$Score >= 76 & myprediction$Participation >= 0.2 & 
           myprediction$Participation < 0.5 & 
           !(myprediction$Major == "Business" & 
               myprediction$Seniority == "Senior")] <- 'C'

# Final overrides
decision[myprediction$Score < 61] <- 'F'
decision[myprediction$Participation < 0.2] <- 'F'

submission$Grade <- decision
submission
# Creating the submission.csv to store submission as csv file on your machine
write.csv(submission, 'submission.csv', row.names=FALSE)
