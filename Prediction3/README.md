# Hiring Decision Prediction

## Overview
This project develops a decision tree classifier to predict hiring decisions based on applicant attributes. The model handles geographical data generalization and implements feature engineering to improve prediction performance.

## Features

### Raw Features:
- University: Applicant's university
- GPA: Applicant's grade point average
- Major: Applicant's field of study

### Engineered Features:
- Region: Geographical region of the university (Northeast, Midwest, South, West, Unknown)
- GPA_Bracket: Categorized GPA ranges (Very Low, Low, Medium, High, Very High)
- GPA_Above3: Binary indicator for GPA ≥ 3.0
- GPA_Above35: Binary indicator for GPA ≥ 3.5
- MajorCategory: Simplified major categories (STEM, NonSTEM)

## Key Approaches
1. **Geographical Generalization**: Converts specific states to broader regions to handle unseen geographical locations in test data
2. **GPA Categorization**: Creates multiple GPA-based features to capture different aspects of academic performance
3. **Major Classification**: Simplifies diverse majors into STEM and NonSTEM categories for better generalization

## Files
- `Prediction3.R`: Main script containing feature engineering, model training, and predictions
- Input files (required):
  - `Prediction3Train.csv`: Training dataset with known hiring decisions
  - `Prediction3Students.csv`: Test dataset for predictions
  - `Location.csv`: University to state mapping data
- Output:
  - `Prediction3submission.csv`: Predictions for the test dataset

## Usage
1. Place required CSV files in the `data/` directory
2. Run the script:
```r
source("Prediction3.R")
```
3. Check the resulting submission file for predictions

## Performance
- Cross-Validation Accuracy: [Add your model's CV accuracy]

## Visualization
The script generates a visualization of the decision tree using rpart.plot, showing the key decision points in the hiring process.

## Challenges Addressed
- Handling new states in the test data not present in training data
- Creating generalizable features from specific university and major information
- Balancing model complexity with generalization capability