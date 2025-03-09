# Student Grade Prediction

## Overview
This project implements a rule-based classification system for predicting student grades based on their performance metrics. The model uses a series of conditional rules to assign grades (A, B, C, or F) based on several factors.

## Features
- Score: Numerical score on assessments
- Participation: Student participation rate (0-1)
- Major: Student's field of study
- Seniority: Student's academic level

## Rules
The grade assignment follows these general rules:
- Grade F: Score < 61 OR Participation < 0.2
- Grade A: Score > 90 AND Participation >= 0.5 (Score exactly 90 requires Participation >= 0.7)
- Grade B: Score >= 76 AND Score < 90 AND Participation >= 0.5
- Grade C: Score >= 61 AND Score < 76 AND Participation >= 0.2

Special conditions exist for:
- Business majors with Senior seniority
- Statistics majors with specific score/participation combinations

## Files
- `prediction1.R`: Main script for the grade prediction model
- Input files (required):
  - `Prediction20251Train.csv`: Training dataset with known grades
  - `Prediction20251TestStudents.csv`: Test dataset for predictions
- Output:
  - `submission.csv`: Predictions for the test dataset

## Usage
1. Place the required CSV files in the `data/` directory
2. Run the script:
```r
source("prediction1.R")
```
3. Check the resulting `submission.csv` file for predictions

## Performance
- Training accuracy: [Add your model's training accuracy]