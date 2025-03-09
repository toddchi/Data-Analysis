# Marriage Outcome Prediction

## Overview
This project uses decision tree modeling to predict marriage outcomes based on personality compatibility and demographic factors. The model analyzes Myers-Briggs personality types, education levels, and age differences to predict marriage success.

## Features
The model uses both raw features and engineered features:

### Raw Features:
- Groom_MB: Groom's Myers-Briggs personality type
- Bride_MB: Bride's Myers-Briggs personality type
- Groom_Edu: Groom's education level
- Bride_Edu: Bride's education level
- Groom_Age: Groom's age
- Bride_Age: Bride's age

### Engineered Features:
- Same_EI: Whether both partners share the same Extroversion/Introversion trait
- Same_SN: Whether both partners share the same Sensing/Intuition trait
- Same_TF: Whether both partners share the same Thinking/Feeling trait
- Same_JP: Whether both partners share the same Judging/Perceiving trait
- Total_Matches: Sum of matching personality traits (0-4)
- Same_Edu: Whether both partners have the same education level
- Age_Diff: Absolute age difference between partners

## Model
The project uses the rpart package to build a decision tree classifier with the following configuration:
- Method: Classification
- Complexity Parameter (cp): 0.01
- Minimum Split: 30

## Files
- `Prediction2.R`: Main script containing data loading, feature engineering, model training, and prediction
- Input files (required):
  - `Prediction2025-2Train.csv`: Training dataset with known marriage outcomes
  - `Prediction2025-2TestStud.csv`: Test dataset for predictions
- Output:
  - `Prediction2025-2submission.csv`: Predictions for the test dataset

## Usage
1. Place required CSV files in the `data/` directory
2. Run the script:
```r
source("Prediction2.R")
```
3. Check the resulting submission file for predictions

## Performance
- 10-fold Cross-Validation Accuracy: [Add your model's CV accuracy]
- Training Accuracy: [Add your model's training accuracy]
- Test Accuracy: [Add your model's test accuracy]

## Visualization
The script generates a visualization of the decision tree using rpart.plot, showing the key decision points in the prediction process.